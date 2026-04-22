CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(200) NOT NULL
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATE DEFAULT (CURRENT_DATE),
    total_amount DECIMAL(10,2) NOT NULL,
    customer_id INT NOT NULL,
    
    FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id)
);