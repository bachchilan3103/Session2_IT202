CREATE TABLE cart_items (
    cartitems_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    product_id INT,
    quantity INT,
    addeddate DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnODB DEFAULT CHARSET=utf8mb4;

INSERT INTO cart_items (user_id, product_id, quantity)
VALUES (1, 101, 1);

SELECT * 
FROM cart_items
WHERE user_id = 1;

UPDATE cart_items
SET quantity = 5
WHERE user_id = 1;

DELETE FROM cart_items
WHERE user_id = 1;