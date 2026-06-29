<?php

namespace App\OpenApi\Schemas;

use OpenApi\Attributes as OA;

#[OA\Schema(
    schema: 'Lead',
    properties: [
        new OA\Property(property: 'id', type: 'integer', example: 1),
        new OA\Property(property: 'first_name', type: 'string', example: 'John'),
        new OA\Property(property: 'last_name', type: 'string', example: 'Smith'),
        new OA\Property(property: 'email', type: 'string', format: 'email', example: 'john.smith@example.com'),
        new OA\Property(property: 'phone', type: 'string', nullable: true, example: '+1-555-0100'),
        new OA\Property(property: 'company', type: 'string', nullable: true, example: 'Acme Corp'),
        new OA\Property(
            property: 'status',
            type: 'string',
            enum: ['new', 'contacted', 'qualified', 'proposal_sent', 'won', 'lost'],
            example: 'new',
        ),
        new OA\Property(property: 'source', type: 'string', nullable: true, example: 'website'),
        new OA\Property(property: 'assigned_user', ref: '#/components/schemas/UserSummary', nullable: true),
        new OA\Property(property: 'creator', ref: '#/components/schemas/UserSummary', nullable: true),
        new OA\Property(property: 'created_at', type: 'string', format: 'date-time', nullable: true),
        new OA\Property(property: 'updated_at', type: 'string', format: 'date-time', nullable: true),
    ],
)]
class LeadSchema
{
}
