<?php

namespace App\Services;

use App\Enums\TaskStatus;
use App\Models\Role;
use App\Models\Task;
use App\Models\User;
use App\Support\Search;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Http\Exceptions\HttpResponseException;
use Illuminate\Support\Facades\DB;

class TaskService
{
    public function __construct(private readonly ActivityService $activityService)
    {
    }

    /**
     * Get a paginated list of tasks, with optional filtering.
     *
     * Sales executives only ever see tasks assigned to themselves.
     *
     * @param  array<string, mixed>  $filters
     */
    public function list(array $filters, User $actor): LengthAwarePaginator
    {
        $query = Task::query()->with(['user', 'lead', 'customer']);

        if ($actor->hasRole(Role::SALES_EXECUTIVE)) {
            $query->where('user_id', $actor->id);
        }

        if ($search = $filters['search'] ?? null) {
            $query->where('title', Search::operator(), "%{$search}%");
        }

        if ($userId = $filters['user_id'] ?? null) {
            $query->where('user_id', $userId);
        }

        if ($leadId = $filters['lead_id'] ?? null) {
            $query->where('lead_id', $leadId);
        }

        if ($customerId = $filters['customer_id'] ?? null) {
            $query->where('customer_id', $customerId);
        }

        if ($status = $filters['status'] ?? null) {
            $query->where('status', $status);
        }

        if ($priority = $filters['priority'] ?? null) {
            $query->where('priority', $priority);
        }

        if (filter_var($filters['overdue'] ?? false, FILTER_VALIDATE_BOOLEAN)) {
            $query->where('due_date', '<', now())
                ->whereNot('status', TaskStatus::COMPLETED->value);
        }

        return $query->latest()->paginate($filters['per_page'] ?? 15);
    }

    /**
     * Create a new task.
     *
     * @param  array<string, mixed>  $data
     */
    public function create(array $data, User $actor): Task
    {
        return DB::transaction(function () use ($data, $actor) {
            $task = Task::create($data);

            $this->activityService->log($actor, 'task.created', $task, "Created task {$task->title}");

            return $task->load(['user', 'lead', 'customer']);
        });
    }

    /**
     * Display a single task. Sales executives may only view their own task.
     */
    public function view(Task $task, User $actor): Task
    {
        $this->authorizeOwnership($task, $actor);

        return $task->load(['user', 'lead', 'customer']);
    }

    /**
     * Update an existing task. Sales executives may only update their own task.
     *
     * @param  array<string, mixed>  $data
     */
    public function update(Task $task, array $data, User $actor): Task
    {
        $this->authorizeOwnership($task, $actor);

        return DB::transaction(function () use ($task, $data, $actor) {
            $task->update($data);

            $this->activityService->log($actor, 'task.updated', $task, "Updated task {$task->title}");

            return $task->load(['user', 'lead', 'customer']);
        });
    }

    /**
     * Delete a task. Sales executives may only delete their own task.
     */
    public function delete(Task $task, User $actor): void
    {
        $this->authorizeOwnership($task, $actor);

        DB::transaction(function () use ($task, $actor) {
            $this->activityService->log($actor, 'task.deleted', $task, "Deleted task {$task->title}");

            $task->delete();
        });
    }

    /**
     * Sales executives may only act on tasks assigned to themselves.
     * Admins and sales managers have unrestricted access.
     */
    private function authorizeOwnership(Task $task, User $actor): void
    {
        if ($actor->hasRole(Role::SALES_EXECUTIVE) && $task->user_id !== $actor->id) {
            throw new HttpResponseException(response()->json(['message' => 'Forbidden.'], 403));
        }
    }
}
