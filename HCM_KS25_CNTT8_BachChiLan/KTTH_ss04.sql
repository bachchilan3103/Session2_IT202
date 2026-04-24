CREATE TABLE categories(
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE products(
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    price DECIMAL(12, 2) NOT NULL,
    stock INT NOT NULL DEFAULT 0 CHECK (stock >=0),
    category_id INT NOT NULL,
    CONSTRAINT FOREIGN KEY(category_id) REFERENCES categories(category_id)
);

INSERT INTO categories (category_name)
VALUES ('Điện tử'), 
	   ('Thời trang');
       
INSERT INTO products (product_name, price, stock, category_id)
VALUES ('iPhone 15', 250000000, 10, 1),
       ('Samsung S23', 20000000, 5, 1),
       ('Áo sơ mi nam', 500000, 50, 2),
       ('Giày thể thao', 1200000, 20, 2);
       
UPDATE products
SET price = 26000000
WHERE product_id = 1;

UPDATE products
SET stock = stock + 10
WHERE category_id = 1;

DELETE FROM products
WHERE product_id = 4;

SET SQL_SAFE_UPDATES = 0;
DELETE FROM products
WHERE price < 1000000;

SELECT * FROM products
WHERE stock > 15; 

SELECT * FROM products
WHERE price >= 1000000 AND price <= 25000000;

SELECT * FROM products
WHERE product_name <> 'iPhone15' AND stock > 0;

SELECT * FROM products
WHERE category_id <> 1 AND price > 500000;


