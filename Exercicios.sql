/* Exercicio 2602 */

SELECT name FROM customers WHERE state = 'RS';

/* Exercicio 2603 */

SELECT name, street FROM customers WHERE city = 'Porto Alegre';

/* Exercicio 2604 */

SELECT id, name FROM products WHERE price < 10 OR price > 100;

/* ou */

SELECT products.id, products.name FROM products WHERE price NOT BETWEEN 10 AND 100;

/* Exercicio 2605 */

SELECT products.name, providers.name FROM products
INNER JOIN providers ON providers.id = products.id_providers
WHERE products.id_categories = 6;

/* ou */

SELECT products.name, providers.name FROM products
INNER JOIN providers ON providers.id = products.id_providers
WHERE products.id_categories IN(6);

/* Exercicio 2606 */

SELECT products.id, products.name FROM products
INNER JOIN categories ON categories.id = products.id_categories WHERE categories.name LIKE 'super%';

/* Exercicio 2607 */

SELECT DISTINCT city FROM providers ORDER BY city ASC;

/* Exercicio 2608 */

SELECT MAX(price) AS price, MIN(price) AS price FROM products;

/* Exercicio 2609 */

SELECT categories.name, SUM(products.amount) FROM categories
INNER JOIN products ON products.id_categories = categories.id
GROUP BY categories.name ORDER BY SUM(products.amount);

/* Exercicio 2610 */

SELECT ROUND(AVG(price), 2) AS price FROM products;

/* Exercicio 2611 */

SELECT movies.id, movies.name FROM movies
INNER JOIN genres ON movies.id_genres = genres.id WHERE genres.description = 'Action';

/* Exercicio 2613 */

SELECT movies.id, movies.name FROM movies INNER JOIN prices ON movies.id_prices = prices.id WHERE prices.value < 2.00;

/* Exercicio 2614 */

SELECT customers.name, rentals.rentals_date FROM customers
INNER JOIN rentals ON rentals.id_customers = customers.id
WHERE rentals_date >= '2016-09-01' AND rentals_date <= '2016-10-01';

/* OU */

SELECT customers.name, rentals.rentals_date FROM customers
INNER JOIN rentals ON rentals.id_customers = customers.id
WHERE EXTRACT(MONTH FROM rentals.rentals_date) = 9
AND EXTRACT(YEAR FROM rentals.rentals_date) = 2016;

/* Exercico 2615 */

SELECT DISTINCT customers.city FROM customers;

/* Exercico 2616 */

SELECT customers.id, customers.name FROM customers
WHERE NOT EXISTS (SELECT id_customers FROM locations WHERE customers.id = locations.id_customers);

/* OU */

SELECT customers.id, customers.name FROM customers WHERE customers.id NOT IN (SELECT id_customers FROM locations);

/* Exercico 2617 */

SELECT products.name, providers.name FROM products
INNER JOIN providers ON products.id_providers = providers.id WHERE providers.id = 1;

/* OU */

SELECT products.name, providers.name FROM products
INNER JOIN providers ON products.id_providers = providers.id WHERE providers.name LIKE 'Aja%';

/* Exercico 2618 */

/* Se a condição fosse uma este exemplo seria aceito */

SELECT products.name, providers.name, categories.name FROM categories
INNER JOIN products ON products.id_categories = categories.id
INNER JOIN providers ON products.id_providers = providers.id
WHERE categories.name LIKE 'Imp%';

/* OU */

SELECT products.name, providers.name, categories.name FROM categories
INNER JOIN products ON products.id_categories = categories.id
INNER JOIN providers ON products.id_providers = providers.id
WHERE categories.name = 'Imported' AND providers.name = 'Sansul SA';

/* Exercico 2619 */

SELECT products.name, providers.name, products.price FROM categories
INNER JOIN products ON products.id_categories = categories.id
INNER JOIN providers ON products.id_providers = providers.id
WHERE products.price >= 1000 AND categories.name = 'Super Luxury';

