## Pag 9

### SQL
-- CRIAÇÃO DO BANCO DE DADOS

-- CREATE DATABASE Hospital;

-- Conecte-se ao banco

-- \c Hospital;

-- CRIAÇÃO DAS TABELAS

CREATE TABLE Ambulatorio (

numeroA INT PRIMARY KEY,

andar INT,

capacidade INT

);

  

CREATE TABLE Medico (

codm INT PRIMARY KEY,

nome VARCHAR(100) NOT NULL,

especialidade VARCHAR(50),

numeroA INT,

FOREIGN KEY (numeroA) REFERENCES Ambulatorio(numeroA)

);

  

CREATE TABLE Paciente (

codp INT PRIMARY KEY,

nome VARCHAR(100) NOT NULL,

endereco VARCHAR(200),

telefone VARCHAR(15)

);

  

CREATE TABLE Consulta (

codm INT,

codp INT,

data_consulta DATE,

hora TIME,

PRIMARY KEY (codm, codp, data_consulta),

FOREIGN KEY (codm) REFERENCES Medico(codm),

FOREIGN KEY (codp) REFERENCES Paciente(codp)

);

  

-- INSERIR AMBULATÓRIOS

INSERT INTO Ambulatorio (numeroA, andar, capacidade) VALUES

(1, 1, 10),

(2, 1, 8),

(3, 2, 12),

(4, 3, 6);

  

-- INSERIR MÉDICOS

INSERT INTO Medico (codm, nome, especialidade, numeroA) VALUES

(1, 'Dr. João Costa', 'Cardiologia', 1),

(2, 'Dra. Ana Paula', 'Pediatria', 2),

(3, 'Dr. Marcos Lima', 'Ortopedia', 4);

  

-- INSERIR PACIENTES

INSERT INTO Paciente (codp, nome, endereco, telefone) VALUES

(1, 'Maria Souza', 'Rua das Flores, 123', '31999998888'),

(2, 'Carlos Pereira', 'Av. Brasil, 456', '31988887777');

  

-- INSERIR CONSULTAS

INSERT INTO Consulta (codm, codp, data_consulta, hora) VALUES

(1, 1, '2025-11-05', '09:00'),

(2, 2, '2025-11-06', '10:30'),

(3, 1, '2025-11-07', '15:00');

  

-- ATUALIZAÇÕES

-- Alterar o número do ambulatório de todos os médicos para 3

UPDATE Medico

SET numeroA = 3;

  

-- Alterar o nome do paciente 1 para "Pedro da Silva"

UPDATE Paciente

SET nome = 'Pedro da Silva'

WHERE codp = 1;

  

-- CONSULTAS DE VERIFICAÇÃO (opcional)

SELECT * FROM Ambulatorio;

SELECT * FROM Medico;

SELECT * FROM Paciente;

SELECT * FROM Consulta;


### dump
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

1 1 10

2 1 8

3 2 12

4 3 6

\.

  
  

--

-- Data for Name: consulta; Type: TABLE DATA; Schema: public; Owner: giuseppesena

--

  

COPY public.consulta (codm, codp, data_consulta, hora) FROM stdin;

1 1 2025-11-05 09:00:00

2 2 2025-11-06 10:30:00

3 1 2025-11-07 15:00:00

\.

  
  

--

-- Data for Name: medico; Type: TABLE DATA; Schema: public; Owner: giuseppesena

--

  

COPY public.medico (codm, nome, especialidade, numeroa) FROM stdin;

1 Dr. João Costa Cardiologia 3

2 Dra. Ana Paula Pediatria 3

3 Dr. Marcos Lima Ortopedia 3

\.

  
  

--

-- Data for Name: paciente; Type: TABLE DATA; Schema: public; Owner: giuseppesena

--

  

COPY public.paciente (codp, nome, endereco, telefone) FROM stdin;

2 Carlos Pereira Av. Brasil, 456 31988887777

1 Pedro da Silva Rua das Flores, 123 31999998888

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

## Pag 29
### A)
-- Criar a base de dados

CREATE DATABASE Hospital;

USE Hospital;

  

-- Tabela Ambulatório

CREATE TABLE Ambulatorio (

numeroA INT PRIMARY KEY,

andar INT NOT NULL,

capacidade INT NOT NULL

);

  

