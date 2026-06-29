<?php

namespace App\OpenApi\Schemas;

use OpenApi\Attributes as OA;

#[OA\Schema(
    schema: 'DashboardStats',
    properties: [
        new OA\Property(property: 'total_leads', type: 'integer', example: 120),
        new OA\Property(property: 'total_customers', type: 'integer', example: 45),
        new OA\Property(property: 'todays_follow_ups', type: 'integer', example: 6),
        new OA\Property(property: 'overdue_tasks', type: 'integer', example: 3),
        new OA\Property(
            property: 'leads_by_status',
            type: 'object',
            properties: [
                new OA\Property(property: 'new', type: 'integer', example: 30),
                new OA\Property(property: 'contacted', type: 'integer', example: 25),
                new OA\Property(property: 'qualified', type: 'integer', example: 20),
                new OA\Property(property: 'proposal_sent', type: 'integer', example: 15),
                new OA\Property(property: 'won', type: 'integer', example: 20),
                new OA\Property(property: 'lost', type: 'integer', example: 10),
            ],
        ),
        new OA\Property(property: 'conversion_rate', type: 'number', format: 'float', example: 37.5),
    ],
)]
class DashboardStatsSchema
{
}
