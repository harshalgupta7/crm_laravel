<?php

namespace App\Http\Controllers;

use App\Http\Resources\CustomerResource;
use App\Models\Customer;
use App\Models\Lead;
use App\Services\CustomerService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use OpenApi\Attributes as OA;

class CustomerController extends Controller
{
    public function __construct(private readonly CustomerService $customerService)
    {
    }

    #[OA\Post(
        path: '/api/leads/{lead}/convert',
        summary: 'Convert a lead into a customer',
        description: 'Creates a customer record from an existing lead. Restricted to admins and sales managers.',
        tags: ['Customers'],
        security: [['bearerAuth' => []]],
        parameters: [
            new OA\Parameter(name: 'lead', in: 'path', required: true, description: 'Lead ID.', schema: new OA\Schema(type: 'integer')),
        ],
        responses: [
            new OA\Response(response: 201, description: 'Customer created successfully.', content: new OA\JsonContent(properties: [new OA\Property(property: 'data', ref: '#/components/schemas/Customer')])),
            new OA\Response(response: 401, description: 'Unauthenticated.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
            new OA\Response(response: 403, description: 'Forbidden for the current role.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
            new OA\Response(response: 404, description: 'Lead not found.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
            new OA\Response(response: 422, description: 'Lead cannot be converted.', content: new OA\JsonContent(ref: '#/components/schemas/ValidationErrorResponse')),
        ],
    )]
    /**
     * Convert a lead into a customer.
     */
    public function convert(Request $request, Lead $lead): JsonResponse
    {
        $customer = $this->customerService->convertLead($lead, $request->user());

        return (new CustomerResource($customer))->response()->setStatusCode(201);
    }

    #[OA\Get(
        path: '/api/customers',
        summary: 'List customers',
        description: 'Returns a paginated list of customers. Restricted to admins and sales managers.',
        tags: ['Customers'],
        security: [['bearerAuth' => []]],
        parameters: [
            new OA\Parameter(name: 'per_page', in: 'query', description: 'Number of results per page.', schema: new OA\Schema(type: 'integer', default: 15)),
        ],
        responses: [
            new OA\Response(
                response: 200,
                description: 'A paginated list of customers.',
                content: new OA\JsonContent(properties: [
                    new OA\Property(property: 'data', type: 'array', items: new OA\Items(ref: '#/components/schemas/Customer')),
                    new OA\Property(property: 'links', ref: '#/components/schemas/PaginationLinks'),
                    new OA\Property(property: 'meta', ref: '#/components/schemas/PaginationMeta'),
                ]),
            ),
            new OA\Response(response: 401, description: 'Unauthenticated.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
            new OA\Response(response: 403, description: 'Forbidden for the current role.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
        ],
    )]
    /**
     * Display a paginated list of customers.
     */
    public function index(Request $request): JsonResponse
    {
        $customers = $this->customerService->list($request->only(['per_page']));

        return CustomerResource::collection($customers)->response();
    }

    #[OA\Get(
        path: '/api/customers/{customer}',
        summary: 'Get a customer',
        description: 'Returns a single customer with its related lead and notes. Restricted to admins and sales managers.',
        tags: ['Customers'],
        security: [['bearerAuth' => []]],
        parameters: [
            new OA\Parameter(name: 'customer', in: 'path', required: true, description: 'Customer ID.', schema: new OA\Schema(type: 'integer')),
        ],
        responses: [
            new OA\Response(response: 200, description: 'The requested customer.', content: new OA\JsonContent(properties: [new OA\Property(property: 'data', ref: '#/components/schemas/Customer')])),
            new OA\Response(response: 401, description: 'Unauthenticated.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
            new OA\Response(response: 403, description: 'Forbidden for the current role.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
            new OA\Response(response: 404, description: 'Customer not found.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
        ],
    )]
    /**
     * Display a single customer.
     */
    public function show(Customer $customer): JsonResponse
    {
        $customer->load(['lead', 'notes']);

        return (new CustomerResource($customer))->response();
    }
}
