CREATE TABLE products (
    product_id VARCHAR(10),
    product_name VARCHAR(100),
    size VARCHAR(10),
    price INT
);

INSERT INTO products 
VALUES ('P01', 'Ao so mi trang', 'L', 250000);
INSERT INTO products 
VALUES ('P02', 'Quan jean xanh', 'M', 450000);
INSERT INTO products 
VALUES ('P03', 'Ao thun basic', 'XL', 150000);
INSERT INTO products 
VALUES ('P04', 'Ao hoodie', NULL, 200000);

UPDATE products
SET price = 400000
WHERE product_id = 'P02';

UPDATE products
SET price = price * 1.1;

DELETE FROM products
WHERE product_id = 'P03';

SELECT * FROM products;
SELECT product_name, size FROM products;

SELECT * FROM products
WHERE price > 300000;