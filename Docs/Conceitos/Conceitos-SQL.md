# Conceitos Avançados de SQL

## 🎯 Introdução

Este documento explora conceitos avançados de SQL que vão além dos fundamentos, preparando você para trabalhar com cenários complexos e otimizações de banco de dados.

---

## 1. Normalização de Banco de Dados

A normalização é um processo de organização de dados para reduzir redundância e melhorar a integridade.

### 1.1 Primeira Forma Normal (1NF)
**Objetivo:** Eliminar grupos repetitivos

**Regras:**
- Cada coluna deve conter apenas valores atômicos (indivisíveis)
- Não deve haver grupos de colunas repetidas

**Exemplo Incorreto:**
```sql
-- ❌ NÃO FAZER
CREATE TABLE Pedidos (
    PedidoID INT,
    Produtos VARCHAR(200),  -- Múltiplos produtos em uma coluna
    Quantidades VARCHAR(200)
);
```

**Exemplo Correto:**
```sql
-- ✅ FAZER
CREATE TABLE Pedidos (
    PedidoID INT PRIMARY KEY,
    ClienteID INT
);

CREATE TABLE ItemPedidos (
    ItemID INT PRIMARY KEY,
    PedidoID INT,
    ProdutoID INT,
    Quantidade INT,
    FOREIGN KEY (PedidoID) REFERENCES Pedidos(PedidoID)
);
```

### 1.2 Segunda Forma Normal (2NF)
**Objetivo:** Remover dependências parciais

**Regras:**
- Deve estar em 1NF
- Todos os atributos não-chave devem ser totalmente dependentes da chave primária

**Exemplo:**
```sql
-- ❌ PROBLEMA: DeptNome depende apenas de DeptID
CREATE TABLE Empregados (
    EmpID INT PRIMARY KEY,
    DeptID INT,
    EmpNome VARCHAR(100),
    DeptNome VARCHAR(100)  -- Depende só de DeptID
);

-- ✅ SOLUÇÃO: Separar em tabelas
CREATE TABLE Departamentos (
    DeptID INT PRIMARY KEY,
    DeptNome VARCHAR(100)
);

CREATE TABLE Empregados (
    EmpID INT PRIMARY KEY,
    EmpNome VARCHAR(100),
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Departamentos(DeptID)
);
```

### 1.3 Terceira Forma Normal (3NF)
**Objetivo:** Remover dependências transitivas

**Regras:**
- Deve estar em 2NF
- Nenhum atributo não-chave deve depender de outro atributo não-chave

**Exemplo:**
```sql
-- ❌ PROBLEMA: CidadeID não é chave, mas CidadeNome depende dele
CREATE TABLE Clientes (
    ClienteID INT PRIMARY KEY,
    ClienteNome VARCHAR(100),
    CidadeID INT,
    CidadeNome VARCHAR(100)  -- Depende de CidadeID
);

-- ✅ SOLUÇÃO
CREATE TABLE Cidades (
    CidadeID INT PRIMARY KEY,
    CidadeNome VARCHAR(100)
);

CREATE TABLE Clientes (
    ClienteID INT PRIMARY KEY,
    ClienteNome VARCHAR(100),
    CidadeID INT,
    FOREIGN KEY (CidadeID) REFERENCES Cidades(CidadeID)
);
```

### 1.4 BCNF (Boyce-Codd Normal Form)
Forma mais restritiva que 3NF, garantindo que todo determinante é uma chave candidata.

---

## 2. Relacionamentos entre Tabelas

### 2.1 Um para Um (1:1)
Cada registro em uma tabela se relaciona com exatamente um registro em outra tabela.

```sql
CREATE TABLE Pessoas (
    PessoaID INT PRIMARY KEY,
    Nome VARCHAR(100)
);

CREATE TABLE Passaportes (
    PassaporteID INT PRIMARY KEY,
    NumeroPassaporte VARCHAR(20),
    PessoaID INT UNIQUE,  -- UNIQUE garante 1:1
    FOREIGN KEY (PessoaID) REFERENCES Pessoas(PessoaID)
);
```

### 2.2 Um para Muitos (1:N)
Um registro em uma tabela pode se relacionar com múltiplos registros em outra tabela.

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

### 2.3 Muitos para Muitos (N:M)
Múltiplos registros em uma tabela podem se relacionar com múltiplos registros em outra tabela.

