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

SELECT * FROM tb_empregado INNER JOIN tb_departamento ON tb_empregado.dept_id = tb_departamento.IDENTITY

/* Tipos de Junção */

/* INNER JOIN Refere dados da duas tabelas*/

/* LEFT JOIN Refere todos os dados da tabela da esquerda e um pouco da direita */

