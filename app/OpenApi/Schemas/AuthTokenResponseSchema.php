<?php

namespace App\OpenApi\Schemas;

use OpenApi\Attributes as OA;

#[OA\Schema(
    schema: 'AuthTokenResponse',
    description: 'The JWT access token is set as an HttpOnly cookie and is not present in the response body.',
    properties: [
        new OA\Property(property: 'user', ref: '#/components/schemas/AuthUser'),
    ],
)]
class AuthTokenResponseSchema
{
}
