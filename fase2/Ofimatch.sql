--
-- PostgreSQL database dump
--

\restrict sR2Hhuawe23sHbpUdn03PjAsp287QyG84o89LAx8ppXXufMQdqsx5g3A6fPju0B

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

-- Started on 2026-10-07 19:07:58

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
-- TOC entry 224 (class 1259 OID 16462)
-- Name: categorias; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categorias (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL
);


ALTER TABLE public.categorias OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16461)
-- Name: categorias_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categorias_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categorias_id_seq OWNER TO postgres;

--
-- TOC entry 5057 (class 0 OID 0)
-- Dependencies: 223
-- Name: categorias_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categorias_id_seq OWNED BY public.categorias.id;


--
-- TOC entry 222 (class 1259 OID 16428)
-- Name: clientes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clientes (
    id integer NOT NULL,
    usuario_id integer NOT NULL
);


ALTER TABLE public.clientes OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16427)
-- Name: clientes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.clientes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.clientes_id_seq OWNER TO postgres;

--
-- TOC entry 5058 (class 0 OID 0)
-- Dependencies: 221
-- Name: clientes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.clientes_id_seq OWNED BY public.clientes.id;


--
-- TOC entry 226 (class 1259 OID 16473)
-- Name: trabajadores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trabajadores (
    id integer NOT NULL,
    usuario_id integer NOT NULL,
    categoria_id integer NOT NULL,
    nombre_publico character varying(100) NOT NULL,
    biografia text,
    ciudad character varying(100),
    disponible boolean DEFAULT true,
    categoria_personalizada character varying(100)
);


ALTER TABLE public.trabajadores OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16472)
-- Name: trabajadores_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.trabajadores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.trabajadores_id_seq OWNER TO postgres;

--
-- TOC entry 5059 (class 0 OID 0)
-- Dependencies: 225
-- Name: trabajadores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.trabajadores_id_seq OWNED BY public.trabajadores.id;


--
-- TOC entry 220 (class 1259 OID 16409)
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    apellido character varying(100) NOT NULL,
    email character varying(150) NOT NULL,
    password text NOT NULL,
    telefono character varying(20),
    tipo_usuario character varying(15) NOT NULL,
    fecha_registro timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT usuarios_tipo_usuario_check CHECK (((tipo_usuario)::text = ANY ((ARRAY['cliente'::character varying, 'trabajador'::character varying, 'admin'::character varying])::text[])))
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16408)
-- Name: usuarios_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuarios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuarios_id_seq OWNER TO postgres;

--
-- TOC entry 5060 (class 0 OID 0)
-- Dependencies: 219
-- Name: usuarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuarios_id_seq OWNED BY public.usuarios.id;


--
-- TOC entry 4874 (class 2604 OID 16465)
-- Name: categorias id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorias ALTER COLUMN id SET DEFAULT nextval('public.categorias_id_seq'::regclass);


--
-- TOC entry 4873 (class 2604 OID 16431)
-- Name: clientes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientes ALTER COLUMN id SET DEFAULT nextval('public.clientes_id_seq'::regclass);


--
-- TOC entry 4875 (class 2604 OID 16476)
-- Name: trabajadores id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trabajadores ALTER COLUMN id SET DEFAULT nextval('public.trabajadores_id_seq'::regclass);


--
-- TOC entry 4871 (class 2604 OID 16412)
-- Name: usuarios id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN id SET DEFAULT nextval('public.usuarios_id_seq'::regclass);


--
-- TOC entry 5049 (class 0 OID 16462)
-- Dependencies: 224
-- Data for Name: categorias; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categorias (id, nombre) FROM stdin;
11	Tatuador
12	Peluquero
13	Barbero
14	Manicurista
15	Maquillador
16	Estilista
17	Fotógrafo
18	Videógrafo
19	Diseñador gráfico
20	Ilustrador
21	Diseñador web
22	Animador
23	DJ
24	Músico
25	Profesor particular
26	Traductor
27	Redactor
28	Community Manager
29	Electricista
30	Gasfíter
31	Carpintero
32	Cerrajero
33	Pintor
34	Albañil
35	Soldador
36	Técnico en computación
37	Técnico en celulares
38	Técnico en electrónica
39	Instalador de cámaras
40	Instalador de redes
41	Mecánico automotriz
42	Vulcanizador
43	Tapicero
44	Jardinero
45	Paisajista
46	Limpieza de hogares
47	Cuidador de mascotas
48	Paseador de perros
49	Adiestrador de mascotas
50	Chef
51	Repostero
52	Panadero
53	Cocinero
54	Bartender
55	Organizador de eventos
56	Decorador
57	Personal trainer
58	Masajista
59	Costurero
60	Modista
61	Otro
\.


