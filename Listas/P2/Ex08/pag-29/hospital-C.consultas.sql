SELECT * FROM Medico WHERE cidade='Belo Horizonte';

SELECT nome, idade FROM Paciente WHERE doença='Gripe';

SELECT * FROM Consulta WHERE CRM=101;

SELECT P.nome AS paciente, M.nome AS medico
FROM Consulta C
JOIN Paciente P ON C.RG = P.RG
JOIN Medico M ON C.CRM = M.CRM;
