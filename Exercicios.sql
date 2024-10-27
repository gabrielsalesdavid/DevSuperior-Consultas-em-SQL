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