```sql
CREATE TABLE Alunos (
    AlunoID INT PRIMARY KEY,
    Nome VARCHAR(100)
);

CREATE TABLE Disciplinas (
    DisciplinaID INT PRIMARY KEY,
    Nome VARCHAR(100)
);

CREATE TABLE MatricularemDisciplinas (
    AlunoID INT,
    DisciplinaID INT,
    DataMatricula DATE,
    PRIMARY KEY (AlunoID, DisciplinaID),
    FOREIGN KEY (AlunoID) REFERENCES Alunos(AlunoID),
    FOREIGN KEY (DisciplinaID) REFERENCES Disciplinas(DisciplinaID)
);
```

---

## 3. Constraints (Restrições)

### 3.1 PRIMARY KEY
Identifica exclusivamente cada registro:

```sql
CREATE TABLE Produtos (
    ProdutoID INT PRIMARY KEY,
    Nome VARCHAR(100)
);
```

### 3.2 FOREIGN KEY
Mantém referencial integrity:

```sql
CREATE TABLE Pedidos (
    PedidoID INT PRIMARY KEY,
    ProdutoID INT,
    FOREIGN KEY (ProdutoID) REFERENCES Produtos(ProdutoID)
);
```

### 3.3 UNIQUE
Garante que todos os valores em uma coluna sejam únicos:

```sql
CREATE TABLE Usuarios (
    UsuarioID INT PRIMARY KEY,
    Email VARCHAR(100) UNIQUE
);
```

### 3.4 NOT NULL
Garante que uma coluna sempre tem um valor:

```sql
CREATE TABLE Empregados (
    EmpID INT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL
);
```

### 3.5 CHECK
Valida valores baseado em uma condição:

```sql
CREATE TABLE Salarios (
    SalarioID INT PRIMARY KEY,
    Valor DECIMAL(10,2) CHECK (Valor > 0)
);
```

### 3.6 DEFAULT
Define valor padrão para uma coluna:

```sql
CREATE TABLE Pedidos (
    PedidoID INT PRIMARY KEY,
    DataPedido DATE DEFAULT GETDATE()
);
```

---

## 4. Funções de Agregação Avançadas

### 4.1 Window Functions
Executam cálculos em um conjunto de linhas relacionadas:

```sql
-- Ranking de empregados por salário em seu departamento
SELECT 
    Nome,
    DeptID,
    Salario,
    RANK() OVER (PARTITION BY DeptID ORDER BY Salario DESC) as Ranking
FROM Empregados;
```

### 4.2 ROW_NUMBER
Atribui número único a cada linha:

```sql
SELECT 
    Nome,
    Salario,
    ROW_NUMBER() OVER (ORDER BY Salario DESC) as Posicao
FROM Empregados;
```

### 4.3 DENSE_RANK vs RANK
- **RANK()**: Deixa lacunas no ranking quando há empates
- **DENSE_RANK()**: Não deixa lacunas

```sql
-- RANK: 1, 2, 2, 4 (pula 3)
-- DENSE_RANK: 1, 2, 2, 3

SELECT 
    Nome,
    Salario,
    RANK() OVER (ORDER BY Salario DESC) as Ranking_RANK,
    DENSE_RANK() OVER (ORDER BY Salario DESC) as Ranking_DENSE
FROM Empregados;
```

### 4.4 LAG e LEAD
Acessam dados de linhas anteriores ou posteriores:

```sql
-- Comparar salário com linha anterior
SELECT 
    Nome,
    Salario,
    LAG(Salario) OVER (ORDER BY DataAdmissao) as SalarioAnterior,
    LEAD(Salario) OVER (ORDER BY DataAdmissao) as ProximoSalario
FROM Empregados;
```

---

## 5. Subconsultas Avançadas

### 5.1 Subconsultas Escalares
Retornam um único valor:

```sql
SELECT 
    Nome,
    Salario,
    (SELECT AVG(Salario) FROM Empregados) as MediaSalarial
FROM Empregados;
```

### 5.2 Subconsultas de Linha
Retornam uma linha:

```sql
SELECT * FROM Empregados
WHERE (DeptID, Salario) = 
    (SELECT DeptID, MAX(Salario) FROM Empregados GROUP BY DeptID);
```

### 5.3 Subconsultas de Tabela
Retornam múltiplas linhas:

```sql
SELECT * FROM (
    SELECT Nome, Salario
    FROM Empregados
    WHERE DeptID = 10
) as Subquery
WHERE Salario > 5000;
```

### 5.4 Subconsultas Correlacionadas
Referenciam colunas da consulta externa:

```sql
SELECT Nome, Salario
FROM Empregados e1
WHERE Salario > (
    SELECT AVG(Salario)
    FROM Empregados e2
    WHERE e2.DeptID = e1.DeptID
);
```

