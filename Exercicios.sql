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