SELECT * FROM orders LIMIT 10;
SELECT COUNT(*) FROM orders;
SELECT COUNT(*) FROM orders
WHERE order_id IS NULL OR order_id=' ';
DELETE FROM orders
WHERE order_id IS NULL OR order_id=' ';
SELECT COUNT(*) FROM orders;
-- The duplicate back?
SELECT order_id, product_name, sales, quantity, discount, profit, COUNT(*) AS n
FROM orders
GROUP BY order_id, product_name, sales, quantity, discount, profit
HAVING COUNT(*) > 1;
SELECT typeof(sales), typeof(discount), typeof(profit)
FROM orders LIMIT 1;
-- The duplicate back?
SELECT order_id, sales, quantity, discount, profit, COUNT(*) AS n
FROM orders
GROUP BY order_id, sales, quantity, discount, profit
HAVING COUNT(*) > 1;
SELECT COUNT(*) FROM orders
WHERE profit < 0;





SELECT COUNT(*) FROM orders
WHERE discount = 0;
SELECT COUNT(*) FROM orders
WHERE region = 'Central' AND discount > 0.2;
SELECT COUNT(*) FROM orders
WHERE category = 'Furniture' AND profit < 0;
SELECT COUNT(*) FROM orders
WHERE state = 'Texas' AND profit < 0;
SELECT order_id, product_name, discount, profit
FROM orders
WHERE discount >= 0.7;
SELECT order_id, product_name, discount, profit
FROM orders
WHERE discount >= 0.7;