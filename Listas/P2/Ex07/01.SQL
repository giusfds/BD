-- 1)
CREATE TABLE Estudantes{
    id INT PRIMARY KEY,
    nome TEXT,
    email TEXT,
    idade INT
};

-- 2)
ALTER TABLE Estudantes
ADD COLUMN endereco TEXT;

-- 3)
ALTER TABLE Estudantes
RENAME TO Alunos;

-- 4)
ALTER TABLE Alunos
DROP COLUMN idade;

-- 5)
CREAte TABLE Professores{
    id INT PRIMARY KEY,
    nome TEXT,
    email TEXT,
    diciplica TEXT
};

-- 6)
ALTER TABLE Professores
ADD COLUMN salario DECIMAL;

-- 7)
DROP TABLE Professores;

-- 8)
CREATE TABLE Autores (
    id INT PRIMARY KEY,
    nome TEXT
);

CREATE TABLE Livros (
    id INT PRIMARY KEY,
    titulo TEXT,
    autor_id INT
);

-- 9)
ALTER TABLE Livros
ADD CONSTRAINT fk_autor
FOREIGN KEY (autor_id)
REFERENCES Autores(id);

-- 10)
CREATE TABLE Clientes (
    id INT PRIMARY KEY,
    nome TEXT
);

CREATE TABLE Pedidos (
    id INT PRIMARY KEY,
    produto TEXT,
    quantidade INT,
    cliente_id INT,
    CONSTRAINT fk_cliente FOREIGN KEY (cliente_id)
        REFERENCES Clientes(id)
);