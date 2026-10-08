-- DATA CLEANING & SCHEMA MODIFICATIONS
-- initial data preparation
USE techgear_db;
SET SQL_SAFE_UPDATES = 0;
UPDATE employees
	SET name = 'Diana Prince' WHERE email ='diana@techgear.com';

UPDATE customers
	SET email = LOWER(email) WHERE email = 'JANE@JANE.COM';

DELETE FROM customers
	WHERE email = 'test@test.com' OR name = 'test_user';
    
UPDATE employees 
	SET salary = salary + 5000 WHERE salary < 50000 ;
    
ALTER TABLE customers
	ADD COLUMN loyalty_points INT DEFAULT 1 AFTER phone_number;
    
alter TABLE products
	modify column product_name VARCHAR(255) NOT NULL;
SET SQL_SAFE_UPDATES = 1;