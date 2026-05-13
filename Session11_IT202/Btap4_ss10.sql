CREATE DATABASE Btap4_ss11;
USE Btap4_ss11;

-- IN thi ta dung cho ma benh nhan va sdt
-- OUT dung cho tong so no va trang thai

-- giai phap 1 ta co the dung if/esle de doc de sua code nhung lai qua dai dong
-- giai phap 2 dung where ngan gon chi can dung select nhung phai coi ki truong hop NULL
-- van nen sai cach 1 

DROP PROCEDURE IF EXISTS GetPatientDebt;

DELIMITER //
CREATE PROCEDURE GetPatientDebt(IN p_patient_id INT, IN p_phone VARCHAR(15), OUT p_total_due DECIMAL(18,2), OUT p_message VARCHAR(100))
BEGIN
    DECLARE v_due DECIMAL(18,2);

    IF p_patient_id IS NULL AND p_phone IS NULL THEN
        SET p_total_due = 0;
        SET p_message = 'Lỗi: Phải nhập ID hoặc Phone';
    ELSE
        IF p_patient_id IS NOT NULL THEN
            SELECT total_due INTO v_due
            FROM Patient_Invoices pi
            JOIN Patients p ON pi.patient_id = p.patient_id
            WHERE p.patient_id = p_patient_id;
        ELSE
            SELECT total_due INTO v_due
            FROM Patient_Invoices pi
            JOIN Patients p ON pi.patient_id = p.patient_id
            WHERE p.phone = p_phone;
        END IF;

        IF v_due IS NULL THEN
            SET p_total_due = 0;
            SET p_message = 'Không tìm thấy bệnh nhân';
        ELSE
            SET p_total_due = v_due;
            SET p_message = 'Đã tra cứu thành công';
        END IF;
    END IF;
END //
DELIMITER ;

CALL GetPatientDebt(1, NULL, @debt, @msg);
SELECT @debt AS TongNo, @msg AS ThongBao;

CALL GetPatientDebt(NULL, '0912222333', @debt, @msg);
SELECT @debt AS TongNo, @msg AS ThongBao;

CALL GetPatientDebt(NULL, NULL, @debt, @msg);
SELECT @debt AS TongNo, @msg AS ThongBao;

CALL GetPatientDebt(999, NULL, @debt, @msg);
SELECT @debt AS TongNo, @msg AS ThongBao;




