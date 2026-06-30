# CRM & Lead Management System

A full-stack CRM application for managing sales leads, customers, notes, tasks, and team activity. The project consists of a **Laravel 12** backend (REST API, JWT authentication, RBAC) and a **React 19 + TypeScript** frontend (Vite, Tailwind CSS, shadcn/ui) that together provide a complete, production-style admin dashboard for a sales team.

---

## Table of Contents

1. [Features](#features)
2. [Tech Stack](#tech-stack)
3. [Project Structure](#project-structure)
4. [Installation](#installation)
5. [Environment Variables](#environment-variables)
6. [Authentication Flow](#authentication-flow)
7. [Demo Accounts](#demo-accounts)
8. [Frontend Pages](#frontend-pages)
9. [Search](#search)
10. [Lead Management](#lead-management)
11. [Customer Management](#customer-management)
12. [Task Management](#task-management)
13. [Activity Timeline](#activity-timeline)
14. [UI/UX](#uiux)
15. [API Documentation](#api-documentation)
16. [Database Design](#database-design)
17. [Docker](#docker)
18. [Screenshots](#screenshots)
19. [Known Limitations](#known-limitations)
20. [Future Improvements](#future-improvements)
21. [License](#license)

---

## Features

### Backend

- JWT Authentication (HttpOnly Cookies)
- Automatic Access-Token Refresh
- Role Based Access Control (Admin, Sales Manager, Sales Executive)
- Lead Management
- Customer Management
- Customer Notes
- Task Management
- Activity Timeline
- Dashboard Statistics
- Global Search (leads, customers, tasks)
- Swagger / OpenAPI Documentation
- Demo Data Seeding

### Frontend

- Responsive Admin Dashboard
- Secure Cookie-Based Authentication with Automatic Token Refresh
- Dashboard (aggregated stats and recent activity feed)
- Leads (list, search, filter, assign, status updates, conversion)
- Lead Detail page
- Customers (list with linked lead and notes)
- Customer Detail page
- Customer Notes
- Tasks (with user, lead, and customer autocomplete)
- Activities (paginated audit trail)
- Global Search (debounced, searches leads, customers, and tasks)
- User Autocomplete
- Lead Autocomplete
- Customer Autocomplete
- Loading Skeletons
- Toast Notifications
- Responsive UI

---

## Tech Stack

### Backend

- Laravel 12
- PostgreSQL
- JWT (`php-open-source-saver/jwt-auth`)
- L5 Swagger (OpenAPI 3.0)

### Frontend

- React 19
- Vite
- TypeScript
- Tailwind CSS
- shadcn/ui
- React Router
- Axios
- React Hook Form
- Sonner (toast notifications)
- Lucide React (icons)

---

## Project Structure

```
.
├── app/                  # Laravel backend (Controllers, Services, Models, Middleware, Resources)
├── routes/                # API route definitions
├── database/              # Migrations, seeders, schema dump, ERD docs
├── config/                 # Laravel & CORS configuration
├── docs/                    # ERD and Postman collections
├── frontend/                 # React + TypeScript single-page application
│   ├── src/
│   │   ├── api/                # Axios instance & API request modules
│   │   ├── components/          # Feature components (leads, customers, tasks, activities, ui, ...)
│   │   ├── context/               # React context (auth state)
│   │   ├── hooks/                   # Custom hooks
│   │   ├── pages/                    # Route-level pages (Dashboard, Leads, Customers, Tasks, Activities, Login)
│   │   ├── routes/                    # React Router configuration & protected routes
│   │   └── types/                      # Shared TypeScript types
│   └── package.json
└── Dockerfile
```

**Backend (project root)** — A Laravel REST API responsible for authentication, authorization, business logic, and persistence. It issues a JWT on login and sets it as an HttpOnly cookie; all CRM data (leads, customers, notes, tasks, activities) is served through versioned `/api` endpoints.

**`frontend/`** — A Vite-powered React SPA that consumes the Laravel API. It handles routing, protected routes, forms, and all UI rendering using Tailwind CSS and shadcn/ui components.

---

## Installation

### Backend

```bash
composer install
copy .env.example .env
php artisan key:generate
php artisan jwt:secret
php artisan migrate --seed
php artisan serve
```

The backend runs on **http://localhost:8000**.

### Frontend

```bash
cd frontend
npm install
npm run dev
```

The frontend runs on **http://localhost:3000**.

> Run both servers simultaneously during development — the React app at `:3000` talks to the Laravel API at `:8000`.

---

## Environment Variables

### Backend (`.env`)

| Variable | Description |
|---|---|
| `APP_URL` | Base URL of the Laravel application |
| `DB_CONNECTION` / `DB_HOST` / `DB_PORT` / `DB_DATABASE` / `DB_USERNAME` / `DB_PASSWORD` | PostgreSQL connection settings |
| `JWT_SECRET` | Secret key used to sign JWTs (generate with `php artisan jwt:secret`) |
| `JWT_TTL` / `JWT_REFRESH_TTL` | Token and refresh token lifetimes (minutes) |
| `FRONTEND_URL` | URL of the React app, used for CORS and cookie domain configuration |
| `L5_SWAGGER_GENERATE_ALWAYS` | Whether Swagger docs regenerate automatically |

### Frontend (`frontend/.env`)

```
VITE_API_URL=http://localhost:8000
```

---

## Authentication Flow

Authentication is cookie-based — **no token is ever stored in `localStorage`**.

```
React Login
     ↓
Laravel Login API
     ↓
JWT issued → Stored as HttpOnly Cookie
     ↓
Browser sends cookie on every request automatically
     ↓
React checks /api/auth/me → Protected Routes render
     ↓
On any 401 response:
     ↓
Axios interceptor calls /api/auth/refresh
     ↓
New access-token cookie set by server
     ↓
Original request retried automatically
     ↓
If refresh fails → Logout forced
```

Because the JWT lives in an HttpOnly cookie, it is inaccessible to client-side JavaScript, which mitigates token theft via XSS. On app load (and after navigation to a protected route), the React app calls `/api/auth/me` to validate the session and hydrate the authenticated user before rendering protected content.

The Axios response interceptor handles silent token refresh: when any API call returns a `401`, it calls `/api/auth/refresh` once, then replays all queued failed requests. If the refresh itself fails, the user is logged out automatically.

---

## Demo Accounts

All demo accounts use the password: `password`

| Role | Name | Email | Password |
|---|---|---|---|
| Admin | Alice Admin | `admin@example.com` | `password` |
| Sales Manager | Mark Manager | `manager@example.com` | `password` |
| Sales Executive | Eve Executive | `executive@example.com` | `password` |

These accounts are created by `DemoUserSeeder` when running `php artisan migrate --seed`.

---

## Frontend Pages

| Page | Description |
|---|---|
| **Dashboard** | Aggregated stats — lead totals, conversion rate, overdue tasks, follow-ups; recent activity feed |
| **Leads** | List, search, filter, assign, and update lead status; convert to customer |
| **Lead Detail** | Single lead view — status history, assignment, conversion, and related customer link |
| **Customers** | Customer list with linked lead and notes |
| **Customer Detail** | Single customer view with notes and related lead link |
| **Tasks** | Follow-up task management with priority, status, due-date highlighting, and lead/customer association |
| **Activities** | Paginated audit trail of actions across the system with clickable entity links |

---

## Search

The application provides a **Global Search** bar in the top navigation, plus per-page inline search on every list view.

| Search | Scope | Notes |
|---|---|---|
| **Global Search** | Leads, Customers, Tasks | Debounced (350 ms), server-side, recent-search history stored locally |
| **Lead Search** | Leads list | Debounced, case-insensitive, server-side |
| **Customer Search** | Customers list | Debounced, case-insensitive, server-side |
| **Task Search** | Tasks list | Debounced, case-insensitive, server-side |

---

## Lead Management

- **List view** — searchable, filterable by status, assignable in bulk
- **Lead Detail page** — full lead profile, current status, assigned user, related customer (after conversion)
- **Status changes** — controlled workflow (e.g. New → Contacted → Qualified → …)
- **Assignment** — admin/manager can assign leads to any sales executive
- **Conversion** — leads can be converted to customers; the detail page links to the resulting customer record

---

## Customer Management

- **List view** — searchable, shows company / contact name and linked lead
- **Customer Detail page** — full customer profile with linked lead reference
- **Notes** — freeform notes can be added and viewed per customer
- Customers are created exclusively via lead conversion (no standalone customer creation)

---

## Task Management

- **User autocomplete** — search and select any user as the task assignee
- **Lead / Customer association** — each task is linked to either a lead or a customer (toggle in the form)
- **Lead autocomplete** / **Customer autocomplete** — type-ahead search when linking a task
- **Due-date highlighting** — overdue tasks (past due date, not completed) are flagged with a destructive warning icon
- **Ownership restrictions** — role-based visibility; executives see only their own tasks

---

## Activity Timeline

- Every significant action (lead created, assigned, status changed, converted; task created/updated/deleted; customer note added) is recorded automatically
- Each row shows a **coloured icon** representing the action type, the acting user's name, a description with a **clickable link** to the affected entity, and a **relative timestamp** (e.g. "3 hours ago") with the exact time on hover
- The timeline is paginated and available both on the Activities page and as a recent-activity widget on the Dashboard

---

## UI/UX

- Modern SaaS-inspired design built with Tailwind CSS and shadcn/ui
- **Floating sidebar** with avatar, role display, and logout — collapsible nav groups for main and workspace items (Calendar and Pipeline shown as UI placeholders)
- **Dashboard cards** — stat tiles with trend indicators and a recent activity feed
- **Responsive layout** — works across desktop and tablet breakpoints
- **Skeleton loading** — every table and list shows content-shaped skeletons while data is fetched
- **Empty states** — friendly empty-state illustrations and calls-to-action when a list has no data
- **Global search** in the top navbar with dropdown results and recent-search history
- **Sticky table headers** — column headers remain visible while scrolling long lists
- **Premium dialogs** — all create/edit/delete/assign/convert actions use polished modal dialogs with server-side validation feedback

---

## API Documentation

Interactive OpenAPI 3.0 documentation is generated by L5-Swagger and available at:

```
http://localhost:8000/api/documentation
```

---

## Database Design

An entity-relationship diagram and schema notes are documented in [`docs/ERD.md`](docs/ERD.md). A ready-made PostgreSQL schema dump is also available at `database/schema.sql` for quickly inspecting or restoring the schema.

---

## Docker

Build and run the backend in a container:

```bash
docker build -t crm-backend .
docker run -p 8000:8000 --env-file .env crm-backend
```

The frontend is not currently containerized — run it locally with `npm run dev` (or `npm run build` and serve the static output separately) while pointing `VITE_API_URL` at the containerized backend.

---

## Screenshots

> Screenshots will be added here. Place image files under `docs/screenshots/` and reference them below.

| Login | Dashboard |
|---|---|
| _(placeholder)_ | _(placeholder)_ |

| Leads | Lead Detail |
|---|---|
| _(placeholder)_ | _(placeholder)_ |

| Customers | Customer Detail |
|---|---|
| _(placeholder)_ | _(placeholder)_ |

| Tasks | Activities |
|---|---|
| _(placeholder)_ | _(placeholder)_ |

---

## Known Limitations

- **User Management** — creating, editing, or deactivating user accounts via the UI is intentionally out of scope; accounts are managed via seeders or directly in the database.
- **Calendar** — the Calendar nav item in the sidebar is a UI placeholder with no backing implementation.
- **Pipeline** — the Pipeline nav item is similarly a placeholder.
- **No email integrations** — no outbound email (reminders, notifications, lead assignment alerts).
- **No real-time notifications** — all data requires a manual page refresh or re-navigation to reflect changes made by other users.
- **No file attachments** — notes and leads do not support document or image uploads.

---

## Future Improvements

- Real-time notifications (WebSockets / broadcasting)
- File uploads for leads, customers, and notes
- Email reminders and assignment alerts
- Advanced analytics and reporting charts
- User Management (admin UI for creating and managing accounts and roles)
- Calendar integration
- Kanban pipeline view

---

## License

MIT
