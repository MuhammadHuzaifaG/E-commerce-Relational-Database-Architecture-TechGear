-- QUERIES, PROCEDURES, AND AUTOMATION

USE techgear_db;
SELECT 
	p.category,
    SUM(oi.quantity * oi.unit_price) as total_revenue,
    AVG(p.price) AS avg_product_price
FROM products p
LEFT JOIN order_items oi ON p.id = oi.product_id
GROUP BY p.category
HAVING total_revenue > 0 or total_revenue IS NULL;

SELECT category, SUM(stock_quantity) AS total_stocks
from products
GROUP BY category WITH ROLLUP ;

SELECT 
	o.order_id,
	c.name AS customer_name,
    p.product_name,
    oi.quantity,
    oi.unit_price
FROM orders o
INNER JOIN customers c ON o.customer_id=c.id
INNER JOIN order_items oi ON o.order_id = oi.order_id
INNER JOIN products p On oi.product_id =p.id;

-- SELF JOIN
SELECT 
	emp.name AS employee_name,
    emp.salary,
    mgr.name AS manager_name
FROM employees emp
LEFT JOIN employees mgr ON emp.manager_id = mgr.id;

-- SUBQUERIES & UNION
SELECT id, name, email
FROM customers WHERE id IN (
	SELECT o.customer_id
    from orders o
    INNER JOIN order_items.oi ON o.order_id = oi.order_id
    WHERE oi.unit_price > 100
);
SELECT name, email, 'Employee' AS stakeholder_type
from employees UNION
SELECT name, email, 'Customer' AS stakeholder_type from customers
ORDER BY name;

-- view
CREATE VIEW high_value_pending_orders
SELECT
	o.order_id,
    o.total_amount,
    o.order_date
FROM orders o
INNER JOIN customers c on o.customer_id = c.id
WHERE o.status ='Pending' AND o.total_amount > 10.0

-- TRANSACTIONS
SET autocommit = 0;
UPDATE products 
	 SET stock_quantity = stock_quantity - 2
     WHERE id = 3 AND stock_quantity >= 2;
INSERT INTO orders (cutomer_id, status, total_amount)
	VALUES(3, 'Pending', '90');
COMMIT;
SET autocommit = 1;
-- PROCEDURE
DELIMITER $$
CREATE PROCEDURE ReStockProduct(
	IN p_product_id INT,
    IN p_quantity_added INT
)
BEGIN
	UPDATE products
    SET stock_quantity = stock_quantity + p_quantity_added
    WHERE id = p_product_id;
END $$
DELIMITER ;
CALL ReStockProduct(1, 50);
-- TRIGGERS
CREATE TABLE price_audit_log (
	log_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    old_price DECIMAL(10, 2),
    new_price DECIMAL (10,2),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
DELIMITER $$
CREATE TRIGGER after_price_update
	AFTER UPDATE ON products
    FOR EACH ROW
    BEGIN
		IF OLD.price <> NEW.price then
			INSERT INTO price_audit_log (product_id, old_price, new_price)
            VALUES (OLD.id, OLD.price, NEW.price);
		END IF;
    END $$
DELIMITER ;
-- TEST TRIGGER
UPDATE products SET price = 1120 WHERE id = 1;
SELECT * FROM product_audit_log;