<?php

namespace App\Http\Controllers;

use App\Services\DashboardService;
use Illuminate\Http\JsonResponse;
use OpenApi\Attributes as OA;

class DashboardController extends Controller
{
    public function __construct(private readonly DashboardService $dashboardService) {}

    #[OA\Get(
        path: '/api/dashboard',
        summary: 'Get dashboard statistics',
        description: 'Returns aggregated statistics for the CRM dashboard: lead and customer totals, today\'s follow-ups, overdue tasks, lead breakdown by status, and the conversion rate. Accessible to admins, sales managers, and sales executives.',
        tags: ['Dashboard'],
        security: [['bearerAuth' => []]],
        responses: [
            new OA\Response(response: 200, description: 'Aggregated dashboard statistics.', content: new OA\JsonContent(ref: '#/components/schemas/DashboardStats')),
            new OA\Response(response: 401, description: 'Unauthenticated.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
            new OA\Response(response: 403, description: 'Forbidden for the current role.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
        ],
    )]
    /**
     * Display aggregated dashboard statistics.
     */
    public function index(): JsonResponse
    {
        return response()->json($this->dashboardService->getStats());
    }
}
