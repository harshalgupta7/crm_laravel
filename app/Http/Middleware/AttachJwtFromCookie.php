<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

/**
 * Bridges HttpOnly-cookie auth to jwt-auth's header-based parser.
 *
 * Runs ahead of auth:api so that, when no Authorization header is present,
 * the JWT stored in the auth cookie is copied onto the header. jwt-auth's
 * own guard/parser is left untouched and keeps working exactly as before.
 */
class AttachJwtFromCookie
{
    public function handle(Request $request, Closure $next): Response
    {
        if (! $request->headers->has('Authorization')) {
            $token = $request->cookie(config('jwt.cookie_key_name'));

            if ($token) {
                $request->headers->set('Authorization', 'Bearer '.$token);
            }
        }

        return $next($request);
    }
}
