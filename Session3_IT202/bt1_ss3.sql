CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    original_price DECIMAL(18, 2)
);

INSERT INTO products (product_id, product_name, category, original_price)
VALUES (1, 'iPhone 15', 'Electronics', 20000000),
       (2, 'Samsung Refrigerator', 'Electronics', 15000000),
       (3, 'Water Spinach', 'Food', 10000),
       (4, 'Filtered Fresh Milk 4', 'Food', 28000);

SET SQL_SAFE_UPDATES = 0;       
UPDATE products
SET original_price = original_price * 0.9
WHERE category = 'Electronics';