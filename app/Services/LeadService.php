<?php

namespace App\Services;

use App\Enums\LeadStatus;
use App\Models\Lead;
use App\Models\User;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\DB;

class LeadService
{
    public function __construct(private readonly ActivityService $activityService)
    {
    }

    /**
     * Get a paginated list of leads, with optional search and status filtering.
     *
     * @param  array<string, mixed>  $filters
     */
    public function list(array $filters): LengthAwarePaginator
    {
        $query = Lead::query()->with(['assignedUser', 'creator']);

        if ($search = $filters['search'] ?? null) {
            $query->where(function ($query) use ($search) {
                $query->where('first_name', 'like', "%{$search}%")
                    ->orWhere('last_name', 'like', "%{$search}%")
                    ->orWhere('email', 'like', "%{$search}%")
                    ->orWhere('company', 'like', "%{$search}%");
            });
        }

        if ($status = $filters['status'] ?? null) {
            $query->where('status', $status);
        }

        return $query->latest()->paginate($filters['per_page'] ?? 15);
    }

    /**
     * Create a new lead.
     *
     * @param  array<string, mixed>  $data
     */
    public function create(array $data, User $createdBy): Lead
    {
        return DB::transaction(function () use ($data, $createdBy) {
            $lead = Lead::create([
                ...$data,
                'created_by' => $createdBy->id,
                'status' => $data['status'] ?? LeadStatus::NEW->value,
            ]);

            $this->activityService->log($createdBy, 'lead.created', $lead, "Created lead {$lead->first_name} {$lead->last_name}");

            return $lead->load(['assignedUser', 'creator']);
        });
    }

    /**
     * Update an existing lead.
     *
     * @param  array<string, mixed>  $data
     */
    public function update(Lead $lead, array $data): Lead
    {
        return DB::transaction(function () use ($lead, $data) {
            $lead->update($data);

            return $lead->load(['assignedUser', 'creator']);
        });
    }

    /**
     * Delete a lead.
     */
    public function delete(Lead $lead): void
    {
        DB::transaction(function () use ($lead) {
            $lead->delete();
        });
    }

    /**
     * Assign a lead to a user (or unassign when null).
     */
    public function assign(Lead $lead, ?int $userId, User $actor): Lead
    {
        return DB::transaction(function () use ($lead, $userId, $actor) {
            $lead->update(['assigned_to' => $userId]);

            $this->activityService->log($actor, 'lead.assigned', $lead, $userId
                ? "Assigned lead {$lead->first_name} {$lead->last_name} to user #{$userId}"
                : "Unassigned lead {$lead->first_name} {$lead->last_name}");

            return $lead->load(['assignedUser', 'creator']);
        });
    }

    /**
     * Update the status of a lead.
     */
    public function updateStatus(Lead $lead, LeadStatus $status, User $actor): Lead
    {
        return DB::transaction(function () use ($lead, $status, $actor) {
            $lead->update(['status' => $status]);

            $this->activityService->log($actor, 'lead.status_updated', $lead, "Updated lead {$lead->first_name} {$lead->last_name} status to {$status->value}");

            return $lead->load(['assignedUser', 'creator']);
        });
    }
}