--
-- TOC entry 5047 (class 0 OID 16428)
-- Dependencies: 222
-- Data for Name: clientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clientes (id, usuario_id) FROM stdin;
\.


--
-- TOC entry 5051 (class 0 OID 16473)
-- Dependencies: 226
-- Data for Name: trabajadores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.trabajadores (id, usuario_id, categoria_id, nombre_publico, biografia, ciudad, disponible, categoria_personalizada) FROM stdin;
57	116	11	Alexander Nicolas Solís Castillo		Santiago	t	
3	61	11	Trabajador1 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	\N
4	62	11	Trabajador2 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	\N
5	63	11	Trabajador3 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	\N
6	64	11	Trabajador4 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	\N
7	65	11	Trabajador5 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	\N
8	66	11	Trabajador6 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	\N
9	67	11	Trabajador7 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	\N
10	68	11	Trabajador8 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	\N
11	69	11	Trabajador9 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	\N
12	70	11	Trabajador10 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	\N
13	71	11	Trabajador11 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	\N
14	72	11	Trabajador12 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	\N
15	73	11	Trabajador13 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	\N
16	74	11	Trabajador14 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	\N
17	75	11	Trabajador15 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	\N
18	76	11	Trabajador16 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	\N
19	77	11	Trabajador17 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	\N
20	78	11	Trabajador18 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	\N
21	79	11	Trabajador19 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	\N
22	80	11	Trabajador20 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	\N
23	81	11	Trabajador21 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	\N
24	82	11	Trabajador22 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	\N
25	83	11	Trabajador23 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	\N
26	84	11	Trabajador24 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	\N
27	85	11	Trabajador25 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	\N
28	86	11	Trabajador26 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	\N
29	87	11	Trabajador27 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	\N
30	88	11	Trabajador28 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	\N
31	89	11	Trabajador29 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	\N
32	90	11	Trabajador30 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	\N
33	91	13	Trabajador31 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	\N
34	92	13	Trabajador32 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	\N
35	93	13	Trabajador33 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	\N
36	94	13	Trabajador34 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	\N
37	95	13	Trabajador35 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	\N
38	96	13	Trabajador36 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	\N
39	97	12	Trabajador37 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	\N
40	98	12	Trabajador38 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	\N
41	99	12	Trabajador39 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	\N
42	100	12	Trabajador40 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	\N
43	101	12	Trabajador41 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	\N
44	102	14	Trabajador42 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	\N
45	103	14	Trabajador43 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	\N
46	104	14	Trabajador44 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	\N
47	105	14	Trabajador45 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	\N
48	106	17	Trabajador46 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	\N
49	107	17	Trabajador47 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	\N
50	108	17	Trabajador48 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	\N
51	109	29	Trabajador49 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	\N
52	110	29	Trabajador50 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	\N
53	111	29	Trabajador51 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	\N
54	112	61	Trabajador52 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	Ceramista
55	113	61	Trabajador53 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	Ceramista
56	114	61	Trabajador54 OfiMatch	Profesional independiente registrado en OfiMatch.	Santiago	t	Ceramista
\.


