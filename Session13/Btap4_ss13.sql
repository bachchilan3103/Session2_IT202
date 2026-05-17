USE RikkeiClinicDB;

DROP TRIGGER IF EXISTS PreventDoctorDoubleBooking_Insert;
DROP TRIGGER IF EXISTS PreventDoctorDoubleBooking_Update;

DELIMITER //
CREATE TRIGGER PreventDoctorDoubleBooking_Insert
BEFORE INSERT ON Appointments
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1
        FROM Appointments
        WHERE doctor_id = NEW.doctor_id
          AND appointment_date = NEW.appointment_date
          AND status <> 'Cancelled'
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Lỗi: Bác sĩ đã có lịch hẹn vào khung giờ này';
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER PreventDoctorDoubleBooking_Update
BEFORE UPDATE ON Appointments
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1
        FROM Appointments
        WHERE doctor_id = NEW.doctor_id
          AND appointment_date = NEW.appointment_date
          AND status <> 'Cancelled'
          AND appointment_id <> OLD.appointment_id
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Lỗi: Bác sĩ đã có lịch hẹn vào khung giờ này';
    END IF;
END //
DELIMITER ;

-- kiem thu
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status)
VALUES (200, 1, 101, '2026-08-01 09:00:00', 'Pending');

INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status)
VALUES (201, 2, 101, '2026-06-10 08:30:00', 'Pending');

INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status)
VALUES (202, 3, 101, '2026-05-02 10:00:00', 'Pending');

UPDATE Appointments
SET status = 'Completed'
WHERE appointment_id = 104;
