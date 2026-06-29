<?php

namespace App\Http\Controllers;

use OpenApi\Attributes as OA;

#[OA\Info(
    version: '1.0.0',
    title: 'CRM API Documentation',
    description: 'REST API for managing leads, customers, notes, tasks, activities, and dashboard statistics. Authentication uses JWT bearer tokens obtained via the login or register endpoints.',
)]
#[OA\SecurityScheme(
    securityScheme: 'bearerAuth',
    type: 'http',
    scheme: 'bearer',
    bearerFormat: 'JWT',
    description: 'Enter the JWT access token obtained from the login or register endpoint, e.g. "Bearer {token}".',
)]
#[OA\Tag(name: 'Authentication', description: 'User registration, login, token refresh, logout, and current-user endpoints.')]
#[OA\Tag(name: 'Leads', description: 'CRUD and workflow operations for sales leads.')]
#[OA\Tag(name: 'Customers', description: 'Customer records, created by converting leads.')]
#[OA\Tag(name: 'Notes', description: 'Notes attached to customers.')]
#[OA\Tag(name: 'Tasks', description: 'Follow-up tasks linked to leads or customers.')]
#[OA\Tag(name: 'Activities', description: 'Audit log of actions performed across the system.')]
#[OA\Tag(name: 'Dashboard', description: 'Aggregated statistics for the CRM dashboard.')]
abstract class Controller
{
    //
}
