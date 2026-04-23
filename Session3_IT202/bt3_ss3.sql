CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50),
    last_purchase_date DATE,
    status VARCHAR(20),
    gender VARCHAR(10),
    date_of_birth DATE,
    points INT,
    address VARCHAR(255)
);

INSERT INTO customers (full_name, email, city, last_purchase_date, status) 
VALUES ('Nguyen Van A', 'anv@gmail.com', 'Ha Noi', '2025-05-20', 'Active'),
       ('Tran Thi B', 'btt@gmail,com', 'Ha Noi', '2026-02-10', 'Active'),
       ('Le Van C', NULL, 'Ha Noi', '2025-01-15', 'Active'),
       ('Pham Minh D', 'dpm@gmail.com', 'Ha Noi', '2024-12-01', 'Locked'),
       ('Hoang An E', 'eha@gmail.com', 'TP HCM', '2025-03-01', 'Active');

SELECT full_name, email
FROM customers
WHERE status = 'Active';