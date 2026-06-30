<?php

namespace App\Http\Controllers;

use App\Http\Resources\CustomerResource;
use App\Http\Resources\LeadResource;
use App\Http\Resources\TaskResource;
use App\Models\Customer;
use App\Models\Lead;
use App\Models\Role;
use App\Models\Task;
use App\Support\Search;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use OpenApi\Attributes as OA;

class SearchController extends Controller
{
    private const RESULTS_PER_GROUP = 5;

    #[OA\Get(
        path: '/api/search',
        summary: 'Global search',
        description: 'Searches leads, customers, and tasks for a free-text query and returns the top matches grouped by type. Customers are only included for admins and sales managers.',
        tags: ['Search'],
        security: [['bearerAuth' => []]],
        parameters: [
            new OA\Parameter(name: 'q', in: 'query', required: true, description: 'Free-text search query.', schema: new OA\Schema(type: 'string')),
        ],
        responses: [
            new OA\Response(
                response: 200,
                description: 'Grouped search results.',
                content: new OA\JsonContent(properties: [
                    new OA\Property(property: 'leads', type: 'array', items: new OA\Items(ref: '#/components/schemas/Lead')),
                    new OA\Property(property: 'customers', type: 'array', items: new OA\Items(ref: '#/components/schemas/Customer')),
                    new OA\Property(property: 'tasks', type: 'array', items: new OA\Items(ref: '#/components/schemas/Task')),
                ]),
            ),
            new OA\Response(response: 401, description: 'Unauthenticated.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
        ],
    )]
    /**
     * Search leads, customers, and tasks for a free-text query.
     */
    public function index(Request $request): JsonResponse
    {
        $term = trim((string) $request->query('q', ''));

        if ($term === '') {
            return response()->json(['leads' => [], 'customers' => [], 'tasks' => []]);
        }

        $operator = Search::operator();
        $actor = $request->user();

        $leads = Lead::query()
            ->with(['assignedUser', 'creator'])
            ->where(function ($query) use ($term, $operator) {
                $query->where('first_name', $operator, "%{$term}%")
                    ->orWhere('last_name', $operator, "%{$term}%")
                    ->orWhere('email', $operator, "%{$term}%")
                    ->orWhere('company', $operator, "%{$term}%");
            })
            ->limit(self::RESULTS_PER_GROUP)
            ->get();

        $tasks = Task::query()
            ->with(['user', 'lead', 'customer'])
            ->when($actor->hasRole(Role::SALES_EXECUTIVE), fn ($query) => $query->where('user_id', $actor->id))
            ->where('title', $operator, "%{$term}%")
            ->limit(self::RESULTS_PER_GROUP)
            ->get();

        $customers = collect();

        if ($actor->hasRole(Role::ADMIN, Role::SALES_MANAGER)) {
            $customers = Customer::query()
                ->with(['lead', 'notes'])
                ->where(function ($query) use ($term, $operator) {
                    $query->where('contact_name', $operator, "%{$term}%")
                        ->orWhere('company', $operator, "%{$term}%")
                        ->orWhere('email', $operator, "%{$term}%")
                        ->orWhere('phone', $operator, "%{$term}%");
                })
                ->limit(self::RESULTS_PER_GROUP)
                ->get();
        }

        return response()->json([
            'leads' => LeadResource::collection($leads),
            'customers' => CustomerResource::collection($customers),
            'tasks' => TaskResource::collection($tasks),
        ]);
    }
}
