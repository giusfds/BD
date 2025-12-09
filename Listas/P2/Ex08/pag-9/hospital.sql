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