/* Exercico 2620 */

/* Sem formatação de Data */

SELECT customers.name, orders.id FROM orders INNER JOIN customers ON orders.id_customers = customers.id
WHERE orders_date >= '2016-01-01' AND orders_date <= '2016-06-30';

/* Sem formatação de Data */

SELECT customers.name, orders.id FROM customers INNER JOIN orders ON customers.id = orders.id_customers
WHERE orders.orders_date BETWEEN '2016-01-01' AND '2016-06-30';

/* Com formatação de Data */

SELECT customers.name, orders.id FROM customers INNER JOIN orders ON customers.id = orders.id_customers
WHERE orders.orders_date BETWEEN TO_DATE('01/0/2016', 'DD/MM/YYYY') AND TO_DATE('30/06/2016', 'DD/MM/YYYY');

/* Exercico 2621 */

SELECT products.name FROM products INNER JOIN providers ON products.id_providers = providers.id
WHERE products.amount >= 10 AND products.amount <= 20 AND providers.name LIKE 'P%';

/* OU */

SELECT products.name FROM products INNER JOIN providers ON products.id_providers = providers.id
WHERE (products.amount BETWEEN 10 AND 20) AND (providers.name LIKE 'P%');

/* Exercico 2622 */

/* Traz valores entre o id 4 e 5 */

SELECT customers.name FROM legal_person INNER JOIN customers ON legal_person.id_customers = customers.id
WHERE customers.id BETWEEN 4 AND 5;

/* OU */

SELECT customers.name FROM legal_person INNER JOIN customers ON legal_person.id_customers = customers.id;

/* Exercico 2623 */

SELECT products.name, categories.name FROM products INNER JOIN categories ON products.id_categories = categories.id
WHERE products.amount >= 100 AND products.id_categories IN(1, 2, 3, 6, 9);

/* OU */

SELECT products.name, categories.name FROM products INNER JOIN categories ON products.id_categories = categories.id
WHERE products.amount > 100 AND products.id_categories IN(1, 2, 3, 6, 9);

/* Exercico 2624 */

SELECT COUNT(city) FROM customers WHERE customers.state = 'RS';

/* OU */

SELECT COUNT(DISTINCT city) FROM customers;

/* Exercico 2625 */

SELECT
SUBSTRING(cpf, 1, 3) || '.' ||
SUBSTRING(cpf, 4, 3) || '.' ||
SUBSTRING(cpf, 7, 3) || '-' ||
SUBSTRING(cpf, 10, 2) FROM natural_person;

/* Exercico 2737 */

(SELECT lawyers.name, customers_number
FROM lawyers
ORDER BY customers_number DESC
LIMIT 1)
 UNION ALL
(SELECT lawyers.name, customers_number
FROM lawyers
ORDER BY customers_number ASC
LIMIT 1)
UNION ALL
(SELECT 'Average', round(AVG(customers_number), 0)
FROM lawyers);

/* Exercico 2738 */

SELECT candidate.name,
CAST((((score.math * 2) + (score.specific * 3) + (score.project_plan * 5)) / 10) AS NUMERIC(15, 2))
AS avg
FROM score INNER JOIN candidate ON score.candidate_id = candidate.id ORDER BY avg DESC;

/* Exercico 2739 */

SELECT loan.name, CAST(EXTRACT(DAY FROM payday) AS INT) AS day FROM loan;

/* Exercico 2740 */

(SELECT
CONCAT('Podium: ', team) AS name
FROM league WHERE position <=3)
UNION ALL
(SELECT CONCAT ('Demoted: ', team) AS name
FROM league WHERE position >= 14);

/* Exercico 2741 */

SELECT CONCAT('Approved: ', name) AS name, grade FROM students WHERE grade >= 7 ORDER BY grade DESC;

/* Exercico 2742 */