-- Tabela Médico

CREATE TABLE Medico (

CRM INT PRIMARY KEY,

nome VARCHAR(100) NOT NULL,

idade INT NOT NULL,

cidade VARCHAR(50),

especialidade VARCHAR(50),

numeroA INT,

FOREIGN KEY (numeroA) REFERENCES Ambulatorio(numeroA)

);

  

-- Tabela Paciente

CREATE TABLE Paciente (

RG INT PRIMARY KEY,

nome VARCHAR(100) NOT NULL,

idade INT NOT NULL,

cidade VARCHAR(50),

doença VARCHAR(50)

);

  

-- Tabela Consulta

CREATE TABLE Consulta (

CRM INT,

RG INT,

data DATE,

hora TIME,

PRIMARY KEY (CRM, RG, data, hora),

FOREIGN KEY (CRM) REFERENCES Medico(CRM),

FOREIGN KEY (RG) REFERENCES Paciente(RG)

);

  

-- Tabela Funcionário

CREATE TABLE Funcionario (

RG INT PRIMARY KEY,

nome VARCHAR(100) NOT NULL,

idade INT NOT NULL,

cidade VARCHAR(50),

salario DECIMAL(10,2)

);

## B)

 1. Médicos de Belo Horizonte
$$
\sigma_{\text{cidade}='Belo\ Horizonte'}(\text{Medico})
$$

 2. Pacientes com Gripe
$$
\sigma_{\text{doenca}='Gripe'}(\text{Paciente})
$$

 3. Consultas de um médico específico (CRM=101)
$$
\sigma_{\text{CRM}=101}(\text{Consulta})
$$

 4. Nome do paciente e do médico de cada consulta
$$
\pi_{\text{Paciente.nome, Medico.nome, Consulta.data, Consulta.hora}} 
    (\text{Consulta} \bowtie \text{Paciente} \bowtie \text{Medico})
$$

 5. Médicos que não têm consultas agendadas
$$
\text{Medico} - \pi_{\text{Medico.*}} (\text{Medico} \bowtie \text{Consulta})
$$

 6. Pacientes atendidos por um determinado médico (CRM=102)
$$
\pi_{\text{Paciente.nome, Paciente.doenca}} 
    (\sigma_{\text{CRM}=102}(\text{Consulta}) \bowtie \text{Paciente})
$$

 7. Funcionários com salário maior que 3000
$$
\sigma_{\text{salario} > 3000}(\text{Funcionario})
$$

### C)
-- Inserir ambulatórios

INSERT INTO Ambulatorio VALUES (1, 2, 10);

INSERT INTO Ambulatorio VALUES (2, 3, 15);

  

-- Inserir médicos

INSERT INTO Medico VALUES (101, 'Dr. Silva', 45, 'Belo Horizonte', 'Cardiologia', 1);

INSERT INTO Medico VALUES (102, 'Dra. Costa', 38, 'Belo Horizonte', 'Pediatria', 2);

  

-- Inserir pacientes

INSERT INTO Paciente VALUES (201, 'João', 30, 'Belo Horizonte', 'Gripe');

INSERT INTO Paciente VALUES (202, 'Maria', 25, 'Belo Horizonte', 'Asma');

  

-- Inserir consultas

INSERT INTO Consulta VALUES (101, 201, '2025-11-01', '09:00:00');

INSERT INTO Consulta VALUES (102, 202, '2025-11-01', '10:00:00');

  

-- Inserir funcionários

INSERT INTO Funcionario VALUES (301, 'Carlos', 40, 'Belo Horizonte', 3000.00);

INSERT INTO Funcionario VALUES (302, 'Ana', 35, 'Belo Horizonte', 3500.00);
SELECT * FROM Medico WHERE cidade='Belo Horizonte';

  

SELECT nome, idade FROM Paciente WHERE doença='Gripe';

  

SELECT * FROM Consulta WHERE CRM=101;

  

SELECT P.nome AS paciente, M.nome AS medico

FROM Consulta C

JOIN Paciente P ON C.RG = P.RG

JOIN Medico M ON C.CRM = M.CRM;


### D)
-- ========================================

-- 1. Criar e usar a base de dados

-- ========================================

DROP DATABASE IF EXISTS Hospital;

