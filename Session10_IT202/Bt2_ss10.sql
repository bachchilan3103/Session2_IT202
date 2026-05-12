CREATE DATABASE bt2_ss10;
USE bt2_ss10;

CREATE TABLE Patients (
    Patient_ID INT AUTO_INCREMENT PRIMARY KEY,
    Full_Name VARCHAR(100),
    Phone VARCHAR(20),
    Age INT,
    Address VARCHAR(100)
);

DELIMITER 
CREATE PROCEDURE SeedPatients()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 500000 DO
        INSERT INTO Patients (Full_Name, Phone, Age, Address)
        VALUES (
            CONCAT('Patient ', i),
            CONCAT('09', FLOOR(RAND() * 100000000)),
            FLOOR(RAND() * 90) + 10,
            'Ho Chi Minh City'
        );
        SET i = i + 1;
    END WHILE;
END 
DELIMITER ;

CALL SeedPatients();

EXPLAIN SELECT * FROM Patients WHERE Phone = '0912345678';

CREATE INDEX idx_phone ON Patients(Phone);

EXPLAIN SELECT * FROM Patients WHERE Phone = '0912345678';

DELIMITER 
CREATE PROCEDURE TestInsertWithIndex()
BEGIN
    DECLARE j INT DEFAULT 1;
    WHILE j <= 1000 DO
        INSERT INTO Patients (Full_Name, Phone, Age, Address)
        VALUES (
            CONCAT('NewPatient ', j),
            CONCAT('09', FLOOR(RAND() * 100000000)),
            FLOOR(RAND() * 90) + 10,
            'Ha Noi'
        );
        SET j = j + 1;
    END WHILE;
END //
DELIMITER ;

CALL TestInsertWithIndex();

DROP INDEX idx_phone ON Patients;

CALL TestInsertWithIndex();