SELECT life_registry.name, ROUND((life_registry.omega * 1.618), 3) AS "The N Factor"
FROM life_registry INNER JOIN dimensions ON life_registry.dimensions_id = dimensions.id
WHERE dimensions.name IN('C875', 'C774') AND life_registry.name LIKE 'Richard%' ORDER BY life_registry ASC;

/* Exercico 2743 */

SELECT name, CHAR_LENGTH(name) AS "length" FROM people ORDER BY length DESC;

/* Exercico 2744 */

SELECT account.id, account.password, MD5(password) AS "MD5" FROM account;

/* Exercico 2745 */

SELECT people.name, ROUND((people.salary * 0.10), 2) AS "tax" FROM people WHERE salary > 3000;

/* OU */

SELECT people.name, ROUND(((people.salary * 10)/ 100), 2) AS "tax" FROM people WHERE salary > 3000;

/* Exercico 2746 */

SELECT REPLACE(name, 'H1', 'X') AS "name" FROM virus;

/* Exercico 2988 */

SELECT teams.name AS "name", COUNT(matches.id) AS "matches",
SUM(CASE WHEN(teams.id = matches.team_1 AND matches.team_1_goals > matches.team_2_goals)
          OR (teams.id = matches.team_2 AND matches.team_2_goals > matches.team_1_goals) THEN 1 ELSE 0 END) AS "victories",
SUM(CASE WHEN(teams.id = matches.team_1 AND matches.team_2_goals > matches.team_1_goals)
		  OR (teams.id = matches.team_2 AND matches.team_1_goals > matches.team_2_goals) THEN 1 ELSE 0 END) AS "defeats",
SUM(CASE WHEN matches.team_1_goals = matches.team_2_goals THEN 1 ELSE 0 END) AS "draws",
SUM(CASE WHEN(teams.id = matches.team_1 AND matches.team_1_goals > matches.team_2_goals)
          OR (teams.id = matches.team_2 AND matches.team_2_goals > matches.team_1_goals) THEN 3
		  WHEN matches.team_1_goals = matches.team_2_goals THEN 1 ELSE 0 END) AS "score"
FROM teams
LEFT JOIN matches ON teams.id = matches.team_1 OR teams.id = matches.team_2
GROUP BY teams.name
ORDER BY matches DESC, victories DESC, defeats DESC;

/* Exercico 2989 */

SELECT departamento.nome AS "departamento", divisao.nome AS "divisao",
ROUND(AVG(tipo_salario.salario - tipo_descontos.descontos), 2) AS "media",
ROUND(MAX(tipo_salario.salario - tipo_descontos.descontos), 2) AS "maior"
FROM departamento
INNER JOIN divisao ON departamento.cod_dep = divisao.cod_dep
INNER JOIN empregado ON divisao.cod_divisao = empregado.lotacao_div
INNER JOIN(
           SELECT empregado.matr, COALESCE(SUM(vencimento.valor), 0) AS "salario"
           FROM empregado
		   LEFT JOIN emp_venc ON empregado.matr = emp_venc.matr
		   LEFT JOIN vencimento ON emp_venc.cod_venc = vencimento.cod_venc
		   GROUP BY empregado.matr) AS "tipo_salario" ON empregado.matr = tipo_salario.matr
INNER JOIN(
           SELECT empregado.matr, COALESCE(SUM(desconto.valor), 0) AS "descontos"
		   FROM empregado
		   LEFT JOIN emp_desc ON empregado.matr = emp_desc.matr
		   LEFT JOIN desconto ON emp_desc.cod_desc = desconto.cod_desc
		   GROUP BY empregado.matr) AS "tipo_descontos" ON empregado.matr = tipo_descontos.matr
GROUP BY divisao.cod_divisao, divisao.nome, departamento.nome
ORDER BY AVG(tipo_salario.salario - tipo_descontos.descontos) DESC;

/* Exercico 2990 */

