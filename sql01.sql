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

SELECT 
	order_id,
	COUNT(customer_id),
	COUNT(product_id)
FROM orders
WHERE order_id IS NULL OR order_id = '';

SELECT
	strftime('%Y', order_date) as order_yr,
	ROUND(sum(sales),0) as total_sales,
	COUNT(*) as order_lines
FROM orders
GROUP BY order_yr
ORDER BY order_yr;

SELECT
	strftime('%Y-%m', order_date),
	ROUND(sum(sales),0) as total_sales,
	COUNT(*) as order_lines
FROM orders
GROUP BY order_date
ORDER BY order_date;

SELECT
	ROUND(AVG(julianday(ship_date) - julianday(order_date)),2),
	COUNT(*) as order_lines
FROM orders;

SELECT 
	SUM(CASE WHEN customer_id IS NULL OR customer_id = '' THEN 1 ELSE 0 END) AS blank_names,
	SUM(CASE WHEN product_id    IS NULL OR product_id    = '' THEN 1 ELSE 0 END) AS blank_products
FROM orders;

SELECT strftime('%Y-%m', order_date) AS order_month,
       ROUND(SUM(sales), 0) AS total_sales,
       COUNT(*) AS order_lines
FROM orders
GROUP BY order_month
ORDER BY order_month;

SELECT
	ship_mode,
	ROUND(AVG(julianday(ship_date) - julianday(order_date)),2) AS avg_ship_days
FROM orders
GROUP BY ship_mode
ORDER BY avg_ship_days;
SELECT 
	strftime('%m', order_date) as month,
	strftime('%Y-%m', order_date) as order_month,
	ROUND(SUM(sales),0) as toal_sales,
	ROUND(SUM(profit),0) as total_profit
FROM orders
GROUP BY order_month
ORDER BY order_month;

SELECT 
	strftime('%Y', order_date) as order_yr,
	ROUND(SUM(sales),0) as total_sales
from orders
GROUP BY order_yr
ORDER BY order_yr;

SELECT COUNT(*) FROM orders
WHERE ship_mode = 'Same Day' AND ship_date > order_date;

SELECT strftime('%m', order_date) AS month,
       ROUND(SUM(sales), 0)  AS total_sales,
       ROUND(SUM(profit), 0) AS total_profit
FROM orders
GROUP BY month
ORDER BY month;

SELECT strftime('%Y', order_date) AS yr,
       ROUND(SUM(sales) / COUNT(*), 0) AS avg_sale_per_line,
       ROUND(AVG(discount), 3) AS avg_discount
FROM orders
GROUP BY yr ORDER BY yr;

