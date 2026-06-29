<?php

namespace App\Http\Controllers;

use App\Enums\LeadStatus;
use App\Http\Requests\Lead\AssignLeadRequest;
use App\Http\Requests\Lead\StoreLeadRequest;
use App\Http\Requests\Lead\UpdateLeadRequest;
use App\Http\Requests\Lead\UpdateLeadStatusRequest;
use App\Http\Resources\LeadResource;
use App\Models\Lead;
use App\Services\LeadService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use OpenApi\Attributes as OA;

class LeadController extends Controller
{
    public function __construct(private readonly LeadService $leadService)
    {
    }

    #[OA\Get(
        path: '/api/leads',
        summary: 'List leads',
        description: 'Returns a paginated, filterable list of leads. Accessible to admins, sales managers, and sales executives.',
        tags: ['Leads'],
        security: [['bearerAuth' => []]],
        parameters: [
            new OA\Parameter(name: 'search', in: 'query', description: 'Free-text search across lead name, email, or company.', schema: new OA\Schema(type: 'string')),
            new OA\Parameter(name: 'status', in: 'query', description: 'Filter by lead status.', schema: new OA\Schema(type: 'string', enum: ['new', 'contacted', 'qualified', 'proposal_sent', 'won', 'lost'])),
            new OA\Parameter(name: 'per_page', in: 'query', description: 'Number of results per page.', schema: new OA\Schema(type: 'integer', default: 15)),
        ],
        responses: [
            new OA\Response(
                response: 200,
                description: 'A paginated list of leads.',
                content: new OA\JsonContent(properties: [
                    new OA\Property(property: 'data', type: 'array', items: new OA\Items(ref: '#/components/schemas/Lead')),
                    new OA\Property(property: 'links', ref: '#/components/schemas/PaginationLinks'),
                    new OA\Property(property: 'meta', ref: '#/components/schemas/PaginationMeta'),
                ]),
            ),
            new OA\Response(response: 401, description: 'Unauthenticated.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
            new OA\Response(response: 403, description: 'Forbidden for the current role.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
        ],
    )]
    /**
     * Display a paginated, filterable list of leads.
     */
    public function index(Request $request): JsonResponse
    {
        $leads = $this->leadService->list($request->only(['search', 'status', 'per_page']));

        return LeadResource::collection($leads)->response();
    }

    #[OA\Post(
        path: '/api/leads',
        summary: 'Create a lead',
        description: 'Creates a new lead. Accessible to admins, sales managers, and sales executives.',
        tags: ['Leads'],
        security: [['bearerAuth' => []]],
        requestBody: new OA\RequestBody(
            required: true,
            content: new OA\JsonContent(
                required: ['first_name', 'last_name', 'email'],
                properties: [
                    new OA\Property(property: 'assigned_to', type: 'integer', nullable: true, example: 2),
                    new OA\Property(property: 'first_name', type: 'string', maxLength: 255, example: 'John'),
                    new OA\Property(property: 'last_name', type: 'string', maxLength: 255, example: 'Smith'),
                    new OA\Property(property: 'email', type: 'string', format: 'email', maxLength: 255, example: 'john.smith@example.com'),
                    new OA\Property(property: 'phone', type: 'string', maxLength: 50, nullable: true, example: '+1-555-0100'),
                    new OA\Property(property: 'company', type: 'string', maxLength: 255, nullable: true, example: 'Acme Corp'),
                    new OA\Property(property: 'status', type: 'string', enum: ['new', 'contacted', 'qualified', 'proposal_sent', 'won', 'lost'], nullable: true, example: 'new'),
                    new OA\Property(property: 'source', type: 'string', maxLength: 255, nullable: true, example: 'website'),
                ],
            ),
        ),
        responses: [
            new OA\Response(response: 201, description: 'Lead created successfully.', content: new OA\JsonContent(properties: [new OA\Property(property: 'data', ref: '#/components/schemas/Lead')])),
            new OA\Response(response: 401, description: 'Unauthenticated.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
            new OA\Response(response: 403, description: 'Forbidden for the current role.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
            new OA\Response(response: 422, description: 'Validation error.', content: new OA\JsonContent(ref: '#/components/schemas/ValidationErrorResponse')),
        ],
    )]
    /**
     * Store a newly created lead.
     */
    public function store(StoreLeadRequest $request): JsonResponse
    {
        $lead = $this->leadService->create($request->validated(), $request->user());

        return (new LeadResource($lead))->response()->setStatusCode(201);
    }