SELECT empregados.cpf, empregados.enome, departamentos.dnome FROM empregados
INNER JOIN departamentos ON empregados.dnumero = departamentos.dnumero
WHERE empregados.cpf_supervisor IS NULL ORDER BY empregados.cpf;

/* Exercico 2991 */

SELECT departamento.nome AS "Nome Departamento",
COUNT(empregado.matr) AS "Numero de Empregados",
TO_CHAR((AVG(tipo_salario.salario - tipo_descontos.descontos)), '99999.99') AS "Media Salarial",
TO_CHAR((MAX(tipo_salario.salario - tipo_descontos.descontos)), '99999.99') AS "Maior Salario",
(CASE WHEN
		  MIN(tipo_salario.salario - tipo_descontos.descontos) = 0 THEN '0'
		  ELSE TO_CHAR((MIN(tipo_salario.salario - tipo_descontos.descontos)), '99999.99') END) AS "Menor Salario"
FROM departamento
INNER JOIN empregado ON departamento.cod_dep = empregado.lotacao
INNER JOIN(
           SELECT empregado.matr, COALESCE(SUM(vencimento.valor), 0) AS "salario"
		   FROM empregado
		   LEFT JOIN emp_venc ON empregado.matr = emp_venc.matr
		   LEFT JOIN vencimento ON emp_venc.cod_venc = vencimento.cod_venc
		   GROUP BY empregado.matr) AS "tipo_salario" ON empregado.matr = tipo_salario.matr
INNER JOIN(
           SELECT empregado.matr, COALESCE(SUM(desconto.valor), 0) AS "descontos"
		   FROM empregado
		   LEFT JOIN emp_desc ON empregado.matr = emp_desc.matr
		   LEFT JOIN desconto ON emp_desc.cod_desc = desconto.cod_desc
		   GROUP BY empregado.matr) AS "tipo_descontos" ON empregado.matr = tipo_descontos.matr
GROUP BY departamento.cod_dep, departamento.nome
ORDER BY "Media Salarial" DESC;

/* OU */

	SELECT
		departamento.nome AS "Nome Departamento",
		COUNT(salarios.lotacao) AS "Numero de Empregados",
		ROUND(AVG(salarios.salario), 2) AS "Media Salarial",
		ROUND(MAX(salarios.salario), 2) AS "Maior Salario",
		CASE WHEN MIN(salarios.salario) = 0.00 THEN 0
			 ELSE ROUND(MIN(salarios.salario), 2)
		END AS "Menor Salario"
	FROM (
		SELECT
		venc_agrupados.lotacao,
		ROUND(SUM(total_vencimentos) - COALESCE(SUM(total_descontos), 0), 2) AS salario
		FROM (
			SELECT
				empregado.matr,
				empregado.lotacao,
				COALESCE(SUM(vencimento.valor), 0) AS total_vencimentos
			FROM empregado
			LEFT JOIN emp_venc
				ON empregado.matr = emp_venc.matr
			LEFT JOIN vencimento
				ON emp_venc.cod_venc = vencimento.cod_venc
			GROUP BY empregado.matr, empregado.lotacao
			) AS venc_agrupados
			LEFT JOIN (
				SELECT
					empregado.matr,
					empregado.lotacao,
					COALESCE(SUM(desconto.valor), 0) AS total_descontos
				FROM empregado
				LEFT JOIN emp_desc
					ON empregado.matr = emp_desc.matr
				LEFT JOIN desconto
					ON emp_desc.cod_desc = desconto.cod_desc
				GROUP BY empregado.matr, empregado.lotacao
			) AS desc_agrupados
				ON venc_agrupados.matr = desc_agrupados.matr
			GROUP BY venc_agrupados.matr, venc_agrupados.lotacao
		) AS salarios
	INNER JOIN departamento
		ON salarios.lotacao = departamento.cod_dep
	GROUP BY departamento.nome
	ORDER BY "Media Salarial" DESC;

/* Exercico 2992 */

