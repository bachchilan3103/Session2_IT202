-- Atomicity trong giao dich bat buoc
-- phai thanh cong tat ca hoac kh co cai nao duoc chay het

DROP PROCEDURE IF EXISTS TransferBed;
DELIMITER //
CREATE PROCEDURE TransferBed(IN p_patient_id INT, IN p_new_bed_id INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Giao dịch thất bại, đã hoàn tác!';
    END;
    START TRANSACTION;
    UPDATE Beds 
    SET patient_id = NULL 
    WHERE patient_id = p_patient_id;

    UPDATE Beds 
    SET patient_id = p_patient_id 
    WHERE bed_id = p_new_bed_id;
    COMMIT;
END //
DELIMITER ;

-- kiem thu
CALL TransferBed(1, 201);
CALL TransferBed(2, 999);

SELECT * FROM Beds;



