/* Exercicio 2602 */

SELECT name FROM customers WHERE state = 'RS';

/* Exercicio 2603 */

SELECT name, street FROM customers WHERE city = 'Porto Alegre';

/* Exercicio 2604 */

SELECT id, name FROM products WHERE price < 10 OR price > 100;

/* Exercicio 2605 */

SELECT products.name, providers.name FROM products
INNER JOIN providers ON providers.id = products.id_providers
WHERE products.id_categories = 6;

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