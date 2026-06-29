<?php

namespace App\OpenApi\Schemas;

use OpenApi\Attributes as OA;

#[OA\Schema(
    schema: 'Activity',
    properties: [
        new OA\Property(property: 'id', type: 'integer', example: 1),
        new OA\Property(property: 'action', type: 'string', example: 'lead.status_updated'),
        new OA\Property(property: 'subject_type', type: 'string', example: 'App\\Models\\Lead'),
        new OA\Property(property: 'subject_id', type: 'integer', example: 1),
        new OA\Property(property: 'description', type: 'string', nullable: true, example: 'Lead status changed to qualified.'),
        new OA\Property(property: 'user', ref: '#/components/schemas/UserSummary', nullable: true),
        new OA\Property(property: 'created_at', type: 'string', format: 'date-time', nullable: true),
    ],
)]
class ActivitySchema
{
}
