<?php

namespace App\Http\Controllers;

use App\Http\Requests\Task\StoreTaskRequest;
use App\Http\Requests\Task\UpdateTaskRequest;
use App\Http\Resources\TaskResource;
use App\Models\Task;
use App\Services\TaskService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use OpenApi\Attributes as OA;

class TaskController extends Controller
{
    public function __construct(private readonly TaskService $taskService) {}

    #[OA\Get(
        path: '/api/tasks',
        summary: 'List tasks',
        description: 'Returns a paginated, filterable list of tasks. Accessible to admins, sales managers, and sales executives.',
        tags: ['Tasks'],
        security: [['bearerAuth' => []]],
        parameters: [
            new OA\Parameter(name: 'search', in: 'query', description: 'Free-text search across task title.', schema: new OA\Schema(type: 'string')),
            new OA\Parameter(name: 'user_id', in: 'query', description: 'Filter by assigned user ID.', schema: new OA\Schema(type: 'integer')),
            new OA\Parameter(name: 'lead_id', in: 'query', description: 'Filter by related lead ID.', schema: new OA\Schema(type: 'integer')),
            new OA\Parameter(name: 'customer_id', in: 'query', description: 'Filter by related customer ID.', schema: new OA\Schema(type: 'integer')),
            new OA\Parameter(name: 'status', in: 'query', description: 'Filter by task status.', schema: new OA\Schema(type: 'string', enum: ['pending', 'in_progress', 'completed'])),
            new OA\Parameter(name: 'priority', in: 'query', description: 'Filter by task priority.', schema: new OA\Schema(type: 'string', enum: ['low', 'medium', 'high'])),
            new OA\Parameter(name: 'overdue', in: 'query', description: 'Filter to only overdue tasks.', schema: new OA\Schema(type: 'boolean')),
            new OA\Parameter(name: 'per_page', in: 'query', description: 'Number of results per page.', schema: new OA\Schema(type: 'integer', default: 15)),
        ],
        responses: [
            new OA\Response(
                response: 200,
                description: 'A paginated list of tasks.',
                content: new OA\JsonContent(properties: [
                    new OA\Property(property: 'data', type: 'array', items: new OA\Items(ref: '#/components/schemas/Task')),
                    new OA\Property(property: 'links', ref: '#/components/schemas/PaginationLinks'),
                    new OA\Property(property: 'meta', ref: '#/components/schemas/PaginationMeta'),
                ]),
            ),
            new OA\Response(response: 401, description: 'Unauthenticated.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
            new OA\Response(response: 403, description: 'Forbidden for the current role.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
        ],
    )]
    /**
     * Display a paginated, filterable list of tasks.
     */
    public function index(Request $request): JsonResponse
    {
        $tasks = $this->taskService->list(
            $request->only(['search', 'user_id', 'lead_id', 'customer_id', 'status', 'priority', 'overdue', 'per_page']),
            $request->user()
        );

        return TaskResource::collection($tasks)->response();
    }

    #[OA\Post(
        path: '/api/tasks',
        summary: 'Create a task',
        description: 'Creates a new task. A task must belong to either a lead or a customer. Accessible to admins, sales managers, and sales executives.',
        tags: ['Tasks'],
        security: [['bearerAuth' => []]],
        requestBody: new OA\RequestBody(
            required: true,
            content: new OA\JsonContent(
                required: ['user_id', 'title', 'due_date'],
                properties: [
                    new OA\Property(property: 'user_id', type: 'integer', example: 2),
                    new OA\Property(property: 'customer_id', type: 'integer', nullable: true, example: 1),
                    new OA\Property(property: 'lead_id', type: 'integer', nullable: true, example: 1),
                    new OA\Property(property: 'title', type: 'string', maxLength: 255, example: 'Send follow-up proposal'),
                    new OA\Property(property: 'description', type: 'string', nullable: true, example: 'Email the revised pricing.'),
                    new OA\Property(property: 'priority', type: 'string', enum: ['low', 'medium', 'high'], nullable: true, example: 'medium'),
                    new OA\Property(property: 'status', type: 'string', enum: ['pending', 'in_progress', 'completed'], nullable: true, example: 'pending'),
                    new OA\Property(property: 'due_date', type: 'string', format: 'date', example: '2026-07-01'),
                    new OA\Property(property: 'reminder_at', type: 'string', format: 'date-time', nullable: true),
                ],
            ),
        ),
        responses: [
            new OA\Response(response: 201, description: 'Task created successfully.', content: new OA\JsonContent(properties: [new OA\Property(property: 'data', ref: '#/components/schemas/Task')])),
            new OA\Response(response: 401, description: 'Unauthenticated.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
            new OA\Response(response: 403, description: 'Forbidden for the current role.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
            new OA\Response(response: 422, description: 'Validation error.', content: new OA\JsonContent(ref: '#/components/schemas/ValidationErrorResponse')),
        ],
    )]
    /**
     * Store a newly created task.
     */
    public function store(StoreTaskRequest $request): JsonResponse
    {
        $task = $this->taskService->create($request->validated(), $request->user());

        return (new TaskResource($task))->response()->setStatusCode(201);
    }