---

## 6. CTEs (Common Table Expressions)

Consultas nomeadas que podem ser reutilizadas:

### 6.1 CTE Simples
```sql
WITH SalarioAlto AS (
    SELECT Nome, Salario
    FROM Empregados
    WHERE Salario > 5000
)
SELECT * FROM SalarioAlto;
```

### 6.2 CTE Recursiva
Útil para dados hierárquicos:

```sql
WITH Hierarquia AS (
    -- Caso Base
    SELECT EmpID, Nome, GerenteID, 0 as Nivel
    FROM Empregados
    WHERE GerenteID IS NULL
    
    UNION ALL
    
    -- Caso Recursivo
    SELECT e.EmpID, e.Nome, e.GerenteID, h.Nivel + 1
    FROM Empregados e
    INNER JOIN Hierarquia h ON e.GerenteID = h.EmpID
)
SELECT * FROM Hierarquia;
```

---

## 7. Transações e Locks

### 7.1 Transações ACID
Garantem propriedades de dados:

- **A (Atomicidade)**: Tudo ou nada
- **C (Consistência)**: Dados sempre válidos
- **I (Isolamento)**: Transações não interferem
- **D (Durabilidade)**: Dados persistentes

```sql
BEGIN TRANSACTION;
BEGIN TRY
    UPDATE Contas SET Saldo = Saldo - 100 WHERE ContaID = 1;
    UPDATE Contas SET Saldo = Saldo + 100 WHERE ContaID = 2;
    COMMIT;
END TRY
BEGIN CATCH
    ROLLBACK;
    THROW;
END CATCH
```

### 7.2 Níveis de Isolamento

| Nível | Phantom Read | Non-repeatable Read | Dirty Read |
|-------|--------------|---------------------|-----------|
| **READ UNCOMMITTED** | ✓ | ✓ | ✓ |
| **READ COMMITTED** | ✓ | ✓ | ✗ |
| **REPEATABLE READ** | ✓ | ✗ | ✗ |
| **SERIALIZABLE** | ✗ | ✗ | ✗ |

```sql
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
BEGIN TRANSACTION;
-- Operações
COMMIT;
```

---

## 8. Otimização de Queries

### 8.1 Execution Plans
Analisar como o banco executa a consulta:

```sql
-- SQL Server
SET STATISTICS IO ON;
SET STATISTICS TIME ON;

SELECT * FROM Empregados WHERE DeptID = 10;
```

### 8.2 Índices Compostos
Para múltiplas colunas:

```sql
CREATE INDEX idx_dept_salary 
ON Empregados(DeptID, Salario);
```

### 8.3 Índices Filtrados
Índices em um subconjunto de dados:

```sql
CREATE INDEX idx_empregados_ativos 
ON Empregados(Nome)
WHERE DataDemissao IS NULL;
```

### 8.4 Hints de Query
Orientar o otimizador:

```sql
SELECT /*+ INDEX(Empregados idx_salary) */ 
    Nome, Salario 
FROM Empregados 
WHERE Salario > 5000;
```

---

## 9. Stored Procedures e Funções

### 9.1 Stored Procedures
Blocos de SQL reutilizáveis:

```sql
CREATE PROCEDURE sp_AumentarSalario
    @DeptID INT,
    @Percentual DECIMAL(5,2)
AS
BEGIN
    UPDATE Empregados
    SET Salario = Salario * (1 + @Percentual/100)
    WHERE DeptID = @DeptID;
END;

-- Executar
EXEC sp_AumentarSalario @DeptID = 10, @Percentual = 10;
```

### 9.2 Funções Definidas pelo Usuário
```sql
CREATE FUNCTION CalcularIdade(@DataNascimento DATE)
RETURNS INT
AS
BEGIN
    RETURN DATEDIFF(YEAR, @DataNascimento, GETDATE());
END;

-- Usar
SELECT Nome, dbo.CalcularIdade(DataNascimento) as Idade
FROM Empregados;
```

---

## 10. Segurança em SQL

### 10.1 SQL Injection
**Problema:** Entrada do usuário interpretada como código

```sql
-- ❌ INSEGURO
DECLARE @nome NVARCHAR(100) = @input;
EXEC('SELECT * FROM Usuarios WHERE Nome = ''' + @nome + '''');

-- ✅ SEGURO: Usar parâmetros
DECLARE @nome NVARCHAR(100) = @input;
SELECT * FROM Usuarios WHERE Nome = @nome;
```