CREATE DATABASE Hospital;

\c Hospital

  

-- ========================================

-- 2. Criação das tabelas

-- ========================================

CREATE TABLE Ambulatorio (

numeroA INT PRIMARY KEY,

andar INT NOT NULL,

capacidade INT NOT NULL

);

  

CREATE TABLE Medico (

CRM INT PRIMARY KEY,

nome VARCHAR(100) NOT NULL,

idade INT NOT NULL,

cidade VARCHAR(50),

especialidade VARCHAR(50),

numeroA INT,

FOREIGN KEY (numeroA) REFERENCES Ambulatorio(numeroA)

);

  

CREATE TABLE Paciente (

RG INT PRIMARY KEY,

nome VARCHAR(100) NOT NULL,

idade INT NOT NULL,

cidade VARCHAR(50),

doenca VARCHAR(50)

);

  

CREATE TABLE Consulta (

CRM INT,

RG INT,

data DATE,

hora TIME,

PRIMARY KEY (CRM, RG, data, hora),

FOREIGN KEY (CRM) REFERENCES Medico(CRM),

FOREIGN KEY (RG) REFERENCES Paciente(RG)

);

  

CREATE TABLE Funcionario (

RG INT PRIMARY KEY,

nome VARCHAR(100) NOT NULL,

idade INT NOT NULL,

cidade VARCHAR(50),

salario DECIMAL(10,2)

);

  

-- ========================================

-- 3. Inserção de dados

-- ========================================

  

-- Ambulatórios

INSERT INTO Ambulatorio VALUES (1, 2, 10);

INSERT INTO Ambulatorio VALUES (2, 3, 15);

INSERT INTO Ambulatorio VALUES (3, 1, 8);

  

-- Médicos

INSERT INTO Medico VALUES (101, 'Dr. Silva', 45, 'Belo Horizonte', 'Cardiologia', 1);

INSERT INTO Medico VALUES (102, 'Dra. Costa', 38, 'Belo Horizonte', 'Pediatria', 2);

INSERT INTO Medico VALUES (103, 'Dr. Souza', 50, 'Contagem', 'Ortopedia', 3);

  

-- Pacientes

INSERT INTO Paciente VALUES (201, 'João', 30, 'Belo Horizonte', 'Gripe');

INSERT INTO Paciente VALUES (202, 'Maria', 25, 'Belo Horizonte', 'Asma');

INSERT INTO Paciente VALUES (203, 'Pedro', 40, 'Contagem', 'Fratura');

  

-- Consultas

INSERT INTO Consulta VALUES (101, 201, '2025-11-01', '09:00:00');

INSERT INTO Consulta VALUES (102, 202, '2025-11-01', '10:00:00');

INSERT INTO Consulta VALUES (103, 203, '2025-11-02', '14:00:00');

  

-- Funcionários

INSERT INTO Funcionario VALUES (301, 'Carlos', 40, 'Belo Horizonte', 3000.00);

INSERT INTO Funcionario VALUES (302, 'Ana', 35, 'Belo Horizonte', 3500.00);

INSERT INTO Funcionario VALUES (303, 'Paulo', 28, 'Contagem', 2800.00);

  

-- ========================================

-- 4. Consultas de exemplo

-- ========================================

  

-- a) Todos os médicos de Belo Horizonte

SELECT * FROM Medico WHERE cidade='Belo Horizonte';

  

-- b) Pacientes com Gripe

SELECT nome, idade FROM Paciente WHERE doenca='Gripe';

  

-- c) Consultas de um médico específico (CRM = 101)

SELECT * FROM Consulta WHERE CRM=101;

  

-- d) Nome do paciente e do médico de cada consulta

SELECT P.nome AS paciente, M.nome AS medico, C.data, C.hora

FROM Consulta C

JOIN Paciente P ON C.RG = P.RG

JOIN Medico M ON C.CRM = M.CRM;

  

-- e) Médicos que não têm consultas agendadas

SELECT * FROM Medico

WHERE CRM NOT IN (SELECT CRM FROM Consulta);

  

-- f) Pacientes atendidos por um determinado médico (CRM=102)

SELECT P.nome, P.doenca

FROM Paciente P

JOIN Consulta C ON P.RG = C.RG