    #[OA\Get(
        path: '/api/tasks/{task}',
        summary: 'Get a task',
        description: 'Returns a single task. Accessible to admins, sales managers, and sales executives.',
        tags: ['Tasks'],
        security: [['bearerAuth' => []]],
        parameters: [
            new OA\Parameter(name: 'task', in: 'path', required: true, description: 'Task ID.', schema: new OA\Schema(type: 'integer')),
        ],
        responses: [
            new OA\Response(response: 200, description: 'The requested task.', content: new OA\JsonContent(properties: [new OA\Property(property: 'data', ref: '#/components/schemas/Task')])),
            new OA\Response(response: 401, description: 'Unauthenticated.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
            new OA\Response(response: 403, description: 'Forbidden for the current role.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
            new OA\Response(response: 404, description: 'Task not found.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
        ],
    )]
    /**
     * Display a single task.
     */
    public function show(Request $request, Task $task): JsonResponse
    {
        $task = $this->taskService->view($task, $request->user());

        return (new TaskResource($task))->response();
    }

    #[OA\Put(
        path: '/api/tasks/{task}',
        summary: 'Update a task',
        description: 'Updates an existing task. Accessible to admins, sales managers, and sales executives.',
        tags: ['Tasks'],
        security: [['bearerAuth' => []]],
        parameters: [
            new OA\Parameter(name: 'task', in: 'path', required: true, description: 'Task ID.', schema: new OA\Schema(type: 'integer')),
        ],
        requestBody: new OA\RequestBody(
            required: false,
            content: new OA\JsonContent(
                properties: [
                    new OA\Property(property: 'user_id', type: 'integer', example: 2),
                    new OA\Property(property: 'customer_id', type: 'integer', nullable: true, example: 1),
                    new OA\Property(property: 'lead_id', type: 'integer', nullable: true, example: 1),
                    new OA\Property(property: 'title', type: 'string', maxLength: 255, example: 'Send follow-up proposal'),
                    new OA\Property(property: 'description', type: 'string', nullable: true, example: 'Email the revised pricing.'),
                    new OA\Property(property: 'priority', type: 'string', enum: ['low', 'medium', 'high']),
                    new OA\Property(property: 'status', type: 'string', enum: ['pending', 'in_progress', 'completed']),
                    new OA\Property(property: 'due_date', type: 'string', format: 'date', example: '2026-07-01'),
                    new OA\Property(property: 'reminder_at', type: 'string', format: 'date-time', nullable: true),
                ],
            ),
        ),
        responses: [
            new OA\Response(response: 200, description: 'Task updated successfully.', content: new OA\JsonContent(properties: [new OA\Property(property: 'data', ref: '#/components/schemas/Task')])),
            new OA\Response(response: 401, description: 'Unauthenticated.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
            new OA\Response(response: 403, description: 'Forbidden for the current role.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
            new OA\Response(response: 404, description: 'Task not found.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
            new OA\Response(response: 422, description: 'Validation error.', content: new OA\JsonContent(ref: '#/components/schemas/ValidationErrorResponse')),
        ],
    )]
    /**
     * Update an existing task.
     */
    public function update(UpdateTaskRequest $request, Task $task): JsonResponse
    {
        $task = $this->taskService->update($task, $request->validated(), $request->user());

        return (new TaskResource($task))->response();
    }

    #[OA\Delete(
        path: '/api/tasks/{task}',
        summary: 'Delete a task',
        description: 'Permanently deletes a task. Accessible to admins, sales managers, and sales executives.',
        tags: ['Tasks'],
        security: [['bearerAuth' => []]],
        parameters: [
            new OA\Parameter(name: 'task', in: 'path', required: true, description: 'Task ID.', schema: new OA\Schema(type: 'integer')),
        ],
        responses: [
            new OA\Response(response: 204, description: 'Task deleted successfully.'),
            new OA\Response(response: 401, description: 'Unauthenticated.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
            new OA\Response(response: 403, description: 'Forbidden for the current role.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
            new OA\Response(response: 404, description: 'Task not found.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
        ],
    )]
    /**
     * Remove a task.
     */
    public function destroy(Request $request, Task $task): JsonResponse
    {
        $this->taskService->delete($task, $request->user());

        return response()->json(null, 204);
    }
}
