CREATE DATABASE bt4_ss10;
USE bt4_ss10;

CREATE TABLE Pharmacy_Inventory (
    Inventory_ID INT AUTO_INCREMENT PRIMARY KEY,
    Drug_Name VARCHAR(255),
    Batch_Number VARCHAR(50),
    Expiry_Date DATE,
    Quantity INT
);

-- cach 1
CREATE INDEX idx_drug ON Pharmacy_Inventory(Drug_Name);
CREATE INDEX idx_expiry ON Pharmacy_Inventory(Expiry_Date);

-- cach 2
CREATE INDEX idx_drug_expiry ON Pharmacy_Inventory(Drug_Name, Expiry_Date);

SELECT * FROM Pharmacy_Inventory
WHERE Drug_Name = 'Paracetamol' AND Expiry_Date = '2026-12-31';
EXPLAIN SELECT * FROM Pharmacy_Inventory
WHERE Drug_Name = 'Paracetamol' AND Expiry_Date = '2026-12-31';

SELECT * FROM Pharmacy_Inventory
WHERE Drug_Name LIKE '%Para%';
-- % o dau chuoi lam cho mysql kh the dung index vi kbiet diem bat dau de tim

