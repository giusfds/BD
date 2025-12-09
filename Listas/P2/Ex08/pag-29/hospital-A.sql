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