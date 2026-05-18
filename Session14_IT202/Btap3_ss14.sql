-- dau vao: p_patient_id  ma benh nhan, p_medicine_id ma thuoc, p_quantity so luong can cap
-- dau ra: 1 chuoi tbao trang thai (OUT p_message VARCHAR) de tra kqua

-- dung START TRANSACTIOn de bat dau gdich
-- ktra so luong ton kho cua thuoc
-- neu ton kho nho hon so luong ycauu thi rollback va tra ve tbao loi
-- neu du ton kho thi - kho va + no benh nhan sau do COMMIT
-- dung tham so OUT de tra ve tbao trang thai

DROP PROCEDURE IF EXISTS DispenseMedicine;
DELIMITER //
CREATE PROCEDURE DispenseMedicine(IN p_patient_id INT,IN p_medicine_id INT,IN p_quantity INT,OUT p_message VARCHAR(100)
)
BEGIN
    DECLARE v_stock INT;
    DECLARE v_price DECIMAL(18,2);
    SELECT stock, price INTO v_stock, v_price
    FROM Medicines
    WHERE medicine_id = p_medicine_id;

    IF v_stock < p_quantity THEN
        SET p_message = 'So luong ton kho kh du';
        ROLLBACK;
    ELSE
        START TRANSACTION;
            UPDATE Medicines
            SET stock = stock - p_quantity
            WHERE medicine_id = p_medicine_id;

            UPDATE Patient_Invoices
            SET total_due = total_due + (v_price * p_quantity)
            WHERE patient_id = p_patient_id;
        COMMIT;
        SET p_message = 'Da cap phat thanh cong';
    END IF;
END //
DELIMITER ;

-- kiem thu 
CALL DispenseMedicine(1, 1, 10, @msg);
SELECT @msg;
CALL DispenseMedicine(2, 2, 10, @msg);
SELECT @msg;