--
-- TOC entry 5045 (class 0 OID 16409)
-- Dependencies: 220
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuarios (id, nombre, apellido, email, password, telefono, tipo_usuario, fecha_registro) FROM stdin;
36	Cliente1	OfiMatch	cliente1@ofimatch.cl	123456	910000001	cliente	2026-10-07 17:28:20.987272
37	Cliente2	OfiMatch	cliente2@ofimatch.cl	123456	910000002	cliente	2026-10-07 17:28:20.987272
38	Cliente3	OfiMatch	cliente3@ofimatch.cl	123456	910000003	cliente	2026-10-07 17:28:20.987272
39	Cliente4	OfiMatch	cliente4@ofimatch.cl	123456	910000004	cliente	2026-10-07 17:28:20.987272
40	Cliente5	OfiMatch	cliente5@ofimatch.cl	123456	910000005	cliente	2026-10-07 17:28:20.987272
41	Cliente6	OfiMatch	cliente6@ofimatch.cl	123456	910000006	cliente	2026-10-07 17:28:20.987272
42	Cliente7	OfiMatch	cliente7@ofimatch.cl	123456	910000007	cliente	2026-10-07 17:28:20.987272
43	Cliente8	OfiMatch	cliente8@ofimatch.cl	123456	910000008	cliente	2026-10-07 17:28:20.987272
44	Cliente9	OfiMatch	cliente9@ofimatch.cl	123456	910000009	cliente	2026-10-07 17:28:20.987272
45	Cliente10	OfiMatch	cliente10@ofimatch.cl	123456	910000010	cliente	2026-10-07 17:28:20.987272
46	Cliente11	OfiMatch	cliente11@ofimatch.cl	123456	910000011	cliente	2026-10-07 17:28:20.987272
47	Cliente12	OfiMatch	cliente12@ofimatch.cl	123456	910000012	cliente	2026-10-07 17:28:20.987272
48	Cliente13	OfiMatch	cliente13@ofimatch.cl	123456	910000013	cliente	2026-10-07 17:28:20.987272
49	Cliente14	OfiMatch	cliente14@ofimatch.cl	123456	910000014	cliente	2026-10-07 17:28:20.987272
50	Cliente15	OfiMatch	cliente15@ofimatch.cl	123456	910000015	cliente	2026-10-07 17:28:20.987272
51	Cliente16	OfiMatch	cliente16@ofimatch.cl	123456	910000016	cliente	2026-10-07 17:28:20.987272
52	Cliente17	OfiMatch	cliente17@ofimatch.cl	123456	910000017	cliente	2026-10-07 17:28:20.987272
53	Cliente18	OfiMatch	cliente18@ofimatch.cl	123456	910000018	cliente	2026-10-07 17:28:20.987272
54	Cliente19	OfiMatch	cliente19@ofimatch.cl	123456	910000019	cliente	2026-10-07 17:28:20.987272
55	Cliente20	OfiMatch	cliente20@ofimatch.cl	123456	910000020	cliente	2026-10-07 17:28:20.987272
56	Cliente21	OfiMatch	cliente21@ofimatch.cl	123456	910000021	cliente	2026-10-07 17:28:20.987272
57	Cliente22	OfiMatch	cliente22@ofimatch.cl	123456	910000022	cliente	2026-10-07 17:28:20.987272
58	Cliente23	OfiMatch	cliente23@ofimatch.cl	123456	910000023	cliente	2026-10-07 17:28:20.987272
59	Cliente24	OfiMatch	cliente24@ofimatch.cl	123456	910000024	cliente	2026-10-07 17:28:20.987272
60	Cliente25	OfiMatch	cliente25@ofimatch.cl	123456	910000025	cliente	2026-10-07 17:28:20.987272
61	Trabajador1	OfiMatch	trabajador1@ofimatch.cl	123456	920000001	trabajador	2026-10-07 17:28:20.987272
62	Trabajador2	OfiMatch	trabajador2@ofimatch.cl	123456	920000002	trabajador	2026-10-07 17:28:20.987272
63	Trabajador3	OfiMatch	trabajador3@ofimatch.cl	123456	920000003	trabajador	2026-10-07 17:28:20.987272
64	Trabajador4	OfiMatch	trabajador4@ofimatch.cl	123456	920000004	trabajador	2026-10-07 17:28:20.987272
65	Trabajador5	OfiMatch	trabajador5@ofimatch.cl	123456	920000005	trabajador	2026-10-07 17:28:20.987272
66	Trabajador6	OfiMatch	trabajador6@ofimatch.cl	123456	920000006	trabajador	2026-10-07 17:28:20.987272
67	Trabajador7	OfiMatch	trabajador7@ofimatch.cl	123456	920000007	trabajador	2026-10-07 17:28:20.987272
68	Trabajador8	OfiMatch	trabajador8@ofimatch.cl	123456	920000008	trabajador	2026-10-07 17:28:20.987272
69	Trabajador9	OfiMatch	trabajador9@ofimatch.cl	123456	920000009	trabajador	2026-10-07 17:28:20.987272
70	Trabajador10	OfiMatch	trabajador10@ofimatch.cl	123456	920000010	trabajador	2026-10-07 17:28:20.987272
71	Trabajador11	OfiMatch	trabajador11@ofimatch.cl	123456	920000011	trabajador	2026-10-07 17:28:20.987272
72	Trabajador12	OfiMatch	trabajador12@ofimatch.cl	123456	920000012	trabajador	2026-10-07 17:28:20.987272
73	Trabajador13	OfiMatch	trabajador13@ofimatch.cl	123456	920000013	trabajador	2026-10-07 17:28:20.987272
74	Trabajador14	OfiMatch	trabajador14@ofimatch.cl	123456	920000014	trabajador	2026-10-07 17:28:20.987272
75	Trabajador15	OfiMatch	trabajador15@ofimatch.cl	123456	920000015	trabajador	2026-10-07 17:28:20.987272
76	Trabajador16	OfiMatch	trabajador16@ofimatch.cl	123456	920000016	trabajador	2026-10-07 17:28:20.987272
77	Trabajador17	OfiMatch	trabajador17@ofimatch.cl	123456	920000017	trabajador	2026-10-07 17:28:20.987272
78	Trabajador18	OfiMatch	trabajador18@ofimatch.cl	123456	920000018	trabajador	2026-10-07 17:28:20.987272
79	Trabajador19	OfiMatch	trabajador19@ofimatch.cl	123456	920000019	trabajador	2026-10-07 17:28:20.987272
80	Trabajador20	OfiMatch	trabajador20@ofimatch.cl	123456	920000020	trabajador	2026-10-07 17:28:20.987272
81	Trabajador21	OfiMatch	trabajador21@ofimatch.cl	123456	920000021	trabajador	2026-10-07 17:28:20.987272
82	Trabajador22	OfiMatch	trabajador22@ofimatch.cl	123456	920000022	trabajador	2026-10-07 17:28:20.987272
83	Trabajador23	OfiMatch	trabajador23@ofimatch.cl	123456	920000023	trabajador	2026-10-07 17:28:20.987272
84	Trabajador24	OfiMatch	trabajador24@ofimatch.cl	123456	920000024	trabajador	2026-10-07 17:28:20.987272
85	Trabajador25	OfiMatch	trabajador25@ofimatch.cl	123456	920000025	trabajador	2026-10-07 17:28:20.987272
86	Trabajador26	OfiMatch	trabajador26@ofimatch.cl	123456	920000026	trabajador	2026-10-07 17:28:20.987272
87	Trabajador27	OfiMatch	trabajador27@ofimatch.cl	123456	920000027	trabajador	2026-10-07 17:28:20.987272
88	Trabajador28	OfiMatch	trabajador28@ofimatch.cl	123456	920000028	trabajador	2026-10-07 17:28:20.987272
89	Trabajador29	OfiMatch	trabajador29@ofimatch.cl	123456	920000029	trabajador	2026-10-07 17:28:20.987272
90	Trabajador30	OfiMatch	trabajador30@ofimatch.cl	123456	920000030	trabajador	2026-10-07 17:28:20.987272
91	Trabajador31	OfiMatch	trabajador31@ofimatch.cl	123456	920000031	trabajador	2026-10-07 17:28:20.987272
92	Trabajador32	OfiMatch	trabajador32@ofimatch.cl	123456	920000032	trabajador	2026-10-07 17:28:20.987272
93	Trabajador33	OfiMatch	trabajador33@ofimatch.cl	123456	920000033	trabajador	2026-10-07 17:28:20.987272
94	Trabajador34	OfiMatch	trabajador34@ofimatch.cl	123456	920000034	trabajador	2026-10-07 17:28:20.987272
95	Trabajador35	OfiMatch	trabajador35@ofimatch.cl	123456	920000035	trabajador	2026-10-07 17:28:20.987272
96	Trabajador36	OfiMatch	trabajador36@ofimatch.cl	123456	920000036	trabajador	2026-10-07 17:28:20.987272
97	Trabajador37	OfiMatch	trabajador37@ofimatch.cl	123456	920000037	trabajador	2026-10-07 17:28:20.987272
98	Trabajador38	OfiMatch	trabajador38@ofimatch.cl	123456	920000038	trabajador	2026-10-07 17:28:20.987272
99	Trabajador39	OfiMatch	trabajador39@ofimatch.cl	123456	920000039	trabajador	2026-10-07 17:28:20.987272
100	Trabajador40	OfiMatch	trabajador40@ofimatch.cl	123456	920000040	trabajador	2026-10-07 17:28:20.987272
101	Trabajador41	OfiMatch	trabajador41@ofimatch.cl	123456	920000041	trabajador	2026-10-07 17:28:20.987272
102	Trabajador42	OfiMatch	trabajador42@ofimatch.cl	123456	920000042	trabajador	2026-10-07 17:28:20.987272
103	Trabajador43	OfiMatch	trabajador43@ofimatch.cl	123456	920000043	trabajador	2026-10-07 17:28:20.987272
104	Trabajador44	OfiMatch	trabajador44@ofimatch.cl	123456	920000044	trabajador	2026-10-07 17:28:20.987272
105	Trabajador45	OfiMatch	trabajador45@ofimatch.cl	123456	920000045	trabajador	2026-10-07 17:28:20.987272
106	Trabajador46	OfiMatch	trabajador46@ofimatch.cl	123456	920000046	trabajador	2026-10-07 17:28:20.987272
107	Trabajador47	OfiMatch	trabajador47@ofimatch.cl	123456	920000047	trabajador	2026-10-07 17:28:20.987272
108	Trabajador48	OfiMatch	trabajador48@ofimatch.cl	123456	920000048	trabajador	2026-10-07 17:28:20.987272
109	Trabajador49	OfiMatch	trabajador49@ofimatch.cl	123456	920000049	trabajador	2026-10-07 17:28:20.987272
110	Trabajador50	OfiMatch	trabajador50@ofimatch.cl	123456	920000050	trabajador	2026-10-07 17:28:20.987272
111	Trabajador51	OfiMatch	trabajador51@ofimatch.cl	123456	920000051	trabajador	2026-10-07 17:28:20.987272
112	Trabajador52	OfiMatch	trabajador52@ofimatch.cl	123456	920000052	trabajador	2026-10-07 17:28:20.987272
113	Trabajador53	OfiMatch	trabajador53@ofimatch.cl	123456	920000053	trabajador	2026-10-07 17:28:20.987272
114	Trabajador54	OfiMatch	trabajador54@ofimatch.cl	123456	920000054	trabajador	2026-10-07 17:28:20.987272
115	Administrador	OfiMatch	admin@ofimatch.cl	admin123	900000000	admin	2026-10-07 17:28:20.987272
116	Alexander Nicolas	Solís Castillo	krendoc@gmail.com	perritos11	945056399	trabajador	2026-10-07 17:43:47.300785
\.


