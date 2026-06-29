<?php

namespace App\OpenApi\Schemas;

use OpenApi\Attributes as OA;

#[OA\Schema(
    schema: 'Customer',
    properties: [
        new OA\Property(property: 'id', type: 'integer', example: 1),
        new OA\Property(property: 'lead_id', type: 'integer', nullable: true, example: 1),
        new OA\Property(property: 'company', type: 'string', nullable: true, example: 'Acme Corp'),
        new OA\Property(property: 'contact_name', type: 'string', example: 'John Smith'),
        new OA\Property(property: 'email', type: 'string', format: 'email', example: 'john.smith@example.com'),
        new OA\Property(property: 'phone', type: 'string', nullable: true, example: '+1-555-0100'),
        new OA\Property(property: 'lead', ref: '#/components/schemas/Lead', nullable: true),
        new OA\Property(
            property: 'notes',
            type: 'array',
            items: new OA\Items(ref: '#/components/schemas/Note'),
            nullable: true,
        ),
        new OA\Property(property: 'created_at', type: 'string', format: 'date-time', nullable: true),
        new OA\Property(property: 'updated_at', type: 'string', format: 'date-time', nullable: true),
    ],
)]
class CustomerSchema
{
}