WHERE C.CRM = 102;

  

-- g) Funcionários com salário maior que 3000

SELECT nome, salario FROM Funcionario WHERE salario > 3000;

### 30 e 31)

 Pacientes com dengue
$$
\sigma_{\text{doenca}='Dengue'}(\text{Paciente})
$$

 2) Médicos cardiologistas com mais de 44 anos
$$
\sigma_{\text{especialidade}='Cardiologia' \wedge \text{idade}>44}(\text{Medico})
$$

3) Consultas, exceto CRM 4656 e 1879
$$
\sigma_{\text{CRM} \neq 4656 \wedge \text{CRM} \neq 1879}(\text{Consulta})
$$

4) Ambulatório do quarto andar com capacidade 50 ou número > 10
$$
\sigma_{(\text{andar}=4) \wedge (\text{capacidade}=50 \vee \text{numeroA}>10)}(\text{Ambulatorio})
$$

5) Nome e especialidade de todos os médicos
$$
\pi_{\text{nome, especialidade}}(\text{Medico})
$$

6) Números dos ambulatórios, exceto 2º e 4º andares, capacidade > 50
$$
\pi_{\text{numeroA}}(\sigma_{\text{andar} \neq 2 \wedge \text{andar} \neq 4 \wedge \text{capacidade} > 50}(\text{Ambulatorio}))
$$

7) Nome dos médicos com consultas marcadas e datas
$$
\pi_{\text{Medico.nome, Consulta.data}}(\text{Medico} \bowtie \text{Consulta})
$$

8) Número e capacidade dos ambulatórios do 5º andar e médicos que atendem neles
$$
\pi_{\text{Ambulatorio.numeroA, Ambulatorio.capacidade, Medico.nome}} 
(\sigma_{\text{andar}=5}(\text{Ambulatorio}) \bowtie \text{Medico})
$$

9) Nome dos médicos, pacientes e datas das consultas
$$
\pi_{\text{Medico.nome, Paciente.nome, Consulta.data}} 
(\text{Consulta} \bowtie \text{Medico} \bowtie \text{Paciente})
$$

10) Médicos ortopedistas com consultas de 7h-12h em 20/06/24
$$
\pi_{\text{Medico.nome}} 
(\sigma_{\text{especialidade}='Ortopedia' \wedge \text{data}='2024-06-20' \wedge \text{hora} \ge '07:00' \wedge \text{hora} \le '12:00'} 
(\text{Medico} \bowtie \text{Consulta}))
$$

11) Pacientes com consultas para João Carlos Santos ou Maria Souza com pneumonia
$$
\pi_{\text{Paciente.nome}} 
(\sigma_{\text{Medico.nome}='João Carlos Santos' \vee \text{Medico.nome}='Maria Souza'} 
(\text{Consulta} \bowtie \text{Medico} \bowtie \sigma_{\text{doenca}='Pneumonia'}(\text{Paciente})))
$$

12) Nomes dos médicos e pacientes cadastrados
$$
\pi_{\text{nome}}(\text{Medico}) \cup \pi_{\text{nome}}(\text{Paciente})
$$

13) Nomes e idade dos médicos, pacientes e funcionários de Ribeirão das Neves
$$
\pi_{\text{nome, idade}}(\sigma_{\text{cidade}='Ribeirão das Neves'}(\text{Medico})) \\
\cup \pi_{\text{nome, idade}}(\sigma_{\text{cidade}='Ribeirão das Neves'}(\text{Paciente})) \\
\cup \pi_{\text{nome, idade}}(\sigma_{\text{cidade}='Ribeirão das Neves'}(\text{Funcionario}))
$$

14) Nomes e RGs dos funcionários com salário < 3000 e não pacientes
$$
\pi_{\text{nome, RG}}(\sigma_{\text{salario}<3000}(\text{Funcionario}) - \pi_{\text{RG}}(\text{Paciente}))
$$

15) Números dos ambulatórios sem médicos
$$
\pi_{\text{numeroA}}(\text{Ambulatorio}) - \pi_{\text{numeroA}}(\text{Medico})
$$

16) Nomes e RGs dos funcionários que são pacientes
$$
\pi_{\text{nome, RG}}(\text{Funcionario} \bowtie \text{Paciente})
$$