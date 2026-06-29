# CRM & Lead Management System

A REST API for managing sales leads, customers, notes, tasks, and team activity — built on Laravel 12 with JWT authentication, role-based access control, and full OpenAPI/Swagger documentation.

---

## Table of Contents

1. [Project Overview](#1-project-overview)
2. [Features](#2-features)
3. [Tech Stack](#3-tech-stack)
4. [Architecture Overview](#4-architecture-overview)
5. [Installation](#5-installation)
6. [Environment Variables](#6-environment-variables)
7. [JWT Setup](#7-jwt-setup)
8. [Database Migration & Seeding](#8-database-migration--seeding)
9. [Running the Project](#9-running-the-project)
10. [Demo Accounts](#10-demo-accounts)
11. [Authentication Flow](#11-authentication-flow)
12. [Swagger Documentation](#12-swagger-documentation)
13. [API Modules](#13-api-modules)
14. [Folder Structure](#14-folder-structure)
15. [Database Design Summary](#15-database-design-summary)
16. [Role Matrix](#16-role-matrix)
17. [Assumptions](#17-assumptions)
18. [Future Improvements](#18-future-improvements)
19. [License](#19-license)

---

## 1. Project Overview

This system is a backend API for a small sales team to track the full lifecycle of a sale: capturing a **lead**, working it through a pipeline of statuses, converting it into a **customer**, attaching **notes** to that customer, and managing **follow-up tasks** along the way. Every meaningful action is recorded in an **activity** log, and a **dashboard** endpoint surfaces aggregated metrics (lead totals, conversion rate, overdue tasks, etc.).

Access is governed by three roles — **Admin**, **Sales Manager**, and **Sales Executive** — each with a different level of visibility and control over leads, customers, and tasks. Authentication is stateless, using JWT bearer tokens.

The API is fully documented with OpenAPI 3.0 (via L5-Swagger) and can be explored interactively at `/api/documentation` once the project is running.

## 2. Features

- JWT-based registration, login, token refresh, logout, and "current user" endpoint.
- Self-service role selection at registration (Sales Manager or Sales Executive); Admin accounts are provisioned separately.
- Full lead lifecycle: create, list (search/filter/paginate), view, update, delete, assign to a user, and update status.
- Lead-to-customer conversion, preserving the link back to the originating lead.
- Customer listing/detail views with related lead and notes eagerly loaded.
- Notes: append free-text notes to a customer, attributed to the authenticated user.
- Tasks: create/list/view/update/delete follow-up tasks linked to a lead or a customer, with priority, status, due date, and reminder support, plus filtering by user, status, priority, and overdue state.
- Activity log: an append-only audit trail of actions performed across the system.
- Dashboard: aggregated stats — total leads, total customers, today's follow-ups, overdue tasks, lead breakdown by status, and conversion rate.
- Role-based authorization enforced via middleware on every protected route.
- Rate limiting on registration and login (5 requests/minute) to slow down brute-force attempts.
- Complete, browsable OpenAPI 3.0 documentation generated from PHP attributes.

## 3. Tech Stack

| Layer            | Technology |
|-------------------|-----------|
| Language          | PHP 8.2+ |
| Framework         | Laravel 12 |
| Authentication    | JWT via `php-open-source-saver/jwt-auth` |
| Authorization     | Custom role middleware (`App\Http\Middleware\RoleMiddleware`) |
| API Documentation | OpenAPI 3.0 via `darkaonline/l5-swagger` (`zircote/swagger-php`, PHP attributes) |
| Database          | SQLite by default (MySQL/PostgreSQL supported via `.env`) |
| Testing           | PHPUnit |
| Code style        | Laravel Pint |
| Frontend tooling  | Vite + Tailwind CSS (asset pipeline only — this is an API-first project) |

## 4. Architecture Overview

The codebase follows a layered structure on top of standard Laravel conventions, keeping HTTP concerns separate from business logic:

```
HTTP Request
   │
   ▼
routes/api.php          → route definitions, middleware groups (auth, role, throttle)
   │
   ▼
Form Requests            → validation (App\Http\Requests\*)
   │
   ▼
Controllers               → thin, orchestration-only (App\Http\Controllers\*)
   │
   ▼
Services                  → business logic (App\Services\*)
   │
   ▼
Models / Eloquent          → persistence (App\Models\*)
   │
   ▼
API Resources              → response shaping (App\Http\Resources\*)
```

Key architectural decisions:

- **Controllers are thin.** They validate via Form Requests, delegate to a Service class, and shape the response via a Resource. No business rules live in controllers.
- **Services encapsulate business logic** (`AuthService`, `LeadService`, `CustomerService`, `TaskService`, `DashboardService`), keeping it testable and reusable independent of HTTP.
- **Stateless authentication.** JWT tokens carry identity; no server-side session is used for the API.
- **Role middleware (`role:admin,sales-manager`)** gates routes declaratively at the routing layer, in addition to `auth:api` for authentication.
- **API Resources** (`LeadResource`, `CustomerResource`, etc.) control exactly what is exposed in JSON responses, including conditionally-loaded relationships via `whenLoaded`.
- **OpenAPI documentation lives alongside the code** as PHP attributes on controllers, plus a dedicated `app/OpenApi/Schemas` directory for reusable response schemas — so the spec evolves with the code instead of drifting from it.

## 5. Installation

### Prerequisites

- PHP **8.2** or higher, with the typical extensions Laravel needs (`mbstring`, `openssl`, `pdo_sqlite` or `pdo_mysql`, `tokenizer`, `xml`, `ctype`, `json`, `bcmath`).
- Composer 2.x
- Node.js 18+ and npm (only needed if you intend to build the bundled front-end assets; not required for the API itself).

### Steps

```bash
# 1. Clone the repository
git clone <repository-url>
cd laravel_project

# 2. Install PHP dependencies
composer install

# 3. Copy the environment file
cp .env.example .env

# 4. Generate the application key
php artisan key:generate

# 5. Create the SQLite database file (default driver — skip if using MySQL/Postgres)
touch database/database.sqlite
# Windows PowerShell equivalent:
# New-Item -ItemType File -Path database/database.sqlite -Force

# 6. Generate the JWT secret (see section 7 for details)
php artisan jwt:secret

# 7. Run migrations and seed demo data
php artisan migrate --seed

# 8. Generate the Swagger/OpenAPI documentation
php artisan l5-swagger:generate

# 9. Serve the application
php artisan serve
```

The API will be available at `http://127.0.0.1:8000/api`, and the interactive documentation at `http://127.0.0.1:8000/api/documentation`.

## 6. Environment Variables

Copy `.env.example` to `.env` and adjust as needed. The variables most relevant to this project:

| Variable | Description | Default |
|---|---|---|
| `APP_NAME` | Application name | `Laravel` |
| `APP_ENV` | Environment (`local`, `production`, etc.) | `local` |
| `APP_KEY` | Laravel encryption key — set by `php artisan key:generate` | _(empty)_ |
| `APP_DEBUG` | Show detailed error pages | `true` |
| `APP_URL` | Base URL of the application | `http://localhost` |
| `DB_CONNECTION` | Database driver (`sqlite`, `mysql`, `pgsql`) | `sqlite` |
| `DB_DATABASE` | Path to the SQLite file, or DB name for other drivers | `database/database.sqlite` |
| `DB_HOST` / `DB_PORT` / `DB_USERNAME` / `DB_PASSWORD` | Connection details when not using SQLite | — |
| `JWT_SECRET` | Secret used to sign JWTs — set by `php artisan jwt:secret` | _(empty, required)_ |
| `JWT_TTL` | Access token lifetime, in minutes | `60` |
| `JWT_REFRESH_TTL` | Window during which an expired token can still be refreshed, in minutes | `20160` (2 weeks) |
| `JWT_ALGO` | Signing algorithm | `HS256` |
| `L5_SWAGGER_GENERATE_ALWAYS` | Regenerate the spec on every request (useful in local dev) | `false` |
| `L5_FORMAT_TO_USE_FOR_DOCS` | `json` or `yaml` for the documentation UI | `json` |

> If you switch `DB_CONNECTION` to `mysql` or `pgsql`, remove/comment the SQLite-specific line in `.env` and fill in `DB_HOST`, `DB_PORT`, `DB_DATABASE`, `DB_USERNAME`, and `DB_PASSWORD`.

## 7. JWT Setup

Authentication uses [`php-open-source-saver/jwt-auth`](https://github.com/PHP-Open-Source-Saver/jwt-auth), configured in `config/jwt.php` and `config/auth.php` (guard `api`, driver `jwt`).

1. **Generate the signing secret** (writes `JWT_SECRET` into `.env` automatically):
   ```bash
   php artisan jwt:secret
   ```
2. **Tune the token lifetimes** if needed, via `.env`:
   ```env
   JWT_TTL=60            # access token lifetime, in minutes
   JWT_REFRESH_TTL=20160 # refresh window, in minutes
   ```
3. **How tokens are issued and consumed:**
   - `POST /api/auth/register` and `POST /api/auth/login` return an `access_token` (type `bearer`) and its `expires_in` (seconds).
   - Send the token on every subsequent request as:
     ```
     Authorization: Bearer <access_token>
     ```
   - `POST /api/auth/refresh` exchanges a still-refreshable token (even if expired, within `JWT_REFRESH_TTL`) for a brand-new one.
   - `POST /api/auth/logout` blacklists the current token so it can no longer be used.

No additional setup is required beyond running `php artisan jwt:secret` once.

## 8. Database Migration & Seeding

Run migrations and seeders together:

```bash
php artisan migrate --seed
```

Or separately:

```bash
php artisan migrate     # create all tables
php artisan db:seed     # populate roles and demo users
```

To start completely fresh (drops all tables first):

```bash
php artisan migrate:fresh --seed
```

Seeding runs two seeders, in order:

1. **`RoleSeeder`** — creates the three roles: `admin`, `sales-manager`, `sales-executive`.
2. **`DemoUserSeeder`** — creates one ready-to-use account per role (see [Demo Accounts](#10-demo-accounts) below).

## 9. Running the Project

Start the built-in PHP server:

```bash
php artisan serve
```

By default this serves the app at `http://127.0.0.1:8000`. The API itself is rooted at `/api` (e.g. `http://127.0.0.1:8000/api/leads`).

Optional, if you want the queue worker, log viewer, and Vite dev server running alongside the app (mainly useful if you touch the bundled front-end scaffolding — not required to exercise the API):

```bash
composer run dev
```

Run the automated test suite at any time with:

```bash
php artisan test
```

## 10. Demo Accounts

The `DemoUserSeeder` provisions one account per role so you can log in immediately after seeding. All accounts share the password `password`.

| Role | Email | Password |
|---|---|---|
| **Admin** | `admin@example.com` | `password` |
| **Sales Manager** | `manager@example.com` | `password` |
| **Sales Executive** | `executive@example.com` | `password` |

Log in via `POST /api/auth/login` with any of the credentials above to obtain a JWT, then use that token to exercise the rest of the API (see [Authentication Flow](#11-authentication-flow)).

## 11. Authentication Flow

1. **Register** (optional — demo accounts already exist):
   ```http
   POST /api/auth/register
   Content-Type: application/json

   {
     "name": "Jane Doe",
     "email": "jane.doe@example.com",
     "password": "secret123",
     "password_confirmation": "secret123",
     "role": "sales-executive"
   }
   ```
   `role` is optional and limited to `sales-manager` or `sales-executive` — it defaults to `sales-executive` if omitted. Admin accounts cannot be self-registered; they must be seeded or created by another admin.

2. **Login:**
   ```http
   POST /api/auth/login
   Content-Type: application/json

   {
     "email": "admin@example.com",
     "password": "password"
   }
   ```
   Response:
   ```json
   {
     "access_token": "eyJ...",
     "token_type": "bearer",
     "expires_in": 3600,
     "user": { "id": 1, "name": "Alice Admin", "email": "admin@example.com", "role": { "...": "..." } }
   }
   ```

3. **Authenticate subsequent requests** by sending the token in the `Authorization` header:
   ```
   Authorization: Bearer eyJ...
   ```

4. **Get the current user:**
   ```http
   GET /api/auth/me
   Authorization: Bearer eyJ...
   ```

5. **Refresh the token** before/after it expires (within the refresh window):
   ```http
   POST /api/auth/refresh
   Authorization: Bearer eyJ...
   ```

6. **Logout** (blacklists the token):
   ```http
   POST /api/auth/logout
   Authorization: Bearer eyJ...
   ```

All endpoints other than `register`, `login`, and `refresh` require a valid bearer token; routes are additionally gated by role (see [Role Matrix](#16-role-matrix)).

## 12. Swagger Documentation

The full API is documented with OpenAPI 3.0 using PHP attributes (`zircote/swagger-php`) rendered through `darkaonline/l5-swagger`.

- **Interactive UI:** `http://127.0.0.1:8000/api/documentation`
- **Raw spec (JSON):** `http://127.0.0.1:8000/docs`

To regenerate the spec after changing any controller annotations:

```bash
php artisan l5-swagger:generate
```

To authenticate inside the Swagger UI, click **Authorize**, paste a bearer token obtained from `/api/auth/login`, and all "try it out" requests will include it automatically.

Documentation source lives in:
- `app/Http/Controllers/Controller.php` — global `Info` block, the `bearerAuth` security scheme, and tag definitions.
- Each controller — per-endpoint `summary`, `description`, `parameters`, `requestBody`, and `responses`.
- `app/OpenApi/Schemas/*.php` — reusable response schema definitions (`Lead`, `Customer`, `Note`, `Task`, `Activity`, etc.).

## 13. API Modules

All routes are prefixed with `/api`. 🔒 indicates a route requires a valid JWT; roles listed are the only roles permitted.

### Authentication (`/api/auth`)

| Method | Endpoint | Description | Access |
|---|---|---|---|
| POST | `/auth/register` | Register a new user | Public (rate-limited 5/min) |
| POST | `/auth/login` | Authenticate and receive a token | Public (rate-limited 5/min) |
| POST | `/auth/refresh` | Exchange a token for a new one | Bearer token |
| POST | `/auth/logout` | Invalidate the current token | 🔒 Any authenticated user |
| GET | `/auth/me` | Get the authenticated user | 🔒 Any authenticated user |

### Leads (`/api/leads`)

| Method | Endpoint | Description | Access |
|---|---|---|---|
| GET | `/leads` | List leads (search, filter by status, paginate) | 🔒 Admin, Sales Manager, Sales Executive |
| POST | `/leads` | Create a lead | 🔒 Admin, Sales Manager, Sales Executive |
| GET | `/leads/{lead}` | View a lead | 🔒 Admin, Sales Manager, Sales Executive |
| PUT/PATCH | `/leads/{lead}` | Update a lead | 🔒 Admin, Sales Manager, Sales Executive |
| DELETE | `/leads/{lead}` | Delete a lead | 🔒 Admin, Sales Manager |
| PATCH | `/leads/{lead}/assign` | Assign/unassign a lead to a user | 🔒 Admin, Sales Manager |
| PATCH | `/leads/{lead}/status` | Update a lead's status | 🔒 Admin, Sales Manager, Sales Executive |
| POST | `/leads/{lead}/convert` | Convert a lead into a customer | 🔒 Admin, Sales Manager |

### Customers (`/api/customers`)

| Method | Endpoint | Description | Access |
|---|---|---|---|
| GET | `/customers` | List customers | 🔒 Admin, Sales Manager |
| GET | `/customers/{customer}` | View a customer (with lead + notes) | 🔒 Admin, Sales Manager |

### Notes (`/api/customers/{customer}/notes`)

| Method | Endpoint | Description | Access |
|---|---|---|---|
| GET | `/customers/{customer}/notes` | List notes for a customer | 🔒 Admin, Sales Manager |
| POST | `/customers/{customer}/notes` | Add a note to a customer | 🔒 Admin, Sales Manager |

### Tasks (`/api/tasks`)

| Method | Endpoint | Description | Access |
|---|---|---|---|
| GET | `/tasks` | List tasks (filter by user, status, priority, overdue) | 🔒 Admin, Sales Manager, Sales Executive |
| POST | `/tasks` | Create a task (must link to a lead or a customer) | 🔒 Admin, Sales Manager, Sales Executive |
| GET | `/tasks/{task}` | View a task | 🔒 Admin, Sales Manager, Sales Executive |
| PUT/PATCH | `/tasks/{task}` | Update a task | 🔒 Admin, Sales Manager, Sales Executive |
| DELETE | `/tasks/{task}` | Delete a task | 🔒 Admin, Sales Manager, Sales Executive |

### Activities (`/api/activities`)

| Method | Endpoint | Description | Access |
|---|---|---|---|
| GET | `/activities` | Paginated audit log, latest first | 🔒 Admin, Sales Manager |

### Dashboard (`/api/dashboard`)

| Method | Endpoint | Description | Access |
|---|---|---|---|
| GET | `/dashboard` | Aggregated stats (totals, conversion rate, overdue tasks, leads by status) | 🔒 Admin, Sales Manager, Sales Executive |

Full request/response schemas, parameters, and error codes for every endpoint are available in the [Swagger UI](#12-swagger-documentation).

## 14. Folder Structure

```
laravel_project/
├── app/
│   ├── Enums/                  # LeadStatus, TaskPriority, TaskStatus
│   ├── Http/
│   │   ├── Controllers/        # Thin controllers (Auth, Lead, Customer, Note, Task, Activity, Dashboard)
│   │   ├── Middleware/         # RoleMiddleware (role-based access control)
│   │   ├── Requests/           # Form Request validation, grouped by domain (Auth, Lead, Customer, Task)
│   │   └── Resources/          # JSON response shaping (AuthResource, LeadResource, etc.)
│   ├── Models/                 # Eloquent models (User, Role, Lead, Customer, Note, Task, Activity)
│   ├── OpenApi/
│   │   └── Schemas/            # Reusable OpenAPI component schemas (Lead, Customer, Task, etc.)
│   ├── Providers/              # Service container bindings
│   └── Services/               # Business logic (AuthService, LeadService, CustomerService, TaskService, DashboardService)
├── config/                     # Laravel + jwt-auth + l5-swagger configuration
├── database/
│   ├── factories/              # Model factories used in tests/seeding
│   ├── migrations/             # Schema definitions for every table
│   └── seeders/                # RoleSeeder, DemoUserSeeder
├── routes/
│   ├── api.php                 # All API routes, grouped by auth/role middleware
│   ├── console.php
│   └── web.php
├── storage/api-docs/           # Generated OpenAPI spec (api-docs.json)
├── tests/
│   ├── Feature/
│   └── Unit/
├── .env.example
├── composer.json
└── README.md
```

## 15. Database Design Summary

| Table | Purpose | Key relationships |
|---|---|---|
| `roles` | The three system roles (`admin`, `sales-manager`, `sales-executive`) | `users.role_id → roles.id` |
| `users` | Application users / sales team members | belongs to `roles`; has many `leads` (as creator/assignee), `tasks`, `notes`, `activities` |
| `leads` | Prospective customers, tracked through a status pipeline | `assigned_to → users.id` (nullable), `created_by → users.id`; has one `customer` |
| `customers` | Leads that have been converted into paying/active accounts | `lead_id → leads.id` (unique — one customer per lead); has many `notes` |
| `notes` | Free-text notes logged against a customer | `customer_id → customers.id`, `user_id → users.id` |
| `tasks` | Follow-up tasks linked to a lead and/or a customer | `user_id → users.id`, `customer_id → customers.id` (nullable), `lead_id → leads.id` (nullable) |
| `activities` | Append-only audit log of actions taken in the system | `user_id → users.id`; polymorphic-style `subject_type` + `subject_id` (no `updated_at`) |

**Notes on design:**
- `leads.status` is a string column backed by the `LeadStatus` enum (`new`, `contacted`, `qualified`, `proposal_sent`, `won`, `lost`).
- `tasks.priority` / `tasks.status` are string columns backed by the `TaskPriority` (`low`, `medium`, `high`) and `TaskStatus` (`pending`, `in_progress`, `completed`) enums.
- A `customers.lead_id` unique constraint enforces a strict 1:1 relationship between a lead and the customer it became.
- A task must reference at least a `lead_id` or a `customer_id` — enforced at the validation layer (`StoreTaskRequest` / `UpdateTaskRequest`), not the database, to keep both fields independently nullable.
- `activities` has no `updated_at` column by design — it is an immutable log.

## 16. Role Matrix

| Capability | Admin | Sales Manager | Sales Executive |
|---|:---:|:---:|:---:|
| Register / Login / Logout / Me | ✅ | ✅ | ✅ |
| List / view / create / update leads | ✅ | ✅ | ✅ |
| Delete a lead | ✅ | ✅ | ❌ |
| Assign a lead to a user | ✅ | ✅ | ❌ |
| Update lead status | ✅ | ✅ | ✅ |
| Convert a lead into a customer | ✅ | ✅ | ❌ |
| List / view customers | ✅ | ✅ | ❌ |
| List / add notes on a customer | ✅ | ✅ | ❌ |
| List / view / create / update / delete tasks | ✅ | ✅ | ✅ |
| View the dashboard | ✅ | ✅ | ✅ |
| List activities (audit log) | ✅ | ✅ | ❌ |

> Authorization is enforced server-side via the `role:` middleware on each route group (see `routes/api.php`); the table above reflects what is actually permitted, not just UI-level hints.

## 17. Assumptions

- A single "admin" tier was assumed sufficient — there is no further distinction between, e.g., "super admin" vs. "admin".
- Self-registration is intentionally restricted to Sales Manager and Sales Executive; provisioning an Admin account is treated as an operational/seeding concern rather than a public API capability.
- A lead can be converted at most once — there is no unconvert/undo flow, and `customers.lead_id` is unique to enforce this at the database level.
- "Overdue" tasks are defined as tasks with a `due_date` in the past and a `status` other than `completed`.
- Pagination defaults to 15 items per page across all paginated list endpoints, overridable via `per_page`.
- SQLite is used as the default datastore for ease of evaluation; the schema and queries are written to be portable to MySQL/PostgreSQL without modification.
- The activity log is populated by application code at the point actions occur; there is no database-trigger-based auditing.
- JWT is used instead of session/cookie auth since this is a pure JSON API intended to be consumed by external/SPA/mobile clients.

## 18. Future Improvements

- Add granular, per-record ownership checks (e.g., a Sales Executive only managing tasks/leads assigned to them) rather than role-only gating.
- Add soft deletes for leads, customers, and tasks to support recovery and more complete audit trails.
- Add email notifications/reminders for upcoming task due dates.
- Add bulk operations (bulk lead import, bulk assignment).
- Add API versioning (`/api/v1/...`) ahead of any breaking changes.
- Add rate limiting more broadly across write endpoints, not just auth.
- Add automated factories/seeders for sample leads, customers, notes, and tasks to make manual exploration of the dashboard and listing endpoints richer out of the box.
- Expand automated test coverage (currently limited to the framework's default smoke tests) with feature tests per module and role.
- Consider OAuth2/social login as an alternative to password-based auth.

## 19. License

This project is open-sourced under the [MIT license](https://opensource.org/licenses/MIT).
