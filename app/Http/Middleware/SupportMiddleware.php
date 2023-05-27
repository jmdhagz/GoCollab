<?php

namespace App\Http\Middleware;

use Closure;

class SupportMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next)
    {
        $user_roles = \Auth::user()->roles->pluck('role_id')->toArray();
        if (!in_array(1, $user_roles)) {
            abort(403);
        }

        return $next($request);
    }
}
