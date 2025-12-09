-- Estrutura Final da tabela Alunos (originalmente Estudantes)
-- Ela foi alterada: adicionada 'endereco' e removida 'idade'.
CREATE TABLE Alunos (
    id INT PRIMARY KEY,
    nome TEXT,
    email TEXT,
    endereco TEXT
);

---

-- Estrutura Final da tabela Autores
CREATE TABLE Autores (
    id INT PRIMARY KEY,
    nome TEXT
);

---

-- Estrutura Final da tabela Livros
-- Inclui a chave estrangeira (FOREIGN KEY) adicionada posteriormente.
CREATE TABLE Livros (
    id INT PRIMARY KEY,
    titulo TEXT,
    autor_id INT,
    CONSTRAINT fk_autor
    FOREIGN KEY (autor_id)
    REFERENCES Autores(id)
);

---

-- Estrutura Final da tabela Clientes
CREATE TABLE Clientes (
    id INT PRIMARY KEY,
    nome TEXT
);

---

-- Estrutura Final da tabela Pedidos
-- Inclui a chave estrangeira (FOREIGN KEY) definida na criação.
CREATE TABLE Pedidos (
    id INT PRIMARY KEY,
    produto TEXT,
    quantidade INT,
    cliente_id INT,
    CONSTRAINT fk_cliente FOREIGN KEY (cliente_id)
        REFERENCES Clientes(id)
);