--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3
-- Dumped by pg_dump version 15.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- Name: athletes; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.athletes (
    athlete_id integer NOT NULL,
    athlete_name character varying(100),
    sport_type character varying(100)
);


ALTER TABLE public.athletes OWNER TO "user";

--
-- Name: athletes_athlete_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.athletes_athlete_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.athletes_athlete_id_seq OWNER TO "user";

--
-- Name: athletes_athlete_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.athletes_athlete_id_seq OWNED BY public.athletes.athlete_id;


--
-- Name: customer_visit; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.customer_visit (
    id integer NOT NULL,
    customer_id integer,
    created_at timestamp without time zone,
    visit_length integer,
    landing_page character varying(255),
    exit_page character varying(255),
    utm_source character varying(255)
);


ALTER TABLE public.customer_visit OWNER TO "user";

--
-- Name: customer_visit_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.customer_visit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customer_visit_id_seq OWNER TO "user";

--
-- Name: customer_visit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.customer_visit_id_seq OWNED BY public.customer_visit.id;


--
-- Name: customer_visit_page; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.customer_visit_page (
    id integer NOT NULL,
    visit_id integer,
    page character varying(255),
    timeon_page integer
);


ALTER TABLE public.customer_visit_page OWNER TO "user";

--
-- Name: customer_visit_page_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.customer_visit_page_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customer_visit_page_id_seq OWNER TO "user";

--
-- Name: customer_visit_page_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.customer_visit_page_id_seq OWNED BY public.customer_visit_page.id;


--
-- Name: customers; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.customers (
    id integer NOT NULL,
    created_at timestamp without time zone,
    first_name character varying(50),
    last_name character varying(50),
    phone character varying(20),
    email character varying(100)
);


ALTER TABLE public.customers OWNER TO "user";

--
-- Name: customers_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.customers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customers_id_seq OWNER TO "user";

--
-- Name: customers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.customers_id_seq OWNED BY public.customers.id;


--
-- Name: order_history; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.order_history (
    id integer NOT NULL,
    order_id integer,
    created_at date,
    field_name character varying(255),
    old_value character varying(255),
    new_value character varying(255)
);


ALTER TABLE public.order_history OWNER TO "user";

--
-- Name: order_history_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.order_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_history_id_seq OWNER TO "user";

--
-- Name: order_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.order_history_id_seq OWNED BY public.order_history.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    created_at timestamp without time zone,
    customer_id integer,
    manager_id integer,
    status_id integer,
    is_paid boolean,
    total_sum numeric(10,2),
    utm_source character varying(100)
);


ALTER TABLE public.orders OWNER TO "user";

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_id_seq OWNER TO "user";

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: transactions; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.transactions (
    transaction_id integer NOT NULL,
    operation_type character varying(100),
    amount numeric,
    percent_of_total numeric
);


ALTER TABLE public.transactions OWNER TO "user";

--
-- Name: transactions_table; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.transactions_table (
    operation_number integer NOT NULL,
    operation_type character varying(50),
    amount numeric
);


ALTER TABLE public.transactions_table OWNER TO "user";

--
-- Name: transactions_table_operation_number_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.transactions_table_operation_number_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transactions_table_operation_number_seq OWNER TO "user";

--
-- Name: transactions_table_operation_number_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.transactions_table_operation_number_seq OWNED BY public.transactions_table.operation_number;


--
-- Name: transactions_transaction_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.transactions_transaction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transactions_transaction_id_seq OWNER TO "user";

--
-- Name: transactions_transaction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.transactions_transaction_id_seq OWNED BY public.transactions.transaction_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(100),
    email character varying(100)
);


ALTER TABLE public.users OWNER TO "user";

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO "user";

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: visits; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.visits (
    id integer NOT NULL,
    customer_id integer,
    visit_time timestamp without time zone
);


ALTER TABLE public.visits OWNER TO "user";

--
-- Name: visits_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.visits_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.visits_id_seq OWNER TO "user";

--
-- Name: visits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.visits_id_seq OWNED BY public.visits.id;


--
-- Name: athletes athlete_id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.athletes ALTER COLUMN athlete_id SET DEFAULT nextval('public.athletes_athlete_id_seq'::regclass);


--
-- Name: customer_visit id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.customer_visit ALTER COLUMN id SET DEFAULT nextval('public.customer_visit_id_seq'::regclass);


--
-- Name: customer_visit_page id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.customer_visit_page ALTER COLUMN id SET DEFAULT nextval('public.customer_visit_page_id_seq'::regclass);


--
-- Name: customers id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.customers ALTER COLUMN id SET DEFAULT nextval('public.customers_id_seq'::regclass);


