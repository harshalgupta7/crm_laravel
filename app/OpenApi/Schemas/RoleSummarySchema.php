<?php

namespace App\OpenApi\Schemas;

use OpenApi\Attributes as OA;

#[OA\Schema(
    schema: 'RoleSummary',
    properties: [
        new OA\Property(property: 'id', type: 'integer', example: 1),
        new OA\Property(property: 'name', type: 'string', example: 'Sales Executive'),
        new OA\Property(property: 'slug', type: 'string', example: 'sales-executive'),
    ],
)]
class RoleSummarySchema
{
}
