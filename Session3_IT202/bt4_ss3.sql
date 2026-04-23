CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100),
    order_date DATETIME,
    total_amount DECIMAL(18,2),
    status VARCHAR(20),
    IsDeleted TINYINT(1) DEFAULT 0
) ENGINE=InnODB DEFAULT CHARSET=utf8mb4;

INSERT INTO orders (customer_name, order_date, total_amount, status) 
VALUES ('Nguyen Van A', '2023-10-10', 500000, 'Completed'),
       ('Khach hang vang lai', '2023-08-15', 1200000, 'Canceled'),
       ('Tran Thi B', '2023-05-20', 300000, 'Canceled'),
       ('Le Van C', '2024-01-05', 850000, 'Completed');
 
SET SQL_SAFE_UPDATES = 0;     
UPDATE orders
SET IsDeleted = 1
WHERE status = 'Canceled';

SELECT * FROM orders
WHERE IsDeleted = 0;

SELECT * FROM orders
WHERE status = 'Canceled';