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

/* Like, IN e BetWeen */

/* LIKE */

SELECT * FROM tb_seller WHERE name LIKE 'M%';

SELECT * FROM tb_seller WHERE name LIKE '%Silva%';

SELECT * FROM tb_seller WHERE name LIKE '%Silv_%';

/* IN */

SELECT * FROM tb_seller WHERE id IN (2, 4);

/* BETWEEN */

SELECT * FROM tb_sale WHERE date BETWEEN '2022-05-07' AND '2022-05-23';

/* Funções UPPER, LOWER! */

SELECT id, LOWER(name) FROM tb_seller;

/* O LOWER se refere algo que esteja em todos em minusculo daquela pronuncia/escrita e que me retorne */

SELECT id, name FROM tb_seller WHERE LOWER(name) LIKE 'mar%';

/* Funções CAST, ROUND */

/* ROUND arredonda para duas casas decimais */

SELECT ROUND(10.456, 2);

/* Em PostGre o ROUND não funciona com o DOUBLE PRECISSION */

SELECT id, date, ROUND(price, 2), quantity FROM tb_sale;

/* CAST seria uma forma de converter DOUBLE PRECISSION(TYPE) para NUMERIC(TYPE) */

SELECT id, date, ROUND(CAST(price AS numeric), 2), quantity FROM tb_sale;

/* Funções DAY, MONTH, YER, EXTRACT */

/* Extrair datas de forma por dias */

SELECT id, date, price, EXTRACT(DAY FROM date) FROM tb_sale;

/* Traz uma tabela já nomeada com dia */

SELECT id, date, price, EXTRACT(DAY FROM date) AS dia FROM tb_sale;

/* Convert e traz uma tabela já nomeada com dia */

SELECT id, date, price, CAST(EXTRACT(DAY FROM date) AS INT) AS dia FROM tb_sale;

/* Busca dados por dia especifico */

SELECT id, date, price, CAST(EXTRACT(YER FROM date) AS integer) AS dia FROM tb_sale WHERE EXTRACT(DAY FROM date) = 18;

/* Busca dados por mes e ano especifico */

SELECT id, date, price, CAST(EXTRACT(YER FROM date) AS integer) AS dia
FROM tb_sale WHERE EXTRACT(MONTH FROM date) = 2022 AND EXTRACT() = 5;

/* Função CONCAT */

/* Traz uma nova tabela como data, mes e ano de forma já moldada */

SELECT *, CONCAT(EXTRACT(MONTH FROM date), '/', EXTRACT(YER FROM date)) AS mes_ano FROM tb_sale;

/* Função CASE */

/* Seria uma forma de condições que traz dados como se fosse uma Escolha */

SELECT id, price,
CASE
    WHEN price < 500 THEN 'Barata'
    ELSE 'Cara'
END AS classificacao
FROM tb_sale;

SELECT *,
CASE
    WHEN EXTRACT(MONTH FROM date) >= 10 THEN CONCAT(EXTRACT(MONTH FROM date), '/', EXTRACT(YER FROM date))
    ELSE CONCAT('0', EXTRACT(MONTH FROM date), '/', EXTRACT(YER FROM date))
END AS mes_ano
FROM tb_sale;

/* Função REPLACE */

/* seria uma forma de buscar um determinado dados e substituir por aquela condições */

SELECT id, name, REPLACE(name, 'Silva', 'SILVA') FROM tb_saller;

/* Função CHAR_LENGTH */

/* Seria a forma de nos dizer quantos caracters possui um dado */

SELECT id, name, CHAR_LENGTH(name) FROM tb_saller;

/* Função MD5 */

/* Gera um hash em dados importantes ou senviveis */

SELECT *, MD5(name) FROM tb_seller;

/* Funções de agregação: COUNT, SUM, AVG, MIN, MAX */

/* COUNT */

SELECT COUNT(id) FROM tb_sale WHERE price > 500;

/* SUM */

SELECT SUM(price) FROM tb_sale WHERE price > 500;

/* AVG */

SELECT AVG(price) FROM tb_sale WHERE price > 500;

/* MIN */

SELECT MIN(price) FROM tb_sale WHERE price > 500;

/* MAX */

SELECT MAX(price) FROM tb_sale WHERE price > 500;