SELECT * FROM(
	SELECT departamento.nome, divisao.nome AS Divisao,
	ROUND(AVG(tipo_salario.salario - tipo_descontos.descontos), 2) AS Media
	FROM divisao
		INNER JOIN empregado ON divisao.cod_divisao = empregado.lotacao_div
		INNER JOIN departamento ON divisao.cod_dep = departamento.cod_dep
		INNER JOIN(
				   SELECT empregado.matr, COALESCE(SUM(vencimento.valor), 0) AS "salario"
				   FROM empregado
				   	    LEFT JOIN emp_venc ON empregado.matr = emp_venc.matr
					    LEFT JOIN vencimento ON emp_venc.cod_venc = vencimento.cod_venc
					    GROUP BY empregado.matr) AS "tipo_salario" ON empregado.matr = tipo_salario.matr
				    INNER JOIN(
                            SELECT empregado.matr, COALESCE(SUM(desconto.valor), 0) AS "descontos"
                            FROM empregado
							    LEFT JOIN emp_desc ON empregado.matr = emp_desc.matr
								LEFT JOIN desconto ON emp_desc.cod_desc = desconto.cod_desc
							GROUP BY empregado.matr) AS "tipo_descontos" ON empregado.matr = tipo_descontos.matr
                    WHERE divisao.cod_dep = 1 AND departamento.cod_dep = 1
				    GROUP BY divisao.cod_divisao, departamento.nome, divisao.nome
				    ORDER BY AVG(tipo_salario.salario - tipo_descontos.descontos) DESC
        LIMIT 1) AS "T"
UNION ALL
SELECT * FROM(
        SELECT departamento.nome, divisao.nome AS Divisao,
	    ROUND(AVG(tipo_salario.salario - tipo_descontos.descontos), 2) AS Media
	    FROM divisao
	        INNER JOIN empregado ON divisao.cod_divisao = empregado.lotacao_div
		    INNER JOIN departamento ON divisao.cod_dep = departamento.cod_dep
		    INNER JOIN(
                    SELECT empregado.matr, COALESCE(SUM(vencimento.valor), 0) AS "salario"
                    FROM empregado
                        LEFT JOIN emp_venc ON empregado.matr = emp_venc.matr
                        LEFT JOIN vencimento ON emp_venc.cod_venc = vencimento.cod_venc
                    GROUP BY empregado.matr) AS "tipo_salario" ON empregado.matr = tipo_salario.matr
            INNER JOIN(
                    SELECT empregado.matr,
					COALESCE(SUM(desconto.valor), 0) AS "descontos"
					FROM empregado
					    LEFT JOIN emp_desc ON empregado.matr = emp_desc.matr
						LEFT JOIN desconto ON emp_desc.cod_desc = desconto.cod_desc
				    GROUP BY empregado.matr) AS "tipo_descontos" ON empregado.matr = tipo_descontos.matr
                    WHERE divisao.cod_dep = 2 AND departamento.cod_dep = 2
		            GROUP BY divisao.cod_divisao, departamento.nome, divisao.nome
		            ORDER BY AVG(tipo_salario.salario - tipo_descontos.descontos) DESC
		LIMIT 1) AS "T"
