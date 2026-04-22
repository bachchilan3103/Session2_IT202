CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
	full_name VARCHAR(100),
    email VARCHAR(100) NOT NULL,
    age INT CHECK (age >= 0),
    CONSTRAINT ab_email UNIQUE (email)
);