### 10.2 Princípio de Menor Privilégio
```sql
-- Criar usuário com permissões mínimas
CREATE USER [usuario_leitura] FOR LOGIN [usuario_leitura];
GRANT SELECT ON Empregados TO [usuario_leitura];
```

### 10.3 Criptografia
```sql
-- SQL Server: Always Encrypted
CREATE TABLE Pessoas (
    PessoaID INT,
    NomeCompleto NVARCHAR(100) 
        ENCRYPTED WITH (ENCRYPTION_TYPE = DETERMINISTIC)
);
```

---

## 11. Backup e Recovery

### 11.1 Tipos de Backup

```sql
-- Full Backup
BACKUP DATABASE MeuBanco TO DISK = 'C:\Backup\banco.bak';

-- Incremental Backup
BACKUP DATABASE MeuBanco TO DISK = 'C:\Backup\banco_diff.bak' 
WITH DIFFERENTIAL;

-- Transaction Log Backup
BACKUP LOG MeuBanco TO DISK = 'C:\Backup\banco_log.bak';
```

### 11.2 Recovery
```sql
-- Restaurar backup
RESTORE DATABASE MeuBanco FROM DISK = 'C:\Backup\banco.bak';
```

---

## 12. Monitoramento de Performance

### 12.1 DMVs (Dynamic Management Views)
Informações sobre performance:

```sql
-- Queries mais caras
SELECT TOP 10
    SUM(qs.total_worker_time) as Total_CPU,
    SUM(qs.execution_count) as Execucoes,
    SUBSTRING(st.text, 1, 100) as Query
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) st
GROUP BY st.text
ORDER BY Total_CPU DESC;
```

### 12.2 Waitstats
Identifica gargalos:

```sql
SELECT 
    wait_type,
    waiting_tasks_count,
    wait_time_ms
FROM sys.dm_os_wait_stats
ORDER BY wait_time_ms DESC;
```

---

## 13. Replicação e Distribuição

### 13.1 Replicação Transacional
Copia alterações para subscribers:

```sql
-- Configurar publicação
EXEC sp_addpublication 
    @publication = 'PubEmpregados',
    @allow_push = 'true';
```

### 13.2 Particionamento
Distribuir dados em múltiplos físicos:

```sql
CREATE PARTITION FUNCTION pf_Data (DATE) AS RANGE LEFT FOR VALUES
('2020-01-01', '2021-01-01', '2022-01-01');

CREATE PARTITION SCHEME ps_Data AS PARTITION pf_Data 
ALL TO ([PRIMARY]);

CREATE TABLE Vendas (
    VendaID INT,
    Data DATE,
    Valor DECIMAL(10,2)
) ON ps_Data(Data);
```

---

## 14. Análise de Dados Avançada

### 14.1 PIVOT
Transformar linhas em colunas:

```sql
SELECT 
    [2020], [2021], [2022]
FROM (
    SELECT YEAR(Data) as Ano, Valor FROM Vendas
) as SourceTable
PIVOT (
    SUM(Valor) FOR Ano IN ([2020], [2021], [2022])
) as PivotTable;
```

### 14.2 UNPIVOT
Transformar colunas em linhas:

```sql
SELECT Mes, Valor
FROM (
    SELECT Janeiro, Fevereiro, Marco FROM Vendas
) as SourceTable
UNPIVOT (
    Valor FOR Mes IN (Janeiro, Fevereiro, Marco)
) as UnpivotTable;
```

---

## 15. Boas Práticas Avançadas

✅ **Faça:**
- Normalize seu banco de dados (até 3NF no mínimo)
- Use indices de forma estratégica
- Implemente constraints para integridade referencial
- Monitore performance regularmente
- Documente sua estrutura e procedimentos
- Use CTEs para queries complexas
- Implemente tratamento de erros em procedures

❌ **Não Faça:**
- Não abuse de JOINs em excesso
- Não deixe dados sensíveis sem proteção
- Não ignore avisos do query optimizer
- Não use índices em coluna com baixa seletividade
- Não modifique estruturas sem testing adequado
- Não deixe transactions abertas longamente
- Não confie apenas em senha para segurança

---

## 16. Conclusão

Dominar estes conceitos avançados coloca você em posição de trabalhar com sistemas de banco de dados complexos e escaláveis. Continue praticando e explorando!

**Recursos:**
- [Documentação de Fundamentos](Fundamentos-SQL.md)
- Exercícios práticos disponíveis no repositório
- Documentação oficial do seu SGBD específico
