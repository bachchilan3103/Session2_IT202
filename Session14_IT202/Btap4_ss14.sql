-- dau vao: p_patient_id ma benh nhan, p_amount so tien thanh toan
-- dau ra: OUT p_message tbao trang thai gdich

-- chien luoc 1 Exception
-- don gian, nhung de gay ra loi am, kho kiem soat, kho de mo rong
-- chien luoc 2 ktra truoc
-- rat phuc tap, hieu qua trong vc chan du lieu, de kiem soat, de mo rong

-- luong xu li
-- nhan tham so dau vao
-- ktra so tien hop le
-- lay so du vi htai
-- neu so du nho hon so tien thi tra ve tbao loi va rollback
-- hop le thi START TRANSACTION
-- - tien trong vi va - cno benh nhan roi commit
-- tbao kqua thanh cong

DROP PROCEDURE IF EXISTS PayHospitalFee;
DELIMITER //
CREATE PROCEDURE PayHospitalFee(IN p_patient_id INT,IN p_amount DECIMAL(18,2),OUT p_message VARCHAR(100))
BEGIN
    DECLARE v_balance DECIMAL(18,2);
    IF p_amount <= 0 THEN
        SET p_message = 'So tien thanh toan k hop le';
        ROLLBACK;
    ELSE
        SELECT balance INTO v_balance
        FROM Wallets
        WHERE patient_id = p_patient_id;

        IF v_balance < p_amount THEN
            SET p_message = 'So du k du';
            ROLLBACK;
        ELSE
            START TRANSACTION;
                UPDATE Wallets
                SET balance = balance - p_amount
                WHERE patient_id = p_patient_id;

                UPDATE Patient_Invoices
                SET total_due = total_due - p_amount
                WHERE patient_id = p_patient_id;
            COMMIT;
            SET p_message = 'hoan tat thanh toan';
        END IF;
    END IF;
END //
DELIMITER ;

-- kiem thu 
CALL PayHospitalFee(1, 200000, @msg);
SELECT @msg;  

CALL PayHospitalFee(2, 200000, @msg);
SELECT @msg;  

CALL PayHospitalFee(1, -50000, @msg);
SELECT @msg; 



