<?php

namespace App\Http\Controllers;

use App\Http\Resources\UserResource;
use App\Models\User;
use App\Support\Search;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use OpenApi\Attributes as OA;

class UserController extends Controller
{
    #[OA\Get(
        path: '/api/users',
        summary: 'List users',
        description: 'Returns a lightweight, searchable list of users (id and name only), used to populate assignment comboboxes.',
        tags: ['Users'],
        security: [['bearerAuth' => []]],
        parameters: [
            new OA\Parameter(name: 'search', in: 'query', description: 'Free-text search by user name.', schema: new OA\Schema(type: 'string')),
        ],
        responses: [
            new OA\Response(
                response: 200,
                description: 'A list of users.',
                content: new OA\JsonContent(properties: [
                    new OA\Property(property: 'data', type: 'array', items: new OA\Items(properties: [
                        new OA\Property(property: 'id', type: 'integer'),
                        new OA\Property(property: 'name', type: 'string'),
                    ])),
                ]),
            ),
            new OA\Response(response: 401, description: 'Unauthenticated.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
        ],
    )]
    /**
     * Display a searchable list of users.
     */
    public function index(Request $request): JsonResponse
    {
        $query = User::query()->orderBy('name');

        if ($search = $request->query('search')) {
            $query->where('name', Search::operator(), "%{$search}%");
        }

        $users = $query->limit(20)->get();

        return UserResource::collection($users)->response();
    }
}