--
-- Name: order_history id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.order_history ALTER COLUMN id SET DEFAULT nextval('public.order_history_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: transactions transaction_id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.transactions ALTER COLUMN transaction_id SET DEFAULT nextval('public.transactions_transaction_id_seq'::regclass);


--
-- Name: transactions_table operation_number; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.transactions_table ALTER COLUMN operation_number SET DEFAULT nextval('public.transactions_table_operation_number_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: visits id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.visits ALTER COLUMN id SET DEFAULT nextval('public.visits_id_seq'::regclass);


--
-- Data for Name: athletes; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.athletes (athlete_id, athlete_name, sport_type) FROM stdin;
1	Алексей	шахматы
2	Иван	шахматы
3	Мария	шахматы
4	Елена	настольный теннис
5	Дмитрий	настольный теннис
6	Ольга	настольный теннис
7	Андрей	футбол
8	Светлана	футбол
9	Павел	футбол
\.


--
-- Data for Name: customer_visit; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.customer_visit (id, customer_id, created_at, visit_length, landing_page, exit_page, utm_source) FROM stdin;
1	1	2024-03-01 08:00:00	300	/home	/product	google
2	1	2024-03-02 09:00:00	400	/product	/cart	facebook
3	2	2024-03-01 10:00:00	200	/home	/product	instagram
4	2	2024-03-03 11:00:00	350	/product	/checkout	google
\.


--
-- Data for Name: customer_visit_page; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.customer_visit_page (id, visit_id, page, timeon_page) FROM stdin;
1	1	/home	60
2	1	/product	120
3	1	/cart	120
4	2	/home	80
5	2	/product	180
6	2	/checkout	90
7	3	/home	100
8	3	/product	150
9	4	/home	90
10	4	/product	200
11	4	/checkout	60
\.


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.customers (id, created_at, first_name, last_name, phone, email) FROM stdin;
1	2024-01-01 00:00:00	John	Doe	123456789	john@example.com
2	2024-02-01 00:00:00	Jane	Smith	987654321	jane@example.com
\.


--
-- Data for Name: order_history; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.order_history (id, order_id, created_at, field_name, old_value, new_value) FROM stdin;
1	1	2024-03-03	status_id	1	2
2	1	2024-03-05	status_id	2	3
3	2	2024-03-02	status_id	1	3
4	2	2024-03-06	status_id	3	4
5	3	2024-03-03	status_id	1	2
6	3	2024-03-07	status_id	2	3
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.orders (id, created_at, customer_id, manager_id, status_id, is_paid, total_sum, utm_source) FROM stdin;
1	2024-01-05 00:00:00	1	1	1	t	100.00	Google
2	2024-01-10 00:00:00	1	1	1	t	150.00	Facebook
3	2024-02-05 00:00:00	2	2	1	t	200.00	Google
4	2024-02-10 00:00:00	2	2	1	t	250.00	Facebook
\.


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.transactions (transaction_id, operation_type, amount, percent_of_total) FROM stdin;
2	Возврат абонемента	-100.00	-32.25806451612903225800
3	Покупка билета	30.00	9.67741935483870967700
4	Покупка в аптеке	70.00	22.58064516129032258100
5	Возврат билета	-30.00	-9.67741935483870967700
6	Покупка абонемента	200.00	64.51612903225806451600
7	Покупка билета	50.00	16.12903225806451612900
8	Покупка в аптеке	40.00	12.90322580645161290300
1	Покупка в аптеке	70	16.12903225806451612900
\.


--
-- Data for Name: transactions_table; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.transactions_table (operation_number, operation_type, amount) FROM stdin;
1	Покупка в аптеке	50.00
2	Возврат абонемента	-100.00
3	Покупка билета	30.00
4	Покупка в аптеке	70.00
5	Возврат билета	-30.00
6	Покупка абонемента	200.00
7	Покупка билета	50.00
8	Покупка в аптеке	40.00
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.users (id, name, email) FROM stdin;
1	Igor	knigor@mail.ru
\.


--
-- Data for Name: visits; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.visits (id, customer_id, visit_time) FROM stdin;
1	1	2024-01-01 10:00:00
2	1	2024-01-06 10:00:00
3	2	2024-02-01 10:00:00
4	2	2024-02-06 10:00:00
\.


--
-- Name: athletes_athlete_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.athletes_athlete_id_seq', 9, true);


--
-- Name: customer_visit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.customer_visit_id_seq', 4, true);


--
-- Name: customer_visit_page_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.customer_visit_page_id_seq', 11, true);


--
-- Name: customers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.customers_id_seq', 2, true);


--
-- Name: order_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.order_history_id_seq', 6, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.orders_id_seq', 4, true);


--
-- Name: transactions_table_operation_number_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.transactions_table_operation_number_seq', 8, true);


--
-- Name: transactions_transaction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.transactions_transaction_id_seq', 8, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- Name: visits_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.visits_id_seq', 4, true);


--
-- Name: athletes athletes_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.athletes
    ADD CONSTRAINT athletes_pkey PRIMARY KEY (athlete_id);


--
-- Name: customer_visit_page customer_visit_page_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.customer_visit_page
    ADD CONSTRAINT customer_visit_page_pkey PRIMARY KEY (id);


--
-- Name: customer_visit customer_visit_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.customer_visit
    ADD CONSTRAINT customer_visit_pkey PRIMARY KEY (id);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- Name: order_history order_history_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.order_history
    ADD CONSTRAINT order_history_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (transaction_id);


--
-- Name: transactions_table transactions_table_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.transactions_table
    ADD CONSTRAINT transactions_table_pkey PRIMARY KEY (operation_number);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: visits visits_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.visits
    ADD CONSTRAINT visits_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