--
-- TOC entry 5061 (class 0 OID 0)
-- Dependencies: 223
-- Name: categorias_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categorias_id_seq', 61, true);


--
-- TOC entry 5062 (class 0 OID 0)
-- Dependencies: 221
-- Name: clientes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clientes_id_seq', 1, false);


--
-- TOC entry 5063 (class 0 OID 0)
-- Dependencies: 225
-- Name: trabajadores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.trabajadores_id_seq', 57, true);


--
-- TOC entry 5064 (class 0 OID 0)
-- Dependencies: 219
-- Name: usuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuarios_id_seq', 116, true);


--
-- TOC entry 4887 (class 2606 OID 16471)
-- Name: categorias categorias_nombre_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorias
    ADD CONSTRAINT categorias_nombre_key UNIQUE (nombre);


--
-- TOC entry 4889 (class 2606 OID 16469)
-- Name: categorias categorias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorias
    ADD CONSTRAINT categorias_pkey PRIMARY KEY (id);


--
-- TOC entry 4883 (class 2606 OID 16435)
-- Name: clientes clientes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_pkey PRIMARY KEY (id);


--
-- TOC entry 4885 (class 2606 OID 16437)
-- Name: clientes clientes_usuario_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_usuario_id_key UNIQUE (usuario_id);


