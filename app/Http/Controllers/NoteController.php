<?php

namespace App\Http\Controllers;

use App\Http\Requests\Customer\StoreCustomerNoteRequest;
use App\Http\Resources\NoteResource;
use App\Models\Customer;
use App\Services\CustomerService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use OpenApi\Attributes as OA;

class NoteController extends Controller
{
    public function __construct(private readonly CustomerService $customerService)
    {
    }

    #[OA\Get(
        path: '/api/customers/{customer}/notes',
        summary: 'List notes for a customer',
        description: 'Returns all notes attached to the given customer. Restricted to admins and sales managers.',
        tags: ['Notes'],
        security: [['bearerAuth' => []]],
        parameters: [
            new OA\Parameter(name: 'customer', in: 'path', required: true, description: 'Customer ID.', schema: new OA\Schema(type: 'integer')),
        ],
        responses: [
            new OA\Response(
                response: 200,
                description: 'A list of notes for the customer.',
                content: new OA\JsonContent(properties: [
                    new OA\Property(property: 'data', type: 'array', items: new OA\Items(ref: '#/components/schemas/Note')),
                ]),
            ),
            new OA\Response(response: 401, description: 'Unauthenticated.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
            new OA\Response(response: 403, description: 'Forbidden for the current role.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
            new OA\Response(response: 404, description: 'Customer not found.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
        ],
    )]
    /**
     * Display the notes for a customer.
     */
    public function index(Customer $customer): JsonResponse
    {
        $notes = $this->customerService->listNotes($customer);

        return NoteResource::collection($notes)->response();
    }

    #[OA\Post(
        path: '/api/customers/{customer}/notes',
        summary: 'Add a note to a customer',
        description: 'Creates a new note for the given customer, recorded against the authenticated user. Restricted to admins and sales managers.',
        tags: ['Notes'],
        security: [['bearerAuth' => []]],
        parameters: [
            new OA\Parameter(name: 'customer', in: 'path', required: true, description: 'Customer ID.', schema: new OA\Schema(type: 'integer')),
        ],
        requestBody: new OA\RequestBody(
            required: true,
            content: new OA\JsonContent(
                required: ['note'],
                properties: [
                    new OA\Property(property: 'note', type: 'string', example: 'Called to follow up on the proposal.'),
                ],
            ),
        ),
        responses: [
            new OA\Response(response: 201, description: 'Note created successfully.', content: new OA\JsonContent(properties: [new OA\Property(property: 'data', ref: '#/components/schemas/Note')])),
            new OA\Response(response: 401, description: 'Unauthenticated.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
            new OA\Response(response: 403, description: 'Forbidden for the current role.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
            new OA\Response(response: 404, description: 'Customer not found.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
            new OA\Response(response: 422, description: 'Validation error.', content: new OA\JsonContent(ref: '#/components/schemas/ValidationErrorResponse')),
        ],
    )]
    /**
     * Store a new note for a customer.
     */
    public function store(StoreCustomerNoteRequest $request, Customer $customer): JsonResponse
    {
        $note = $this->customerService->addNote($customer, $request->validated(), $request->user());

        return (new NoteResource($note))->response()->setStatusCode(201);
    }
}
