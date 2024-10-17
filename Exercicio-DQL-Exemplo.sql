/* DQL */

/* Projeção em SQL*/

/* Traz em BD apenas os conceitos atribuidos, como: id e nome */

SELECT id, nome
FROM tb_empregado;

/* Restrição em SQL */

/* Traz em BD apenas o conceito atribuido a ele, como: todos que estejam neste id */

SELECT * FROM tb_empregado WHERE dept_id = 2;