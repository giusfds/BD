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