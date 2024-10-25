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