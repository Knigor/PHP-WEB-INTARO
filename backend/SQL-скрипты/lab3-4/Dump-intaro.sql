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

--
-- Name: insert_interval_data(); Type: FUNCTION; Schema: public; Owner: user
--

CREATE FUNCTION public.insert_interval_data() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Сохраняем текущее значение data_send в interval_data
    NEW.interval_data := NEW.data_send;
    
    -- Прибавляем к текущему значению data_send интервал 1.5 часа и сохраняем в interval_data
    NEW.interval_data := NEW.interval_data + INTERVAL '1 hour 30 minutes';
    
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.insert_interval_data() OWNER TO "user";

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: api_responses; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.api_responses (
    id integer NOT NULL,
    json_data jsonb
);


ALTER TABLE public.api_responses OWNER TO "user";

--
-- Name: api_responses_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.api_responses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_responses_id_seq OWNER TO "user";

--
-- Name: api_responses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.api_responses_id_seq OWNED BY public.api_responses.id;


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
-- Name: lab3_php; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.lab3_php (
    id_form integer NOT NULL,
    fio character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    phone character varying(100) NOT NULL,
    text_message text NOT NULL,
    data_send timestamp without time zone DEFAULT now() NOT NULL,
    interval_data timestamp without time zone
);


ALTER TABLE public.lab3_php OWNER TO "user";

--
-- Name: lab3_php_id_form_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.lab3_php_id_form_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lab3_php_id_form_seq OWNER TO "user";

--
-- Name: lab3_php_id_form_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.lab3_php_id_form_seq OWNED BY public.lab3_php.id_form;


