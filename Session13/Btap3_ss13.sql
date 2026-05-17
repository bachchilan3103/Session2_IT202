USE RikkeiClinicDB;

CREATE TABLE Price_Changes_Log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    medicine_id INT NOT NULL,
    old_price DECIMAL(18,2) NOT NULL,
    new_price DECIMAL(18,2) NOT NULL,
    change_type VARCHAR(20) NOT NULL,
    difference DECIMAL(18,2) NOT NULL,
    changed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (medicine_id) REFERENCES Medicines(medicine_id)
);

DROP TRIGGER IF EXISTS TrackMedicinePriceChanges;

DELIMITER //
CREATE TRIGGER TrackMedicinePriceChanges
BEFORE UPDATE ON Medicines
FOR EACH ROW
BEGIN
    IF (NEW.price <= 0) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Lỗi: Giá thuốc mới không hợp lệ';
    END IF;

    IF (NEW.price <> OLD.price) THEN
        IF (NEW.price > OLD.price) THEN
            INSERT INTO Price_Changes_Log (medicine_id, old_price, new_price, change_type, difference)
            VALUES (OLD.medicine_id, OLD.price, NEW.price, 'TĂNG GIÁ', NEW.price - OLD.price);
        ELSE
            INSERT INTO Price_Changes_Log (medicine_id, old_price, new_price, change_type, difference)
            VALUES (OLD.medicine_id, OLD.price, NEW.price, 'GIẢM GIÁ', OLD.price - NEW.price);
        END IF;
    END IF;
END //
DELIMITER ;

UPDATE Medicines SET price = 20000 WHERE medicine_id = 1;
UPDATE Medicines SET price = 10000 WHERE medicine_id = 1;
UPDATE Medicines SET stock = 150 WHERE medicine_id = 1;
UPDATE Medicines SET price = -5000 WHERE medicine_id = 1;

SELECT * FROM Price_Changes_Log;
