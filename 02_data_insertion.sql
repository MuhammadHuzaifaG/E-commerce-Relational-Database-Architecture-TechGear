USE techgear_db;

-- INSERT DATA INTO TABLES
-- Inserting Employees 
INSERT INTO employees (name, email, gender, date_of_birth, salary, manager_id)
VALUES
	('Alice Admin', 'alice@techgear.com', 'Female', '1985-04-12', 95000.00, NULL),
	('Bob Builder', 'bob@techgear.com', 'Male', '1990-11-23', 60000.00, 1),
	('Charlie Chaplin', 'charlie.c@techgear.com', 'Other', '1995-02-17', 55000.00, 1),
	('diana prince', 'diana@techgear.com', 'Female', '1992-08-09', 45000.00, 2),
	('Evan Wright', 'evan.w@techgear.com', 'Male', '1988-07-22', 82000.00, 1),
	('Fiona Gallagher', 'fiona.g@techgear.com', 'Female', '1993-01-15', 78000.00, 1),
	('George Costanza', 'george.c@techgear.com', 'Male', '1980-05-10', 58000.00, 2),
	('Hannah Abbott', 'hannah.a@techgear.com', 'Female', '1997-11-30', 52000.00, 2),
	('Ian Malcolm', 'ian.m@techgear.com', 'Male', '1975-03-24', 95000.00, NULL),
	('Julia Styles', 'julia.s@techgear.com', 'Female', '1999-09-09', 48000.00, 9),
	('Kevin Hart', 'kevin.h@techgear.com', 'Male', '1984-12-12', 61000.00, 9);

-- Inserting Customers 
INSERT INTO customers (name, email, phone_number, is_active)
 VALUES
	('John Doe', 'john.doe@example.com', '555-1234', TRUE),
	('Jane Smith', 'JANE.SMITH@EXAMPLE.COM', '555-1234', FALSE),
	('Test User', 'test@test.com', '000-0000', TRUE),
	('Mike Johnson', 'mike.j@example.com', '555-9876', TRUE),
	('Rachel Green', 'rachel.g@example.com', '555-2001', TRUE),
	('Ross Geller', 'ross.g@example.com', '555-2002', FALSE),
	('Monica Geller', 'monica.g@example.com', '555-2003', TRUE),
	('Chandler Bing', 'chandler.b@example.com', '555-2004', TRUE),
	('Joey Tribbiani', 'joey.t@example.com', '555-2005', TRUE),
	('Phoebe Buffay', 'phoebe.b@example.com', '555-1234', TRUE),
	('Gunther Central', 'gunther.c@example.com', '555-2007', FALSE);

-- Inserting Products
INSERT INTO products (product_name, category, price, stock_quantity) 
VALUES
	('ProBook X1', 'Laptops', 1200.00, 50),
	('Mechanical Keyboard', 'Peripherals', 150.00, 200),
	('Wireless Mouse', 'Peripherals', 45.00, 150),
	('USB-C Hub', 'Accessories', 25.00, 300),
	('Antivirus License', 'Software', 60.00, 1000),
	('Gaming Laptop Max (RTX 4090)', 'Laptops', 2500.00, 15),
	('UltraSlim Ultrabook 14"', 'Laptops', 1400.00, 30),
	('Ergonomic Office Chair', 'Accessories', 250.00, 45),
	('Noise Cancelling Headphones', 'Peripherals', 300.00, 80),
	('4K IPS Monitor 27-inch', 'Peripherals', 450.00, 40),
	('Graphic Design Suite (1Yr Sub)', 'Software', 299.00, 500),
	('Cloud Storage 1TB (Annual)', 'Software', 120.00, 1000),
	('Webcam 1080p HD', 'Peripherals', 80.00, 120),
	('USB-C Braided Cable 6ft', 'Accessories', 15.00, 400),
	('Laptop Cooling Pad', 'Accessories', 35.00, 85);

-- Inserting Orders
INSERT INTO orders (customer_id, status, total_amount) VALUES
	(1, 'Delivered', 1350.00),
	(2, 'Pending', 45.00),
	(4, 'Shipped', 85.00),
	(5, 'Delivered', 2500.00),   
	(7, 'Pending', 750.00),      
	(8, 'Shipped', 450.00),      
	(9, 'Delivered', 120.00),    
	(10, 'Cancelled', 15.00),    
	(6, 'Pending', 1700.00),     
	(11, 'Shipped', 334.00);     

-- Inserting Order Items
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 1200.00),
(1, 2, 1, 150.00),
(2, 3, 1, 45.00),
(3, 4, 1, 25.00),
(3, 5, 1, 60.00),
(4, 6, 1, 2500.00),
(5, 10, 1, 450.00),
(5, 9, 1, 300.00),
(6, 10, 1, 450.00),
(7, 12, 1, 120.00),
(8, 14, 1, 15.00),
(9, 7, 1, 1400.00),
(9, 9, 1, 300.00),
(10, 11, 1, 299.00),
(10, 15, 1, 35.00);