--
-- TOC entry 4891 (class 2606 OID 16485)
-- Name: trabajadores trabajadores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trabajadores
    ADD CONSTRAINT trabajadores_pkey PRIMARY KEY (id);


--
-- TOC entry 4893 (class 2606 OID 16487)
-- Name: trabajadores trabajadores_usuario_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trabajadores
    ADD CONSTRAINT trabajadores_usuario_id_key UNIQUE (usuario_id);


--
-- TOC entry 4879 (class 2606 OID 16426)
-- Name: usuarios usuarios_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key UNIQUE (email);


--
-- TOC entry 4881 (class 2606 OID 16424)
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);


--
-- TOC entry 4894 (class 2606 OID 16438)
-- Name: clientes clientes_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id) ON DELETE CASCADE;


--
-- TOC entry 4895 (class 2606 OID 16493)
-- Name: trabajadores trabajadores_categoria_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trabajadores
    ADD CONSTRAINT trabajadores_categoria_id_fkey FOREIGN KEY (categoria_id) REFERENCES public.categorias(id);


--
-- TOC entry 4896 (class 2606 OID 16488)
-- Name: trabajadores trabajadores_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trabajadores
    ADD CONSTRAINT trabajadores_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id) ON DELETE CASCADE;


-- Completed on 2026-10-07 19:07:58

--
-- PostgreSQL database dump complete
--

\unrestrict sR2Hhuawe23sHbpUdn03PjAsp287QyG84o89LAx8ppXXufMQdqsx5g3A6fPju0B

