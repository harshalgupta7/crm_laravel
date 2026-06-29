<?php

namespace App\Services;

use App\Models\Role;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Illuminate\Validation\ValidationException;
use PHPOpenSourceSaver\JWTAuth\JWTGuard;

class AuthService
{
    /**
     * Roles a user is allowed to self-select at registration.
     *
     * @var list<string>
     */
    private const SELF_REGISTERABLE_ROLES = [
        Role::SALES_MANAGER,
        Role::SALES_EXECUTIVE,
    ];

    /**
     * Register a new user and return a freshly issued access token.
     *
     * @param  array<string, mixed>  $data
     * @return array<string, mixed>
     */
    public function register(array $data): array
    {
        $roleSlug = in_array($data['role'] ?? null, self::SELF_REGISTERABLE_ROLES, true)
            ? $data['role']
            : Role::SALES_EXECUTIVE;

        $role = Role::where('slug', $roleSlug)->firstOrFail();

        $user = User::create([
            'name' => $data['name'],
            'email' => $data['email'],
            'password' => $data['password'],
            'role_id' => $role->id,
        ]);

        return $this->respondWithToken($this->guard()->login($user), $user);
    }

    /**
     * Attempt to authenticate a user and return a freshly issued access token.
     *
     * @param  array<string, mixed>  $credentials
     * @return array<string, mixed>
     */
    public function login(array $credentials): array
    {
        if (! $token = $this->guard()->attempt($credentials)) {
            throw ValidationException::withMessages([
                'email' => ['The provided credentials are incorrect.'],
            ]);
        }

        /** @var User $user */
        $user = $this->guard()->user();

        return $this->respondWithToken($token, $user);
    }

    /**
     * Exchange the token currently attached to the request for a new one.
     *
     * @return array<string, mixed>
     */
    public function refresh(): array
    {
        $token = $this->guard()->refresh();

        /** @var User $user */
        $user = $this->guard()->setToken($token)->user();

        return $this->respondWithToken($token, $user);
    }

    /**
     * Invalidate the token currently attached to the request.
     */
    public function logout(): void
    {
        $this->guard()->logout();
    }

    /**
     * Get the currently authenticated user with their role loaded.
     */
    public function me(): User
    {
        /** @var User $user */
        $user = $this->guard()->user();

        return $user->load('role');
    }

    /**
     * Build the standard token response payload.
     *
     * @return array<string, mixed>
     */
    private function respondWithToken(string $token, User $user): array
    {
        return [
            'access_token' => $token,
            'token_type' => 'bearer',
            'expires_in' => $this->guard()->factory()->getTTL() * 60,
            'user' => $user->load('role'),
        ];
    }

    private function guard(): JWTGuard
    {
        /** @var JWTGuard $guard */
        $guard = Auth::guard('api');

        return $guard;
    }
}