UNION ALL
SELECT * FROM(
            SELECT departamento.nome, divisao.nome AS Divisao,
			    ROUND(AVG(tipo_salario.salario - tipo_descontos.descontos), 2) AS Media
			    FROM divisao
			        INNER JOIN empregado ON divisao.cod_divisao = empregado.lotacao_div
				    INNER JOIN departamento ON divisao.cod_dep = departamento.cod_dep
				    INNER JOIN(
				            SELECT empregado.matr, COALESCE(SUM(vencimento.valor), 0) AS "salario"
                            FROM empregado
							    LEFT JOIN emp_venc ON empregado.matr = emp_venc.matr
								LEFT JOIN vencimento ON emp_venc.cod_venc = vencimento.cod_venc
                            GROUP BY empregado.matr) AS "tipo_salario" ON empregado.matr = tipo_salario.matr
                    INNER JOIN(
                            SELECT empregado.matr, COALESCE(SUM(desconto.valor), 0) AS "descontos"
							FROM empregado
							 	LEFT JOIN emp_desc ON empregado.matr = emp_desc.matr
								LEFT JOIN desconto ON emp_desc.cod_desc = desconto.cod_desc
				    GROUP BY empregado.matr) AS "tipo_descontos" ON empregado.matr = tipo_descontos.matr
                WHERE divisao.cod_dep = 3 AND departamento.cod_dep = 3
			    GROUP BY divisao.cod_divisao, departamento.nome, divisao.nome
			    ORDER BY AVG(tipo_salario.salario - tipo_descontos.descontos) DESC
		LIMIT 1) AS "T"
	ORDER BY Media DESC;

/* Exercico 2993 */

SELECT amount FROM value_table GROUP BY amount HAVING COUNT(*) <= 12 ORDER BY COUNT(*) DESC LIMIT 1;

/* Exercico 2994 */

SELECT doctors.name, SUM(ROUND((attendances.hours * 150) * (1 + work_shifts.bonus / 100), 1)) AS "salary" FROM attendances
INNER JOIN doctors ON attendances.id_doctor = doctors.id
INNER JOIN work_shifts ON attendances.id_work_shift = work_shifts.id
GROUP BY doctors.name ORDER BY salary DESC;

/* OU */

SELECT doctors.name, ROUND(SUM(attendances.hours * 150 + work_shifts.bonus * 0.01 * attendances.hours * 150), 1)
AS "salary" FROM attendances
INNER JOIN doctors ON attendances.id_doctor = doctors.id
INNER JOIN work_shifts ON attendances.id_work_shift = work_shifts.id
GROUP BY doctors.name ORDER BY salary DESC;

/* Exercico 2995 */

SELECT temperature, COUNT(temperature) AS "number_of_records"
FROM records GROUP BY mark, temperature ORDER BY mark;

/* OU */

SELECT temperature, CONCAT(COUNT(mark)) AS "number_of_records"
FROM records GROUP BY mark, temperature ORDER BY mark;

/* Exercico 2996 */

SELECT packages.year, user_sender.name, user_receiver.name
FROM packages
INNER JOIN users user_sender ON packages.id_user_sender = user_sender.id
INNER JOIN users user_receiver ON packages.id_user_receiver = user_receiver.id
WHERE (packages.color = 'blue' OR packages.year = '2015')
AND user_sender.address != 'Taiwan'
AND user_receiver.address != 'Taiwan'
ORDER BY packages.year DESC;

/* OU */

SELECT packages.year, user_sender.name, user_receiver.name
FROM packages
INNER JOIN users user_sender ON packages.id_user_sender = user_sender.id AND user_sender.address NOT LIKE 'Taiw%'
INNER JOIN users user_receiver ON packages.id_user_receiver = user_receiver.id AND user_receiver.address NOT LIKE 'Taiw%'
WHERE packages.color LIKE 'blu%' OR packages.year = '2015'
ORDER BY packages.year DESC;

/* Exercico 2997 */

SELECT departamento.nome AS "Departamento", empregado.nome
AS "Empregado", t1.Salario_Bruto, t2.Total_Desconto, (t1.Salario_Bruto - t2.Total_Desconto)
AS Salario_Liquido
FROM empregado
		INNER JOIN departamento ON empregado.lotacao = departamento.cod_dep
		INNER JOIN(
			SELECT empregado.matr,
				COALESCE(SUM(vencimento.valor), 0) AS Salario_Bruto
			FROM empregado
					LEFT JOIN emp_venc ON empregado.matr = emp_venc.matr
					LEFT JOIN vencimento ON emp_venc.cod_venc = vencimento.cod_venc
			GROUP BY empregado.matr) AS t1 ON empregado.matr = t1.matr
		INNER JOIN(
			SELECT empregado.matr,
				COALESCE(SUM(desconto.valor), 0) AS Total_Desconto
			FROM empregado
					LEFT JOIN emp_desc ON empregado.matr = emp_desc.matr
					LEFT JOIN desconto ON emp_desc.cod_desc = desconto.cod_desc
			GROUP BY empregado.matr) AS t2 ON empregado.matr = t2.matr
