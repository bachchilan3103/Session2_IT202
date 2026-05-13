CREATE DATABASE Btap2_ss11;
USE Btap2_ss11;

CALL AddInventory(10, -500);
-- udp kh ktra gia tri am nen khi nhap so am thi he thong se tru vao hang ton kho
-- gay nen tinh trang mat hang trong kho

DELIMITER //
CREATE PROCEDURE AddInventory(IN p_item_id INT, IN p_quantity INT)
BEGIN
    IF p_quantity > 0 THEN
        UPDATE Inventory
        SET stock_quantity = stock_quantity + p_quantity
        WHERE item_id = p_item_id;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'So luong nhap kho phai lon hon 0';
    END IF;
END //
DELIMITER ;

CALL AddInventory(10, 200);
CALL AddInventory(10, -500);
