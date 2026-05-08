CREATE DATABASE Miniproject_ss08;
USE Miniproject_ss08;

CREATE TABLE Customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    gender TINYINT NOT NULL,
    cus_date DATE NOT NULL
);

CREATE TABLE Category (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Product (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(150) NOT NULL,
    price DECIMAL(12, 2) NOT NULL CHECK (price > 0),
    category_id INT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES Category(category_id)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

CREATE TABLE Order_Detail (
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK(quantity > 0),
    unit_price DECIMAL(12,2) NOT NULL CHECK(unit_price > 0),
    PRIMARY KEY(order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

INSERT INTO Customer(full_name, email, gender, birth_date)
VALUES ('Nguyen Van A', 'a@gmail.com', 1, '2000-05-10'),
       ('Tran Thi B', 'b@gmail.com', 0, '1998-09-21'),
       ('Le Van C', 'c@gmail.com', 1, '2003-01-15'),
       ('Pham Thi D', 'd@gmail.com', 0, '1995-12-11'),
       ('Hoang Van E', 'e@gmail.com', 1, '2001-07-30');

INSERT INTO Category(category_name)
VALUES ('Điện tử'),
       ('Thời trang'),
	   ('Gia dụng'),
	   ('Sách'),
	   ('Thể thao');

INSERT INTO Product(product_name, price, category_id)
VALUES ('iPhone 15', 25000000, 1),
       ('Laptop Dell', 22000000, 1),
       ('Áo Hoodie', 500000, 2),
       ('Nồi cơm điện', 1200000, 3),
       ('Giày thể thao', 1500000, 5),
       ('Sách SQL', 300000, 4),
       ('Tai nghe Bluetooth', 800000, 1);

INSERT INTO Orders(customer_id, order_date)
VALUES (1, '2025-01-10'),
       (2, '2025-01-15'),
	   (1, '2025-02-01'),
	   (3, '2025-02-18'),
       (5, '2025-03-05');

INSERT INTO Order_Detail(order_id, product_id, quantity, unit_price)
VALUES (1, 1, 1, 25000000),
       (1, 7, 2, 800000),
       (2, 3, 3, 500000),
       (3, 2, 1, 22000000),
	   (3, 6, 2, 300000),
       (4, 5, 1, 1500000),
       (5, 4, 1, 1200000);

UPDATE Product
SET price = 26000000
WHERE product_name = 'iPhone 15';

UPDATE Customer
SET email = 'newemail@gmail.com'
WHERE customer_id = 1;

DELETE FROM Order_Detail
WHERE order_id = 5
AND product_id = 4;

SELECT full_name as 'Họ tên',
    email as 'Email',
    CASE
        WHEN gender = 1 THEN 'Nam'
        ELSE 'Nữ'
    END as 'Giới tính'
FROM Customer;

SELECT full_name, 
YEAR(now()) - YEAR(birth_date) as age
FROM Customer
ORDER BY age ASC
LIMIT 3;

SELECT o.order_id, c.full_name, o.order_date
FROM Orders o
INNER JOIN Customer c
ON o.customer_id = c.customer_id;

SELECT c.category_name,
COUNT(p.product_id) as total_products
FROM Category c
INNER JOIN Product p
ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name
HAVING COUNT(p.product_id) >= 2;

SELECT product_name, price
FROM Product
WHERE price >
(
    SELECT AVG(price)
    FROM Product
);

SELECT full_name, email
FROM Customer
WHERE customer_id NOT IN
(
    SELECT customer_id
    FROM Orders
);

SELECT c.category_name,
SUM(od.quantity * od.unit_price) as revenue
FROM Category c
INNER JOIN Product p
ON c.category_id = p.category_id
INNER JOIN Order_Detail od
ON p.product_id = od.product_id
GROUP BY c.category_id, c.category_name
HAVING SUM(od.quantity * od.unit_price) >
(
    SELECT AVG(total_revenue) * 1.2
    FROM
    (
        SELECT
            SUM(od2.quantity * od2.unit_price) as total_revenue
        FROM Category c2
        INNER JOIN Product p2
        ON c2.category_id = p2.category_id
        INNER JOIN Order_Detail od2
        ON p2.product_id = od2.product_id
        GROUP BY c2.category_id
    ) as temp
);

SELECT p.product_name, p.price, c.category_name
FROM Product p
INNER JOIN Category c
ON p.category_id = c.category_id
WHERE p.price =
(
    SELECT MAX(p2.price)
    FROM Product p2
    WHERE p2.category_id = p.category_id
);

SELECT DISTINCT full_name
FROM Customer
WHERE customer_id IN
(
    SELECT customer_id
    FROM Orders
    WHERE order_id IN
    (
        SELECT order_id
        FROM Order_Detail
        WHERE product_id IN
        (
            SELECT product_id
            FROM Product
            WHERE category_id =
            (
                SELECT category_id
                FROM Category
                WHERE category_name = 'Điện tử'
            )
        )
    )
);