--
-- PostgreSQL schema dump
--
-- Includes all application tables, indexes, constraints, and foreign keys,
-- plus seeded demo data for roles and demo users.
-- No environment-specific data is included.
--
-- Usage:
--   psql "<connection-string>" -f database/schema.sql
--

BEGIN;

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

-- =========================================================================
-- Tables
-- =========================================================================

CREATE TABLE roles (
    id bigserial PRIMARY KEY,
    name varchar(255) NOT NULL,
    slug varchar(255) NOT NULL,
    created_at timestamp(0) without time zone NULL,
    updated_at timestamp(0) without time zone NULL
);

CREATE TABLE users (
    id bigserial PRIMARY KEY,
    role_id bigint NULL,
    name varchar(255) NOT NULL,
    email varchar(255) NOT NULL,
    email_verified_at timestamp(0) without time zone NULL,
    password varchar(255) NOT NULL,
    remember_token varchar(100) NULL,
    created_at timestamp(0) without time zone NULL,
    updated_at timestamp(0) without time zone NULL
);

CREATE TABLE password_reset_tokens (
    email varchar(255) PRIMARY KEY,
    token varchar(255) NOT NULL,
    created_at timestamp(0) without time zone NULL
);

CREATE TABLE sessions (
    id varchar(255) PRIMARY KEY,
    user_id bigint NULL,
    ip_address varchar(45) NULL,
    user_agent text NULL,
    payload text NOT NULL,
    last_activity integer NOT NULL
);

CREATE TABLE cache (
    key varchar(255) PRIMARY KEY,
    value text NOT NULL,
    expiration integer NOT NULL
);

CREATE TABLE cache_locks (
    key varchar(255) PRIMARY KEY,
    owner varchar(255) NOT NULL,
    expiration integer NOT NULL
);

CREATE TABLE jobs (
    id bigserial PRIMARY KEY,
    queue varchar(255) NOT NULL,
    payload text NOT NULL,
    attempts smallint NOT NULL,
    reserved_at integer NULL,
    available_at integer NOT NULL,
    created_at integer NOT NULL
);

CREATE TABLE job_batches (
    id varchar(255) PRIMARY KEY,
    name varchar(255) NOT NULL,
    total_jobs integer NOT NULL,
    pending_jobs integer NOT NULL,
    failed_jobs integer NOT NULL,
    failed_job_ids text NOT NULL,
    options text NULL,
    cancelled_at integer NULL,
    created_at integer NOT NULL,
    finished_at integer NULL
);

