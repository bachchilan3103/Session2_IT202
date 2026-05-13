CREATE DATABASE Btap3_ss11;
USE Btap3_ss11;

-- dau vao: tong chi phi, dien benh nhanh
-- dau ra: so tien cuoi cung phai thu, tbao trang thai
DROP PROCEDURE IF EXISTS CalculateFinalPayment;

DELIMITER //
CREATE PROCEDURE CalculateFinalPayment(IN p_total_cost DECIMAL(18,2), IN p_patient_type VARCHAR(20), OUT p_final_amount DECIMAL(18,2), OUT p_message VARCHAR(100))
BEGIN
    IF p_total_cost <= 0 THEN
        SET p_final_amount = 0;
        SET p_message = 'Chi phi kh hop le';
    ELSE
        CASE p_patient_type
            WHEN 'BHYT' THEN
                SET p_final_amount = p_total_cost * 0.2;
                SET p_message = 'Da tinh toan xong';
            WHEN 'VIP' THEN
                SET p_final_amount = p_total_cost * 0.9;
                SET p_message = 'Da tinh toan xong';
            WHEN 'THUONG' THEN
                SET p_final_amount = p_total_cost;
                SET p_message = 'Da tinh toan xong';
            ELSE
                SET p_final_amount = 0;
                SET p_message = 'Dien benh nhan khong hop le';
        END CASE;
    END IF;
END //
DELIMITER ;

-- lenh kiem thu
CALL CalculateFinalPayment(1000000, 'BHYT', @final, @msg);
SELECT @final AS SoTienPhaiThu, @msg AS ThongBao;
CALL CalculateFinalPayment(1000000, 'VIP', @final, @msg);
SELECT @final AS SoTienPhaiThu, @msg AS ThongBao;
CALL CalculateFinalPayment(1000000, 'THUONG', @final, @msg);
SELECT @final AS SoTienPhaiThu, @msg AS ThongBao;
CALL CalculateFinalPayment(-500000, 'BHYT', @final, @msg);
SELECT @final AS SoTienPhaiThu, @msg AS ThongBao;

