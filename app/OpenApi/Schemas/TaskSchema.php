<?php

namespace App\OpenApi\Schemas;

use OpenApi\Attributes as OA;

#[OA\Schema(
    schema: 'Task',
    properties: [
        new OA\Property(property: 'id', type: 'integer', example: 1),
        new OA\Property(property: 'title', type: 'string', example: 'Send follow-up proposal'),
        new OA\Property(property: 'description', type: 'string', nullable: true, example: 'Email the revised pricing.'),
        new OA\Property(property: 'priority', type: 'string', enum: ['low', 'medium', 'high'], nullable: true, example: 'medium'),
        new OA\Property(property: 'status', type: 'string', enum: ['pending', 'in_progress', 'completed'], nullable: true, example: 'pending'),
        new OA\Property(property: 'due_date', type: 'string', format: 'date', example: '2026-07-01'),
        new OA\Property(property: 'reminder_at', type: 'string', format: 'date-time', nullable: true),
        new OA\Property(property: 'user', ref: '#/components/schemas/UserSummary', nullable: true),
        new OA\Property(
            property: 'lead',
            type: 'object',
            nullable: true,
            properties: [
                new OA\Property(property: 'id', type: 'integer', example: 1),
                new OA\Property(property: 'first_name', type: 'string', example: 'John'),
                new OA\Property(property: 'last_name', type: 'string', example: 'Smith'),
            ],
        ),
        new OA\Property(
            property: 'customer',
            type: 'object',
            nullable: true,
            properties: [
                new OA\Property(property: 'id', type: 'integer', example: 1),
                new OA\Property(property: 'company', type: 'string', nullable: true, example: 'Acme Corp'),
                new OA\Property(property: 'contact_name', type: 'string', example: 'John Smith'),
            ],
        ),
        new OA\Property(property: 'created_at', type: 'string', format: 'date-time', nullable: true),
        new OA\Property(property: 'updated_at', type: 'string', format: 'date-time', nullable: true),
    ],
)]
class TaskSchema
{
}