    #[OA\Get(
        path: '/api/leads/{lead}',
        summary: 'Get a lead',
        description: 'Returns a single lead with its assigned user and creator. Accessible to admins, sales managers, and sales executives.',
        tags: ['Leads'],
        security: [['bearerAuth' => []]],
        parameters: [
            new OA\Parameter(name: 'lead', in: 'path', required: true, description: 'Lead ID.', schema: new OA\Schema(type: 'integer')),
        ],
        responses: [
            new OA\Response(response: 200, description: 'The requested lead.', content: new OA\JsonContent(properties: [new OA\Property(property: 'data', ref: '#/components/schemas/Lead')])),
            new OA\Response(response: 401, description: 'Unauthenticated.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
            new OA\Response(response: 403, description: 'Forbidden for the current role.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
            new OA\Response(response: 404, description: 'Lead not found.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
        ],
    )]
    /**
     * Display a single lead.
     */
    public function show(Lead $lead): JsonResponse
    {
        $lead->load(['assignedUser', 'creator']);

        return (new LeadResource($lead))->response();
    }

    #[OA\Put(
        path: '/api/leads/{lead}',
        summary: 'Update a lead',
        description: 'Updates an existing lead. Accessible to admins, sales managers, and sales executives.',
        tags: ['Leads'],
        security: [['bearerAuth' => []]],
        parameters: [
            new OA\Parameter(name: 'lead', in: 'path', required: true, description: 'Lead ID.', schema: new OA\Schema(type: 'integer')),
        ],
        requestBody: new OA\RequestBody(
            required: false,
            content: new OA\JsonContent(
                properties: [
                    new OA\Property(property: 'assigned_to', type: 'integer', nullable: true, example: 2),
                    new OA\Property(property: 'first_name', type: 'string', maxLength: 255, example: 'John'),
                    new OA\Property(property: 'last_name', type: 'string', maxLength: 255, example: 'Smith'),
                    new OA\Property(property: 'email', type: 'string', format: 'email', maxLength: 255, example: 'john.smith@example.com'),
                    new OA\Property(property: 'phone', type: 'string', maxLength: 50, nullable: true, example: '+1-555-0100'),
                    new OA\Property(property: 'company', type: 'string', maxLength: 255, nullable: true, example: 'Acme Corp'),
                    new OA\Property(property: 'status', type: 'string', enum: ['new', 'contacted', 'qualified', 'proposal_sent', 'won', 'lost']),
                    new OA\Property(property: 'source', type: 'string', maxLength: 255, nullable: true, example: 'website'),
                ],
            ),
        ),
        responses: [
            new OA\Response(response: 200, description: 'Lead updated successfully.', content: new OA\JsonContent(properties: [new OA\Property(property: 'data', ref: '#/components/schemas/Lead')])),
            new OA\Response(response: 401, description: 'Unauthenticated.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
            new OA\Response(response: 403, description: 'Forbidden for the current role.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
            new OA\Response(response: 404, description: 'Lead not found.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
            new OA\Response(response: 422, description: 'Validation error.', content: new OA\JsonContent(ref: '#/components/schemas/ValidationErrorResponse')),
        ],
    )]
    /**
     * Update an existing lead.
     */
    public function update(UpdateLeadRequest $request, Lead $lead): JsonResponse
    {
        $lead = $this->leadService->update($lead, $request->validated());

        return (new LeadResource($lead))->response();
    }

    #[OA\Delete(
        path: '/api/leads/{lead}',
        summary: 'Delete a lead',
        description: 'Permanently deletes a lead. Restricted to admins and sales managers.',
        tags: ['Leads'],
        security: [['bearerAuth' => []]],
        parameters: [
            new OA\Parameter(name: 'lead', in: 'path', required: true, description: 'Lead ID.', schema: new OA\Schema(type: 'integer')),
        ],
        responses: [
            new OA\Response(response: 204, description: 'Lead deleted successfully.'),
            new OA\Response(response: 401, description: 'Unauthenticated.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
            new OA\Response(response: 403, description: 'Forbidden for the current role.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
            new OA\Response(response: 404, description: 'Lead not found.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
        ],
    )]
    /**
     * Remove a lead.
     */
    public function destroy(Lead $lead): JsonResponse
    {
        $this->leadService->delete($lead);

        return response()->json(null, 204);
    }

    #[OA\Patch(
        path: '/api/leads/{lead}/assign',
        summary: 'Assign a lead',
        description: 'Assigns a lead to a user, or unassigns it when null. Restricted to admins and sales managers.',
        tags: ['Leads'],
        security: [['bearerAuth' => []]],
        parameters: [
            new OA\Parameter(name: 'lead', in: 'path', required: true, description: 'Lead ID.', schema: new OA\Schema(type: 'integer')),
        ],
        requestBody: new OA\RequestBody(
            required: true,
            content: new OA\JsonContent(
                properties: [
                    new OA\Property(property: 'assigned_to', type: 'integer', nullable: true, example: 2),
                ],
            ),
        ),
        responses: [
            new OA\Response(response: 200, description: 'Lead assigned successfully.', content: new OA\JsonContent(properties: [new OA\Property(property: 'data', ref: '#/components/schemas/Lead')])),
            new OA\Response(response: 401, description: 'Unauthenticated.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
            new OA\Response(response: 403, description: 'Forbidden for the current role.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
            new OA\Response(response: 404, description: 'Lead not found.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
            new OA\Response(response: 422, description: 'Validation error.', content: new OA\JsonContent(ref: '#/components/schemas/ValidationErrorResponse')),
        ],
    )]
    /**
     * Assign a lead to a user.
     */
    public function assign(AssignLeadRequest $request, Lead $lead): JsonResponse
    {
        $lead = $this->leadService->assign($lead, $request->validated('assigned_to'), $request->user());

        return (new LeadResource($lead))->response();
    }

    #[OA\Patch(
        path: '/api/leads/{lead}/status',
        summary: 'Update lead status',
        description: 'Updates the status of a lead. Accessible to admins, sales managers, and sales executives.',
        tags: ['Leads'],
        security: [['bearerAuth' => []]],
        parameters: [
            new OA\Parameter(name: 'lead', in: 'path', required: true, description: 'Lead ID.', schema: new OA\Schema(type: 'integer')),
        ],
        requestBody: new OA\RequestBody(
            required: true,
            content: new OA\JsonContent(
                required: ['status'],
                properties: [
                    new OA\Property(property: 'status', type: 'string', enum: ['new', 'contacted', 'qualified', 'proposal_sent', 'won', 'lost'], example: 'qualified'),
                ],
            ),
        ),
        responses: [
            new OA\Response(response: 200, description: 'Lead status updated successfully.', content: new OA\JsonContent(properties: [new OA\Property(property: 'data', ref: '#/components/schemas/Lead')])),
            new OA\Response(response: 401, description: 'Unauthenticated.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
            new OA\Response(response: 403, description: 'Forbidden for the current role.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
            new OA\Response(response: 404, description: 'Lead not found.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
            new OA\Response(response: 422, description: 'Validation error.', content: new OA\JsonContent(ref: '#/components/schemas/ValidationErrorResponse')),
        ],
    )]
    /**
     * Update the status of a lead.
     */
    public function updateStatus(UpdateLeadStatusRequest $request, Lead $lead): JsonResponse
    {
        $lead = $this->leadService->updateStatus($lead, $request->enum('status', LeadStatus::class), $request->user());

        return (new LeadResource($lead))->response();
    }
}
