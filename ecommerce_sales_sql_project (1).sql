-- Ecommerce Sales Database System

CREATE DATABASE ecommerce_db;
USE ecommerce_db;

-- Customers Table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    city VARCHAR(50)
);

-- Products Table
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    stock INT
);

-- Orders Table
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Order Details Table
CREATE TABLE order_details (
    order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    subtotal DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Sample Data
INSERT INTO customers (name, email, city) VALUES
('Ankit Kumar', 'ankit@gmail.com', 'Muzaffarpur'),
('Rahul Sharma', 'rahul@gmail.com', 'Delhi');

INSERT INTO products (product_name, category, price, stock) VALUES
('Luxury Candle', 'Candles', 499, 50),
('Royal Oud Perfume', 'Perfume', 899, 30),
('Gift Hamper', 'Gifting', 1299, 20);

INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, '2026-05-01', 1398),
(2, '2026-05-02', 1299);

INSERT INTO order_details (order_id, product_id, quantity, subtotal) VALUES
(1, 1, 1, 499),
(1, 2, 1, 899),
(2, 3, 1, 1299);

-- Complex Query 1: Total revenue
SELECT SUM(total_amount) AS total_revenue FROM orders;

-- Complex Query 2: Top selling products
SELECT p.product_name, SUM(od.quantity) AS total_sold
FROM order_details od
JOIN products p ON od.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC;

-- Complex Query 3: Customer purchase history
SELECT c.name, o.order_id, o.total_amount
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;

-- Complex Query 4: Low stock products
SELECT product_name, stock
FROM products
WHERE stock < 25;
