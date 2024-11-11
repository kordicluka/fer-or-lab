--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4 (Ubuntu 16.4-1.pgdg24.04+2)
-- Dumped by pg_dump version 16.4 (Ubuntu 16.4-0ubuntu0.24.04.2)

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
-- Name: pica; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pica (
    id integer NOT NULL,
    naziv character varying(100) NOT NULL,
    vrsta character varying(50) NOT NULL,
    podvrsta character varying(50),
    proizvodac_id integer,
    godina_proizvodnje integer,
    postotak_alkohola numeric(4,2),
    volumen integer NOT NULL,
    cijena numeric(6,2) NOT NULL
);


ALTER TABLE public.pica OWNER TO postgres;

--
-- Name: pica_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pica_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pica_id_seq OWNER TO postgres;

--
-- Name: pica_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pica_id_seq OWNED BY public.pica.id;


--
-- Name: pica_sastojci; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pica_sastojci (
    pice_id integer NOT NULL,
    sastojak_id integer NOT NULL
);


ALTER TABLE public.pica_sastojci OWNER TO postgres;

--
-- Name: proizvodaci; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.proizvodaci (
    id integer NOT NULL,
    naziv character varying(100) NOT NULL,
    zemlja character varying(100) NOT NULL
);


ALTER TABLE public.proizvodaci OWNER TO postgres;

--
-- Name: proizvodaci_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.proizvodaci_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.proizvodaci_id_seq OWNER TO postgres;

--
-- Name: proizvodaci_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.proizvodaci_id_seq OWNED BY public.proizvodaci.id;


--
-- Name: sastojci; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sastojci (
    id integer NOT NULL,
    naziv character varying(100) NOT NULL
);


ALTER TABLE public.sastojci OWNER TO postgres;

--
-- Name: sastojci_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sastojci_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sastojci_id_seq OWNER TO postgres;

--
-- Name: sastojci_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sastojci_id_seq OWNED BY public.sastojci.id;


--
-- Name: pica id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pica ALTER COLUMN id SET DEFAULT nextval('public.pica_id_seq'::regclass);


--
-- Name: proizvodaci id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proizvodaci ALTER COLUMN id SET DEFAULT nextval('public.proizvodaci_id_seq'::regclass);


--
-- Name: sastojci id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sastojci ALTER COLUMN id SET DEFAULT nextval('public.sastojci_id_seq'::regclass);


--
-- Data for Name: pica; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pica (id, naziv, vrsta, podvrsta, proizvodac_id, godina_proizvodnje, postotak_alkohola, volumen, cijena) FROM stdin;
1	Ožujsko	alkoholno	pivo	1	2024	5.00	500	10.99
2	Pelinkovac	alkoholno	liker	2	2023	28.00	700	89.99
3	Coca-Cola	bezalkoholno	gazirano piće	3	2024	0.00	330	8.99
4	Jamnica	bezalkoholno	mineralna voda	4	2024	0.00	1500	7.99
5	Heineken	alkoholno	pivo	5	2024	5.00	330	12.99
6	Johnnie Walker Black Label	alkoholno	whisky	6	2020	40.00	700	249.99
7	Absolut Vodka	alkoholno	vodka	7	2023	40.00	1000	159.99
8	Maraschino	alkoholno	liker	8	2022	32.00	700	129.99
9	Vindi Sok od jabuke	bezalkoholno	voćni sok	9	2024	0.00	1000	11.99
10	Somersby Apple Cider	alkoholno	cider	10	2024	4.50	330	14.99
\.


--
-- Data for Name: pica_sastojci; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pica_sastojci (pice_id, sastojak_id) FROM stdin;
1	1
1	2
1	3
2	1
2	7
2	10
3	1
3	4
3	5
4	1
4	5
5	1
5	2
5	3
6	1
6	8
6	9
7	1
7	10
8	1
8	6
8	10
9	1
9	6
10	1
10	6
10	10
\.


--
-- Data for Name: proizvodaci; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.proizvodaci (id, naziv, zemlja) FROM stdin;
1	Zagrebačka pivovara	Hrvatska
2	Badel	Hrvatska
3	Coca-Cola	SAD
4	Jamnica	Hrvatska
5	Heineken	Nizozemska
6	Diageo	Ujedinjeno Kraljevstvo
7	Pernod Ricard	Francuska
8	Maraska	Hrvatska
9	Vindija	Hrvatska
10	Carlsberg	Danska
\.


--
-- Data for Name: sastojci; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sastojci (id, naziv) FROM stdin;
1	Voda
2	Hmelj
3	Ječmeni slad
4	Šećer
5	Ugljični dioksid
6	Jabuka
7	Pelin
8	Ječmeni destilat
9	Karamela
10	Alkohol
\.


--
-- Name: pica_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pica_id_seq', 10, true);


--
-- Name: proizvodaci_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.proizvodaci_id_seq', 10, true);


--
-- Name: sastojci_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sastojci_id_seq', 10, true);


--
-- Name: pica pica_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pica
    ADD CONSTRAINT pica_pkey PRIMARY KEY (id);


--
-- Name: pica_sastojci pica_sastojci_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pica_sastojci
    ADD CONSTRAINT pica_sastojci_pkey PRIMARY KEY (pice_id, sastojak_id);


--
-- Name: proizvodaci proizvodaci_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proizvodaci
    ADD CONSTRAINT proizvodaci_pkey PRIMARY KEY (id);


--
-- Name: sastojci sastojci_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sastojci
    ADD CONSTRAINT sastojci_pkey PRIMARY KEY (id);


--
-- Name: pica pica_proizvodac_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pica
    ADD CONSTRAINT pica_proizvodac_id_fkey FOREIGN KEY (proizvodac_id) REFERENCES public.proizvodaci(id);


--
-- Name: pica_sastojci pica_sastojci_pice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pica_sastojci
    ADD CONSTRAINT pica_sastojci_pice_id_fkey FOREIGN KEY (pice_id) REFERENCES public.pica(id);


--
-- Name: pica_sastojci pica_sastojci_sastojak_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pica_sastojci
    ADD CONSTRAINT pica_sastojci_sastojak_id_fkey FOREIGN KEY (sastojak_id) REFERENCES public.sastojci(id);


--
-- PostgreSQL database dump complete
--