GROUP BY empregado.matr, departamento.nome, empregado.nome, t1.Salario_Bruto, t2.Total_Desconto
ORDER BY(t1.Salario_Bruto - t2.Total_Desconto) DESC;

/* Exercico 2998 */

WITH running_operations_returns AS (
SELECT 
		clients.id,
		clients.name,
		clients.investment,
		operations.month,
		SUM(profit) OVER (PARTITION BY client_id ORDER BY operations.id) AS running_sum_of_profit,
		SUM(profit) OVER (PARTITION BY client_id ORDER BY operations.id) - clients.investment AS return
	FROM operations
	INNER JOIN clients
		ON operations.client_id = clients.id
	ORDER BY operations.client_id, operations.month
)
SELECT 
	payback_month_return.name,
	running_operations_returns.investment,
	running_operations_returns.month AS month_of_payback,
	payback_month_return.return
FROM (
	SELECT DISTINCT ON (id)
		name,
		investment,
		return
	FROM running_operations_returns
	WHERE return >= 0
) AS payback_month_return
INNER JOIN running_operations_returns
	USING (return )
ORDER BY return DESC;

/* Exercico 2999 */

WITH salarios AS (
	SELECT
		venc_agrupados.matr,
		venc_agrupados.lotacao_div,
		ROUND(SUM(total_vencimentos) - COALESCE(SUM(total_descontos), 0), 2) AS salario
	FROM (
		SELECT
			empregado.matr,
			empregado.lotacao_div,
			COALESCE(SUM(vencimento.valor), 0) AS total_vencimentos
		FROM empregado
		LEFT JOIN emp_venc
			ON empregado.matr = emp_venc.matr
		LEFT JOIN vencimento
			ON emp_venc.cod_venc = vencimento.cod_venc
		GROUP BY empregado.matr, empregado.lotacao_div
	) AS venc_agrupados
	LEFT JOIN (
		SELECT
			empregado.matr,
			empregado.lotacao_div,
			COALESCE(SUM(desconto.valor), 0) AS total_descontos
		FROM empregado
		LEFT JOIN emp_desc
			ON empregado.matr = emp_desc.matr
		LEFT JOIN desconto
			ON emp_desc.cod_desc = desconto.cod_desc
		GROUP BY empregado.matr, empregado.lotacao_div
	) AS desc_agrupados
	ON venc_agrupados.matr = desc_agrupados.matr
	GROUP BY venc_agrupados.matr, venc_agrupados.lotacao_div
),
	media_salarial_div AS (
		SELECT
			lotacao_div,
			AVG(salario) as salario_medio
		FROM salarios
		GROUP BY lotacao_div
)
SELECT 
	empregado.nome,
	salarios.salario
FROM salarios
INNER JOIN media_salarial_div
	ON salarios.lotacao_div = media_salarial_div.lotacao_div
	AND salarios.salario > media_salarial_div.salario_medio
	AND salarios.salario > 8000
INNER JOIN empregado
	ON salarios.matr = empregado.matr
ORDER BY salarios.lotacao_div;

/* Exercico 3001 */

SELECT products.name,
CASE WHEN products.type = 'A' THEN 20.0 ELSE
CASE WHEN products.type = 'B' THEN 70.0 ELSE
CASE WHEN products.type = 'C' THEN 530.5 ELSE 0 END END END AS "price"
FROM products
ORDER BY products.type, products.id DESC;