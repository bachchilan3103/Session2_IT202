USE RikkeiClinicDB;

DROP TRIGGER IF EXISTS PreventStatusRevert;

DELIMITER //
CREATE TRIGGER PreventStatusRevert
BEFORE UPDATE ON Appointments
FOR EACH ROW
BEGIN
    IF (OLD.status = 'Completed') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Lỗi: Không được phép thay đổi trạng thái của lịch khám đã hoàn thành';
    END IF;
END //
DELIMITER ;

UPDATE Appointments
SET status = 'Completed'
WHERE appointment_id = 104;

UPDATE Appointments
SET status = 'Cancelled'
WHERE appointment_id = 105;