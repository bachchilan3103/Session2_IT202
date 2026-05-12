CREATE DATABASE IF NOT EXISTS bt6_ss10;
USE bt6_ss10;

CREATE TABLE patients(
	Patient_ID CHAR(5) PRIMARY KEY,
    Full_Name VARCHAR(100) NOT NULL,
    Admission_Time DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE vitals_Logs(
	Log_ID INT PRIMARY KEY AUTO_INCREMENT,
	Patient_ID CHAR(5),
	Heart_Rate INT CHECK (Heart_Rate > 0),
	Blood_Pressure VARCHAR(10),
	Record_Time DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (Patient_ID) REFERENCES patients(Patient_ID)
);

INSERT INTO patients
VALUES('BN001', 'Tran Van A', default),
('BN002', 'Tran Van B', default),
('BN003', 'Tran Van C', default),
('BN004', 'Tran Van D', default),
('BN005', 'Tran Van E', default);

INSERT INTO vitals_Logs (Patient_ID, Heart_Rate, Blood_Pressure, Record_Time) VALUES
-- Bệnh nhân BN001: Nhịp tim đang ổn định dần
('BN001', 95, '120/80', '2026-05-11 06:05:00'),
('BN001', 80, '118/75', '2026-05-11 07:00:00'), -- Đây là bản ghi mới nhất của BN001
-- Bệnh nhân BN002: Đang nguy kịch (Nhịp tim rất cao)
('BN002', 110, '130/85', '2026-05-11 06:20:00'),
('BN002', 135, '140/90', '2026-05-11 07:10:00'), -- Đây là bản ghi mới nhất của BN002 (CRITICAL)
-- Bệnh nhân BN003: Nhịp tim thấp (Cảnh báo nguy hiểm)
('BN003', 45, '90/60', '2026-05-11 07:05:00'), -- Đây là bản ghi mới nhất của BN003 (CRITICAL)
-- Bệnh nhân BN004: Bình thường
('BN004', 72, '120/80', '2026-05-11 07:15:00');
-- BN005: Không chèn dữ liệu để test trường hợp "Pending"
-- Ycau 2
CREATE INDEX idx_patient_record_time 
ON vitals_Logs (Patient_ID, Record_Time DESC);
-- Ycau 3
CREATE OR REPLACE VIEW ER_Dashboard_View AS
SELECT p.Patient_ID, p.Full_Name,
COALESCE(CAST(v.Heart_Rate as CHAR), 'Pending') as Heart_Rate,
CASE
	WHEN Heart_Rate > 120 OR Heart_Rate < 50 THEN 'CRITICAL'
    ELSE 'STABLE'
END as Urgency_Level
FROM patients as p
LEFT JOIN (
	SELECT *
    FROM vitals_Logs
    WHERE (Patient_ID, Record_Time) IN (
		SELECT Patient_ID, MAX(Record_Time)
        FROM vitals_Logs
        GROUP BY Patient_ID
    )
) as v
ON p.Patient_ID = v.Patient_ID;