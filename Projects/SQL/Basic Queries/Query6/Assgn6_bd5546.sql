-- Q1
DROP PROCEDURE IF EXISTS test;
DELIMITER //
CREATE PROCEDURE test ()
BEGIN
	DECLARE sql_err TINYINT DEFAULT FALSE;
	DECLARE CONTINUE HANDLER FOR NOT FOUND
		SET sql_err = TRUE;
	START TRANSACTION;
    DELETE FROM addresses WHERE musician_id = 8;
    DELETE FROM orders WHERE musician_id = 8;
    DELETE FROM musicians WHERE musician_id = 8; 
    
    IF sql_err = FALSE THEN
		COMMIT;
		SELECT 'committed' AS Transaction;
   ELSE
        ROLLBACK;
        SELECT 'rolled back' AS Transaction;
    END IF;
END //
DELIMITER ;

CALL test();

SELECT * FROM musicians
WHERE musician_id = 8;


-- Q2
DROP PROCEDURE IF EXISTS test2;
DELIMITER //
CREATE PROCEDURE test2 ()
BEGIN
    DECLARE order_id INT;
	DECLARE sql_err TINYINT DEFAULT FALSE;
	DECLARE CONTINUE HANDLER FOR NOT FOUND
		SET sql_err = TRUE;
	START TRANSACTION;
	INSERT INTO orders VALUES (DEFAULT, 3, NOW(), '10.00', '0.00', NULL, 4, 'American Express', '378282246310005', '04/2016', 4);     
	SELECT LAST_INSERT_ID() INTO order_id;
    INSERT INTO order_instruments VALUES(DEFAULT, order_id, 6, '415.00', '161.85', 1);
    INSERT INTO order_instruments VALUES(DEFAULT, order_id, 1, '699.00', '209.70', 1);
   
   IF sql_err = FALSE THEN
		COMMIT;
		SELECT 'committed' AS Transaction;
   ELSE
        ROLLBACK;
        SELECT 'rolled back' AS Transaction;
    END IF;
END //
DELIMITER ;

CALL test2();

-- Q3
DROP PROCEDURE IF EXISTS test3;
DELIMITER //
CREATE PROCEDURE test3 ()
BEGIN
	DECLARE sql_err TINYINT DEFAULT FALSE;
	DECLARE CONTINUE HANDLER FOR NOT FOUND
		SET sql_err = TRUE;
        
	START TRANSACTION;
    SELECT * FROM musicians WHERE musician_id = 6 FOR SHARE;
    
	UPDATE orders
    SET order_date = '2018-04-01 23:11:12', ship_amount = 15.00, tax_amount = 0.00,	
    ship_date = '2018-04-03 10:21:35', ship_address_id = 8, card_type = 'MasterCard', 
    card_number = 5555555555554444,	card_expires = '04/2019', billing_address_id = 8
    WHERE musician_id = 3;
    
	UPDATE addresses
    SET line1 = '23 Mountain View St.', line2 = '', city = 'Denver', state = 'CO',
    zip_code = 80208, phone = '303-912-3852'
    WHERE musician_id = 3;
    
	DELETE FROM addresses WHERE musician_id = 6;
    DELETE FROM orders WHERE musician_id = 6;
    DELETE FROM musicians WHERE musician_id = 6;
    
	IF sql_err = FALSE THEN
		COMMIT;
		SELECT 'committed' AS Transaction;
    ELSE
        ROLLBACK;
        SELECT 'rolled back' AS Transaction;
    END IF;
END //
DELIMITER ;

CALL test3();

SELECT * FROM musicians
WHERE musician_id = 6;
