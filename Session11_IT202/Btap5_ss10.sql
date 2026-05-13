CREATE DATABASE Btap5_ss11;
USE Btap5_ss11;

-- Procedure master IN patient_id,dept_id
-- OUT: new_bed_id, message
-- Procedure phu (FindEmptyBed) IN dept_id
-- OUT bed_id, dept_name
-- Master se goi phu, nhan kqa qua tham so OUT, roi qdinh tiep tuc hay kh

DROP PROCEDURE IF EXISTS FindEmptyBed;
DELIMITER //
CREATE PROCEDURE FindEmptyBed(IN p_dept_id INT, OUT p_bed_id INT, OUT p_dept_name VARCHAR(100))
BEGIN
    SELECT dept_name INTO p_dept_name
    FROM Departments
    WHERE dept_id = p_dept_id;
    SELECT bed_id INTO p_bed_id
    FROM Beds
    WHERE dept_id = p_dept_id AND patient_id IS NULL
    LIMIT 1;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS TransferBed;
DELIMITER //
CREATE PROCEDURE TransferBed(IN p_patient_id INT, IN p_dept_id INT, OUT p_new_bed_id INT, OUT p_message VARCHAR(200))
BEGIN
    DECLARE v_current_bed INT;
    DECLARE v_status VARCHAR(20);
    DECLARE v_dept_name VARCHAR(100);
    SELECT a.status INTO v_status
    FROM Appointments a
    WHERE a.patient_id = p_patient_id
    ORDER BY a.appointment_date DESC
    LIMIT 1;

    IF v_status = 'Completed' THEN
        SET p_new_bed_id = NULL;
        SET p_message = 'Benh nhan da xuat vien';
        LEAVE proc;
    END IF;

    CALL FindEmptyBed(p_dept_id, p_new_bed_id, v_dept_name);

    IF p_new_bed_id IS NULL THEN
        SET p_message = CONCAT('Tu choi', v_dept_name, ' da het giuong');
    ELSE
        SELECT bed_id INTO v_current_bed
        FROM Beds
        WHERE patient_id = p_patient_id;
        UPDATE Beds
        SET patient_id = NULL
        WHERE bed_id = v_current_bed;
        UPDATE Beds
        SET patient_id = p_patient_id
        WHERE bed_id = p_new_bed_id;
		SET p_message = 'Chuyen giuong thanh cong';
    END IF;
END //
DELIMITER ;

CALL TransferBed(1, 2, @new_bed, @msg);
SELECT @new_bed AS BedMoi, @msg AS ThongBao;

CALL TransferBed(2, 3, @new_bed, @msg);
SELECT @new_bed AS BedMoi, @msg AS ThongBao;

CALL TransferBed(2, 1, @new_bed, @msg);
SELECT @new_bed AS BedMoi, @msg AS ThongBao;

CALL TransferBed(1, 999, @new_bed, @msg);
SELECT @new_bed AS BedMoi, @msg AS ThongBao;