CREATE TABLE failed_jobs (
    id bigserial PRIMARY KEY,
    uuid varchar(255) NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE personal_access_tokens (
    id bigserial PRIMARY KEY,
    tokenable_type varchar(255) NOT NULL,
    tokenable_id bigint NOT NULL,
    name text NOT NULL,
    token varchar(64) NOT NULL,
    abilities text NULL,
    last_used_at timestamp(0) without time zone NULL,
    expires_at timestamp(0) without time zone NULL,
    created_at timestamp(0) without time zone NULL,
    updated_at timestamp(0) without time zone NULL
);

CREATE TABLE leads (
    id bigserial PRIMARY KEY,
    assigned_to bigint NULL,
    created_by bigint NOT NULL,
    first_name varchar(255) NOT NULL,
    last_name varchar(255) NOT NULL,
    email varchar(255) NOT NULL,
    phone varchar(255) NULL,
    company varchar(255) NULL,
    status varchar(255) NOT NULL DEFAULT 'new',
    source varchar(255) NULL,
    created_at timestamp(0) without time zone NULL,
    updated_at timestamp(0) without time zone NULL
);

CREATE TABLE customers (
    id bigserial PRIMARY KEY,
    lead_id bigint NOT NULL,
    company varchar(255) NULL,
    contact_name varchar(255) NOT NULL,
    email varchar(255) NOT NULL,
    phone varchar(255) NULL,
    created_at timestamp(0) without time zone NULL,
    updated_at timestamp(0) without time zone NULL
);

CREATE TABLE notes (
    id bigserial PRIMARY KEY,
    customer_id bigint NOT NULL,
    user_id bigint NOT NULL,
    note text NOT NULL,
    created_at timestamp(0) without time zone NULL,
    updated_at timestamp(0) without time zone NULL
);

CREATE TABLE tasks (
    id bigserial PRIMARY KEY,
    user_id bigint NOT NULL,
    customer_id bigint NULL,
    lead_id bigint NULL,
    title varchar(255) NOT NULL,
    description text NULL,
    priority varchar(255) NOT NULL DEFAULT 'medium',
    status varchar(255) NOT NULL DEFAULT 'pending',
    due_date date NOT NULL,
    reminder_at timestamp(0) without time zone NULL,
    created_at timestamp(0) without time zone NULL,
    updated_at timestamp(0) without time zone NULL
);

CREATE TABLE activities (
    id bigserial PRIMARY KEY,
    user_id bigint NOT NULL,
    action varchar(255) NOT NULL,
    subject_type varchar(255) NOT NULL,
    subject_id bigint NOT NULL,
    description text NOT NULL,
    created_at timestamp(0) without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- =========================================================================
-- Unique constraints
-- =========================================================================

ALTER TABLE roles ADD CONSTRAINT roles_name_unique UNIQUE (name);
ALTER TABLE roles ADD CONSTRAINT roles_slug_unique UNIQUE (slug);

ALTER TABLE users ADD CONSTRAINT users_email_unique UNIQUE (email);

ALTER TABLE personal_access_tokens ADD CONSTRAINT personal_access_tokens_token_unique UNIQUE (token);

ALTER TABLE failed_jobs ADD CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid);

ALTER TABLE customers ADD CONSTRAINT customers_lead_id_unique UNIQUE (lead_id);

-- =========================================================================
-- Indexes
-- =========================================================================

CREATE INDEX sessions_user_id_index ON sessions (user_id);
CREATE INDEX sessions_last_activity_index ON sessions (last_activity);

CREATE INDEX jobs_queue_index ON jobs (queue);

CREATE INDEX personal_access_tokens_tokenable_type_tokenable_id_index ON personal_access_tokens (tokenable_type, tokenable_id);
CREATE INDEX personal_access_tokens_expires_at_index ON personal_access_tokens (expires_at);

CREATE INDEX leads_status_index ON leads (status);
CREATE INDEX leads_first_name_last_name_index ON leads (first_name, last_name);

CREATE INDEX tasks_status_index ON tasks (status);
CREATE INDEX tasks_priority_index ON tasks (priority);
CREATE INDEX tasks_due_date_index ON tasks (due_date);

CREATE INDEX activities_subject_type_subject_id_index ON activities (subject_type, subject_id);

-- =========================================================================
-- Foreign keys
-- =========================================================================

ALTER TABLE users
    ADD CONSTRAINT users_role_id_foreign FOREIGN KEY (role_id) REFERENCES roles (id) ON DELETE SET NULL;

ALTER TABLE leads
    ADD CONSTRAINT leads_assigned_to_foreign FOREIGN KEY (assigned_to) REFERENCES users (id) ON DELETE SET NULL;
ALTER TABLE leads
    ADD CONSTRAINT leads_created_by_foreign FOREIGN KEY (created_by) REFERENCES users (id) ON DELETE CASCADE;

ALTER TABLE customers
    ADD CONSTRAINT customers_lead_id_foreign FOREIGN KEY (lead_id) REFERENCES leads (id) ON DELETE CASCADE;

ALTER TABLE notes
    ADD CONSTRAINT notes_customer_id_foreign FOREIGN KEY (customer_id) REFERENCES customers (id) ON DELETE CASCADE;
ALTER TABLE notes
    ADD CONSTRAINT notes_user_id_foreign FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE;

ALTER TABLE tasks
    ADD CONSTRAINT tasks_user_id_foreign FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE;
ALTER TABLE tasks
    ADD CONSTRAINT tasks_customer_id_foreign FOREIGN KEY (customer_id) REFERENCES customers (id) ON DELETE SET NULL;
ALTER TABLE tasks
    ADD CONSTRAINT tasks_lead_id_foreign FOREIGN KEY (lead_id) REFERENCES leads (id) ON DELETE SET NULL;

ALTER TABLE activities
    ADD CONSTRAINT activities_user_id_foreign FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE;

-- =========================================================================
-- Seed data: roles
-- =========================================================================

INSERT INTO roles (name, slug, created_at, updated_at) VALUES
    ('Admin', 'admin', now(), now()),
    ('Sales Manager', 'sales-manager', now(), now()),
    ('Sales Executive', 'sales-executive', now(), now());

-- =========================================================================
-- Seed data: demo users
--
-- All demo accounts use the password "password".
-- =========================================================================

INSERT INTO users (role_id, name, email, password, email_verified_at, created_at, updated_at) VALUES
    ((SELECT id FROM roles WHERE slug = 'admin'), 'Alice Admin', 'admin@example.com', '$2y$12$igYhApmWD/W1xurIlpzZnugARGU5.G.ES1qXOVpQ0MkR1nX1Eq1Jm', now(), now(), now()),
    ((SELECT id FROM roles WHERE slug = 'sales-manager'), 'Mark Manager', 'manager@example.com', '$2y$12$igYhApmWD/W1xurIlpzZnugARGU5.G.ES1qXOVpQ0MkR1nX1Eq1Jm', now(), now(), now()),
    ((SELECT id FROM roles WHERE slug = 'sales-executive'), 'Eve Executive', 'executive@example.com', '$2y$12$igYhApmWD/W1xurIlpzZnugARGU5.G.ES1qXOVpQ0MkR1nX1Eq1Jm', now(), now(), now());

COMMIT;
