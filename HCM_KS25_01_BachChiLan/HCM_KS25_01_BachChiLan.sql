CREATE DATABASE SalesManagement;
USE SalesManagement; 

CREATE TABLE product (
    productID INT AUTO_INCREMENT PRIMARY KEY,
    productname VARCHAR(255) NOT NULL,
    manufacturer VARCHAR(255) NOT NULL,
    price DECIMAL(12, 2) NOT NULL,
    stock INT
);

CREATE TABLE customer (
    customerID INT AUTO_INCREMENT PRIMARY KEY, 
    customername VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE,
    phonenumber VARCHAR(15) UNIQUE,
    addres VARCHAR(255)
);

CREATE TABLE orders (
    orderID INT AUTO_INCREMENT PRIMARY KEY,
    orderdate DATE NOT NULL,
    totalamount DECIMAL(12, 2) NOT NULL,
    customerID INT NOT NULL,
    FOREIGN KEY (customerID) REFERENCES customer(customerID)
);

CREATE TABLE orderdetail (
    orderID INT,
    productID INT,
    quantity INT NOT NULL,
    priceatorder DECIMAL(12, 2) NOT NULL,
    PRIMARY KEY (orderID, productID),
    FOREIGN KEY (orderID) REFERENCES orders(orderID),
	FOREIGN KEY (productID) REFERENCES product(productID)
);

ALTER TABLE orders
ADD note VARCHAR(255);

ALTER TABLE product
CHANGE manufacturer nhasanxuat VARCHAR(255);

DROP TABLE orderdetail;
DROP TABLE orders;

INSERT INTO product (productname, nhasanxuat, price, stock)
VALUES ('MacBook Air M2', 'Apple', 25000000, 10),
	   ('iPhone 14', 'Apple', 20000000, 15),
       ('SamSung Galaxy S23', 'SamSung', 18000000, 20),
       ('Asus ROG', 'Asus', 30000000, 5);

INSERT INTO customer (customername, email, phonenumber, address)
VALUES ('Nguyen Van A', 'a@gmail.com', 0123456789, 'HCM'),
	   ('Tran Thi B', 'b@gmail.com', NULL, 'HN'),
       ('Le Van C', 'c@gmail.com', 0987654321, 'BMT'),
       ('Pham Thi D', 'd@gmail.com', NULL, 'TH'),
       ('Hoang Van E', 'e@gmail.com', 0843224848, 'HP');

INSERT INTO orders (orderdate, totalamount, customerID)
VALUES ('2026-03-05', 45000000, 1),
	   ('2026-03-31', 20000000, 3),
       ('2026-04-17', 18000000, 4),
       ('2026-08-16', 22000000, 1),
       ('2026-09-29', 30000000, 3);

INSERT INTO oderdetail
VALUES (1, 1, 1, 20000000),
       (1, 2, 1, 60000000),
       (2, 2, 1, 19000000),
       (3, 3, 1, 30000000),
       (4, 4, 1, 18000000);

UPDATE product
SET price = price * 1.1
WHERE nhasanxuat = 'Apple';

DELETE FROM customer
WHERE Phone is NULL;

SELECT *
FROM product
WHERE price >= 10000000 AND price <= 20000000;

SELECT productID
FROM orderdetail
WHERE orderID = 1;
SELECT * 
FROM product
WHERE productID = 1;

SELECT productID
FROM product
WHERE productname = 'MacBook Air M2';
SELECT orderID
FROM orderdetail
WHERE productID = 1;
SELECT customerID
FROM orders
WHERE orderID = 1;
SELECT *
FROM customer
WHERE customerID = 1;
       