/* DQL */

/* Projeção em SQL*/

/* Traz em BD apenas os conceitos atribuidos, como: id e nome */

SELECT id, nome FROM tb_empregado;

/* Restrição em SQL */

/* Traz em BD apenas o conceito atribuido a ele, como: todos que estejam neste id */

SELECT * FROM tb_empregado WHERE dept_id = 2;

/* Produto Cartesiano */

/* Faz o cruzamento de dados da tabela */

SELECT * FROM tb_empregado, tb_departamento;

/* Junção */

/* Faz o cruzamento entre duas tabelas apenas */

SELECT * FROM tb_empregado INNER JOIN tb_departamento ON tb_empregado.dept_id = tb_departamento.id;

/* Tipos de Junção */

/* INNER JOIN Refere dados da duas tabelas*/

SELECT * FROM tb_empregado INNER JOIN tb_departamento ON tb_empregado.dept_id = tb_departamento.id;

/* LEFT JOIN Refere todos os dados da tabela da esquerda e um pouco da direita */

SELECT * FROM tb_empregado LEFT JOIN tb_departamento ON tb_empregado.dept_id = tb_departamento.id;

/* RIGHT JOIN Refere todos os dados da tabela da direita e um pouco da esquerda */

SELECT * FROM tb_empregado RIGHT JOIN tb_departamento ON tb_empregado.dept_id = tb_departamento.id;

/* FULL JOIN refere todos os dados das tabelas */

SELECT * FROM tb_empregado FULL JOIN tb_departamento ON tb_empregado.dept_id = tb_departamento.id;

/* Renomeação (AS) */

/* Remover Ambiquidade */

SELECT * FROM tb_empregado INNER JOIN tb_departamento ON tb_empregado.dept_id = tb_departamento.id;

/* Elimina a Ambiquidade */

SELECT tb_empregado.id, tb_empregado.nome FROM tb_empregado INNER JOIN tb_departamento ON tb_empregado.dept_id = tb_departamento.id;

/* Apelida a coluna da tabela */

SELECT tb_empregado.id, tb_empregado.nome, tb_departamento.nome AS nome_departamento
FROM tb_empregado INNER JOIN tb_departamento ON tb_empregado.dept_id = tb_departamento.id;

/* Calculos */

SELECT tb_empregado.id, tb_empregado.nome, tb_empregado.id * 10 AS Calculo
FROM tb_empregado INNER JOIN tb_departamento ON tb_empregado.dept_id = tb_departamento.id;

/* Uma consulta(pai) com a sub-consulta(filho) */

SELECT dept_id
FROM (
    SELECT *
    FROM tb_empregado
    INNER JOIN tb_departamento ON tb_empregado.dept_id = tb_departamento.id
) AS juncao;