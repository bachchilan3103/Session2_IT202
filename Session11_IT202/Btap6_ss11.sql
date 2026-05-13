CREATE DATABASE Btap6_ss11;
USE Btap6_ss11;

-- IN patient_id INT, medicine_id INT, quantity INT, discount_code VARCHAR(20)
-- OUT message VARCHAR(200)
-- Vi hthong chi can tra ve tbao trang thai, ta sdung OUT de xuat ket qua

-- Bien cuc bo stock de luu so luong ton kho htai
-- price de luu don gia thuoc
-- amount de luu so tien sau khi tinh toan

CREATE TABLE IF NOT EXISTS Medicines (
    medicine_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(18,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS Patient_Invoices (
    patient_id INT PRIMARY KEY,
    total_due DECIMAL(18,2) NOT NULL DEFAULT 0,
    last_updated DATETIME DEFAULT CURRENT_TIMESTAMP
);

DROP PROCEDURE IF EXISTS ProcessPrescription;
DELIMITER //
CREATE PROCEDURE ProcessPrescription(
    IN p_patient_id INT,
    IN p_medicine_id INT,
    IN p_quantity INT,
    IN p_discount_code VARCHAR(20),
    OUT p_message VARCHAR(200)
)
BEGIN
    DECLARE v_stock INT;
    DECLARE v_price DECIMAL(18,2);
    DECLARE v_amount DECIMAL(18,2);
    
    SELECT stock, price INTO v_stock, v_price
    FROM Medicines
    WHERE medicine_id = p_medicine_id;

    IF v_stock IS NULL THEN
        SET p_message = 'Thuoc khong ton tai';
    ELSEIF p_quantity > v_stock THEN
        SET p_message = 'Kho khong du thuoc';
    ELSE
        UPDATE Medicines
        SET stock = stock - p_quantity
        WHERE medicine_id = p_medicine_id;

        SET v_amount = p_quantity * v_price;

        IF p_discount_code = 'NV-RIKKEI' THEN
            SET v_amount = v_amount * 0.5;
        END IF;

        UPDATE Patient_Invoices
        SET total_due = total_due + v_amount,
            last_updated = CURRENT_TIMESTAMP
        WHERE patient_id = p_patient_id;

        SET p_message = 'Da xu li don thuoc';
    END IF;
END //
DELIMITER ;

CALL ProcessPrescription(1, 1, 2, NULL, @msg);
SELECT @msg AS ThongBao;

CALL ProcessPrescription(1, 1, 2, 'NV-RIKKEI', @msg);
SELECT @msg AS ThongBao;

CALL ProcessPrescription(2, 2, 10, NULL, @msg);
SELECT @msg AS ThongBao;






