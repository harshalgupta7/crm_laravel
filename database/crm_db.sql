--
-- PostgreSQL database dump
--

\restrict GaKC9s7HJAcuu33NAQCHmr1wTgtumhp27uOYzJ9EFjgNAGlJsStJFb5ji1LO8OR

-- Dumped from database version 18.4 (eaf151e)
-- Dumped by pg_dump version 18.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: activities; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.activities (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    action character varying(255) NOT NULL,
    subject_type character varying(255) NOT NULL,
    subject_id bigint NOT NULL,
    description text NOT NULL,
    created_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.activities OWNER TO neondb_owner;

--
-- Name: activities_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.activities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.activities_id_seq OWNER TO neondb_owner;

--
-- Name: activities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.activities_id_seq OWNED BY public.activities.id;


--
-- Name: cache; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.cache (
    key character varying(255) NOT NULL,
    value text NOT NULL,
    expiration integer NOT NULL
);


ALTER TABLE public.cache OWNER TO neondb_owner;

--
-- Name: cache_locks; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.cache_locks (
    key character varying(255) NOT NULL,
    owner character varying(255) NOT NULL,
    expiration integer NOT NULL
);


ALTER TABLE public.cache_locks OWNER TO neondb_owner;

--
-- Name: customers; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.customers (
    id bigint NOT NULL,
    lead_id bigint NOT NULL,
    company character varying(255),
    contact_name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    phone character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.customers OWNER TO neondb_owner;

--
-- Name: customers_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.customers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.customers_id_seq OWNER TO neondb_owner;

--
-- Name: customers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.customers_id_seq OWNED BY public.customers.id;


--
-- Name: failed_jobs; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.failed_jobs (
    id bigint NOT NULL,
    uuid character varying(255) NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.failed_jobs OWNER TO neondb_owner;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.failed_jobs_id_seq OWNER TO neondb_owner;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;


--
-- Name: job_batches; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.job_batches (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    total_jobs integer NOT NULL,
    pending_jobs integer NOT NULL,
    failed_jobs integer NOT NULL,
    failed_job_ids text NOT NULL,
    options text,
    cancelled_at integer,
    created_at integer NOT NULL,
    finished_at integer
);


ALTER TABLE public.job_batches OWNER TO neondb_owner;

--
-- Name: jobs; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.jobs (
    id bigint NOT NULL,
    queue character varying(255) NOT NULL,
    payload text NOT NULL,
    attempts smallint NOT NULL,
    reserved_at integer,
    available_at integer NOT NULL,
    created_at integer NOT NULL
);


ALTER TABLE public.jobs OWNER TO neondb_owner;

--
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.jobs_id_seq OWNER TO neondb_owner;

--
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.jobs_id_seq OWNED BY public.jobs.id;


--
-- Name: leads; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.leads (
    id bigint NOT NULL,
    assigned_to bigint,
    created_by bigint NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    phone character varying(255),
    company character varying(255),
    status character varying(255) DEFAULT 'new'::character varying NOT NULL,
    source character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.leads OWNER TO neondb_owner;

--
-- Name: leads_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.leads_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.leads_id_seq OWNER TO neondb_owner;

--
-- Name: leads_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.leads_id_seq OWNED BY public.leads.id;


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE public.migrations OWNER TO neondb_owner;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.migrations_id_seq OWNER TO neondb_owner;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: notes; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.notes (
    id bigint NOT NULL,
    customer_id bigint NOT NULL,
    user_id bigint NOT NULL,
    note text NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.notes OWNER TO neondb_owner;

--
-- Name: notes_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.notes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notes_id_seq OWNER TO neondb_owner;

--
-- Name: notes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.notes_id_seq OWNED BY public.notes.id;


--
-- Name: password_reset_tokens; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.password_reset_tokens (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);


ALTER TABLE public.password_reset_tokens OWNER TO neondb_owner;

--
-- Name: personal_access_tokens; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.personal_access_tokens (
    id bigint NOT NULL,
    tokenable_type character varying(255) NOT NULL,
    tokenable_id bigint NOT NULL,
    name text NOT NULL,
    token character varying(64) NOT NULL,
    abilities text,
    last_used_at timestamp(0) without time zone,
    expires_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.personal_access_tokens OWNER TO neondb_owner;

--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.personal_access_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.personal_access_tokens_id_seq OWNER TO neondb_owner;

--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.personal_access_tokens_id_seq OWNED BY public.personal_access_tokens.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.roles (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.roles OWNER TO neondb_owner;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_seq OWNER TO neondb_owner;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.sessions (
    id character varying(255) NOT NULL,
    user_id bigint,
    ip_address character varying(45),
    user_agent text,
    payload text NOT NULL,
    last_activity integer NOT NULL
);


ALTER TABLE public.sessions OWNER TO neondb_owner;

--
-- Name: tasks; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.tasks (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    customer_id bigint,
    lead_id bigint,
    title character varying(255) NOT NULL,
    description text,
    priority character varying(255) DEFAULT 'medium'::character varying NOT NULL,
    status character varying(255) DEFAULT 'pending'::character varying NOT NULL,
    due_date date NOT NULL,
    reminder_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.tasks OWNER TO neondb_owner;

--
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tasks_id_seq OWNER TO neondb_owner;

--
-- Name: tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.tasks_id_seq OWNED BY public.tasks.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    email_verified_at timestamp(0) without time zone,
    password character varying(255) NOT NULL,
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    role_id bigint
);


ALTER TABLE public.users OWNER TO neondb_owner;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO neondb_owner;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: activities id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.activities ALTER COLUMN id SET DEFAULT nextval('public.activities_id_seq'::regclass);


--
-- Name: customers id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.customers ALTER COLUMN id SET DEFAULT nextval('public.customers_id_seq'::regclass);


--
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);


--
-- Name: jobs id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);


--
-- Name: leads id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.leads ALTER COLUMN id SET DEFAULT nextval('public.leads_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: notes id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.notes ALTER COLUMN id SET DEFAULT nextval('public.notes_id_seq'::regclass);


--
-- Name: personal_access_tokens id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.personal_access_tokens ALTER COLUMN id SET DEFAULT nextval('public.personal_access_tokens_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: tasks id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.tasks ALTER COLUMN id SET DEFAULT nextval('public.tasks_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: activities; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.activities (id, user_id, action, subject_type, subject_id, description, created_at) FROM stdin;
1	1	lead.created	App\\Models\\Lead	1	Created lead Loren Bode	2026-06-30 17:11:38
2	2	lead.created	App\\Models\\Lead	2	Created lead Lenna Wunsch	2026-06-30 17:11:40
3	3	lead.created	App\\Models\\Lead	3	Created lead Felipe Rogahn	2026-06-30 17:11:43
4	1	lead.created	App\\Models\\Lead	4	Created lead Nathanial Barton	2026-06-30 17:11:45
5	2	lead.created	App\\Models\\Lead	5	Created lead Adelia Kuhic	2026-06-30 17:11:47
6	3	lead.created	App\\Models\\Lead	6	Created lead Jany Walker	2026-06-30 17:11:49
7	1	lead.created	App\\Models\\Lead	7	Created lead Obie Ebert	2026-06-30 17:11:51
8	2	lead.created	App\\Models\\Lead	8	Created lead April Prosacco	2026-06-30 17:11:52
9	3	lead.created	App\\Models\\Lead	9	Created lead Eric Miller	2026-06-30 17:11:54
10	1	lead.created	App\\Models\\Lead	10	Created lead Mariano Wuckert	2026-06-30 17:11:56
11	2	lead.created	App\\Models\\Lead	11	Created lead Anabelle Kunde	2026-06-30 17:11:58
12	3	lead.created	App\\Models\\Lead	12	Created lead Ana Thompson	2026-06-30 17:12:00
13	1	lead.created	App\\Models\\Lead	13	Created lead Brett Metz	2026-06-30 17:12:02
14	2	lead.created	App\\Models\\Lead	14	Created lead Wava Kuhic	2026-06-30 17:12:04
15	3	lead.created	App\\Models\\Lead	15	Created lead Arnulfo Zulauf	2026-06-30 17:12:07
16	1	lead.created	App\\Models\\Lead	16	Created lead Lucinda Wiegand	2026-06-30 17:12:09
17	2	lead.created	App\\Models\\Lead	17	Created lead Maye Kohler	2026-06-30 17:12:11
18	3	lead.created	App\\Models\\Lead	18	Created lead Shawn Kreiger	2026-06-30 17:12:13
19	1	lead.created	App\\Models\\Lead	19	Created lead Lizzie Schimmel	2026-06-30 17:12:15
20	2	lead.created	App\\Models\\Lead	20	Created lead Rex Schamberger	2026-06-30 17:12:17
21	3	lead.created	App\\Models\\Lead	21	Created lead Audra O'Connell	2026-06-30 17:12:19
22	1	lead.created	App\\Models\\Lead	22	Created lead Alia Lang	2026-06-30 17:12:21
23	2	lead.created	App\\Models\\Lead	23	Created lead Libby Ward	2026-06-30 17:12:23
24	3	lead.created	App\\Models\\Lead	24	Created lead Libby Schulist	2026-06-30 17:12:26
25	1	lead.created	App\\Models\\Lead	25	Created lead Mazie Baumbach	2026-06-30 17:12:28
26	2	lead.created	App\\Models\\Lead	26	Created lead Marilie Feeney	2026-06-30 17:12:30
27	3	lead.created	App\\Models\\Lead	27	Created lead Stella Moore	2026-06-30 17:12:32
28	1	lead.created	App\\Models\\Lead	28	Created lead Helen Christiansen	2026-06-30 17:12:34
29	2	lead.created	App\\Models\\Lead	29	Created lead Charley Wiegand	2026-06-30 17:12:36
30	3	lead.created	App\\Models\\Lead	30	Created lead Imani Bauch	2026-06-30 17:12:38
31	1	lead.created	App\\Models\\Lead	31	Created lead Hettie Bogan	2026-06-30 17:12:40
32	2	lead.created	App\\Models\\Lead	32	Created lead Lorenza Rodriguez	2026-06-30 17:12:42
33	3	lead.created	App\\Models\\Lead	33	Created lead Damaris Runolfsdottir	2026-06-30 17:12:44
34	1	lead.created	App\\Models\\Lead	34	Created lead Leonor Hoeger	2026-06-30 17:12:46
35	2	lead.created	App\\Models\\Lead	35	Created lead Cassandra Heaney	2026-06-30 17:12:48
36	3	lead.created	App\\Models\\Lead	36	Created lead Xzavier Yundt	2026-06-30 17:12:51
37	1	lead.created	App\\Models\\Lead	37	Created lead Norene Kulas	2026-06-30 17:12:53
38	2	lead.created	App\\Models\\Lead	38	Created lead Kamryn Schroeder	2026-06-30 17:12:55
39	3	lead.created	App\\Models\\Lead	39	Created lead Carmine Jones	2026-06-30 17:12:57
40	1	lead.created	App\\Models\\Lead	40	Created lead Kylee Kulas	2026-06-30 17:12:59
41	2	lead.created	App\\Models\\Lead	41	Created lead Nasir Robel	2026-06-30 17:13:01
42	3	lead.created	App\\Models\\Lead	42	Created lead Ella McLaughlin	2026-06-30 17:13:03
43	1	lead.created	App\\Models\\Lead	43	Created lead Shanon Ward	2026-06-30 17:13:06
44	2	lead.created	App\\Models\\Lead	44	Created lead Nakia Hand	2026-06-30 17:13:08
45	3	lead.created	App\\Models\\Lead	45	Created lead Chasity Jones	2026-06-30 17:13:10
46	1	lead.created	App\\Models\\Lead	46	Created lead Maxwell Reichert	2026-06-30 17:13:12
47	2	lead.created	App\\Models\\Lead	47	Created lead Hermina Hill	2026-06-30 17:13:14
48	3	lead.created	App\\Models\\Lead	48	Created lead Tristian Crooks	2026-06-30 17:13:15
49	1	lead.created	App\\Models\\Lead	49	Created lead Elbert Gottlieb	2026-06-30 17:13:17
50	2	lead.created	App\\Models\\Lead	50	Created lead Ara Nader	2026-06-30 17:13:18
51	1	lead.converted	App\\Models\\Customer	1	Converted lead Alia Lang into a customer	2026-06-30 17:13:21
52	2	lead.converted	App\\Models\\Customer	2	Converted lead Chasity Jones into a customer	2026-06-30 17:13:24
53	3	lead.converted	App\\Models\\Customer	3	Converted lead Lizzie Schimmel into a customer	2026-06-30 17:13:28
54	1	lead.converted	App\\Models\\Customer	4	Converted lead Lorenza Rodriguez into a customer	2026-06-30 17:13:31
55	2	lead.converted	App\\Models\\Customer	5	Converted lead Lenna Wunsch into a customer	2026-06-30 17:13:34
56	3	lead.converted	App\\Models\\Customer	6	Converted lead Shawn Kreiger into a customer	2026-06-30 17:13:36
57	1	lead.converted	App\\Models\\Customer	7	Converted lead Cassandra Heaney into a customer	2026-06-30 17:13:39
58	2	lead.converted	App\\Models\\Customer	8	Converted lead Felipe Rogahn into a customer	2026-06-30 17:13:43
59	3	lead.converted	App\\Models\\Customer	9	Converted lead Maye Kohler into a customer	2026-06-30 17:13:47
60	1	lead.converted	App\\Models\\Customer	10	Converted lead Loren Bode into a customer	2026-06-30 17:13:50
61	2	lead.converted	App\\Models\\Customer	11	Converted lead Mazie Baumbach into a customer	2026-06-30 17:13:53
62	3	lead.converted	App\\Models\\Customer	12	Converted lead Hettie Bogan into a customer	2026-06-30 17:13:57
63	1	lead.converted	App\\Models\\Customer	13	Converted lead Jany Walker into a customer	2026-06-30 17:14:00
64	2	lead.converted	App\\Models\\Customer	14	Converted lead Nathanial Barton into a customer	2026-06-30 17:14:03
65	3	lead.converted	App\\Models\\Customer	15	Converted lead Eric Miller into a customer	2026-06-30 17:14:06
66	1	lead.converted	App\\Models\\Customer	16	Converted lead Audra O'Connell into a customer	2026-06-30 17:14:09
67	2	lead.converted	App\\Models\\Customer	17	Converted lead Shanon Ward into a customer	2026-06-30 17:14:12
68	1	task.created	App\\Models\\Task	1	Created task Prepare quote	2026-06-30 17:14:14
69	2	task.created	App\\Models\\Task	2	Created task Follow up call	2026-06-30 17:14:15
70	3	task.created	App\\Models\\Task	3	Created task Send onboarding docs	2026-06-30 17:14:17
71	1	task.created	App\\Models\\Task	4	Created task Check in with customer	2026-06-30 17:14:19
72	2	task.created	App\\Models\\Task	5	Created task Follow up call	2026-06-30 17:14:21
73	3	task.created	App\\Models\\Task	6	Created task Schedule demo	2026-06-30 17:14:23
74	1	task.created	App\\Models\\Task	7	Created task Check in with customer	2026-06-30 17:14:25
75	2	task.created	App\\Models\\Task	8	Created task Schedule demo	2026-06-30 17:14:27
76	3	task.created	App\\Models\\Task	9	Created task Send onboarding docs	2026-06-30 17:14:29
77	1	task.created	App\\Models\\Task	10	Created task Prepare quote	2026-06-30 17:14:31
78	2	task.created	App\\Models\\Task	11	Created task Follow up call	2026-06-30 17:14:32
79	3	task.created	App\\Models\\Task	12	Created task Send proposal	2026-06-30 17:14:34
80	1	task.created	App\\Models\\Task	13	Created task Check in with customer	2026-06-30 17:14:35
81	2	task.created	App\\Models\\Task	14	Created task Schedule demo	2026-06-30 17:14:37
82	3	task.created	App\\Models\\Task	15	Created task Prepare quote	2026-06-30 17:14:39
83	1	task.created	App\\Models\\Task	16	Created task Schedule demo	2026-06-30 17:14:40
84	2	task.created	App\\Models\\Task	17	Created task Review contract	2026-06-30 17:14:42
85	3	task.created	App\\Models\\Task	18	Created task Check in with customer	2026-06-30 17:14:44
86	1	task.created	App\\Models\\Task	19	Created task Follow up call	2026-06-30 17:14:46
87	2	task.created	App\\Models\\Task	20	Created task Review contract	2026-06-30 17:14:48
88	3	task.created	App\\Models\\Task	21	Created task Send proposal	2026-06-30 17:14:49
89	1	task.created	App\\Models\\Task	22	Created task Check in with customer	2026-06-30 17:14:51
90	2	task.created	App\\Models\\Task	23	Created task Send proposal	2026-06-30 17:14:53
91	3	task.created	App\\Models\\Task	24	Created task Prepare quote	2026-06-30 17:14:55
92	1	task.created	App\\Models\\Task	25	Created task Prepare quote	2026-06-30 17:14:56
93	2	task.created	App\\Models\\Task	26	Created task Send proposal	2026-06-30 17:14:58
94	3	task.created	App\\Models\\Task	27	Created task Review contract	2026-06-30 17:15:00
95	1	task.created	App\\Models\\Task	28	Created task Schedule demo	2026-06-30 17:15:02
96	2	task.created	App\\Models\\Task	29	Created task Schedule demo	2026-06-30 17:15:04
97	3	task.created	App\\Models\\Task	30	Created task Send onboarding docs	2026-06-30 17:15:06
98	1	task.created	App\\Models\\Task	31	Created task Send proposal	2026-06-30 17:15:07
99	2	task.created	App\\Models\\Task	32	Created task Discovery call	2026-06-30 17:15:09
100	3	task.created	App\\Models\\Task	33	Created task Prepare quote	2026-06-30 17:15:11
101	1	task.created	App\\Models\\Task	34	Created task Schedule demo	2026-06-30 17:15:13
102	2	task.created	App\\Models\\Task	35	Created task Check in with customer	2026-06-30 17:15:15
103	3	task.created	App\\Models\\Task	36	Created task Send onboarding docs	2026-06-30 17:15:17
104	1	task.created	App\\Models\\Task	37	Created task Review contract	2026-06-30 17:15:19
105	2	task.created	App\\Models\\Task	38	Created task Discovery call	2026-06-30 17:15:22
106	3	task.created	App\\Models\\Task	39	Created task Prepare quote	2026-06-30 17:15:24
107	1	task.created	App\\Models\\Task	40	Created task Prepare quote	2026-06-30 17:15:26
108	2	task.created	App\\Models\\Task	41	Created task Follow up call	2026-06-30 17:15:28
109	3	task.created	App\\Models\\Task	42	Created task Send proposal	2026-06-30 17:15:30
110	1	task.created	App\\Models\\Task	43	Created task Send onboarding docs	2026-06-30 17:15:32
111	2	task.created	App\\Models\\Task	44	Created task Send onboarding docs	2026-06-30 17:15:34
112	3	task.created	App\\Models\\Task	45	Created task Prepare quote	2026-06-30 17:15:36
113	1	task.created	App\\Models\\Task	46	Created task Check in with customer	2026-06-30 17:15:38
114	2	task.created	App\\Models\\Task	47	Created task Send onboarding docs	2026-06-30 17:15:40
115	3	task.created	App\\Models\\Task	48	Created task Discovery call	2026-06-30 17:15:42
116	1	task.created	App\\Models\\Task	49	Created task Schedule demo	2026-06-30 17:15:44
117	2	task.created	App\\Models\\Task	50	Created task Send proposal	2026-06-30 17:15:47
118	1	customer.note_added	App\\Models\\Customer	1	Added a note to customer Alia Lang	2026-06-30 17:15:48
119	1	customer.note_added	App\\Models\\Customer	1	Added a note to customer Alia Lang	2026-06-30 17:15:49
120	1	customer.note_added	App\\Models\\Customer	1	Added a note to customer Alia Lang	2026-06-30 17:15:51
121	1	customer.note_added	App\\Models\\Customer	1	Added a note to customer Alia Lang	2026-06-30 17:15:52
122	2	customer.note_added	App\\Models\\Customer	1	Added a note to customer Alia Lang	2026-06-30 17:15:53
123	2	customer.note_added	App\\Models\\Customer	2	Added a note to customer Chasity Jones	2026-06-30 17:15:55
124	2	customer.note_added	App\\Models\\Customer	2	Added a note to customer Chasity Jones	2026-06-30 17:15:56
125	3	customer.note_added	App\\Models\\Customer	2	Added a note to customer Chasity Jones	2026-06-30 17:15:57
126	1	customer.note_added	App\\Models\\Customer	2	Added a note to customer Chasity Jones	2026-06-30 17:15:58
127	1	customer.note_added	App\\Models\\Customer	3	Added a note to customer Lizzie Schimmel	2026-06-30 17:16:00
128	3	customer.note_added	App\\Models\\Customer	3	Added a note to customer Lizzie Schimmel	2026-06-30 17:16:01
129	2	customer.note_added	App\\Models\\Customer	3	Added a note to customer Lizzie Schimmel	2026-06-30 17:16:03
130	2	customer.note_added	App\\Models\\Customer	4	Added a note to customer Lorenza Rodriguez	2026-06-30 17:16:04
131	1	customer.note_added	App\\Models\\Customer	4	Added a note to customer Lorenza Rodriguez	2026-06-30 17:16:06
132	2	customer.note_added	App\\Models\\Customer	4	Added a note to customer Lorenza Rodriguez	2026-06-30 17:16:07
133	2	customer.note_added	App\\Models\\Customer	4	Added a note to customer Lorenza Rodriguez	2026-06-30 17:16:09
134	3	customer.note_added	App\\Models\\Customer	4	Added a note to customer Lorenza Rodriguez	2026-06-30 17:16:11
135	3	customer.note_added	App\\Models\\Customer	5	Added a note to customer Lenna Wunsch	2026-06-30 17:16:12
136	3	customer.note_added	App\\Models\\Customer	5	Added a note to customer Lenna Wunsch	2026-06-30 17:16:14
137	1	customer.note_added	App\\Models\\Customer	5	Added a note to customer Lenna Wunsch	2026-06-30 17:16:16
138	2	customer.note_added	App\\Models\\Customer	5	Added a note to customer Lenna Wunsch	2026-06-30 17:16:17
139	2	customer.note_added	App\\Models\\Customer	5	Added a note to customer Lenna Wunsch	2026-06-30 17:16:19
140	2	customer.note_added	App\\Models\\Customer	6	Added a note to customer Shawn Kreiger	2026-06-30 17:16:20
141	3	customer.note_added	App\\Models\\Customer	6	Added a note to customer Shawn Kreiger	2026-06-30 17:16:22
142	2	customer.note_added	App\\Models\\Customer	6	Added a note to customer Shawn Kreiger	2026-06-30 17:16:23
143	2	customer.note_added	App\\Models\\Customer	7	Added a note to customer Cassandra Heaney	2026-06-30 17:16:25
144	3	customer.note_added	App\\Models\\Customer	7	Added a note to customer Cassandra Heaney	2026-06-30 17:16:27
145	2	customer.note_added	App\\Models\\Customer	7	Added a note to customer Cassandra Heaney	2026-06-30 17:16:28
146	1	customer.note_added	App\\Models\\Customer	7	Added a note to customer Cassandra Heaney	2026-06-30 17:16:30
147	3	customer.note_added	App\\Models\\Customer	7	Added a note to customer Cassandra Heaney	2026-06-30 17:16:31
148	3	customer.note_added	App\\Models\\Customer	8	Added a note to customer Felipe Rogahn	2026-06-30 17:16:33
149	3	customer.note_added	App\\Models\\Customer	8	Added a note to customer Felipe Rogahn	2026-06-30 17:16:34
150	1	customer.note_added	App\\Models\\Customer	8	Added a note to customer Felipe Rogahn	2026-06-30 17:16:36
151	1	customer.note_added	App\\Models\\Customer	8	Added a note to customer Felipe Rogahn	2026-06-30 17:16:38
152	1	customer.note_added	App\\Models\\Customer	8	Added a note to customer Felipe Rogahn	2026-06-30 17:16:39
153	3	customer.note_added	App\\Models\\Customer	9	Added a note to customer Maye Kohler	2026-06-30 17:16:41
154	2	customer.note_added	App\\Models\\Customer	9	Added a note to customer Maye Kohler	2026-06-30 17:16:42
155	1	customer.note_added	App\\Models\\Customer	9	Added a note to customer Maye Kohler	2026-06-30 17:16:44
156	2	customer.note_added	App\\Models\\Customer	9	Added a note to customer Maye Kohler	2026-06-30 17:16:45
157	1	customer.note_added	App\\Models\\Customer	9	Added a note to customer Maye Kohler	2026-06-30 17:16:47
158	3	customer.note_added	App\\Models\\Customer	10	Added a note to customer Loren Bode	2026-06-30 17:16:48
159	1	customer.note_added	App\\Models\\Customer	10	Added a note to customer Loren Bode	2026-06-30 17:16:50
160	2	customer.note_added	App\\Models\\Customer	10	Added a note to customer Loren Bode	2026-06-30 17:16:51
161	2	customer.note_added	App\\Models\\Customer	11	Added a note to customer Mazie Baumbach	2026-06-30 17:16:53
162	1	customer.note_added	App\\Models\\Customer	11	Added a note to customer Mazie Baumbach	2026-06-30 17:16:55
163	1	customer.note_added	App\\Models\\Customer	11	Added a note to customer Mazie Baumbach	2026-06-30 17:16:56
164	1	customer.note_added	App\\Models\\Customer	12	Added a note to customer Hettie Bogan	2026-06-30 17:16:58
165	3	customer.note_added	App\\Models\\Customer	12	Added a note to customer Hettie Bogan	2026-06-30 17:16:59
166	3	customer.note_added	App\\Models\\Customer	12	Added a note to customer Hettie Bogan	2026-06-30 17:17:01
167	1	customer.note_added	App\\Models\\Customer	13	Added a note to customer Jany Walker	2026-06-30 17:17:02
168	3	customer.note_added	App\\Models\\Customer	13	Added a note to customer Jany Walker	2026-06-30 17:17:03
169	2	customer.note_added	App\\Models\\Customer	13	Added a note to customer Jany Walker	2026-06-30 17:17:05
170	2	customer.note_added	App\\Models\\Customer	14	Added a note to customer Nathanial Barton	2026-06-30 17:17:07
171	3	customer.note_added	App\\Models\\Customer	14	Added a note to customer Nathanial Barton	2026-06-30 17:17:08
172	1	customer.note_added	App\\Models\\Customer	14	Added a note to customer Nathanial Barton	2026-06-30 17:17:10
173	3	customer.note_added	App\\Models\\Customer	14	Added a note to customer Nathanial Barton	2026-06-30 17:17:11
174	3	customer.note_added	App\\Models\\Customer	14	Added a note to customer Nathanial Barton	2026-06-30 17:17:12
175	3	customer.note_added	App\\Models\\Customer	15	Added a note to customer Eric Miller	2026-06-30 17:17:14
176	3	customer.note_added	App\\Models\\Customer	15	Added a note to customer Eric Miller	2026-06-30 17:17:16
177	1	customer.note_added	App\\Models\\Customer	15	Added a note to customer Eric Miller	2026-06-30 17:17:17
178	2	customer.note_added	App\\Models\\Customer	15	Added a note to customer Eric Miller	2026-06-30 17:17:18
179	3	customer.note_added	App\\Models\\Customer	16	Added a note to customer Audra O'Connell	2026-06-30 17:17:20
180	2	customer.note_added	App\\Models\\Customer	16	Added a note to customer Audra O'Connell	2026-06-30 17:17:21
181	2	customer.note_added	App\\Models\\Customer	16	Added a note to customer Audra O'Connell	2026-06-30 17:17:23
182	1	customer.note_added	App\\Models\\Customer	16	Added a note to customer Audra O'Connell	2026-06-30 17:17:25
183	2	customer.note_added	App\\Models\\Customer	17	Added a note to customer Shanon Ward	2026-06-30 17:17:26
184	3	customer.note_added	App\\Models\\Customer	17	Added a note to customer Shanon Ward	2026-06-30 17:17:28
185	3	customer.note_added	App\\Models\\Customer	17	Added a note to customer Shanon Ward	2026-06-30 17:17:29
186	1	customer.note_added	App\\Models\\Customer	17	Added a note to customer Shanon Ward	2026-06-30 17:17:31
187	1	lead.created	App\\Models\\Lead	51	Created lead Shriya Gupta	2026-06-30 17:26:48
188	3	lead.created	App\\Models\\Lead	52	Created lead QA Tester	2026-06-30 17:42:24
189	3	lead.created	App\\Models\\Lead	53	Created lead Dup Email	2026-06-30 17:44:10
190	3	lead.status_updated	App\\Models\\Lead	49	Updated lead Elbert Gottlieb status to won	2026-06-30 17:45:35
191	1	lead.status_updated	App\\Models\\Lead	52	Updated lead QA Tester status to lost	2026-06-30 17:45:50
192	1	lead.converted	App\\Models\\Customer	18	Converted lead QA Tester into a customer	2026-06-30 17:45:57
193	2	customer.note_added	App\\Models\\Customer	18	Added a note to customer QA Tester	2026-06-30 17:46:35
194	3	task.created	App\\Models\\Task	51	Created task Assigned to admin by exec	2026-06-30 17:48:19
195	3	task.created	App\\Models\\Task	52	Created task both refs	2026-06-30 17:48:25
196	1	lead.created	App\\Models\\Lead	54	Created lead AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA Test	2026-06-30 17:56:28
197	1	lead.created	App\\Models\\Lead	55	Created lead X Y	2026-06-30 17:56:33
198	2	customer.note_added	App\\Models\\Customer	17	Added a note to customer Shanon Ward	2026-06-30 18:00:02
199	1	lead.created	App\\Models\\Lead	56	Created lead NoStatus Test	2026-06-30 18:01:49
200	1	lead.created	App\\Models\\Lead	57	Created lead Alice Wonderland	2026-06-30 19:03:56
201	1	customer.note_added	App\\Models\\Customer	18	Added a note to customer QA Tester	2026-06-30 19:46:14
202	2	lead.status_updated	App\\Models\\Lead	53	Updated lead Dup Email status to contacted	2026-06-30 20:03:09
203	1	lead.created	App\\Models\\Lead	58	Created lead rishika gupta	2026-06-30 20:33:48
204	1	lead.assigned	App\\Models\\Lead	58	Assigned lead rishika gupta to user #3	2026-06-30 20:34:51
\.


--
-- Data for Name: cache; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.cache (key, value, expiration) FROM stdin;
crm_lead_api_cache_4Hgx3Wipxp4ihlrj	a:1:{s:11:"valid_until";i:1782841131;}	1784050791
crm_lead_api_cache_VjrzwPOoSRQxbHXV	a:1:{s:11:"valid_until";i:1782849312;}	1784057412
crm_lead_api_cache_x5r52XhnVJ9XZJLB	a:1:{s:11:"valid_until";i:1782849432;}	1784059032
crm_lead_api_cache_3NdFWTKRtAaOoe6d	a:1:{s:11:"valid_until";i:1782849826;}	1784059126
crm_lead_api_cache_c04uOnF79ZeXS7Wo	a:1:{s:11:"valid_until";i:1782851477;}	1784059517
crm_lead_api_cache_5c785c036466adea360111aa28563bfd556b5fba:timer	i:1782851569;	1782851569
crm_lead_api_cache_5c785c036466adea360111aa28563bfd556b5fba	i:1;	1782851570
crm_lead_api_cache_gdCTeUMODPJl30rr	a:1:{s:11:"valid_until";i:1782851807;}	1784061167
\.


--
-- Data for Name: cache_locks; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.cache_locks (key, owner, expiration) FROM stdin;
\.


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.customers (id, lead_id, company, contact_name, email, phone, created_at, updated_at) FROM stdin;
1	22	Kerluke, Kertzmann and O'Reilly	Alia Lang	maryam96@example.com	253.920.8714	2026-06-30 17:13:20	2026-06-30 17:13:20
2	45	Bahringer, Johnston and Wehner	Chasity Jones	crist.imelda@example.org	+1.210.969.6018	2026-06-30 17:13:23	2026-06-30 17:13:23
3	19	D'Amore, Renner and Hackett	Lizzie Schimmel	yasmine.moen@example.net	364-993-6694	2026-06-30 17:13:27	2026-06-30 17:13:27
4	32	Quitzon-Bins	Lorenza Rodriguez	hessel.anna@example.net	+1-570-593-8988	2026-06-30 17:13:30	2026-06-30 17:13:30
5	2	Balistreri Group	Lenna Wunsch	gislason.giovanna@example.net	+1-781-770-2965	2026-06-30 17:13:33	2026-06-30 17:13:33
6	18	Haley PLC	Shawn Kreiger	flatley.meghan@example.org	+1-984-645-8387	2026-06-30 17:13:36	2026-06-30 17:13:36
7	35	McCullough Ltd	Cassandra Heaney	jane39@example.org	(586) 580-1269	2026-06-30 17:13:39	2026-06-30 17:13:39
8	3	Torphy Inc	Felipe Rogahn	rogers91@example.com	978-892-2699	2026-06-30 17:13:42	2026-06-30 17:13:42
9	17	Crona, Hill and Osinski	Maye Kohler	kiarra.goldner@example.org	+1.272.593.2498	2026-06-30 17:13:46	2026-06-30 17:13:46
10	1	Dibbert-Parker	Loren Bode	trey66@example.com	872-541-9456	2026-06-30 17:13:49	2026-06-30 17:13:49
11	25	Larson, Botsford and Lockman	Mazie Baumbach	goyette.craig@example.com	804-216-3098	2026-06-30 17:13:53	2026-06-30 17:13:53
12	31	Keeling, Harris and Rau	Hettie Bogan	hzboncak@example.net	(719) 784-6403	2026-06-30 17:13:56	2026-06-30 17:13:56
13	6	Parisian-Bahringer	Jany Walker	gwillms@example.com	906.544.4743	2026-06-30 17:13:59	2026-06-30 17:13:59
14	4	Beier, O'Conner and Wolf	Nathanial Barton	neoma.bergnaum@example.org	1-283-880-5040	2026-06-30 17:14:02	2026-06-30 17:14:02
15	9	Bogisich, Feeney and Stracke	Eric Miller	sydnie74@example.net	+1.209.290.8263	2026-06-30 17:14:05	2026-06-30 17:14:05
16	21	Koelpin, Franecki and Stanton	Audra O'Connell	gerlach.rahsaan@example.com	+1-463-414-9111	2026-06-30 17:14:08	2026-06-30 17:14:08
17	43	Christiansen, Boyle and Wehner	Shanon Ward	rogelio99@example.net	+1-520-695-1710	2026-06-30 17:14:11	2026-06-30 17:14:11
18	52	\N	QA Tester	qa.tester.unique999@example.com	\N	2026-06-30 17:45:56	2026-06-30 17:45:56
\.


--
-- Data for Name: failed_jobs; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.failed_jobs (id, uuid, connection, queue, payload, exception, failed_at) FROM stdin;
\.


--
-- Data for Name: job_batches; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.job_batches (id, name, total_jobs, pending_jobs, failed_jobs, failed_job_ids, options, cancelled_at, created_at, finished_at) FROM stdin;
\.


--
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.jobs (id, queue, payload, attempts, reserved_at, available_at, created_at) FROM stdin;
\.


--
-- Data for Name: leads; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.leads (id, assigned_to, created_by, first_name, last_name, email, phone, company, status, source, created_at, updated_at) FROM stdin;
5	3	2	Adelia	Kuhic	corine.graham@example.org	+12514209594	Altenwerth-Donnelly	contacted	referral	2026-06-30 17:11:47	2026-06-30 17:11:47
6	1	3	Jany	Walker	gwillms@example.com	906.544.4743	Parisian-Bahringer	won	website	2026-06-30 17:11:49	2026-06-30 17:11:49
7	2	1	Obie	Ebert	braeden.will@example.org	+1-321-981-0295	Cremin and Sons	new	advertisement	2026-06-30 17:11:50	2026-06-30 17:11:50
8	3	2	April	Prosacco	ujohnson@example.net	+1 (848) 415-1858	Hyatt, Reichert and Von	new	cold-call	2026-06-30 17:11:52	2026-06-30 17:11:52
10	2	1	Mariano	Wuckert	oma15@example.net	878.666.1227	Hermiston-Rempel	new	event	2026-06-30 17:11:56	2026-06-30 17:11:56
11	3	2	Anabelle	Kunde	gleason.imelda@example.org	1-640-806-0388	Stoltenberg and Sons	new	advertisement	2026-06-30 17:11:58	2026-06-30 17:11:58
12	1	3	Ana	Thompson	sward@example.com	214.328.3339	Howe, Hermann and Medhurst	qualified	advertisement	2026-06-30 17:12:00	2026-06-30 17:12:00
13	2	1	Brett	Metz	gabriel.koss@example.net	+1-508-791-7083	Hyatt, Runte and Jaskolski	contacted	website	2026-06-30 17:12:02	2026-06-30 17:12:02
14	3	2	Wava	Kuhic	ignacio.schowalter@example.com	+1.513.962.4656	Barrows, Jones and Langosh	qualified	referral	2026-06-30 17:12:04	2026-06-30 17:12:04
15	1	3	Arnulfo	Zulauf	nolan.audra@example.com	443.907.2306	Glover Inc	contacted	cold-call	2026-06-30 17:12:06	2026-06-30 17:12:06
16	2	1	Lucinda	Wiegand	marianna.lynch@example.com	520.399.4282	Monahan, Hyatt and Skiles	lost	cold-call	2026-06-30 17:12:08	2026-06-30 17:12:08
20	3	2	Rex	Schamberger	price.mose@example.org	+1.337.933.5104	Cummerata, Mills and Rath	won	referral	2026-06-30 17:12:16	2026-06-30 17:12:16
23	3	2	Libby	Ward	oconner.elfrieda@example.org	+1-351-613-0287	Schulist Ltd	qualified	website	2026-06-30 17:12:23	2026-06-30 17:12:23
24	1	3	Libby	Schulist	vesta.bednar@example.net	360.912.1482	Carter-Maggio	new	website	2026-06-30 17:12:25	2026-06-30 17:12:25
26	3	2	Marilie	Feeney	susanna.leannon@example.com	719-380-9561	Jast-Schmidt	new	event	2026-06-30 17:12:30	2026-06-30 17:12:30
27	1	3	Stella	Moore	eichmann.osvaldo@example.net	720-372-4162	Stark Ltd	qualified	website	2026-06-30 17:12:31	2026-06-30 17:12:31
28	2	1	Helen	Christiansen	pkoepp@example.net	562.288.9276	O'Connell Ltd	new	event	2026-06-30 17:12:33	2026-06-30 17:12:33
29	3	2	Charley	Wiegand	zrice@example.org	804-557-4266	Rolfson, Parisian and Jakubowski	qualified	event	2026-06-30 17:12:35	2026-06-30 17:12:35
30	1	3	Imani	Bauch	priscilla.sipes@example.org	351.391.6749	Cummerata, Bruen and Hand	lost	cold-call	2026-06-30 17:12:37	2026-06-30 17:12:37
33	1	3	Damaris	Runolfsdottir	gregoria61@example.org	+1-831-422-3720	Lindgren-Larkin	proposal_sent	referral	2026-06-30 17:12:44	2026-06-30 17:12:44
34	2	1	Leonor	Hoeger	angela.ferry@example.org	702-821-9091	Raynor Ltd	contacted	advertisement	2026-06-30 17:12:46	2026-06-30 17:12:46
35	3	2	Cassandra	Heaney	jane39@example.org	(586) 580-1269	McCullough Ltd	won	event	2026-06-30 17:12:48	2026-06-30 17:12:48
36	1	3	Xzavier	Yundt	homenick.ayla@example.com	1-681-588-6865	Cremin, Homenick and Parker	lost	event	2026-06-30 17:12:50	2026-06-30 17:12:50
37	2	1	Norene	Kulas	jenkins.cynthia@example.org	+1 (863) 621-3786	Lang, Parisian and Spencer	lost	website	2026-06-30 17:12:52	2026-06-30 17:12:52
38	3	2	Kamryn	Schroeder	sammy.nader@example.net	601.245.1808	D'Amore, Hudson and Brekke	won	referral	2026-06-30 17:12:54	2026-06-30 17:12:54
39	1	3	Carmine	Jones	zschuppe@example.net	681.932.9718	Feeney-Stark	proposal_sent	referral	2026-06-30 17:12:57	2026-06-30 17:12:57
40	2	1	Kylee	Kulas	bwatsica@example.net	1-229-860-7128	Waelchi Inc	new	referral	2026-06-30 17:12:59	2026-06-30 17:12:59
41	3	2	Nasir	Robel	boyle.marjorie@example.org	+1-870-732-3839	Sporer-Will	new	cold-call	2026-06-30 17:13:01	2026-06-30 17:13:01
42	1	3	Ella	McLaughlin	okeefe.carolyn@example.org	+13646034749	Bins-Green	proposal_sent	website	2026-06-30 17:13:03	2026-06-30 17:13:03
44	3	2	Nakia	Hand	nveum@example.net	+1 (872) 931-5696	Legros-Little	proposal_sent	cold-call	2026-06-30 17:13:08	2026-06-30 17:13:08
46	2	1	Maxwell	Reichert	patience16@example.net	1-901-461-4751	Kessler LLC	qualified	referral	2026-06-30 17:13:12	2026-06-30 17:13:12
47	3	2	Hermina	Hill	little.fredrick@example.org	+1 (985) 890-5334	Yost Group	qualified	cold-call	2026-06-30 17:13:13	2026-06-30 17:13:13
48	1	3	Tristian	Crooks	boehm.devyn@example.net	+1.984.927.2471	Schmeler Ltd	contacted	event	2026-06-30 17:13:15	2026-06-30 17:13:15
50	3	2	Ara	Nader	sschinner@example.com	(973) 221-8362	Rutherford Ltd	won	advertisement	2026-06-30 17:13:18	2026-06-30 17:13:18
49	2	1	Elbert	Gottlieb	arvel.keeling@example.com	+1-747-730-1351	Herzog-Hyatt	won	cold-call	2026-06-30 17:13:16	2026-06-30 17:45:35
22	2	1	Alia	Lang	maryam96@example.com	253.920.8714	Kerluke, Kertzmann and O'Reilly	won	website	2026-06-30 17:12:21	2026-06-30 17:13:20
45	1	3	Chasity	Jones	crist.imelda@example.org	+1.210.969.6018	Bahringer, Johnston and Wehner	won	cold-call	2026-06-30 17:13:10	2026-06-30 17:13:24
19	2	1	Lizzie	Schimmel	yasmine.moen@example.net	364-993-6694	D'Amore, Renner and Hackett	won	event	2026-06-30 17:12:14	2026-06-30 17:13:27
32	3	2	Lorenza	Rodriguez	hessel.anna@example.net	+1-570-593-8988	Quitzon-Bins	won	cold-call	2026-06-30 17:12:41	2026-06-30 17:13:30
2	3	2	Lenna	Wunsch	gislason.giovanna@example.net	+1-781-770-2965	Balistreri Group	won	website	2026-06-30 17:11:40	2026-06-30 17:13:34
18	1	3	Shawn	Kreiger	flatley.meghan@example.org	+1-984-645-8387	Haley PLC	won	event	2026-06-30 17:12:12	2026-06-30 17:13:36
3	1	3	Felipe	Rogahn	rogers91@example.com	978-892-2699	Torphy Inc	won	website	2026-06-30 17:11:42	2026-06-30 17:13:43
17	3	2	Maye	Kohler	kiarra.goldner@example.org	+1.272.593.2498	Crona, Hill and Osinski	won	advertisement	2026-06-30 17:12:10	2026-06-30 17:13:46
1	2	1	Loren	Bode	trey66@example.com	872-541-9456	Dibbert-Parker	won	advertisement	2026-06-30 17:11:38	2026-06-30 17:13:50
25	2	1	Mazie	Baumbach	goyette.craig@example.com	804-216-3098	Larson, Botsford and Lockman	won	event	2026-06-30 17:12:27	2026-06-30 17:13:53
31	2	1	Hettie	Bogan	hzboncak@example.net	(719) 784-6403	Keeling, Harris and Rau	won	event	2026-06-30 17:12:39	2026-06-30 17:13:57
4	2	1	Nathanial	Barton	neoma.bergnaum@example.org	1-283-880-5040	Beier, O'Conner and Wolf	won	referral	2026-06-30 17:11:45	2026-06-30 17:14:03
9	1	3	Eric	Miller	sydnie74@example.net	+1.209.290.8263	Bogisich, Feeney and Stracke	won	referral	2026-06-30 17:11:54	2026-06-30 17:14:05
21	1	3	Audra	O'Connell	gerlach.rahsaan@example.com	+1-463-414-9111	Koelpin, Franecki and Stanton	won	event	2026-06-30 17:12:19	2026-06-30 17:14:08
43	2	1	Shanon	Ward	rogelio99@example.net	+1-520-695-1710	Christiansen, Boyle and Wehner	won	referral	2026-06-30 17:13:05	2026-06-30 17:14:12
52	\N	3	QA	Tester	qa.tester.unique999@example.com	\N	\N	won	\N	2026-06-30 17:42:23	2026-06-30 17:45:57
56	\N	1	NoStatus	Test	nostatus-test@example.com	\N	\N	new	\N	2026-06-30 18:01:49	2026-06-30 18:01:49
53	\N	3	Dup	Email	qa.tester.unique999@example.com	\N	\N	contacted	\N	2026-06-30 17:44:10	2026-06-30 20:03:09
57	\N	1	Alice	Wonder	alice02@gmail.com	232323	Gradd	contacted	Website	2026-06-30 19:03:55	2026-06-30 20:23:03
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.migrations (id, migration, batch) FROM stdin;
1	0001_01_01_000000_create_users_table	1
2	0001_01_01_000001_create_cache_table	1
3	0001_01_01_000002_create_jobs_table	1
4	2026_06_29_094223_create_personal_access_tokens_table	1
5	2026_06_29_100446_create_roles_table	1
6	2026_06_29_100447_add_role_id_to_users_table	1
7	2026_06_29_101632_create_leads_table	1
8	2026_06_29_155343_create_customers_table	1
9	2026_06_29_155344_create_notes_table	1
10	2026_06_29_155345_create_tasks_table	1
11	2026_06_29_160000_create_activities_table	1
\.


--
-- Data for Name: notes; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.notes (id, customer_id, user_id, note, created_at, updated_at) FROM stdin;
1	1	1	Maxime dolorem dolore vitae cumque inventore corrupti odio. Sequi nostrum nihil quisquam incidunt fugiat quisquam qui.	2026-06-30 17:15:48	2026-06-30 17:15:48
2	1	1	Laboriosam est aperiam non facilis. Necessitatibus minus eos quasi non deserunt dignissimos. Tenetur quo velit id necessitatibus.	2026-06-30 17:15:49	2026-06-30 17:15:49
3	1	1	Labore nesciunt sint voluptatem aut corporis voluptatem placeat aut. Error corrupti voluptatibus similique quos. Enim iure vel totam optio vero.	2026-06-30 17:15:51	2026-06-30 17:15:51
4	1	1	Qui nemo aut sit aut et. Vel autem veritatis eum qui placeat et illo. Ipsam sunt velit ab sunt incidunt. Dolorem corporis provident ut molestiae ipsum tempore error.	2026-06-30 17:15:52	2026-06-30 17:15:52
5	1	2	Ducimus sit nemo et ratione fugit libero. Sit dicta voluptatibus optio. Eveniet soluta minus deleniti quia maiores sint aliquid corrupti.	2026-06-30 17:15:53	2026-06-30 17:15:53
6	2	2	Qui nostrum aperiam veritatis soluta voluptatum ut repellendus. Ea esse necessitatibus est magnam ex. Culpa sunt suscipit reprehenderit qui error explicabo. Illum dolorem et voluptates temporibus delectus quis.	2026-06-30 17:15:54	2026-06-30 17:15:54
7	2	2	Quia consequatur consequatur eos rerum. Incidunt consectetur consequatur et deleniti. Aut labore autem nobis earum rerum doloremque odit quia. Consequatur aut dolorem fuga itaque. Voluptatibus velit non voluptatem et necessitatibus.	2026-06-30 17:15:55	2026-06-30 17:15:55
8	2	3	Incidunt cupiditate ut non illo neque rerum. Reprehenderit eligendi quaerat ut accusantium. Molestias eum iste qui blanditiis ea sequi ex quos.	2026-06-30 17:15:57	2026-06-30 17:15:57
9	2	1	Tenetur ea non consequuntur ratione atque ut aspernatur. Quia reprehenderit excepturi quo autem beatae. Tenetur odio delectus nisi enim illum magni. Voluptates illum provident occaecati odio molestiae placeat.	2026-06-30 17:15:58	2026-06-30 17:15:58
10	3	1	Dolorem est dicta ut quod sapiente non. Repudiandae aut tenetur tempora qui adipisci dolor a sed.	2026-06-30 17:15:59	2026-06-30 17:15:59
11	3	3	Recusandae hic soluta fuga reiciendis sint eveniet ut. Enim asperiores quia eum cupiditate enim officiis. Qui ipsa cumque porro labore modi quae libero. Id iure vel numquam est qui sed. Aliquid eius culpa consectetur ut fugit.	2026-06-30 17:16:00	2026-06-30 17:16:00
12	3	2	Nostrum ut iste non voluptatibus aliquam numquam ex id. Error sint ut ab modi qui veritatis. Aperiam tenetur quod blanditiis doloremque suscipit aspernatur numquam. Quibusdam ad id et pariatur sed.	2026-06-30 17:16:02	2026-06-30 17:16:02
13	4	2	Ut necessitatibus et est. Ut hic et tempora aspernatur veritatis accusamus sit. Provident qui ab voluptas aut ipsum aspernatur natus.	2026-06-30 17:16:04	2026-06-30 17:16:04
14	4	1	Aut autem rem nam voluptates. Et et et aut quia ut sed omnis voluptas. Ut sed molestiae et perferendis eos quis commodi. Impedit enim commodi id libero accusamus necessitatibus.	2026-06-30 17:16:05	2026-06-30 17:16:05
15	4	2	Reiciendis quidem omnis mollitia similique quia dolorum et. Beatae quia eos voluptate impedit. Possimus blanditiis aut dolorem dolorem. Sit inventore omnis molestiae voluptas voluptatibus aperiam.	2026-06-30 17:16:07	2026-06-30 17:16:07
16	4	2	Reiciendis rerum omnis vero modi in consequatur quia animi. Magnam natus ab iste impedit. Expedita fugit repudiandae impedit recusandae dolorem. Ea excepturi ipsum laboriosam aliquid.	2026-06-30 17:16:08	2026-06-30 17:16:08
17	4	3	Optio aut quaerat inventore eveniet voluptatibus magnam repudiandae. Et iusto blanditiis molestiae cumque provident. Deserunt distinctio doloremque iste non corporis non.	2026-06-30 17:16:10	2026-06-30 17:16:10
18	5	3	Eius quia quia voluptates. Molestiae dignissimos sed facilis cupiditate error ad repellat. Omnis voluptates quia velit atque deleniti quia.	2026-06-30 17:16:12	2026-06-30 17:16:12
19	5	3	Quo ipsam officiis occaecati itaque eveniet aut nobis asperiores. Aut suscipit error qui odit minus culpa aut. Ipsa velit ut non.	2026-06-30 17:16:13	2026-06-30 17:16:13
20	5	1	Voluptatem perspiciatis nam mollitia iste porro. Magnam optio qui eos molestiae numquam ut. Debitis rem voluptatem non earum quia temporibus provident. Nostrum et voluptas eum tenetur dolorum esse.	2026-06-30 17:16:15	2026-06-30 17:16:15
21	5	2	Tempore natus ullam velit voluptatem quia ut repellendus. Consequatur tempora quo dicta ut. Aut cum tempora amet officia molestiae quibusdam eos adipisci.	2026-06-30 17:16:17	2026-06-30 17:16:17
22	5	2	Neque debitis voluptatem placeat magnam. Provident voluptates veritatis voluptatem amet autem voluptatem. Rem veniam aut autem ratione aut. Debitis minima maxime quia deserunt.	2026-06-30 17:16:18	2026-06-30 17:16:18
23	6	2	Odio ea voluptatum occaecati ipsam nesciunt eius omnis. Commodi corporis consequatur libero quaerat. Earum nobis et expedita minus earum voluptatem eveniet.	2026-06-30 17:16:20	2026-06-30 17:16:20
24	6	3	Ab pariatur voluptatem consequatur explicabo quos. Est ut cum qui quia. Fuga quas omnis dolore et cumque a. Asperiores dolorem dolores distinctio ducimus rerum.	2026-06-30 17:16:21	2026-06-30 17:16:21
25	6	2	Qui minus qui sed quia sit et. Et eos et corrupti voluptatum nisi explicabo iusto. Facere reiciendis consequatur omnis nulla odit sit qui et. Sit delectus delectus voluptas aperiam nemo. Culpa ex voluptate et architecto enim.	2026-06-30 17:16:23	2026-06-30 17:16:23
26	7	2	Fugiat cumque voluptas qui explicabo ab in. Optio voluptatem eos dolor ullam repellendus vero. Molestias aut sit unde.	2026-06-30 17:16:25	2026-06-30 17:16:25
27	7	3	Dolorum vel non possimus natus. Et dolores corrupti et laborum quis facilis. Corporis voluptatum libero ea est amet.	2026-06-30 17:16:26	2026-06-30 17:16:26
28	7	2	Corporis et dolor qui amet. Nam ut officiis facere aut quidem nesciunt et corrupti. Quasi dicta corrupti aperiam quos sunt.	2026-06-30 17:16:28	2026-06-30 17:16:28
29	7	1	Est omnis quos dolore dolorem non voluptatum sit. Ipsa alias temporibus ratione impedit. Omnis enim sit aut dolor.	2026-06-30 17:16:29	2026-06-30 17:16:29
30	7	3	Et beatae aliquid corporis dolorem. Totam nisi ratione eos repudiandae adipisci in. Totam blanditiis cumque amet harum voluptatum vitae velit. Odio voluptatum impedit velit autem et aperiam.	2026-06-30 17:16:31	2026-06-30 17:16:31
31	8	3	Est a aut illum labore. Quam dolorum aliquid commodi sunt expedita veniam dolorum. Est non voluptatem repudiandae aut.	2026-06-30 17:16:33	2026-06-30 17:16:33
32	8	3	Veniam animi voluptas sequi magni ea. Harum culpa quam laboriosam sit sit dolorem. Qui est ipsam laboriosam id rerum ipsa molestias. Sint voluptatum harum voluptas.	2026-06-30 17:16:34	2026-06-30 17:16:34
33	8	1	Ea eum et officiis iusto. Maxime saepe sunt est quia asperiores. Et quae omnis laborum reiciendis nihil.	2026-06-30 17:16:36	2026-06-30 17:16:36
34	8	1	Consectetur facilis temporibus impedit quis. Nostrum quis culpa nobis ab.	2026-06-30 17:16:37	2026-06-30 17:16:37
35	8	1	Perspiciatis commodi iusto hic in repellendus nobis. Ipsam et vel facilis facilis. Eos est molestiae voluptatem aspernatur placeat ad consectetur. Rerum officia laboriosam incidunt ea molestiae aliquam.	2026-06-30 17:16:38	2026-06-30 17:16:38
36	9	3	Voluptatem ut eligendi dolore. Laborum officiis adipisci illum autem cupiditate et. Quia natus veniam sapiente qui quasi. Sunt architecto omnis harum quis consequatur sunt voluptatum laboriosam.	2026-06-30 17:16:40	2026-06-30 17:16:40
37	9	2	Quis tenetur doloribus qui accusamus minus aliquid. Omnis et iusto quae atque. Esse quis maxime ipsum expedita in. Occaecati ut et qui. Accusamus voluptatum amet labore et totam sit quae.	2026-06-30 17:16:42	2026-06-30 17:16:42
38	9	1	Deserunt saepe aliquid omnis labore ad cumque. Quia beatae repudiandae et qui illo nobis perspiciatis aut.	2026-06-30 17:16:43	2026-06-30 17:16:43
39	9	2	Debitis qui magni impedit qui nisi velit. Maiores eius quam voluptatem et vel tenetur quis. Velit quas molestiae ut qui. Itaque quia delectus qui eos sint optio blanditiis qui.	2026-06-30 17:16:45	2026-06-30 17:16:45
40	9	1	Maxime illum omnis et occaecati unde cupiditate numquam. Rem autem totam voluptas dolore rerum minima.	2026-06-30 17:16:46	2026-06-30 17:16:46
41	10	3	Dolore veritatis ut dignissimos sunt ratione voluptatem debitis. Velit harum ipsum consequuntur consequatur cumque iusto voluptatibus. Soluta iure ut ipsum quae corrupti aut. Nihil sequi et quisquam consequatur vero.	2026-06-30 17:16:48	2026-06-30 17:16:48
42	10	1	Et non suscipit aut rerum sed praesentium. Consequatur a qui possimus autem. Fugiat voluptatem consequatur assumenda dolorem voluptatem nulla est. Officiis placeat quibusdam sit aliquam inventore.	2026-06-30 17:16:49	2026-06-30 17:16:49
43	10	2	Quo nesciunt animi hic dolorem aut sed dolore. Earum dolores iusto et corporis. Unde eius quo similique cupiditate accusantium maiores et adipisci. Sunt commodi ut consectetur asperiores cupiditate.	2026-06-30 17:16:51	2026-06-30 17:16:51
44	11	2	Quaerat mollitia nam delectus nulla eum porro perspiciatis. Et blanditiis similique ut voluptate ut dolor. Porro autem rerum numquam sint.	2026-06-30 17:16:52	2026-06-30 17:16:52
45	11	1	Facere error provident praesentium et sed eos repellendus. Et aut dolore corporis est aut quis. Tenetur non voluptatem inventore fugiat.	2026-06-30 17:16:53	2026-06-30 17:16:53
46	11	1	Eos neque incidunt necessitatibus. Velit beatae harum labore est. Totam id commodi et quia.	2026-06-30 17:16:56	2026-06-30 17:16:56
47	12	1	Iure veniam non veritatis. Accusamus velit in mollitia suscipit consequatur. Asperiores odio saepe nihil repudiandae sed ducimus. Est debitis earum ex non reiciendis ipsa impedit. Voluptatem ut est cupiditate quia.	2026-06-30 17:16:57	2026-06-30 17:16:57
48	12	3	Et ducimus et officia consequatur delectus laudantium eveniet. Sit eum esse ut et est hic officia molestiae. Aperiam quasi quo aut est ut qui. Recusandae eaque eos ducimus tempore.	2026-06-30 17:16:58	2026-06-30 17:16:58
49	12	3	Consequuntur aut dolorem iste qui. Porro voluptas autem commodi praesentium. Ut rerum veniam a rerum voluptas.	2026-06-30 17:17:00	2026-06-30 17:17:00
50	13	1	Et veritatis nesciunt hic rerum officiis quibusdam. Quaerat fugiat quae odit amet quam rem. Repellat culpa adipisci id impedit quia provident.	2026-06-30 17:17:02	2026-06-30 17:17:02
51	13	3	Consequuntur at dignissimos soluta laboriosam quo. Veniam eaque iste sed illum provident quidem. Voluptas repellendus aspernatur pariatur dolorem aut a molestiae.	2026-06-30 17:17:03	2026-06-30 17:17:03
52	13	2	Reiciendis numquam illo aut adipisci expedita repellendus. Eligendi dignissimos iste soluta temporibus. Et nemo vitae culpa adipisci voluptatibus illum itaque perspiciatis.	2026-06-30 17:17:05	2026-06-30 17:17:05
53	14	2	Aliquid consequatur molestiae dolor maiores voluptatibus et. Eius ipsam et quam exercitationem nam temporibus minima et. Rem magni ullam architecto suscipit sequi qui.	2026-06-30 17:17:06	2026-06-30 17:17:06
54	14	3	Officia laboriosam voluptatum eum doloribus non aut. Beatae doloribus reiciendis nam necessitatibus beatae ad. Laudantium dolorem voluptates quia. Vitae cupiditate ea corporis numquam.	2026-06-30 17:17:08	2026-06-30 17:17:08
55	14	1	Et fuga soluta vel sint voluptatem est alias. Suscipit et aperiam cupiditate numquam. Inventore reiciendis illo voluptatem odit recusandae.	2026-06-30 17:17:09	2026-06-30 17:17:09
56	14	3	Perspiciatis impedit rerum modi nihil quasi voluptates dolor. Sed corporis ut voluptas ratione neque quasi sequi. Culpa adipisci est quia magni rerum aperiam.	2026-06-30 17:17:11	2026-06-30 17:17:11
57	14	3	Quisquam eos necessitatibus distinctio. Recusandae optio explicabo est aperiam qui. Sequi ut doloribus ad dolore.	2026-06-30 17:17:12	2026-06-30 17:17:12
58	15	3	Nesciunt quo nihil inventore ducimus aut maxime ea. Quia enim sed exercitationem adipisci. Impedit rerum enim iure neque qui. Doloremque temporibus omnis ipsam animi.	2026-06-30 17:17:13	2026-06-30 17:17:13
59	15	3	Quas aliquam qui harum ipsum aut rerum. Facere aspernatur explicabo officia culpa tempore voluptatem. Commodi minima est optio blanditiis porro ipsa qui.	2026-06-30 17:17:15	2026-06-30 17:17:15
60	15	1	Fugiat eos consequatur et est laboriosam. Dolor sint ut aut aut quisquam cupiditate. Inventore debitis voluptatem iusto inventore magni veniam assumenda et. Fugiat quia et nam suscipit quasi.	2026-06-30 17:17:17	2026-06-30 17:17:17
61	15	2	Perspiciatis ut qui laborum praesentium similique sit et. Ab ut cum voluptatem nisi. Qui quia atque minus qui.	2026-06-30 17:17:18	2026-06-30 17:17:18
62	16	3	Voluptas illum officiis quia. Dolores alias cumque quisquam pariatur qui reiciendis necessitatibus. Soluta exercitationem dolores est magni omnis corporis distinctio delectus. Quae excepturi ut cupiditate voluptas ut sint minima enim.	2026-06-30 17:17:20	2026-06-30 17:17:20
63	16	2	Dolor ut nesciunt cupiditate beatae consequatur. Nostrum amet dolorum error alias qui odit. Et voluptas consequuntur eum consectetur. Consequatur cupiditate rerum repellat assumenda totam est.	2026-06-30 17:17:21	2026-06-30 17:17:21
64	16	2	Repellendus dolorem et magnam et assumenda. Excepturi voluptas molestias debitis impedit.	2026-06-30 17:17:23	2026-06-30 17:17:23
65	16	1	Dolor quo architecto quidem provident. Dolore aut laboriosam asperiores quidem qui. Dolorum quidem ut eum quo. Quia eveniet doloribus et hic animi fugiat.	2026-06-30 17:17:24	2026-06-30 17:17:24
66	17	2	Pariatur tempora et quasi quis iste quo asperiores. Rerum qui omnis id aut dignissimos maxime. Suscipit cupiditate dolores quae reiciendis odit.	2026-06-30 17:17:26	2026-06-30 17:17:26
67	17	3	Est voluptates sunt molestiae sunt deserunt. Suscipit est aut sit sit nisi aliquam nihil aliquid. Dolor praesentium voluptatem nisi.	2026-06-30 17:17:27	2026-06-30 17:17:27
68	17	3	Qui beatae nihil atque voluptatibus debitis ipsam. Quasi iste animi unde. Nihil rerum nam blanditiis unde. Veritatis nulla aspernatur magni.	2026-06-30 17:17:29	2026-06-30 17:17:29
69	17	1	Qui beatae excepturi sequi non est. Ipsam amet sit excepturi reiciendis veritatis iure. Ea nostrum consequatur officiis. Placeat nisi velit quis consequatur beatae.	2026-06-30 17:17:30	2026-06-30 17:17:30
70	18	2	QA test note	2026-06-30 17:46:35	2026-06-30 17:46:35
71	17	2	xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx	2026-06-30 18:00:02	2026-06-30 18:00:02
72	18	1	hi	2026-06-30 19:46:14	2026-06-30 19:46:14
\.


--
-- Data for Name: password_reset_tokens; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.password_reset_tokens (email, token, created_at) FROM stdin;
\.


--
-- Data for Name: personal_access_tokens; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.personal_access_tokens (id, tokenable_type, tokenable_id, name, token, abilities, last_used_at, expires_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.roles (id, name, slug, created_at, updated_at) FROM stdin;
1	Admin	admin	2026-06-30 17:11:27	2026-06-30 17:11:27
2	Sales Manager	sales-manager	2026-06-30 17:11:28	2026-06-30 17:11:28
3	Sales Executive	sales-executive	2026-06-30 17:11:29	2026-06-30 17:11:29
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) FROM stdin;
\.


--
-- Data for Name: tasks; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.tasks (id, user_id, customer_id, lead_id, title, description, priority, status, due_date, reminder_at, created_at, updated_at) FROM stdin;
1	1	9	\N	Prepare quote	Molestiae sint enim totam hic.	low	pending	2026-06-30	\N	2026-06-30 17:14:13	2026-06-30 17:14:13
2	2	\N	14	Follow up call	A vitae laudantium non sunt perspiciatis aspernatur rerum laboriosam.	medium	in_progress	2026-06-23	\N	2026-06-30 17:14:15	2026-06-30 17:14:15
3	3	6	\N	Send onboarding docs	Facilis sit reiciendis consectetur sapiente et sed eaque.	high	completed	2026-07-03	\N	2026-06-30 17:14:17	2026-06-30 17:14:17
4	1	\N	8	Check in with customer	Doloribus amet iure aut sapiente asperiores similique est qui.	low	pending	2026-06-27	\N	2026-06-30 17:14:19	2026-06-30 17:14:19
5	2	9	\N	Follow up call	Tempore ipsa at dolor eos et quaerat maxime.	medium	in_progress	2026-06-30	\N	2026-06-30 17:14:21	2026-06-30 17:14:21
6	3	\N	48	Schedule demo	Accusantium et blanditiis odit doloribus velit ut.	high	completed	2026-07-07	\N	2026-06-30 17:14:23	2026-06-30 17:14:23
7	1	17	\N	Check in with customer	Veniam eveniet assumenda eligendi distinctio maiores.	low	pending	2026-06-30	\N	2026-06-30 17:14:25	2026-06-30 17:14:25
8	2	\N	31	Schedule demo	Sint iste at occaecati.	medium	in_progress	2026-06-30	\N	2026-06-30 17:14:27	2026-06-30 17:14:27
9	3	5	\N	Send onboarding docs	Eveniet commodi neque reiciendis voluptates fugiat.	high	completed	2026-07-03	\N	2026-06-30 17:14:29	2026-06-30 17:14:29
10	1	\N	41	Prepare quote	Sequi itaque et quas quae consectetur eum omnis.	low	pending	2026-06-27	\N	2026-06-30 17:14:30	2026-06-30 17:14:30
11	2	16	\N	Follow up call	Sunt omnis eum ut aspernatur quas ducimus qui.	medium	in_progress	2026-06-30	\N	2026-06-30 17:14:32	2026-06-30 17:14:32
12	3	\N	1	Send proposal	Quod dolorum consequatur sit non minus.	high	completed	2026-06-30	\N	2026-06-30 17:14:33	2026-06-30 17:14:33
13	1	13	\N	Check in with customer	Consequatur nihil libero voluptate omnis voluptas ex odio.	low	pending	2026-06-30	\N	2026-06-30 17:14:35	2026-06-30 17:14:35
14	2	\N	37	Schedule demo	Maxime mollitia in atque corrupti aliquam porro.	medium	in_progress	2026-06-23	\N	2026-06-30 17:14:37	2026-06-30 17:14:37
15	3	1	\N	Prepare quote	Qui temporibus autem sunt eveniet.	high	completed	2026-07-07	\N	2026-06-30 17:14:38	2026-06-30 17:14:38
16	1	\N	6	Schedule demo	Nihil doloribus beatae illum.	low	pending	2026-06-23	\N	2026-06-30 17:14:40	2026-06-30 17:14:40
17	2	4	\N	Review contract	Corporis fugit laudantium odit vitae distinctio sint.	medium	in_progress	2026-06-30	\N	2026-06-30 17:14:42	2026-06-30 17:14:42
18	3	\N	3	Check in with customer	Sed quos tempore fugiat.	high	completed	2026-06-29	\N	2026-06-30 17:14:43	2026-06-30 17:14:43
19	1	5	\N	Follow up call	Voluptas ut tempora laudantium blanditiis aperiam maiores.	low	pending	2026-06-29	\N	2026-06-30 17:14:45	2026-06-30 17:14:45
20	2	\N	40	Review contract	Eum hic eligendi exercitationem quis.	medium	in_progress	2026-07-14	\N	2026-06-30 17:14:47	2026-06-30 17:14:47
21	3	7	\N	Send proposal	Voluptatum dolore asperiores occaecati unde ducimus qui.	high	completed	2026-07-03	\N	2026-06-30 17:14:49	2026-06-30 17:14:49
22	1	\N	34	Check in with customer	Quos occaecati vero dolor sed non.	low	pending	2026-06-30	\N	2026-06-30 17:14:51	2026-06-30 17:14:51
23	2	7	\N	Send proposal	Esse repellendus animi non et debitis assumenda.	medium	in_progress	2026-06-27	\N	2026-06-30 17:14:52	2026-06-30 17:14:52
24	3	\N	28	Prepare quote	Ab et provident nulla officiis sed ipsum fugiat.	high	completed	2026-06-30	\N	2026-06-30 17:14:54	2026-06-30 17:14:54
25	1	11	\N	Prepare quote	Molestiae et expedita quam culpa doloremque asperiores molestiae unde.	low	pending	2026-06-29	\N	2026-06-30 17:14:56	2026-06-30 17:14:56
26	2	\N	11	Send proposal	Qui aut voluptate maiores nobis.	medium	in_progress	2026-06-30	\N	2026-06-30 17:14:58	2026-06-30 17:14:58
27	3	17	\N	Review contract	Quo eligendi et commodi rerum quam incidunt.	high	completed	2026-06-30	\N	2026-06-30 17:15:00	2026-06-30 17:15:00
28	1	\N	5	Schedule demo	Occaecati rerum dolores molestias necessitatibus id.	low	pending	2026-06-29	\N	2026-06-30 17:15:02	2026-06-30 17:15:02
29	2	1	\N	Schedule demo	Natus laborum voluptate expedita blanditiis voluptatibus magnam.	medium	in_progress	2026-06-30	\N	2026-06-30 17:15:04	2026-06-30 17:15:04
30	3	\N	37	Send onboarding docs	Architecto et quam nulla qui.	high	completed	2026-06-30	\N	2026-06-30 17:15:05	2026-06-30 17:15:05
31	1	15	\N	Send proposal	Qui error sunt commodi nemo.	low	pending	2026-07-03	\N	2026-06-30 17:15:07	2026-06-30 17:15:07
32	2	\N	40	Discovery call	Veniam tempore autem quo repudiandae dolorem qui.	medium	in_progress	2026-06-29	\N	2026-06-30 17:15:09	2026-06-30 17:15:09
33	3	11	\N	Prepare quote	Et et perspiciatis repudiandae beatae in molestiae.	high	completed	2026-06-29	\N	2026-06-30 17:15:11	2026-06-30 17:15:11
34	1	\N	32	Schedule demo	Inventore sapiente pariatur minima totam unde non quia.	low	pending	2026-07-07	\N	2026-06-30 17:15:13	2026-06-30 17:15:13
35	2	3	\N	Check in with customer	Ut error mollitia neque alias ullam.	medium	in_progress	2026-06-30	\N	2026-06-30 17:15:15	2026-06-30 17:15:15
36	3	\N	49	Send onboarding docs	Eaque molestiae sunt est enim iste molestiae perspiciatis.	high	completed	2026-06-30	\N	2026-06-30 17:15:17	2026-06-30 17:15:17
37	1	9	\N	Review contract	Deleniti alias ad enim voluptas quidem.	low	pending	2026-06-27	\N	2026-06-30 17:15:19	2026-06-30 17:15:19
38	2	\N	49	Discovery call	Ab qui fuga velit in.	medium	in_progress	2026-07-14	\N	2026-06-30 17:15:21	2026-06-30 17:15:21
39	3	16	\N	Prepare quote	Et et nihil aliquid aut culpa optio.	high	completed	2026-07-07	\N	2026-06-30 17:15:23	2026-06-30 17:15:23
40	1	\N	8	Prepare quote	Dolorem iure cumque id enim dolore nemo.	low	pending	2026-06-27	\N	2026-06-30 17:15:25	2026-06-30 17:15:25
41	2	4	\N	Follow up call	Cum perferendis possimus facilis.	medium	in_progress	2026-06-29	\N	2026-06-30 17:15:28	2026-06-30 17:15:28
42	3	\N	28	Send proposal	Deserunt praesentium debitis sint ut.	high	completed	2026-06-29	\N	2026-06-30 17:15:30	2026-06-30 17:15:30
43	1	2	\N	Send onboarding docs	Facilis ut consequatur dolorum est repellat laboriosam.	low	pending	2026-06-29	\N	2026-06-30 17:15:31	2026-06-30 17:15:31
44	2	\N	17	Send onboarding docs	Ea quas ducimus consequuntur tenetur.	medium	in_progress	2026-06-27	\N	2026-06-30 17:15:33	2026-06-30 17:15:33
45	3	9	\N	Prepare quote	Ab nemo qui similique eveniet vitae corrupti aut est.	high	completed	2026-06-27	\N	2026-06-30 17:15:35	2026-06-30 17:15:35
46	1	\N	22	Check in with customer	Hic est ea non sit.	low	pending	2026-06-29	\N	2026-06-30 17:15:38	2026-06-30 17:15:38
47	2	2	\N	Send onboarding docs	Magnam non et at.	medium	in_progress	2026-06-27	\N	2026-06-30 17:15:40	2026-06-30 17:15:40
48	3	\N	9	Discovery call	Totam minus qui ducimus.	high	completed	2026-06-29	\N	2026-06-30 17:15:42	2026-06-30 17:15:42
49	1	7	\N	Schedule demo	Excepturi tempora harum sunt ullam recusandae id.	low	pending	2026-06-27	\N	2026-06-30 17:15:44	2026-06-30 17:15:44
50	2	\N	7	Send proposal	Alias commodi pariatur unde vel.	medium	in_progress	2026-07-14	\N	2026-06-30 17:15:46	2026-06-30 17:15:46
51	1	\N	1	Assigned to admin by exec	\N	low	pending	2026-07-10	\N	2026-06-30 17:48:18	2026-06-30 17:48:18
52	3	17	1	both refs	\N	low	pending	2026-07-10	\N	2026-06-30 17:48:25	2026-06-30 17:48:25
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.users (id, name, email, email_verified_at, password, remember_token, created_at, updated_at, role_id) FROM stdin;
1	Alice Admin	admin@example.com	2026-06-30 17:11:30	$2y$12$5zyfTw.jOSZyjc/mBoDy/O5E3XUpFPVLkjnEGC0sKr7ILPXzARSoG	\N	2026-06-30 17:11:31	2026-06-30 17:11:31	1
2	Mark Manager	manager@example.com	2026-06-30 17:11:32	$2y$12$4V40XyoGMt.txr5w9mebPOZhxTYIER/16t8VrSLkgnDBrSrn27pfS	\N	2026-06-30 17:11:32	2026-06-30 17:11:32	2
3	Eve Executive	executive@example.com	2026-06-30 17:11:34	$2y$12$kgCM2RgniD8HuJCsUSgrv.URBAwv1lJl/uQvHL5fvSxR.1noemvh2	\N	2026-06-30 17:11:34	2026-06-30 17:11:34	3
\.


--
-- Name: activities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.activities_id_seq', 204, true);


--
-- Name: customers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.customers_id_seq', 18, true);


--
-- Name: failed_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.failed_jobs_id_seq', 1, false);


--
-- Name: jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.jobs_id_seq', 1, false);


--
-- Name: leads_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.leads_id_seq', 58, true);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.migrations_id_seq', 11, true);


--
-- Name: notes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.notes_id_seq', 72, true);


--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.personal_access_tokens_id_seq', 1, false);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.roles_id_seq', 3, true);


--
-- Name: tasks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.tasks_id_seq', 52, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.users_id_seq', 3, true);


--
-- Name: activities activities_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.activities
    ADD CONSTRAINT activities_pkey PRIMARY KEY (id);


--
-- Name: cache_locks cache_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.cache_locks
    ADD CONSTRAINT cache_locks_pkey PRIMARY KEY (key);


--
-- Name: cache cache_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.cache
    ADD CONSTRAINT cache_pkey PRIMARY KEY (key);


--
-- Name: customers customers_lead_id_unique; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_lead_id_unique UNIQUE (lead_id);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid);


--
-- Name: job_batches job_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.job_batches
    ADD CONSTRAINT job_batches_pkey PRIMARY KEY (id);


--
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- Name: leads leads_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.leads
    ADD CONSTRAINT leads_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: notes notes_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (id);


--
-- Name: password_reset_tokens password_reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (email);


--
-- Name: personal_access_tokens personal_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_pkey PRIMARY KEY (id);


--
-- Name: personal_access_tokens personal_access_tokens_token_unique; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_token_unique UNIQUE (token);


--
-- Name: roles roles_name_unique; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_unique UNIQUE (name);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: roles roles_slug_unique; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_slug_unique UNIQUE (slug);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: tasks tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: activities_subject_type_subject_id_index; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX activities_subject_type_subject_id_index ON public.activities USING btree (subject_type, subject_id);


--
-- Name: jobs_queue_index; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX jobs_queue_index ON public.jobs USING btree (queue);


--
-- Name: leads_first_name_last_name_index; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX leads_first_name_last_name_index ON public.leads USING btree (first_name, last_name);


--
-- Name: leads_status_index; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX leads_status_index ON public.leads USING btree (status);


--
-- Name: personal_access_tokens_expires_at_index; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX personal_access_tokens_expires_at_index ON public.personal_access_tokens USING btree (expires_at);


--
-- Name: personal_access_tokens_tokenable_type_tokenable_id_index; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX personal_access_tokens_tokenable_type_tokenable_id_index ON public.personal_access_tokens USING btree (tokenable_type, tokenable_id);


--
-- Name: sessions_last_activity_index; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX sessions_last_activity_index ON public.sessions USING btree (last_activity);


--
-- Name: sessions_user_id_index; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX sessions_user_id_index ON public.sessions USING btree (user_id);


--
-- Name: tasks_due_date_index; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX tasks_due_date_index ON public.tasks USING btree (due_date);


--
-- Name: tasks_priority_index; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX tasks_priority_index ON public.tasks USING btree (priority);


--
-- Name: tasks_status_index; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX tasks_status_index ON public.tasks USING btree (status);


--
-- Name: activities activities_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.activities
    ADD CONSTRAINT activities_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: customers customers_lead_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_lead_id_foreign FOREIGN KEY (lead_id) REFERENCES public.leads(id) ON DELETE CASCADE;


--
-- Name: leads leads_assigned_to_foreign; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.leads
    ADD CONSTRAINT leads_assigned_to_foreign FOREIGN KEY (assigned_to) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: leads leads_created_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.leads
    ADD CONSTRAINT leads_created_by_foreign FOREIGN KEY (created_by) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: notes notes_customer_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT notes_customer_id_foreign FOREIGN KEY (customer_id) REFERENCES public.customers(id) ON DELETE CASCADE;


--
-- Name: notes notes_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT notes_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: tasks tasks_customer_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_customer_id_foreign FOREIGN KEY (customer_id) REFERENCES public.customers(id) ON DELETE SET NULL;


--
-- Name: tasks tasks_lead_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_lead_id_foreign FOREIGN KEY (lead_id) REFERENCES public.leads(id) ON DELETE SET NULL;


--
-- Name: tasks tasks_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: users users_role_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_role_id_foreign FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE SET NULL;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO neon_superuser WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON TABLES TO neon_superuser WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

\unrestrict GaKC9s7HJAcuu33NAQCHmr1wTgtumhp27uOYzJ9EFjgNAGlJsStJFb5ji1LO8OR

