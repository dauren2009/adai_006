DROP DATABASE IF EXISTS store_db;
CREATE DATABASE store_db;
USE store_db;

CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    age INT NOT NULL,
    city VARCHAR(50) DEFAULT 'Atyrau',
    CONSTRAINT chk_age CHECK (age >= 18)
);

CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    category VARCHAR(50),
    CONSTRAINT chk_price CHECK (price > 0)
);

CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    order_date DATE,
    status VARCHAR(30) DEFAULT 'Pending',
    CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES Products(product_id),
    CONSTRAINT chk_quantity CHECK (quantity > 0)
);

ALTER TABLE Customers
ADD phone VARCHAR(20);

ALTER TABLE Products
MODIFY category VARCHAR(100) NOT NULL;

ALTER TABLE Orders
CHANGE status order_status VARCHAR(30);

INSERT INTO Customers (full_name, email, age, city, phone) VALUES
('Dauren Saparov', 'dauren1@gmail.com', 19, 'Atyrau', '87011234567'),
('Aruzhan Nurlanova', 'aruzhan2@gmail.com', 20, 'Aktau', '87021234567'),
('Dias Mukhtar', 'dias3@gmail.com', 18, 'Almaty', '87031234567'),
('Aigerim Tolegen', 'aigerim4@gmail.com', 21, 'Astana', '87041234567'),
('Nursultan Bek', 'nursultan5@gmail.com', 22, 'Atyrau', '87051234567');

INSERT INTO Products (product_name, price, stock, category) VALUES
('Laptop', 350000.00, 10, 'Electronics'),
('Mouse', 5000.00, 50, 'Accessories'),
('Keyboard', 12000.00, 30, 'Accessories'),
('Monitor', 80000.00, 15, 'Electronics'),
('Headphones', 25000.00, 20, 'Audio');

INSERT INTO Orders (customer_id, product_id, quantity, order_date, order_status) VALUES
(1, 1, 1, '2026-03-10', 'Completed'),
(2, 2, 2, '2026-03-11', 'Pending'),
(3, 3, 1, '2026-03-12', 'Completed'),
(4, 4, 1, '2026-03-13', 'Pending'),
(5, 5, 3, '2026-03-14', 'Completed');

SHOW TABLES;

SELECT * FROM Customers;
SELECT * FROM Products;
SELECT * FROM Orders;

SELECT 
    Orders.order_id,
    Customers.full_name,
    Products.product_name,
    Orders.quantity,
    Orders.order_date,
    Orders.order_status
FROM Orders
JOIN Customers ON Orders.customer_id = Customers.customer_id
JOIN Products ON Orders.product_id = Products.product_id;