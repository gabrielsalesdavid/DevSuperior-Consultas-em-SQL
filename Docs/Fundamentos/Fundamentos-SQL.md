# Fundamentos de SQL

## 📚 Introdução

SQL (Structured Query Language) é uma linguagem padrão utilizada para gerenciar e manipular dados em bancos de dados relacionais. Este documento apresenta os fundamentos essenciais para trabalhar com SQL de forma eficaz.

---

## 1. O que é SQL?

SQL é uma linguagem de programação específica de domínio (DSL) projetada para:
- **Criar** estruturas de dados (tabelas, índices, etc.)
- **Inserir** dados nos bancos de dados
- **Consultar** dados armazenados
- **Atualizar** informações existentes
- **Deletar** dados desnecessários

---

## 2. Principais Categorias de SQL

### 2.1 DDL (Data Definition Language)
**Linguagem de Definição de Dados**

Usada para criar e modificar estruturas de banco de dados:
```sql
-- Criar tabela
CREATE TABLE tabela (
    coluna1 INT,
    coluna2 VARCHAR(100)
);

-- Alterar tabela
ALTER TABLE tabela ADD COLUMN coluna3 DATE;

-- Deletar tabela
DROP TABLE tabela;
```

**Comandos principais:** `CREATE`, `ALTER`, `DROP`, `TRUNCATE`

### 2.2 DML (Data Manipulation Language)
**Linguagem de Manipulação de Dados**

Usada para inserir, atualizar e deletar dados:
```sql
-- Inserir dados
INSERT INTO tabela (coluna1, coluna2) 
VALUES (10, 'Valor');

-- Atualizar dados
UPDATE tabela 
SET coluna1 = 20 
WHERE coluna2 = 'Valor';

-- Deletar dados
DELETE FROM tabela 
WHERE coluna1 = 20;
```

**Comandos principais:** `INSERT`, `UPDATE`, `DELETE`

### 2.3 DQL (Data Query Language)
**Linguagem de Consulta de Dados**

Usada para recuperar dados do banco de dados:
```sql
-- Consulta básica
SELECT coluna1, coluna2 
FROM tabela 
WHERE coluna1 > 10;
```

**Comando principal:** `SELECT`

### 2.4 DCL (Data Control Language)
**Linguagem de Controle de Dados**

Usada para controlar permissões e acesso:
```sql
-- Conceder permissão
GRANT SELECT ON tabela TO usuario;

-- Revogar permissão
REVOKE SELECT ON tabela FROM usuario;
```

**Comandos principais:** `GRANT`, `REVOKE`

### 2.5 TCL (Transaction Control Language)
**Linguagem de Controle de Transações**

Usada para gerenciar transações:
```sql
-- Iniciar transação
BEGIN TRANSACTION;

-- Confirmar alterações
COMMIT;

-- Desfazer alterações
ROLLBACK;
```

**Comandos principais:** `COMMIT`, `ROLLBACK`, `SAVEPOINT`

---

## 3. Estrutura Básica de um Banco de Dados

### 3.1 Tabela
Estrutura fundamental que armazena dados em linhas e colunas.

```
╔════════════════════════════════════════╗
║           TABELA: Empregados            ║
╠═════╦════════════╦════════════╦═════════╣
║ ID  ║   Nome     ║  Departamento║ Salário║
╠═════╬════════════╬════════════╬═════════╣
║ 1   ║ João       ║ TI         ║ 5000.00║
║ 2   ║ Maria      ║ RH         ║ 4500.00║
║ 3   ║ Carlos     ║ TI         ║ 5500.00║
╚═════╩════════════╩════════════╩═════════╝
```

### 3.2 Coluna
Também chamada de campo ou atributo. Define um aspecto dos dados.

### 3.3 Linha (Registro)
Um conjunto completo de valores para todas as colunas, representando uma entidade única.

### 3.4 Chave Primária (Primary Key)
Identificador único para cada registro na tabela. Garante que não há duplicatas.

```sql
CREATE TABLE Empregados (
    ID INT PRIMARY KEY,
    Nome VARCHAR(100)
);
```

### 3.5 Chave Estrangeira (Foreign Key)
Estabelece relacionamento entre duas tabelas.

```sql
CREATE TABLE Departamentos (
    DeptID INT PRIMARY KEY,
    Nome VARCHAR(100)
);

CREATE TABLE Empregados (
    EmpID INT PRIMARY KEY,
    Nome VARCHAR(100),
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Departamentos(DeptID)
);
```

---

## 4. Tipos de Dados Comuns

| Tipo | Descrição | Exemplo |
|------|-----------|---------|
| **INT** | Número inteiro | `INT` |
| **FLOAT / DECIMAL** | Número decimal | `DECIMAL(10,2)` |
| **VARCHAR(n)** | Texto variável | `VARCHAR(100)` |
| **CHAR(n)** | Texto fixo | `CHAR(10)` |
| **DATE** | Data | `DATE` |
| **DATETIME** | Data e hora | `DATETIME` |
| **BOOLEAN** | Verdadeiro/Falso | `BOOLEAN` |
| **TEXT** | Texto longo | `TEXT` |
| **BLOB** | Dados binários | `BLOB` |

---

## 5. Operadores Básicos

### 5.1 Operadores de Comparação
```sql
= (igual)
!= ou <> (diferente)
> (maior que)
< (menor que)
>= (maior ou igual)
<= (menor ou igual)
```

