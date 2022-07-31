-- Q1
SELECT category_name, COUNT(instrument_name) AS instruments_count, MAX(list_price) AS most_expensive
FROM categories c 
JOIN instruments i
	ON c.category_id = i.category_id
GROUP BY category_name
ORDER BY instruments_count DESC;

-- Q2
SELECT email_address, SUM(item_price * quantity) AS total_price, SUM(discount_amount * quantity) AS total_discount
FROM musicians m
JOIN orders o 
	ON o.musician_id = m.musician_id
JOIN order_instruments oi 
	ON o.order_id = oi.order_id
GROUP BY email_address
ORDER BY total_price DESC;

-- Q3
SELECT email_address, COUNT(oi.order_id) AS count, SUM((item_price - discount_amount)*quantity) AS total
FROM musicians m
JOIN orders o 
	ON o.musician_id = m.musician_id
JOIN order_instruments oi
	ON o.order_id = oi.order_id
GROUP BY email_address
HAVING COUNT(oi.order_id) > 1
ORDER BY total DESC;

-- Q4
SELECT email_address, COUNT(oi.order_id) AS count, SUM((item_price - discount_amount)*quantity) AS total
FROM musicians m
JOIN orders o 
	ON o.musician_id = m.musician_id
JOIN order_instruments oi
	ON o.order_id = oi.order_id
WHERE item_price>400
GROUP BY email_address
HAVING COUNT(oi.order_id) > 1
ORDER BY total DESC;

-- Q5
SELECT instrument_name, SUM((item_price - discount_amount)*quantity) AS total
FROM instruments i
JOIN order_instruments oi
	ON i.instrument_id = oi.instrument_id
GROUP BY instrument_name WITH ROLLUP;

-- Q6
SELECT email_address, COUNT(DISTINCT oi.instrument_id) AS total_products
FROM musicians m
JOIN orders o 
	ON o.musician_id = m.musician_id
JOIN order_instruments oi
	ON o.order_id = oi.order_id
GROUP BY email_address
HAVING COUNT(DISTINCT oi.instrument_id)>1
ORDER BY email_address;

-- Q7
SELECT IF(GROUPING(category_name) = 1, 'Grand Total', category_name) AS 'Category Name', 
IF(GROUPING(instrument_name) = 1, 'Category Total', instrument_name) AS 'Instrument Name', SUM(quantity) AS Quantity
FROM categories c
JOIN instruments i
	ON c.category_id = i.category_id
JOIN order_instruments oi
	ON i.instrument_id = oi.instrument_id
GROUP BY category_name, instrument_name WITH ROLLUP;

-- Q8
SELECT order_id,(item_price - discount_amount) AS total_amt,
SUM((item_price - discount_amount)*quantity) OVER (PARTITION BY order_id) AS order_amt
FROM order_instruments
ORDER BY order_id ASC;

-- Q9
SELECT order_id,(item_price - discount_amount) AS total_amt,
SUM((item_price - discount_amount)*quantity) OVER (PARTITION BY order_id) AS order_amt,
AVG((item_price - discount_amount)*quantity) OVER (PARTITION BY order_id) AS avg_order_amt
FROM order_instruments
ORDER BY order_id ASC, total_amt;

-- Q10
SELECT m.musician_id, o.order_date, (item_price - discount_amount)*quantity AS item_total,
SUM((item_price - discount_amount)*quantity) OVER (PARTITION BY musician_id) AS musician_total,
SUM((item_price - discount_amount)*quantity) OVER (PARTITION BY order_date) AS total_by_date
FROM musicians m
JOIN orders o
	ON m.musician_id = o.musician_id
JOIN order_instruments oi
	ON o.order_id = oi.order_id
ORDER BY musician_id, order_date;
