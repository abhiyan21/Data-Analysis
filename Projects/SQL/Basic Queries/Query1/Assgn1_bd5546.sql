-- Q1
SELECT instrument_name, list_price, date_added
FROM instruments
WHERE list_price BETWEEN  500 AND 2000
ORDER BY date_added DESC;


-- Q2
SELECT item_id, item_price, discount_amount, quantity,
item_price * quantity AS price_total,
discount_amount * quantity AS discount_total,
(item_price - discount_amount) * quantity AS item_total
FROM order_instruments
WHERE (item_price - discount_amount) * quantity > 500
ORDER BY item_total DESC;


-- Q3
SELECT CURDATE();

SELECT now(), date_format(now(), '%m/%d/%y') AS 'MM/DD/YY';

SELECT now(), date_format(now(), '%e-%b-%Y') AS 'DD-Mon-YYYY';

SELECT now(), date_format(now(), '%m/%y') AS 'mm-yyyy';

SELECT now(), date_format(now(), '%d/%m/%y') AS 'Dd/mm/yy';

SELECT now(), date_format(now(), '%eth %b %Y') AS 'doth month yyyy';


-- Q4
SELECT first_name, last_name, line1, city, state, zip_code, email_address
FROM musicians
INNER JOIN addresses ON musicians.musician_id = addresses.musician_id
WHERE musicians.email_address = 'david.goldstein@hotmail.com';


-- Q5
SELECT first_name, last_name, line1, city, state, zip_code, email_address
FROM musicians
INNER JOIN addresses ON musicians.musician_id = addresses.musician_id
AND addresses.address_id = musicians.billing_address_id;


-- Q6
SELECT m.last_name, m.first_name, o.order_date, i.instrument_name,
oi.item_price, oi.discount_amount, oi.quantity
FROM musicians AS m
JOIN orders AS o ON o.musician_id = m.musician_id
JOIN order_instruments AS oi ON oi.order_id = o.order_id
JOIN instruments AS i ON i.instrument_id = oi.instrument_id
ORDER BY last_name, order_date, instrument_name;


-- Q7
SELECT i1.instrument_name, i1.list_price
FROM instruments AS i1
JOIN instruments AS i2 ON i1.instrument_id <> i2.instrument_id
AND i1.list_price = i2.list_price
ORDER BY instrument_name;


-- Q8
SELECT 'SHIPPED' AS ship_status, order_id, order_date
FROM orders
WHERE ship_date IS NOT NULL
UNION
SELECT 'NOT SHIPPED', order_id, order_date 
FROM orders
WHERE ship_date IS NULL
ORDER BY order_date;