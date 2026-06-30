<?php

use App\Http\Controllers\ActivityController;
use App\Http\Controllers\Auth\AuthController;
use App\Http\Controllers\CustomerController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\LeadController;
use App\Http\Controllers\NoteController;
use App\Http\Controllers\SearchController;
use App\Http\Controllers\TaskController;
use App\Http\Controllers\UserController;
use Illuminate\Support\Facades\Route;

Route::prefix('auth')->group(function () {
    Route::middleware('throttle:5,1')->group(function () {
        Route::post('register', [AuthController::class, 'register']);
        Route::post('login', [AuthController::class, 'login']);
    });

    Route::post('refresh', [AuthController::class, 'refresh']);

    Route::middleware('auth:api')->group(function () {
        Route::post('logout', [AuthController::class, 'logout']);
        Route::get('me', [AuthController::class, 'me']);
    });
});

Route::middleware('auth:api')->group(function () {
    Route::get('users', [UserController::class, 'index']);
    Route::get('search', [SearchController::class, 'index']);

    Route::middleware('role:admin,sales-manager')->group(function () {
        Route::patch('leads/{lead}/assign', [LeadController::class, 'assign']);
        Route::post('leads/{lead}/convert', [CustomerController::class, 'convert']);
        Route::delete('leads/{lead}', [LeadController::class, 'destroy']);
    });

    Route::middleware('role:admin,sales-manager,sales-executive')->group(function () {
        Route::patch('leads/{lead}/status', [LeadController::class, 'updateStatus']);
        Route::apiResource('leads', LeadController::class)->except(['destroy']);

        Route::apiResource('tasks', TaskController::class);

        Route::get('dashboard', [DashboardController::class, 'index']);
    });

    Route::middleware('role:admin,sales-manager')->group(function () {
        Route::get('customers', [CustomerController::class, 'index']);
        Route::get('customers/{customer}', [CustomerController::class, 'show']);
        Route::get('customers/{customer}/notes', [NoteController::class, 'index']);
        Route::post('customers/{customer}/notes', [NoteController::class, 'store']);

        Route::get('activities', [ActivityController::class, 'index']);
    });
});
