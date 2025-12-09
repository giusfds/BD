# 📚 RESUMO COMPLETO - PROVA P2 - BANCO DE DADOS

**Data:** Dezembro 2025  
**Conteúdo:** SQL, Normalização, Subconsultas, Funções, Joins, Views, Triggers, Integridade, SQL Injection

---

## 📑 ÍNDICE

1. [SQL - Fundamentos](#1-sql---fundamentos)
2. [Normalização](#2-normalização)
3. [Subconsultas em SQL](#3-subconsultas-em-sql)
4. [Funções em SQL](#4-funções-em-sql)
5. [Junções (JOINS)](#5-junções-joins)
6. [Views (Visões)](#6-views-visões)
7. [Restrições de Integridade](#7-restrições-de-integridade)
8. [Triggers (Gatilhos)](#8-triggers-gatilhos)
9. [SQL Injection](#9-sql-injection)
10. [Cheat Sheet Rápido](#10-cheat-sheet-rápido)

---

## 1. SQL - Fundamentos

### 1.1 O que é SQL?

**SQL (Structured Query Language)** é a linguagem padrão para gerenciar e manipular bancos de dados relacionais.

### 1.2 Comandos Básicos

#### SELECT - Consultar Dados

```sql
-- Sintaxe básica
SELECT coluna1, coluna2 FROM tabela;

-- Selecionar todas as colunas
SELECT * FROM clientes;

-- Com alias (apelido)
SELECT nome AS cliente_nome, idade AS anos FROM clientes;
```

**Por que usar:** Recuperar dados do banco de dados para visualização ou processamento.

#### WHERE - Filtrar Registros

```sql
-- Condição simples
SELECT * FROM produtos WHERE preco > 100;

-- Múltiplas condições
SELECT * FROM clientes
WHERE cidade = 'São Paulo' AND idade >= 18;

-- Usando LIKE para padrões
SELECT * FROM clientes WHERE nome LIKE 'Ana%';
-- % = qualquer sequência de caracteres
-- _ = um único caractere

-- Usando IN
SELECT * FROM produtos WHERE categoria IN ('Eletrônicos', 'Livros');

-- Usando BETWEEN
SELECT * FROM vendas WHERE data BETWEEN '2025-01-01' AND '2025-12-31';

-- Verificar NULL
SELECT * FROM clientes WHERE email IS NULL;
SELECT * FROM clientes WHERE email IS NOT NULL;
```

**Por que usar:** Filtrar apenas os registros que atendem critérios específicos, reduzindo volume de dados retornados.

#### ORDER BY - Ordenar Resultados

```sql
-- Ordem crescente (padrão)
SELECT * FROM produtos ORDER BY preco;
SELECT * FROM produtos ORDER BY preco ASC;

-- Ordem decrescente
SELECT * FROM produtos ORDER BY preco DESC;

-- Múltiplos critérios
SELECT * FROM clientes ORDER BY cidade ASC, nome DESC;
```

**Por que usar:** Organizar dados de forma lógica para análise ou apresentação.

#### DISTINCT - Remover Duplicatas

```sql
SELECT DISTINCT cidade FROM clientes;

-- Com múltiplas colunas
SELECT DISTINCT cidade, estado FROM clientes;
```

**Por que usar:** Obter valores únicos, evitando repetições nos resultados.

#### LIMIT - Limitar Resultados

```sql
-- Primeiros 10 registros
SELECT * FROM produtos LIMIT 10;

-- Com OFFSET (pular registros)
SELECT * FROM produtos LIMIT 10 OFFSET 20;
-- Retorna registros 21 a 30
```

**Por que usar:** Paginação, testes, ou quando precisa apenas de uma amostra dos dados.

### 1.3 Operadores Lógicos

```sql
-- AND: Todas as condições devem ser verdadeiras
SELECT * FROM produtos WHERE preco > 50 AND estoque > 0;

-- OR: Pelo menos uma condição deve ser verdadeira
SELECT * FROM clientes WHERE cidade = 'Rio' OR cidade = 'SP';

-- NOT: Negação
SELECT * FROM produtos WHERE NOT categoria = 'Livros';

-- Combinação com parênteses
SELECT * FROM vendas
WHERE (status = 'pago' OR status = 'pendente')
  AND valor > 100;
```

---

## 2. Normalização

### 2.1 O que é Normalização?

Processo de organizar dados em um banco de dados para:

- ✅ Reduzir redundância
- ✅ Eliminar anomalias de inserção, atualização e exclusão
- ✅ Garantir integridade dos dados
- ✅ Melhorar eficiência

### 2.2 Primeira Forma Normal (1FN)

**Regras:**

1. Cada coluna deve conter valores atômicos (indivisíveis)
2. Cada coluna deve conter valores do mesmo tipo
3. Cada coluna deve ter nome único
4. A ordem dos dados não importa

**❌ Não está em 1FN:**

```
Clientes
+----+--------+---------------------------+
| ID | Nome   | Telefones                 |
+----+--------+---------------------------+
| 1  | João   | 1111-1111, 2222-2222     |
| 2  | Maria  | 3333-3333                 |
+----+--------+---------------------------+
```

**✅ Está em 1FN:**

```
Clientes
+----+--------+
| ID | Nome   |
+----+--------+
| 1  | João   |
| 2  | Maria  |
+----+--------+

ClienteTelefones
+----+------------+-------------+
| ID | ClienteID  | Telefone    |
+----+------------+-------------+
| 1  | 1          | 1111-1111   |
| 2  | 1          | 2222-2222   |
| 3  | 2          | 3333-3333   |
+----+------------+-------------+
```

**Por que usar:** Permite consultas eficientes e evita problemas com valores múltiplos em uma coluna.

### 2.3 Segunda Forma Normal (2FN)

**Regras:**

1. Estar em 1FN
2. Todos os atributos não-chave devem depender da chave primária completa (eliminar dependências parciais)

**❌ Não está em 2FN:**

```
Pedidos
+----------+------------+-------------+--------------+
| PedidoID | ProdutoID  | Quantidade  | NomeProduto  |
+----------+------------+-------------+--------------+
| 1        | 101        | 5           | Notebook     |
| 1        | 102        | 2           | Mouse        |
+----------+------------+-------------+--------------+
```

_Problema:_ NomeProduto depende apenas de ProdutoID, não da chave completa (PedidoID + ProdutoID)

**✅ Está em 2FN:**

```
Pedidos
+----------+------------+-------------+
| PedidoID | ProdutoID  | Quantidade  |
+----------+------------+-------------+
| 1        | 101        | 5           |
| 1        | 102        | 2           |
+----------+------------+-------------+

Produtos
+------------+--------------+
| ProdutoID  | NomeProduto  |
+------------+--------------+
| 101        | Notebook     |
| 102        | Mouse        |
+------------+--------------+
```

**Por que usar:** Evita redundância quando há chaves primárias compostas.

### 2.4 Terceira Forma Normal (3FN)

**Regras:**

1. Estar em 2FN
2. Não deve haver dependências transitivas (atributos não-chave não devem depender de outros atributos não-chave)

**❌ Não está em 3FN:**

```
Funcionarios
+------+--------+---------+---------------+
| ID   | Nome   | Cidade  | Estado        |
+------+--------+---------+---------------+
| 1    | Ana    | SP      | São Paulo     |
| 2    | João   | RJ      | Rio de Janeiro|
+------+--------+---------+---------------+
```

_Problema:_ Estado depende de Cidade, não diretamente de ID

**✅ Está em 3FN:**

```
Funcionarios
+------+--------+------------+
| ID   | Nome   | CidadeID   |
+------+--------+------------+
| 1    | Ana    | 1          |
| 2    | João   | 2          |
+------+--------+------------+

Cidades
+----------+---------+---------------+
| CidadeID | Cidade  | Estado        |
+----------+---------+---------------+
| 1        | SP      | São Paulo     |
| 2        | RJ      | Rio de Janeiro|
+----------+---------+---------------+
```

**Por que usar:** Elimina redundância de dados que podem ser derivados de outros campos.

### 2.5 Forma Normal de Boyce-Codd (FNBC)

**Regras:**

1. Estar em 3FN
2. Para toda dependência funcional X → Y, X deve ser superchave

**Por que usar:** Versão mais rigorosa da 3FN, resolve casos especiais de anomalias.

---

## 3. Subconsultas em SQL

### 3.1 O que são Subconsultas?

Consultas SQL aninhadas dentro de outra consulta (também chamadas de **subqueries** ou **queries aninhadas**).

### 3.2 Tipos de Subconsultas

#### Subconsulta Escalar (Retorna um único valor)

```sql
-- Encontrar produtos com preço acima da média
SELECT nome, preco
FROM produtos
WHERE preco > (SELECT AVG(preco) FROM produtos);

-- Comparar com valor máximo
SELECT nome
FROM funcionarios
WHERE salario = (SELECT MAX(salario) FROM funcionarios);
```

**Por que usar:** Quando precisa de um valor único para comparação.

#### Subconsulta de Lista (Retorna múltiplos valores)

```sql
-- Operador IN
SELECT nome
FROM clientes
WHERE id IN (SELECT cliente_id FROM pedidos WHERE valor > 1000);

-- Operador NOT IN
SELECT nome
FROM produtos
WHERE id NOT IN (SELECT produto_id FROM vendas);
```

**Por que usar:** Filtrar registros baseado em lista de valores de outra tabela.

#### Subconsulta Correlacionada

```sql
-- Encontrar funcionários com salário acima da média do seu departamento
SELECT f.nome, f.salario, f.departamento_id
FROM funcionarios f
WHERE f.salario > (
    SELECT AVG(f2.salario)
    FROM funcionarios f2
    WHERE f2.departamento_id = f.departamento_id
);
```

**Por que usar:** Quando a subconsulta precisa referenciar a tabela externa.

### 3.3 Operadores com Subconsultas

#### EXISTS e NOT EXISTS

```sql
-- EXISTS: Verifica se subconsulta retorna algum registro
SELECT nome
FROM clientes c
WHERE EXISTS (
    SELECT 1 FROM pedidos p
    WHERE p.cliente_id = c.id AND p.valor > 500
);

-- NOT EXISTS: Clientes sem pedidos
SELECT nome
FROM clientes c
WHERE NOT EXISTS (
    SELECT 1 FROM pedidos p WHERE p.cliente_id = c.id
);
```

**Por que usar EXISTS:** Mais eficiente que IN para grandes volumes, para quando só importa se existe ou não.

#### ANY e ALL

```sql
-- ANY (ou SOME): Comparar com qualquer valor
SELECT nome, preco
FROM produtos
WHERE preco > ANY (SELECT preco FROM produtos WHERE categoria = 'Livros');
-- Retorna produtos mais caros que PELO MENOS UM livro

-- ALL: Comparar com todos os valores
SELECT nome, preco
FROM produtos
WHERE preco > ALL (SELECT preco FROM produtos WHERE categoria = 'Livros');
-- Retorna produtos mais caros que TODOS os livros
```

**Por que usar:** Comparações complexas com conjuntos de valores.

### 3.4 Subconsultas no FROM

```sql
-- Subconsulta como tabela temporária
SELECT categoria, media_preco
FROM (
    SELECT categoria, AVG(preco) as media_preco
    FROM produtos
    GROUP BY categoria
) AS subconsulta
WHERE media_preco > 100;
```

**Por que usar:** Criar tabelas derivadas para consultas complexas.

---

## 4. Funções em SQL

### 4.1 Funções de Agregação

#### COUNT - Contar Registros

```sql
-- Contar todos os registros
SELECT COUNT(*) FROM clientes;

-- Contar valores não nulos
SELECT COUNT(email) FROM clientes;

-- Contar distintos
SELECT COUNT(DISTINCT cidade) FROM clientes;
```

**Por que usar:** Obter quantidade de registros, útil para estatísticas.

#### SUM - Somar Valores

```sql
SELECT SUM(valor) AS total_vendas FROM vendas;

-- Com filtro
SELECT SUM(valor) FROM vendas WHERE status = 'pago';
```

**Por que usar:** Calcular totais, receitas, somatórias.

#### AVG - Calcular Média

```sql
SELECT AVG(preco) AS preco_medio FROM produtos;

-- Média por categoria
SELECT categoria, AVG(preco) AS media
FROM produtos
GROUP BY categoria;
```

**Por que usar:** Análise estatística, identificar valores médios.

#### MAX e MIN - Valores Extremos

```sql
SELECT MAX(salario) AS maior_salario FROM funcionarios;
SELECT MIN(preco) AS menor_preco FROM produtos;

-- Com GROUP BY
SELECT departamento, MAX(salario) AS maior_salario
FROM funcionarios
GROUP BY departamento;
```

**Por que usar:** Encontrar limites superiores/inferiores de dados.

### 4.2 GROUP BY e HAVING

#### GROUP BY - Agrupar Dados

```sql
-- Contar clientes por cidade
SELECT cidade, COUNT(*) as total
FROM clientes
GROUP BY cidade;

-- Múltiplas colunas
SELECT cidade, estado, COUNT(*) as total
FROM clientes
GROUP BY cidade, estado;

-- Com funções de agregação
SELECT
    categoria,
    COUNT(*) as quantidade,
    AVG(preco) as preco_medio,
    MAX(preco) as mais_caro
FROM produtos
GROUP BY categoria;
```

**Por que usar:** Análise agregada de dados, relatórios sumarizados.

#### HAVING - Filtrar Grupos

```sql
-- Categorias com mais de 10 produtos
SELECT categoria, COUNT(*) as total
FROM produtos
GROUP BY categoria
HAVING COUNT(*) > 10;

-- Diferença: WHERE filtra linhas, HAVING filtra grupos
SELECT categoria, AVG(preco) as media
FROM produtos
WHERE estoque > 0  -- Filtra produtos antes de agrupar
GROUP BY categoria
HAVING AVG(preco) > 50;  -- Filtra grupos após agregação
```

**Por que usar:** Filtrar resultados agregados (WHERE não funciona com funções de agregação).

### 4.3 Funções de String

```sql
-- CONCAT: Concatenar strings
SELECT CONCAT(nome, ' ', sobrenome) AS nome_completo FROM clientes;

-- UPPER e LOWER: Conversão de caso
SELECT UPPER(nome) FROM clientes;
SELECT LOWER(email) FROM usuarios;

-- SUBSTRING: Extrair parte da string
SELECT SUBSTRING(nome, 1, 3) FROM clientes;  -- Primeiros 3 caracteres

-- LENGTH/LEN: Tamanho da string
SELECT nome, LENGTH(nome) as tamanho FROM clientes;

-- TRIM: Remover espaços
SELECT TRIM(nome) FROM clientes;
SELECT LTRIM(nome), RTRIM(nome) FROM clientes;

-- REPLACE: Substituir texto
SELECT REPLACE(telefone, '-', '') FROM clientes;
```

**Por que usar:** Manipulação e formatação de texto em consultas.

### 4.4 Funções de Data

```sql
-- NOW/CURRENT_TIMESTAMP: Data/hora atual
SELECT NOW();
SELECT CURRENT_TIMESTAMP;

-- DATE: Extrair apenas a data
SELECT DATE(data_hora) FROM pedidos;

-- YEAR, MONTH, DAY: Extrair componentes
SELECT YEAR(data_nascimento) FROM clientes;
SELECT MONTH(data_pedido), COUNT(*)
FROM pedidos
GROUP BY MONTH(data_pedido);

-- DATEDIFF: Diferença entre datas
SELECT DATEDIFF(NOW(), data_nascimento) / 365 AS idade
FROM clientes;

-- DATE_ADD/DATE_SUB: Adicionar/subtrair datas
SELECT DATE_ADD(data_pedido, INTERVAL 7 DAY) AS data_entrega
FROM pedidos;

-- DATE_FORMAT: Formatar data
SELECT DATE_FORMAT(data_pedido, '%d/%m/%Y') FROM pedidos;
```

**Por que usar:** Análises temporais, cálculos de idade, relatórios por período.

### 4.5 Funções Matemáticas

```sql
-- ROUND: Arredondar
SELECT ROUND(preco, 2) FROM produtos;

-- CEIL e FLOOR: Arredondar para cima/baixo
SELECT CEIL(preco), FLOOR(preco) FROM produtos;

-- ABS: Valor absoluto
SELECT ABS(saldo) FROM contas;

-- POWER: Potência
SELECT POWER(2, 3);  -- 2^3 = 8

-- MOD: Resto da divisão
SELECT MOD(10, 3);  -- 10 % 3 = 1
```

**Por que usar:** Cálculos matemáticos em consultas.

### 4.6 Funções Condicionais

#### CASE - Condicional

```sql
-- CASE simples
SELECT
    nome,
    preco,
    CASE
        WHEN preco < 50 THEN 'Barato'
        WHEN preco BETWEEN 50 AND 100 THEN 'Médio'
        ELSE 'Caro'
    END AS categoria_preco
FROM produtos;

-- CASE com múltiplas condições
SELECT
    nome,
    estoque,
    CASE
        WHEN estoque = 0 THEN 'Sem estoque'
        WHEN estoque < 10 THEN 'Estoque baixo'
        WHEN estoque < 50 THEN 'Estoque normal'
        ELSE 'Estoque alto'
    END AS status_estoque
FROM produtos;
```

**Por que usar:** Criar campos calculados condicionais, categorização dinâmica.

#### COALESCE - Primeiro Valor Não Nulo

```sql
SELECT nome, COALESCE(email, telefone, 'Sem contato') AS contato
FROM clientes;
```

**Por que usar:** Tratar valores NULL, fornecer valores padrão.

#### IFNULL/ISNULL - Substituir NULL

```sql
SELECT nome, IFNULL(desconto, 0) AS desconto_final
FROM produtos;
```

**Por que usar:** Simplificar tratamento de NULLs.

---

## 5. Junções (JOINS)

### 5.1 O que são JOINS?

Operações que combinam registros de duas ou mais tabelas baseado em relação entre elas.

### 5.2 INNER JOIN

**Retorna apenas registros com correspondência em ambas as tabelas.**

```sql
-- Sintaxe básica
SELECT c.nome, p.data, p.valor
FROM clientes c
INNER JOIN pedidos p ON c.id = p.cliente_id;

-- Múltiplas junções
SELECT c.nome, p.data, pr.nome_produto, ip.quantidade
FROM clientes c
INNER JOIN pedidos p ON c.id = p.cliente_id
INNER JOIN itens_pedido ip ON p.id = ip.pedido_id
INNER JOIN produtos pr ON ip.produto_id = pr.id;

-- Com filtros
SELECT c.nome, COUNT(p.id) as total_pedidos
FROM clientes c
INNER JOIN pedidos p ON c.id = p.cliente_id
WHERE p.data >= '2025-01-01'
GROUP BY c.id, c.nome
HAVING COUNT(p.id) > 5;
```

**Diagrama:**

```
Tabela A    Tabela B
   (A)  ∩  (B)
    └──────┘
   INNER JOIN
```

**Por que usar:** Quando precisa apenas de dados que existem em ambas as tabelas (intersecção).

### 5.3 LEFT JOIN (LEFT OUTER JOIN)

**Retorna todos os registros da tabela esquerda + correspondências da direita (NULL se não houver).**

```sql
-- Todos os clientes e seus pedidos (incluindo clientes sem pedidos)
SELECT c.nome, p.id AS pedido_id, p.valor
FROM clientes c
LEFT JOIN pedidos p ON c.id = p.cliente_id;

-- Encontrar clientes sem pedidos
SELECT c.nome
FROM clientes c
LEFT JOIN pedidos p ON c.id = p.cliente_id
WHERE p.id IS NULL;

-- Contar pedidos por cliente (incluindo quem tem 0)
SELECT c.nome, COUNT(p.id) as total_pedidos
FROM clientes c
LEFT JOIN pedidos p ON c.id = p.cliente_id
GROUP BY c.id, c.nome;
```

**Diagrama:**

```
Tabela A    Tabela B
   (A)  ∩  (B)
   └────────────
    LEFT JOIN
```

**Por que usar:** Quando precisa de todos os registros da tabela principal, mesmo sem correspondência.

### 5.4 RIGHT JOIN (RIGHT OUTER JOIN)

**Retorna todos os registros da tabela direita + correspondências da esquerda.**

```sql
-- Todos os pedidos e clientes (incluindo pedidos órfãos)
SELECT c.nome, p.id AS pedido_id, p.valor
FROM clientes c
RIGHT JOIN pedidos p ON c.id = p.cliente_id;
```

**Diagrama:**

```
Tabela A    Tabela B
   (A)  ∩  (B)
        ────────┘
    RIGHT JOIN
```

**Por que usar:** Menos comum que LEFT JOIN, usado quando a tabela direita é a principal.

### 5.5 FULL OUTER JOIN

**Retorna todos os registros de ambas as tabelas (com NULLs onde não há correspondência).**

```sql
-- MySQL não suporta FULL OUTER JOIN diretamente, usar UNION
SELECT c.nome, p.id AS pedido_id
FROM clientes c
LEFT JOIN pedidos p ON c.id = p.cliente_id
UNION
SELECT c.nome, p.id AS pedido_id
FROM clientes c
RIGHT JOIN pedidos p ON c.id = p.cliente_id;
```

**Diagrama:**

```
Tabela A    Tabela B
   (A)  ∪  (B)
   └──────────┘
  FULL OUTER JOIN
```

**Por que usar:** Quando precisa de todos os dados de ambas as tabelas.

### 5.6 CROSS JOIN

**Produto cartesiano: todas as combinações possíveis.**

```sql
-- Todas as combinações de cores e tamanhos
SELECT c.nome AS cor, t.nome AS tamanho
FROM cores c
CROSS JOIN tamanhos t;

-- Equivalente a:
SELECT c.nome AS cor, t.nome AS tamanho
FROM cores c, tamanhos t;
```

**Por que usar:** Gerar combinações, tabelas auxiliares, análises de todas as possibilidades.

### 5.7 SELF JOIN

**Junção de uma tabela com ela mesma.**

```sql
-- Encontrar pares de funcionários no mesmo departamento
SELECT f1.nome AS funcionario1, f2.nome AS funcionario2, f1.departamento
FROM funcionarios f1
INNER JOIN funcionarios f2 ON f1.departamento = f2.departamento
WHERE f1.id < f2.id;  -- Evita duplicatas

-- Hierarquia (funcionário e seu gerente)
SELECT f.nome AS funcionario, g.nome AS gerente
FROM funcionarios f
LEFT JOIN funcionarios g ON f.gerente_id = g.id;
```

**Por que usar:** Relações hierárquicas, comparações dentro da mesma tabela.

---

## 6. Views (Visões)

### 6.1 O que são Views?

**Tabelas virtuais** baseadas em consultas SQL. Não armazenam dados fisicamente, apenas a definição da consulta.

### 6.2 Criar Views

```sql
-- Sintaxe básica
CREATE VIEW nome_view AS
SELECT coluna1, coluna2
FROM tabela
WHERE condição;

-- Exemplo: View de clientes ativos
CREATE VIEW clientes_ativos AS
SELECT id, nome, email, cidade
FROM clientes
WHERE ativo = 1;

-- View com JOIN
CREATE VIEW vendas_detalhadas AS
SELECT
    v.id AS venda_id,
    v.data,
    c.nome AS cliente,
    p.nome AS produto,
    v.quantidade,
    v.valor_unitario,
    (v.quantidade * v.valor_unitario) AS valor_total
FROM vendas v
INNER JOIN clientes c ON v.cliente_id = c.id
INNER JOIN produtos p ON v.produto_id = p.id;

-- View com agregação
CREATE VIEW resumo_vendas_mes AS
SELECT
    YEAR(data) AS ano,
    MONTH(data) AS mes,
    COUNT(*) AS total_vendas,
    SUM(valor) AS receita_total
FROM vendas
GROUP BY YEAR(data), MONTH(data);
```

### 6.3 Usar Views

```sql
-- Usar como tabela normal
SELECT * FROM clientes_ativos;

-- Filtrar view
SELECT * FROM clientes_ativos WHERE cidade = 'São Paulo';

-- JOIN com view
SELECT ca.nome, COUNT(p.id) as total_pedidos
FROM clientes_ativos ca
LEFT JOIN pedidos p ON ca.id = p.cliente_id
GROUP BY ca.id, ca.nome;
```

### 6.4 Alterar Views

```sql
-- Substituir view existente
CREATE OR REPLACE VIEW clientes_ativos AS
SELECT id, nome, email, cidade, telefone
FROM clientes
WHERE ativo = 1 AND email IS NOT NULL;

-- Alterar view (MySQL)
ALTER VIEW clientes_ativos AS
SELECT id, nome, email
FROM clientes
WHERE ativo = 1;
```

### 6.5 Excluir Views

```sql
DROP VIEW clientes_ativos;

-- Não dar erro se não existir
DROP VIEW IF EXISTS clientes_ativos;
```

### 6.6 Vantagens das Views

✅ **Simplificação:** Encapsula consultas complexas

```sql
-- Sem view
SELECT c.nome, SUM(p.valor)
FROM clientes c
JOIN pedidos p ON c.id = p.cliente_id
WHERE p.status = 'pago'
GROUP BY c.id;

-- Com view
CREATE VIEW vendas_pagas AS ...;
SELECT * FROM vendas_pagas;
```

✅ **Segurança:** Restringe acesso a colunas sensíveis

```sql
CREATE VIEW clientes_publico AS
SELECT id, nome, cidade  -- Sem CPF, email, etc.
FROM clientes;

GRANT SELECT ON clientes_publico TO usuario_externo;
```

✅ **Reutilização:** Uma consulta, múltiplos usos
✅ **Abstração:** Oculta complexidade da estrutura de dados
✅ **Independência lógica:** Mudanças na tabela não afetam aplicações que usam view

### 6.7 Limitações

❌ **Performance:** Views complexas podem ser lentas (cada consulta reexecuta)
❌ **Atualizações:** Nem todas as views são atualizáveis (especialmente com JOIN, GROUP BY)
❌ **Dependências:** Mudanças em tabelas base podem quebrar views

**Por que usar:** Simplificar consultas repetitivas, segurança, manutenibilidade.

---

## 7. Restrições de Integridade

### 7.1 O que são Constraints?

Regras que garantem precisão e confiabilidade dos dados no banco.

### 7.2 PRIMARY KEY (Chave Primária)

**Identifica unicamente cada registro.**

```sql
-- Ao criar tabela
CREATE TABLE clientes (
    id INT PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100)
);

-- Com AUTO_INCREMENT
CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100)
);

-- Chave primária composta
CREATE TABLE itens_pedido (
    pedido_id INT,
    produto_id INT,
    quantidade INT,
    PRIMARY KEY (pedido_id, produto_id)
);

-- Adicionar depois
ALTER TABLE clientes ADD PRIMARY KEY (id);
```

**Regras:**

- ✅ Valores únicos
- ✅ Não pode ser NULL
- ✅ Uma por tabela
- ✅ Automaticamente cria índice

**Por que usar:** Identificar unicamente registros, base para relacionamentos.

### 7.3 FOREIGN KEY (Chave Estrangeira)

**Estabelece e garante vínculo entre tabelas.**

```sql
-- Ao criar tabela
CREATE TABLE pedidos (
    id INT PRIMARY KEY,
    cliente_id INT,
    data DATE,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

-- Com ações em cascata
CREATE TABLE pedidos (
    id INT PRIMARY KEY,
    cliente_id INT,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
        ON DELETE CASCADE      -- Deletar pedidos se cliente deletado
        ON UPDATE CASCADE      -- Atualizar se ID do cliente mudar
);

-- Outras opções
CREATE TABLE pedidos (
    id INT PRIMARY KEY,
    cliente_id INT,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
        ON DELETE SET NULL     -- Setar NULL se cliente deletado
        ON DELETE RESTRICT     -- Impedir deletar cliente com pedidos
);

-- Adicionar depois
ALTER TABLE pedidos
ADD CONSTRAINT fk_cliente
FOREIGN KEY (cliente_id) REFERENCES clientes(id);
```

**Por que usar:** Manter integridade referencial, evitar dados órfãos.

### 7.4 UNIQUE (Único)

**Garante valores únicos na coluna (permite NULL).**

```sql
-- Ao criar tabela
CREATE TABLE usuarios (
    id INT PRIMARY KEY,
    email VARCHAR(100) UNIQUE,
    cpf VARCHAR(11) UNIQUE
);

-- Múltiplas colunas (combinação única)
CREATE TABLE produtos (
    id INT PRIMARY KEY,
    nome VARCHAR(100),
    categoria VARCHAR(50),
    UNIQUE (nome, categoria)
);

-- Adicionar depois
ALTER TABLE usuarios ADD UNIQUE (email);
ALTER TABLE usuarios ADD CONSTRAINT uk_cpf UNIQUE (cpf);
```

**Por que usar:** Garantir unicidade sem ser chave primária (ex: email, CPF).

### 7.5 NOT NULL (Não Nulo)

**Campo obrigatório.**

```sql
-- Ao criar tabela
CREATE TABLE clientes (
    id INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    telefone VARCHAR(20)  -- Pode ser NULL
);

-- Adicionar depois
ALTER TABLE clientes MODIFY email VARCHAR(100) NOT NULL;
```

**Por que usar:** Garantir que campos críticos sempre tenham valores.

### 7.6 CHECK (Verificação)

**Define condição que valores devem satisfazer.**

```sql
-- Ao criar tabela
CREATE TABLE produtos (
    id INT PRIMARY KEY,
    nome VARCHAR(100),
    preco DECIMAL(10,2) CHECK (preco > 0),
    estoque INT CHECK (estoque >= 0)
);

-- Verificação mais complexa
CREATE TABLE funcionarios (
    id INT PRIMARY KEY,
    nome VARCHAR(100),
    idade INT CHECK (idade >= 18 AND idade <= 65),
    salario DECIMAL(10,2) CHECK (salario > 0)
);

-- Múltiplas colunas
CREATE TABLE reservas (
    id INT PRIMARY KEY,
    data_inicio DATE,
    data_fim DATE,
    CHECK (data_fim > data_inicio)
);

-- Adicionar depois
ALTER TABLE produtos
ADD CONSTRAINT chk_preco CHECK (preco > 0);
```

**Por que usar:** Validar dados no nível do banco, garantir regras de negócio.

### 7.7 DEFAULT (Valor Padrão)

**Define valor padrão se não especificado.**

```sql
CREATE TABLE pedidos (
    id INT PRIMARY KEY,
    data DATE DEFAULT CURRENT_DATE,
    status VARCHAR(20) DEFAULT 'pendente',
    ativo BOOLEAN DEFAULT TRUE,
    quantidade INT DEFAULT 1
);

-- Usar valor padrão
INSERT INTO pedidos (id) VALUES (1);  -- data e status usam DEFAULT
```

**Por que usar:** Simplificar inserções, garantir valores iniciais consistentes.

### 7.8 Remover Constraints

```sql
-- Remover FOREIGN KEY
ALTER TABLE pedidos DROP FOREIGN KEY fk_cliente;

-- Remover PRIMARY KEY
ALTER TABLE clientes DROP PRIMARY KEY;

-- Remover UNIQUE
ALTER TABLE usuarios DROP INDEX email;

-- Remover CHECK
ALTER TABLE produtos DROP CHECK chk_preco;
```

---

## 8. Triggers (Gatilhos)

### 8.1 O que são Triggers?

**Procedimentos armazenados** executados automaticamente em resposta a eventos (INSERT, UPDATE, DELETE).

### 8.2 Sintaxe Básica

```sql
CREATE TRIGGER nome_trigger
{BEFORE | AFTER} {INSERT | UPDATE | DELETE}
ON tabela
FOR EACH ROW
BEGIN
    -- Comandos SQL
END;
```

### 8.3 BEFORE INSERT

```sql
-- Validar dados antes de inserir
DELIMITER //
CREATE TRIGGER validar_preco_before_insert
BEFORE INSERT ON produtos
FOR EACH ROW
BEGIN
    IF NEW.preco < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Preço não pode ser negativo';
    END IF;
END//
DELIMITER ;

-- Converter para maiúsculas
DELIMITER //
CREATE TRIGGER uppercase_nome
BEFORE INSERT ON clientes
FOR EACH ROW
BEGIN
    SET NEW.nome = UPPER(NEW.nome);
END//
DELIMITER ;

-- Gerar valor automático
DELIMITER //
CREATE TRIGGER gerar_codigo
BEFORE INSERT ON produtos
FOR EACH ROW
BEGIN
    IF NEW.codigo IS NULL THEN
        SET NEW.codigo = CONCAT('PROD-', NEW.id);
    END IF;
END//
DELIMITER ;
```

**Por que usar:** Validação, transformação de dados antes de salvar.

### 8.4 AFTER INSERT

```sql
-- Auditoria: registrar inserções
DELIMITER //
CREATE TRIGGER auditoria_cliente_insert
AFTER INSERT ON clientes
FOR EACH ROW
BEGIN
    INSERT INTO log_auditoria (tabela, acao, registro_id, data_hora)
    VALUES ('clientes', 'INSERT', NEW.id, NOW());
END//
DELIMITER ;

-- Atualizar estoque após venda
DELIMITER //
CREATE TRIGGER atualizar_estoque_venda
AFTER INSERT ON itens_pedido
FOR EACH ROW
BEGIN
    UPDATE produtos
    SET estoque = estoque - NEW.quantidade
    WHERE id = NEW.produto_id;
END//
DELIMITER ;

-- Enviar notificação (inserir em fila)
DELIMITER //
CREATE TRIGGER notificar_novo_cliente
AFTER INSERT ON clientes
FOR EACH ROW
BEGIN
    INSERT INTO fila_emails (destinatario, assunto, mensagem)
    VALUES (NEW.email, 'Bem-vindo', CONCAT('Olá ', NEW.nome));
END//
DELIMITER ;
```

**Por que usar:** Auditoria, propagação de mudanças, notificações.

### 8.5 BEFORE UPDATE

```sql
-- Manter histórico do valor antigo
DELIMITER //
CREATE TRIGGER historico_preco
BEFORE UPDATE ON produtos
FOR EACH ROW
BEGIN
    IF NEW.preco != OLD.preco THEN
        INSERT INTO historico_precos (produto_id, preco_antigo, preco_novo, data)
        VALUES (OLD.id, OLD.preco, NEW.preco, NOW());
    END IF;
END//
DELIMITER ;

-- Validar mudança
DELIMITER //
CREATE TRIGGER validar_desconto
BEFORE UPDATE ON produtos
FOR EACH ROW
BEGIN
    IF NEW.preco > OLD.preco * 1.5 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Aumento de preço muito alto';
    END IF;
END//
DELIMITER ;

-- Atualizar timestamp automático
DELIMITER //
CREATE TRIGGER atualizar_modificado
BEFORE UPDATE ON clientes
FOR EACH ROW
BEGIN
    SET NEW.data_modificacao = NOW();
END//
DELIMITER ;
```

**Por que usar:** Histórico, validação de mudanças, timestamps automáticos.

### 8.6 AFTER UPDATE

```sql
-- Sincronizar tabelas
DELIMITER //
CREATE TRIGGER sincronizar_estoque
AFTER UPDATE ON produtos
FOR EACH ROW
BEGIN
    IF NEW.estoque != OLD.estoque THEN
        INSERT INTO movimento_estoque (produto_id, quantidade_anterior, quantidade_nova, data)
        VALUES (NEW.id, OLD.estoque, NEW.estoque, NOW());
    END IF;
END//
DELIMITER ;
```

### 8.7 BEFORE DELETE

```sql
-- Impedir exclusão de registros importantes
DELIMITER //
CREATE TRIGGER proteger_admin
BEFORE DELETE ON usuarios
FOR EACH ROW
BEGIN
    IF OLD.tipo = 'admin' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Não é permitido deletar administradores';
    END IF;
END//
DELIMITER ;
```

**Por que usar:** Proteger dados críticos, validar exclusões.

### 8.8 AFTER DELETE

```sql
-- Arquivar dados deletados
DELIMITER //
CREATE TRIGGER arquivar_cliente_deletado
AFTER DELETE ON clientes
FOR EACH ROW
BEGIN
    INSERT INTO clientes_arquivados (id, nome, email, data_exclusao)
    VALUES (OLD.id, OLD.nome, OLD.email, NOW());
END//
DELIMITER ;

-- Limpar dados relacionados
DELIMITER //
CREATE TRIGGER limpar_relacionados
AFTER DELETE ON categorias
FOR EACH ROW
BEGIN
    DELETE FROM produtos WHERE categoria_id = OLD.id;
END//
DELIMITER ;
```

**Por que usar:** Arquivamento, limpeza em cascata.

### 8.9 Variáveis Especiais

- **`NEW`**: Novos valores (disponível em INSERT e UPDATE)
- **`OLD`**: Valores antigos (disponível em UPDATE e DELETE)

```sql
-- Exemplo comparando OLD e NEW
DELIMITER //
CREATE TRIGGER log_mudancas_salario
AFTER UPDATE ON funcionarios
FOR EACH ROW
BEGIN
    IF NEW.salario != OLD.salario THEN
        INSERT INTO log_salarios (funcionario_id, salario_antigo, salario_novo, percentual_aumento)
        VALUES (
            NEW.id,
            OLD.salario,
            NEW.salario,
            ((NEW.salario - OLD.salario) / OLD.salario * 100)
        );
    END IF;
END//
DELIMITER ;
```

### 8.10 Gerenciar Triggers

```sql
-- Listar triggers
SHOW TRIGGERS;
SHOW TRIGGERS FROM database_name;
SHOW TRIGGERS LIKE 'clientes%';

-- Ver definição
SHOW CREATE TRIGGER nome_trigger;

-- Excluir trigger
DROP TRIGGER nome_trigger;
DROP TRIGGER IF EXISTS nome_trigger;
```

### 8.11 Cuidados com Triggers

⚠️ **Performance:** Triggers executam a cada operação, podem impactar performance
⚠️ **Debugging:** Difícil debugar, erros não são óbvios
⚠️ **Cascata:** Trigger pode disparar outros triggers (complexidade)
⚠️ **Transações:** Trigger faz parte da transação, erro no trigger desfaz operação
⚠️ **Manutenção:** Lógica "escondida", dificulta manutenção

**Por que usar:** Automatizar regras de negócio, auditoria, validações, manter integridade de dados.

---

## 9. SQL Injection

### 9.1 O que é SQL Injection?

**Técnica de ataque** que injeta código SQL malicioso em campos de entrada, explorando vulnerabilidades em aplicações que concatenam strings SQL.

### 9.2 Como Funciona?

#### Exemplo Vulnerável

```python
# CÓDIGO INSEGURO - NÃO USAR!
usuario = input("Usuário: ")
senha = input("Senha: ")

query = f"SELECT * FROM usuarios WHERE usuario = '{usuario}' AND senha = '{senha}'"
cursor.execute(query)
```

#### Ataque 1: Bypass de Autenticação

```
Usuário: admin' OR '1'='1
Senha: qualquer

Query resultante:
SELECT * FROM usuarios WHERE usuario = 'admin' OR '1'='1' AND senha = 'qualquer'

Resultado: '1'='1' é sempre verdadeiro → Login bem-sucedido!
```

#### Ataque 2: Comentários SQL

```
Usuário: admin'--
Senha: (vazio)

Query resultante:
SELECT * FROM usuarios WHERE usuario = 'admin'--' AND senha = ''

Resultado: Comentário -- ignora resto da query → Login como admin!
```

#### Ataque 3: UNION Attack

```
ID: 1' UNION SELECT usuario, senha FROM usuarios--

Query resultante:
SELECT nome, email FROM produtos WHERE id = '1' UNION SELECT usuario, senha FROM usuarios--'

Resultado: Expõe dados de outra tabela!
```

#### Ataque 4: Deletar Dados

```
ID: 1'; DROP TABLE usuarios; --

Query resultante:
SELECT * FROM produtos WHERE id = '1'; DROP TABLE usuarios; --'

Resultado: Tabela deletada!
```

### 9.3 Prevenção - Métodos Eficazes

#### ✅ 1. Prepared Statements (MAIS IMPORTANTE!)

**PHP (PDO):**

```php
// SEGURO
$stmt = $pdo->prepare("SELECT * FROM usuarios WHERE usuario = ? AND senha = ?");
$stmt->execute([$usuario, $senha]);
```

**Python:**

```python
# SEGURO
cursor.execute("SELECT * FROM usuarios WHERE usuario = %s AND senha = %s", (usuario, senha))
```

**Java:**

```java
// SEGURO
PreparedStatement stmt = conn.prepareStatement("SELECT * FROM usuarios WHERE usuario = ? AND senha = ?");
stmt.setString(1, usuario);
stmt.setString(2, senha);
ResultSet rs = stmt.executeQuery();
```

**Node.js:**

```javascript
// SEGURO
connection.query(
    'SELECT * FROM usuarios WHERE usuario = ? AND senha = ?',
    [usuario, senha],
    function(error, results) { ... }
);
```

**Por que funciona:** Parâmetros são tratados como dados, não como código SQL.

#### ✅ 2. ORM (Object-Relational Mapping)

```python
# Django ORM - SEGURO
usuarios = Usuario.objects.filter(usuario=usuario, senha=senha)

# SQLAlchemy - SEGURO
usuarios = session.query(Usuario).filter(Usuario.usuario == usuario, Usuario.senha == senha).all()
```

**Por que funciona:** ORM abstrai SQL e usa prepared statements internamente.

#### ✅ 3. Validação de Entrada

```python
import re

# Whitelist: permitir apenas caracteres válidos
if not re.match("^[a-zA-Z0-9_]+$", usuario):
    raise ValueError("Usuário inválido")

# Validar tipo
if not isinstance(id, int):
    raise ValueError("ID deve ser numérico")

# Limitar tamanho
if len(senha) > 100:
    raise ValueError("Senha muito longa")
```

**Por que usar:** Defesa em profundidade, bloqueia entradas obviamente maliciosas.

#### ✅ 4. Escapar Caracteres Especiais (ÚLTIMA OPÇÃO)

```python
# Python
import pymysql
usuario_escaped = pymysql.escape_string(usuario)

# PHP
$usuario_escaped = mysqli_real_escape_string($conn, $usuario);
```

**⚠️ ATENÇÃO:** Escapar não é 100% seguro. **Use prepared statements!**

#### ✅ 5. Princípio do Menor Privilégio

```sql
-- Criar usuário com privilégios limitados
CREATE USER 'app_user'@'localhost' IDENTIFIED BY 'senha';

-- Dar apenas SELECT, INSERT, UPDATE (sem DELETE, DROP)
GRANT SELECT, INSERT, UPDATE ON database_app.* TO 'app_user'@'localhost';

-- Não usar conta root na aplicação!
```

**Por que usar:** Limita danos se injection ocorrer.

#### ✅ 6. Web Application Firewall (WAF)

Ferramentas como ModSecurity detectam e bloqueiam padrões de SQL injection.

#### ✅ 7. Tratamento de Erros

```python
# NÃO expor erros SQL ao usuário
try:
    cursor.execute(query)
except Exception as e:
    # Log interno
    logger.error(f"Erro SQL: {e}")
    # Mensagem genérica ao usuário
    return "Erro ao processar requisição"
```

**Por que:** Mensagens de erro revelam estrutura do banco de dados.

### 9.4 Exemplos de Código Seguro vs Inseguro

#### ❌ INSEGURO - Concatenação de Strings

```python
# NÃO FAZER!
query = "SELECT * FROM produtos WHERE categoria = '" + categoria + "'"
cursor.execute(query)
```

#### ✅ SEGURO - Prepared Statement

```python
# CORRETO
query = "SELECT * FROM produtos WHERE categoria = %s"
cursor.execute(query, (categoria,))
```

#### ❌ INSEGURO - String Formatting

```python
# NÃO FAZER!
query = f"DELETE FROM posts WHERE id = {post_id}"
cursor.execute(query)
```

#### ✅ SEGURO - Parametrizado

```python
# CORRETO
query = "DELETE FROM posts WHERE id = %s"
cursor.execute(query, (post_id,))
```

### 9.5 Testes para Verificar Vulnerabilidade

```
# Testar campos de entrada com:
' OR '1'='1
' OR '1'='1'--
' OR '1'='1'/*
admin'--
' UNION SELECT NULL--
'; DROP TABLE usuarios--
```

Se algum desses causar erro SQL ou comportamento inesperado, há vulnerabilidade.

### 9.6 Checklist de Segurança

- [ ] Usar prepared statements em TODAS as consultas
- [ ] Nunca concatenar entrada do usuário em SQL
- [ ] Validar e sanitizar toda entrada
- [ ] Usar usuário de banco com privilégios mínimos
- [ ] Não expor mensagens de erro SQL
- [ ] Usar ORM quando possível
- [ ] Implementar WAF
- [ ] Fazer testes de segurança regulares
- [ ] Manter bibliotecas atualizadas
- [ ] Hash de senhas (bcrypt, não MD5!)

**Por que é crítico:** SQL injection é uma das vulnerabilidades mais perigosas. Pode expor, modificar ou deletar todos os dados do sistema.

---

## 10. Cheat Sheet Rápido

### Comandos Essenciais

```sql
-- SELECIONAR
SELECT * FROM tabela;
SELECT col1, col2 FROM tabela WHERE condicao;

-- INSERIR
INSERT INTO tabela (col1, col2) VALUES (val1, val2);

-- ATUALIZAR
UPDATE tabela SET col1 = val1 WHERE condicao;

-- DELETAR
DELETE FROM tabela WHERE condicao;

-- ORDENAR
SELECT * FROM tabela ORDER BY coluna DESC;

-- LIMITAR
SELECT * FROM tabela LIMIT 10;

-- AGRUPAR
SELECT categoria, COUNT(*) FROM produtos GROUP BY categoria;

-- FILTRAR GRUPOS
SELECT categoria, AVG(preco) FROM produtos
GROUP BY categoria HAVING AVG(preco) > 50;
```

### Joins Rápidos

```sql
-- INNER JOIN
SELECT * FROM A JOIN B ON A.id = B.id;

-- LEFT JOIN
SELECT * FROM A LEFT JOIN B ON A.id = B.id;

-- Encontrar registros sem correspondência
SELECT * FROM A LEFT JOIN B ON A.id = B.id WHERE B.id IS NULL;
```

### Subconsultas

```sql
-- IN
SELECT * FROM A WHERE id IN (SELECT id FROM B);

-- EXISTS
SELECT * FROM A WHERE EXISTS (SELECT 1 FROM B WHERE B.id = A.id);

-- Comparação
SELECT * FROM produtos WHERE preco > (SELECT AVG(preco) FROM produtos);
```

### Funções Importantes

```sql
-- Agregação
COUNT(*), SUM(col), AVG(col), MAX(col), MIN(col)

-- String
CONCAT(s1, s2), UPPER(s), LOWER(s), SUBSTRING(s, pos, len)

-- Data
NOW(), YEAR(data), MONTH(data), DATEDIFF(d1, d2)

-- Condicional
CASE WHEN condicao THEN valor ELSE outro END
COALESCE(col, 'default')
```

### Constraints

```sql
-- PRIMARY KEY
id INT PRIMARY KEY AUTO_INCREMENT

-- FOREIGN KEY
FOREIGN KEY (cliente_id) REFERENCES clientes(id)

-- UNIQUE
email VARCHAR(100) UNIQUE

-- NOT NULL
nome VARCHAR(100) NOT NULL

-- CHECK
preco DECIMAL(10,2) CHECK (preco > 0)

-- DEFAULT
status VARCHAR(20) DEFAULT 'ativo'
```

### Trigger Básico

```sql
DELIMITER //
CREATE TRIGGER nome
AFTER INSERT ON tabela
FOR EACH ROW
BEGIN
    -- codigo
END//
DELIMITER ;
```

### View Básica

```sql
CREATE VIEW nome_view AS
SELECT coluna1, coluna2 FROM tabela WHERE condicao;

SELECT * FROM nome_view;
```

### Prevenção SQL Injection

```python
# ✅ SEMPRE USAR
cursor.execute("SELECT * FROM users WHERE id = %s", (user_id,))

# ❌ NUNCA FAZER
cursor.execute(f"SELECT * FROM users WHERE id = {user_id}")
```

---

## 🎯 Dicas Finais para a Prova

1. **Pratique JOIN** - É o mais cobrado e confuso
2. **Entenda GROUP BY vs WHERE vs HAVING**
3. **Saiba quando usar EXISTS vs IN**
4. **Decore sintaxe de CREATE TRIGGER e VIEW**
5. **Entenda normalização até 3FN**
6. **Saiba prevenir SQL Injection**
7. **Pratique subconsultas aninhadas**
8. **Entenda diferença entre PRIMARY KEY e UNIQUE**
9. **Saiba o que cada constraint faz**
10. **Revise funções de agregação com GROUP BY**

---

## 📖 Exemplos Práticos Completos

### Exemplo 1: Sistema de Vendas

```sql
-- Estrutura
CREATE TABLE clientes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    cidade VARCHAR(50)
);

CREATE TABLE produtos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) CHECK (preco > 0),
    estoque INT DEFAULT 0
);

CREATE TABLE pedidos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT,
    data DATE DEFAULT CURRENT_DATE,
    total DECIMAL(10,2),
    FOREIGN KEY (cliente_id) REFERENCES clientes(id) ON DELETE CASCADE
);

-- View: Resumo de vendas por cliente
CREATE VIEW vendas_por_cliente AS
SELECT
    c.nome,
    COUNT(p.id) as total_pedidos,
    SUM(p.total) as total_gasto,
    AVG(p.total) as ticket_medio
FROM clientes c
LEFT JOIN pedidos p ON c.id = p.cliente_id
GROUP BY c.id, c.nome;

-- Trigger: Atualizar total do pedido
DELIMITER //
CREATE TRIGGER calcular_total
BEFORE INSERT ON pedidos
FOR EACH ROW
BEGIN
    SET NEW.total = NEW.quantidade * (SELECT preco FROM produtos WHERE id = NEW.produto_id);
END//
DELIMITER ;

-- Consultas úteis
-- Top 10 clientes
SELECT * FROM vendas_por_cliente ORDER BY total_gasto DESC LIMIT 10;

-- Produtos mais vendidos
SELECT p.nome, SUM(ped.quantidade) as total_vendido
FROM produtos p
JOIN pedidos ped ON p.id = ped.produto_id
GROUP BY p.id, p.nome
ORDER BY total_vendido DESC;

-- Clientes sem pedidos
SELECT c.nome
FROM clientes c
LEFT JOIN pedidos p ON c.id = p.cliente_id
WHERE p.id IS NULL;
```

---

**🚀 BOA PROVA! Você consegue! 💪**

---

_Criado em: Dezembro 2025_  
_Conteúdo: P2 - Banco de Dados_
