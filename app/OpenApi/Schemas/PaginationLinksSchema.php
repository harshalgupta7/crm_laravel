<?php

namespace App\OpenApi\Schemas;

use OpenApi\Attributes as OA;

#[OA\Schema(
    schema: 'PaginationLinks',
    properties: [
        new OA\Property(property: 'first', type: 'string', nullable: true, example: '/api/leads?page=1'),
        new OA\Property(property: 'last', type: 'string', nullable: true, example: '/api/leads?page=5'),
        new OA\Property(property: 'prev', type: 'string', nullable: true, example: null),
        new OA\Property(property: 'next', type: 'string', nullable: true, example: '/api/leads?page=2'),
    ],
)]
class PaginationLinksSchema
{
}