### 5.2 Operadores Lógicos
```sql
AND (E)     -- Ambas as condições devem ser verdadeiras
OR (OU)     -- Pelo menos uma condição deve ser verdadeira
NOT (NÃO)   -- Inverte a condição
```

### 5.3 Operadores de Padrão
```sql
LIKE        -- Busca por padrão
IN          -- Verifica se está em uma lista
BETWEEN     -- Verifica intervalo
```

---

## 6. Consultas SELECT Básicas

### 6.1 Seleção Simples
```sql
-- Selecionar todas as colunas
SELECT * FROM Empregados;

-- Selecionar colunas específicas
SELECT Nome, Salario FROM Empregados;
```

### 6.2 Filtragem com WHERE
```sql
-- Encontrar empregados com salário maior que 5000
SELECT Nome, Salario 
FROM Empregados 
WHERE Salario > 5000;
```

### 6.3 Ordenação com ORDER BY
```sql
-- Ordenar por nome em ordem alfabética
SELECT Nome, Salario 
FROM Empregados 
ORDER BY Nome ASC;

-- Ordenar por salário em ordem decrescente
SELECT Nome, Salario 
FROM Empregados 
ORDER BY Salario DESC;
```

### 6.4 Limitação de Resultados
```sql
-- Retornar apenas os 5 primeiros registros
SELECT * FROM Empregados 
LIMIT 5;

-- Retornar 5 registros começando a partir do 10º
SELECT * FROM Empregados 
LIMIT 5 OFFSET 10;
```

---

## 7. Funções de Agregação

Funções que realizam cálculos sobre um conjunto de valores:

```sql
-- Contar registros
SELECT COUNT(*) FROM Empregados;

-- Soma de valores
SELECT SUM(Salario) FROM Empregados;

-- Média de valores
SELECT AVG(Salario) FROM Empregados;

-- Valor máximo
SELECT MAX(Salario) FROM Empregados;

-- Valor mínimo
SELECT MIN(Salario) FROM Empregados;
```

---

## 8. GROUP BY e HAVING

### 8.1 GROUP BY
Agrupa registros por uma ou mais colunas:

```sql
-- Salário total por departamento
SELECT Departamento, SUM(Salario) as Total
FROM Empregados
GROUP BY Departamento;
```

### 8.2 HAVING
Filtra grupos após agregação:

```sql
-- Departamentos com salário total maior que 10000
SELECT Departamento, SUM(Salario) as Total
FROM Empregados
GROUP BY Departamento
HAVING SUM(Salario) > 10000;
```

---

## 9. JOINs - Unindo Tabelas

### 9.1 INNER JOIN
Retorna apenas registros com correspondência em ambas as tabelas:

```sql
SELECT e.Nome, d.Nome as Departamento
FROM Empregados e
INNER JOIN Departamentos d 
  ON e.DeptID = d.DeptID;
```

### 9.2 LEFT JOIN
Retorna todos os registros da tabela esquerda mais correspondências da direita:

```sql
SELECT e.Nome, d.Nome as Departamento
FROM Empregados e
LEFT JOIN Departamentos d 
  ON e.DeptID = d.DeptID;
```

### 9.3 RIGHT JOIN
Retorna todos os registros da tabela direita mais correspondências da esquerda:

```sql
SELECT e.Nome, d.Nome as Departamento
FROM Empregados e
RIGHT JOIN Departamentos d 
  ON e.DeptID = d.DeptID;
```

### 9.4 FULL OUTER JOIN
Retorna todos os registros de ambas as tabelas:

```sql
SELECT e.Nome, d.Nome as Departamento
FROM Empregados e
FULL OUTER JOIN Departamentos d 
  ON e.DeptID = d.DeptID;
```

---

## 10. Subqueries

Consultas aninhadas dentro de outras consultas:

```sql
-- Encontrar empregados com salário acima da média
SELECT Nome, Salario
FROM Empregados
WHERE Salario > (SELECT AVG(Salario) FROM Empregados);
```

---

## 11. Índices

Estruturas que melhoram a velocidade de consultas:

```sql
-- Criar índice
CREATE INDEX idx_nome ON Empregados(Nome);

-- Deletar índice
DROP INDEX idx_nome;
```

---

## 12. Views

Tabelas virtuais baseadas em consultas:

```sql
-- Criar view
CREATE VIEW EmpregadosAltoSalario AS
SELECT Nome, Salario
FROM Empregados
WHERE Salario > 5000;

-- Usar a view
SELECT * FROM EmpregadosAltoSalario;
```

---

## 13. Boas Práticas

✅ **Faça:**
- Use nomes descritivos para tabelas e colunas
- Sempre use chaves primárias e estrangeiras
- Crie índices para colunas frequentemente consultadas
- Valide dados antes de inserir
- Use transações para operações críticas
- Faça backup regular dos dados

❌ **Não Faça:**
- Não use `SELECT *` em aplicações em produção
- Não confie em SQL Injection
- Não deixe campos obrigatórios sem validação
- Não ignore avisos de performance
- Não modifique estruturas de tabela sem backup

---

## 14. Conclusão

O SQL é uma ferramenta poderosa e essencial para trabalhar com bancos de dados. Compreender estes fundamentos permite que você execute operações mais complexas com confiança.

**Próximos passos:**
- Explore os conceitos avançados em [Conceitos/](../Conceitos/)
- Pratique os exercícios disponíveis
- Estude casos de uso real em seu contexto específico
