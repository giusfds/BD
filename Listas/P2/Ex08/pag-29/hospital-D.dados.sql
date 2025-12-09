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