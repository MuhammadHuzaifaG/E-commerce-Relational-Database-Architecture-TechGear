-- DATABASE SCHEMA AND INITIALIZATION
CREATE DATABASE IF NOT EXISTS techgear_db;
USE techgear_db;
-- EMPLOYEE TABLE
DROP TABLE employees;
CREATE TABLE employees (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(40) NOT NULL,
    email VARCHAR(50) NOT NULL,
    gender enum('Male', 'Female', 'Other'),
    date_of_birth DATE,
    salary DECIMAL (10,2) DEFAULT 50000.00,
    manager_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_dob CHECK (date_of_birth < '2008-01-01' )
);
-- products TABLE
CREATE TABLE products (
	id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category enum('Laptops', 'Peripherals', 'Accessories', 'Softwares') NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL,
    CONSTRAINT chk_price CHECK ( price >= 0 ),
    CONSTRAINT chk_stock_quantity CHECK ( stock_quantity >= 0 )
);
-- CUSTOMERS TABLE
CREATE TABLE customers (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR (100) NOT NULL,
    email VARCHAR(40) UNIQUE NOT NULL,
    phone_number VARCHAR(19) NOT NULL,
	is_active BOOLEAN DEFAULT TRUE,
    joined_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- ORDERS TABLE
CREATE TABLE orders (
	order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT null,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status enum ('Pending', 'Shipped', 'Delivered', 'Cancelled'),
    total_amount DECIMAL (10, 2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
);
-- ORDER ITEMS TABLE
CREATE TABLE order_items (
	item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE RESTRICT
);
-- INDEXES (FOR BEST PERFORMANCE)
CREATE INDEX idx_emp_email ON employees(email);
CREATE INDEX idx_customer_active ON customers(is_active);
CREATE INDEX idx_product_category_price ON products(category, price);
-- 