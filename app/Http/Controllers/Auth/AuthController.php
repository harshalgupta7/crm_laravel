<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Http\Requests\Auth\LoginRequest;
use App\Http\Requests\Auth\RegisterRequest;
use App\Http\Resources\AuthResource;
use App\Services\AuthService;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Cookie;
use OpenApi\Attributes as OA;
use Symfony\Component\HttpFoundation\Cookie as CookieDefinition;

class AuthController extends Controller
{
    public function __construct(private readonly AuthService $authService)
    {
    }

    #[OA\Post(
        path: '/api/auth/register',
        summary: 'Register a new user',
        description: 'Creates a new user account with an optional self-selectable role (sales-manager or sales-executive, defaulting to sales-executive) and returns a freshly issued JWT access token. Rate limited to 5 requests per minute.',
        tags: ['Authentication'],
        requestBody: new OA\RequestBody(
            required: true,
            content: new OA\JsonContent(
                required: ['name', 'email', 'password', 'password_confirmation'],
                properties: [
                    new OA\Property(property: 'name', type: 'string', maxLength: 255, example: 'Jane Doe'),
                    new OA\Property(property: 'email', type: 'string', format: 'email', maxLength: 255, example: 'jane.doe@example.com'),
                    new OA\Property(property: 'password', type: 'string', format: 'password', minLength: 8, example: 'secret123'),
                    new OA\Property(property: 'password_confirmation', type: 'string', format: 'password', example: 'secret123'),
                    new OA\Property(property: 'role', type: 'string', enum: ['sales-manager', 'sales-executive'], example: 'sales-executive'),
                ],
            ),
        ),
        responses: [
            new OA\Response(response: 200, description: 'User registered successfully.', content: new OA\JsonContent(ref: '#/components/schemas/AuthTokenResponse')),
            new OA\Response(response: 422, description: 'Validation error.', content: new OA\JsonContent(ref: '#/components/schemas/ValidationErrorResponse')),
            new OA\Response(response: 429, description: 'Too many requests.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
        ],
    )]
    /**
     * Register a new user and issue an access token.
     */
    public function register(RegisterRequest $request): JsonResponse
    {
        return $this->tokenResponse(
            $this->authService->register($request->validated())
        );
    }

    #[OA\Post(
        path: '/api/auth/login',
        summary: 'Authenticate a user',
        description: 'Validates the given credentials and returns a freshly issued JWT access token. Rate limited to 5 requests per minute.',
        tags: ['Authentication'],
        requestBody: new OA\RequestBody(
            required: true,
            content: new OA\JsonContent(
                required: ['email', 'password'],
                properties: [
                    new OA\Property(property: 'email', type: 'string', format: 'email', example: 'jane.doe@example.com'),
                    new OA\Property(property: 'password', type: 'string', format: 'password', example: 'secret123'),
                ],
            ),
        ),
        responses: [
            new OA\Response(response: 200, description: 'Authenticated successfully.', content: new OA\JsonContent(ref: '#/components/schemas/AuthTokenResponse')),
            new OA\Response(response: 422, description: 'The provided credentials are incorrect.', content: new OA\JsonContent(ref: '#/components/schemas/ValidationErrorResponse')),
            new OA\Response(response: 429, description: 'Too many requests.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
        ],
    )]
    /**
     * Authenticate a user and issue an access token.
     */
    public function login(LoginRequest $request): JsonResponse
    {
        return $this->tokenResponse(
            $this->authService->login($request->validated())
        );
    }

    #[OA\Post(
        path: '/api/auth/refresh',
        summary: 'Refresh the access token',
        description: 'Exchanges the JWT access token supplied in the Authorization header for a newly issued one.',
        tags: ['Authentication'],
        security: [['bearerAuth' => []]],
        responses: [
            new OA\Response(response: 200, description: 'Token refreshed successfully.', content: new OA\JsonContent(ref: '#/components/schemas/AuthTokenResponse')),
            new OA\Response(response: 401, description: 'Token is missing, invalid, or expired.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
        ],
    )]
    /**
     * Exchange the current token for a new one.
     */
    public function refresh(): JsonResponse
    {
        return $this->tokenResponse($this->authService->refresh());
    }

    #[OA\Post(
        path: '/api/auth/logout',
        summary: 'Log out the current user',
        description: 'Invalidates the JWT access token supplied in the Authorization header.',
        tags: ['Authentication'],
        security: [['bearerAuth' => []]],
        responses: [
            new OA\Response(
                response: 200,
                description: 'Logged out successfully.',
                content: new OA\JsonContent(properties: [
                    new OA\Property(property: 'message', type: 'string', example: 'Successfully logged out.'),
                ]),
            ),
            new OA\Response(response: 401, description: 'Token is missing, invalid, or expired.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
        ],
    )]
    /**
     * Invalidate the current token.
     */
    public function logout(): JsonResponse
    {
        $this->authService->logout();

        return response()->json([
            'message' => 'Successfully logged out.',
        ])->withCookie($this->forgetTokenCookie());
    }

    #[OA\Get(
        path: '/api/auth/me',
        summary: 'Get the authenticated user',
        description: 'Returns the user associated with the current JWT access token, including their role.',
        tags: ['Authentication'],
        security: [['bearerAuth' => []]],
        responses: [
            new OA\Response(
                response: 200,
                description: 'The authenticated user.',
                content: new OA\JsonContent(properties: [
                    new OA\Property(property: 'user', ref: '#/components/schemas/AuthUser'),
                ]),
            ),
            new OA\Response(response: 401, description: 'Token is missing, invalid, or expired.', content: new OA\JsonContent(ref: '#/components/schemas/ErrorResponse')),
        ],
    )]
    /**
     * Return the authenticated user.
     */
    public function me(): JsonResponse
    {
        return response()->json([
            'user' => new AuthResource($this->authService->me()),
        ]);
    }

    /**
     * Build the standard authenticated-user JSON response and attach the
     * JWT as an HttpOnly cookie. The token itself is never exposed in the
     * response body.
     *
     * @param  array<string, mixed>  $payload
     */
    private function tokenResponse(array $payload): JsonResponse
    {
        return response()->json([
            'user' => new AuthResource($payload['user']),
        ])->withCookie($this->makeTokenCookie($payload['access_token'], $payload['expires_in']));
    }

    /**
     * Build the HttpOnly cookie carrying the JWT.
     */
    private function makeTokenCookie(string $token, int $expiresInSeconds): CookieDefinition
    {
        return Cookie::make(
            name: config('jwt.cookie_key_name'),
            value: $token,
            minutes: (int) ceil($expiresInSeconds / 60),
            path: '/',
            domain: null,
            secure: app()->environment('production'),
            httpOnly: true,
            raw: false,
            sameSite: 'lax',
        );
    }

    /**
     * Build an expired cookie that clears the JWT cookie on the client.
     */
    private function forgetTokenCookie(): CookieDefinition
    {
        return Cookie::forget(config('jwt.cookie_key_name'));
    }
}