--
-- Name: order_history; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.order_history (
    id integer NOT NULL,
    order_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    field_name character varying(50) NOT NULL,
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
-- Name: products; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.products (
    id integer NOT NULL,
    created_at timestamp without time zone,
    active boolean,
    sort integer,
    price numeric,
    code character(255),
    name character(255),
    description character(255)
);


ALTER TABLE public.products OWNER TO "user";

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_id_seq OWNER TO "user";

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


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
-- Name: api_responses id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_responses ALTER COLUMN id SET DEFAULT nextval('public.api_responses_id_seq'::regclass);


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
-- Name: lab3_php id_form; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.lab3_php ALTER COLUMN id_form SET DEFAULT nextval('public.lab3_php_id_form_seq'::regclass);


--
-- Name: order_history id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.order_history ALTER COLUMN id SET DEFAULT nextval('public.order_history_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


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
-- Data for Name: api_responses; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.api_responses (id, json_data) FROM stdin;
1	{"data": {"id": 1, "name": "Test 1"}, "status": "success"}
2	{"status": "error", "message": "Invalid request"}
3	{"data": {"id": 2, "name": "Test 2"}, "status": "success"}
4	{"status": "error", "message": "Server error"}
\.


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
1	1	2024-06-13 08:00:00	300	/home	/product	google
2	1	2024-06-13 09:00:00	400	/product	/cart	facebook
3	2	2024-06-13 10:00:00	200	/home	/product	instagram
4	2	2024-06-13 11:00:00	350	/product	/checkout	google
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
-- Data for Name: lab3_php; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.lab3_php (id_form, fio, email, phone, text_message, data_send, interval_data) FROM stdin;
1	Кретов Игорь Олегович	aboba@mail.ru	88005553535	Вфывфывф	2024-04-18 12:06:43.745679	2024-04-18 13:36:43.745679
2	Зубенко Михаил Петрович	asda@mail.ru	88005553535	Какое-то описание	2024-04-18 09:49:00.339833	2024-04-18 11:19:00.339833
68	Ефремов Владимир Александрович	aboba@mail.ru	88005553535	aboba	2024-04-26 08:21:59	2024-04-26 09:51:59
69	Агеев Илья Андреевиич	aboba228@mail.ru	88005553535	aboba	2024-04-26 08:22:57	2024-04-26 09:52:57
70	Кретов Игорь Олегович	test@mail.ru	88005553535	test 	2024-04-26 11:39:42	2024-04-26 13:09:42
71	Кретов Игорь Олегович	test@mail.ri	88005553535	dasdsad	2024-04-26 11:41:32	2024-04-26 13:11:32
48	Кретов Игорь Олегович	aboba@mail.ru	88005553535	123456	2024-04-19 11:55:24	2024-04-19 13:25:24
49	Зубенко Михаил Петрович	aboba111111@mail.ru	88005553535	Какое-то описание	2024-04-19 12:13:19	2024-04-19 13:43:19
50	Кретов Игорь Олегович	test@mail.ru	88888888	dasda	2024-04-19 12:14:35	2024-04-19 12:10:35
51	Кретов Игорь Олегович	test@mail.ru	88888888	dasda	2024-04-19 12:16:27	2024-04-19 13:25:27
52	Зубенко Михаил Петрович	test@mail.ru	88005553535	Какое-то описание	2024-04-19 13:46:47	2024-04-19 15:16:47
53	Кретов Игорь Олегович	aboba@mail.ru	8888888	123	2024-04-19 14:23:56	2024-04-19 15:53:56
54	Кретов Игорь Олегович	aboba111@mail.ru	88000000	123	2024-04-19 14:38:11	2024-04-19 16:08:11
55	Кретов Игорь Олегович	abob11111112312312a@mail.ru	8888888	123	2024-04-19 14:40:15	2024-04-19 16:10:15
56	Кретов Игорь Олегович	bboba@mail.ru	88000553535	Кретов Игорь Олегович Кретов Игорь Олегович Кретов Игорь Олегович Кретов Игорь Олегович Кретов Игорь Олегович	2024-04-19 14:41:09	2024-04-19 16:11:09
57	Кретов Игорь Олегович	aboba@mail.ru	88005553535	123	2024-04-25 18:06:56	2024-04-25 19:36:56
58	Зубенко Михаил Петрович	tezxcst@mail.ru	88005553535	Какое-то описание	2024-04-25 18:08:41	2024-04-25 19:38:41
\.


--
-- Data for Name: order_history; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.order_history (id, order_id, created_at, field_name, old_value, new_value) FROM stdin;
1	1	2024-06-13 10:00:00	status_id	\N	1
2	1	2024-06-13 12:00:00	status_id	1	2
3	1	2024-06-13 14:00:00	status_id	2	3
5	2	2024-06-13 12:00:00	status_id	1	2
4	2	2024-06-13 10:00:00	status_id	\N	1
6	3	2024-06-13 10:00:00	status_id	\N	1
7	3	2024-06-13 12:00:00	status_id	1	3
8	3	2024-06-13 14:00:00	status_id	3	4
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
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.products (id, created_at, active, sort, price, code, name, description) FROM stdin;
1	2023-01-01 12:00:00	t	1	19.99	A001                                                                                                                                                                                                                                                           	Product 1                                                                                                                                                                                                                                                      	Description for Product 1                                                                                                                                                                                                                                      
2	2023-02-01 13:30:00	t	2	29.99	A002                                                                                                                                                                                                                                                           	Product 2                                                                                                                                                                                                                                                      	Description for Product 2                                                                                                                                                                                                                                      
3	2023-03-01 14:45:00	f	3	39.99	A003                                                                                                                                                                                                                                                           	Product 3                                                                                                                                                                                                                                                      	Description for Product 3                                                                                                                                                                                                                                      
4	2023-04-01 16:00:00	t	4	49.99	A004                                                                                                                                                                                                                                                           	Product 4                                                                                                                                                                                                                                                      	Description for Product 4                                                                                                                                                                                                                                      
5	2023-05-01 17:15:00	f	5	59.99	A005                                                                                                                                                                                                                                                           	Product 5                                                                                                                                                                                                                                                      	Description for Product 5                                                                                                                                                                                                                                      
6	2023-06-01 18:30:00	t	6	69.99	A006                                                                                                                                                                                                                                                           	Product 6                                                                                                                                                                                                                                                      	Description for Product 6                                                                                                                                                                                                                                      
7	2023-07-01 19:45:00	t	7	79.99	A007                                                                                                                                                                                                                                                           	Product 7                                                                                                                                                                                                                                                      	Description for Product 7                                                                                                                                                                                                                                      
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
-- Name: api_responses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.api_responses_id_seq', 4, true);


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
-- Name: lab3_php_id_form_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.lab3_php_id_form_seq', 71, true);


--
-- Name: order_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.order_history_id_seq', 8, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.orders_id_seq', 4, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.products_id_seq', 7, true);


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
-- Name: api_responses api_responses_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.api_responses
    ADD CONSTRAINT api_responses_pkey PRIMARY KEY (id);


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
-- Name: lab3_php lab3_php_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.lab3_php
    ADD CONSTRAINT lab3_php_pkey PRIMARY KEY (id_form);


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
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


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
-- Name: idx_products_active; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_products_active ON public.products USING btree (active);


--
-- Name: idx_products_code_hash; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_products_code_hash ON public.products USING hash (code);


--
-- Name: idx_products_created_at_brin; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_products_created_at_brin ON public.products USING brin (created_at);


--
-- Name: idx_products_price_active_partial; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_products_price_active_partial ON public.products USING btree (price) WHERE (active = true);


--
-- Name: lab3_php trigger_insert_interval_data; Type: TRIGGER; Schema: public; Owner: user
--

CREATE TRIGGER trigger_insert_interval_data BEFORE INSERT ON public.lab3_php FOR EACH ROW EXECUTE FUNCTION public.insert_interval_data();


--
-- PostgreSQL database dump complete
--

