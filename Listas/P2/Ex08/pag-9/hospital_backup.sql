--
-- PostgreSQL database dump
--

\restrict PzVFzYCMmwQAJvx9hdz2tuyJ8UwKgHCFODFHSaILVIFS5bk2hpGTw3sk3LbmbqQ

-- Dumped from database version 14.19 (Homebrew)
-- Dumped by pg_dump version 14.19 (Homebrew)

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
-- Name: ambulatorio; Type: TABLE; Schema: public; Owner: giuseppesena
--

CREATE TABLE public.ambulatorio (
    numeroa integer NOT NULL,
    andar integer,
    capacidade integer
);


ALTER TABLE public.ambulatorio OWNER TO giuseppesena;

--
-- Name: consulta; Type: TABLE; Schema: public; Owner: giuseppesena
--

CREATE TABLE public.consulta (
    codm integer NOT NULL,
    codp integer NOT NULL,
    data_consulta date NOT NULL,
    hora time without time zone
);


ALTER TABLE public.consulta OWNER TO giuseppesena;

--
-- Name: medico; Type: TABLE; Schema: public; Owner: giuseppesena
--

CREATE TABLE public.medico (
    codm integer NOT NULL,
    nome character varying(100) NOT NULL,
    especialidade character varying(50),
    numeroa integer
);


ALTER TABLE public.medico OWNER TO giuseppesena;

--
-- Name: paciente; Type: TABLE; Schema: public; Owner: giuseppesena
--

CREATE TABLE public.paciente (
    codp integer NOT NULL,
    nome character varying(100) NOT NULL,
    endereco character varying(200),
    telefone character varying(15)
);


ALTER TABLE public.paciente OWNER TO giuseppesena;

--
-- Data for Name: ambulatorio; Type: TABLE DATA; Schema: public; Owner: giuseppesena
--

COPY public.ambulatorio (numeroa, andar, capacidade) FROM stdin;
1	1	10
2	1	8
3	2	12
4	3	6
\.


--
-- Data for Name: consulta; Type: TABLE DATA; Schema: public; Owner: giuseppesena
--

COPY public.consulta (codm, codp, data_consulta, hora) FROM stdin;
1	1	2025-11-05	09:00:00
2	2	2025-11-06	10:30:00
3	1	2025-11-07	15:00:00
\.


--
-- Data for Name: medico; Type: TABLE DATA; Schema: public; Owner: giuseppesena
--

COPY public.medico (codm, nome, especialidade, numeroa) FROM stdin;
1	Dr. João Costa	Cardiologia	3
2	Dra. Ana Paula	Pediatria	3
3	Dr. Marcos Lima	Ortopedia	3
\.


--
-- Data for Name: paciente; Type: TABLE DATA; Schema: public; Owner: giuseppesena
--

COPY public.paciente (codp, nome, endereco, telefone) FROM stdin;
2	Carlos Pereira	Av. Brasil, 456	31988887777
1	Pedro da Silva	Rua das Flores, 123	31999998888
\.


--
-- Name: ambulatorio ambulatorio_pkey; Type: CONSTRAINT; Schema: public; Owner: giuseppesena
--

ALTER TABLE ONLY public.ambulatorio
    ADD CONSTRAINT ambulatorio_pkey PRIMARY KEY (numeroa);


--
-- Name: consulta consulta_pkey; Type: CONSTRAINT; Schema: public; Owner: giuseppesena
--

ALTER TABLE ONLY public.consulta
    ADD CONSTRAINT consulta_pkey PRIMARY KEY (codm, codp, data_consulta);


--
-- Name: medico medico_pkey; Type: CONSTRAINT; Schema: public; Owner: giuseppesena
--

ALTER TABLE ONLY public.medico
    ADD CONSTRAINT medico_pkey PRIMARY KEY (codm);


--
-- Name: paciente paciente_pkey; Type: CONSTRAINT; Schema: public; Owner: giuseppesena
--

ALTER TABLE ONLY public.paciente
    ADD CONSTRAINT paciente_pkey PRIMARY KEY (codp);


--
-- Name: consulta consulta_codm_fkey; Type: FK CONSTRAINT; Schema: public; Owner: giuseppesena
--

ALTER TABLE ONLY public.consulta
    ADD CONSTRAINT consulta_codm_fkey FOREIGN KEY (codm) REFERENCES public.medico(codm);


--
-- Name: consulta consulta_codp_fkey; Type: FK CONSTRAINT; Schema: public; Owner: giuseppesena
--

ALTER TABLE ONLY public.consulta
    ADD CONSTRAINT consulta_codp_fkey FOREIGN KEY (codp) REFERENCES public.paciente(codp);


--
-- Name: medico medico_numeroa_fkey; Type: FK CONSTRAINT; Schema: public; Owner: giuseppesena
--

ALTER TABLE ONLY public.medico
    ADD CONSTRAINT medico_numeroa_fkey FOREIGN KEY (numeroa) REFERENCES public.ambulatorio(numeroa);


--
-- PostgreSQL database dump complete
--

\unrestrict PzVFzYCMmwQAJvx9hdz2tuyJ8UwKgHCFODFHSaILVIFS5bk2hpGTw3sk3LbmbqQ

