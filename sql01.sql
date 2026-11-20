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
SELECT COUNT(*) FROM orders
WHERE category = 'Furniture' OR category = 'Technology' AND profit < 0;
SELECT product_name, profit
FROM orders
ORDER BY region ASC, profit DESC   -- DESC = largest first; ASC (default) = smallest first
LIMIT 5;
SELECT DISTINCT region FROM orders;
SELECT COUNT(DISTINCT order_id) FROM orders;  -- number of unique orders
SELECT count(*) FROM orders
--WHERE discount BETWEEN 0.21 AND 0.4;
WHERE order_date BETWEEN '2017-01-01' AND '2017-12-31';
SELECT order_id, product_name, sales 
FROM orders
ORDER BY sales DESC
LIMIT 10;
SELECT order_id, product_name, sales, profit 
FROM orders
ORDER BY profit
LIMIT 10;
SELECT DISTINCT region FROM orders;
SELECT COUNT(DISTINCT customer_id) FROM orders;
SELECT COUNT(DISTINCT order_id) FROM orders;
SELECT COUNT(DISTINCT sub_category) FROM orders;
SELECT order_id, product_name, profit from orders
WHERE product_name like '%letter opener%';
SELECT DISTINCT product_name from orders
WHERE product_name like '%letter opener%';
SELECT order_id, product_name, profit from orders
WHERE product_name like '%chair%';
SELECT count(*) from orders
WHERE region IN ('West', 'East');
SELECT count(*) from orders
WHERE state IN ('Texas', 'Illinois', 'North Carolina', 'Ohio', 'Pennsylvania')
AND profit < 0;
SELECT count(*) from orders
WHERE discount BETWEEN 0.21 AND 0.4;
SELECT order_id,product_name,profit 
FROM orders
WHERE order_date BETWEEN '2017-01-01' AND '2017-12-31'
ORDER BY profit
LIMIT 5;
SELECT DISTINCT product_name, sub_category
FROM orders
WHERE product_name LIKE '%chair%' AND sub_category = 'Chairs';
SELECT order_id, product_name, discount, round(profit, 0)
FROM orders
WHERE order_date BETWEEN '2017-01-01' AND '2017-12-31'
ORDER BY profit
LIMIT 5;
SELECT order_id, product_name, discount, profit
FROM orders
WHERE order_date BETWEEN '2017-01-01' AND '2017-12-31'
ORDER BY profit
LIMIT 5;
SELECT DISTINCT product_name, sub_category
FROM orders
WHERE product_name LIKE '%chair%' AND sub_category = 'Chairs';
SELECT COUNT(*) FROM orders WHERE sub_category = 'Chairs';
SELECT COUNT(*) FROM orders
WHERE product_name LIKE '%chair%' AND sub_category <> 'Chairs';
SELECT COUNT(*) FROM orders
WHERE sub_category = 'Chairs' AND product_name LIKE '%chair%';
-- The 126 extras: what are they?
SELECT DISTINCT product_name, sub_category
FROM orders
WHERE product_name LIKE '%chair%' AND sub_category <> 'Chairs';

-- The 42 missed: which chairs lack "chair" in the name?
SELECT DISTINCT product_name
FROM orders
WHERE sub_category = 'Chairs' AND product_name NOT LIKE '%chair%';

SELECT sub_category, ROUND(SUM(profit), 0) AS total_profit
FROM orders
GROUP BY sub_category
HAVING SUM(profit) < 0;
SELECT
  CASE
    WHEN discount = 0    THEN '0%'
    WHEN discount <= 0.2 THEN '1–20%'
    WHEN discount <= 0.4 THEN '21–40%'
	WHEN discount <= 1   THEN 'Over 40%'
    ELSE 'CHECK'
  END AS discount_band,
  COUNT(*) AS order_lines,
  SUM(CASE WHEN profit < 0 THEN 1 ELSE 0 END) AS loss_lines
FROM orders
GROUP BY discount_band;

SELECT sub_category, ROUND(SUM(profit), 0) AS total_profit
FROM orders
GROUP BY sub_category
HAVING SUM(profit) < 0;

