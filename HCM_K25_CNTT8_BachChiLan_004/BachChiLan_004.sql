CREATE DATABASE HCM_K25_CNTT8_BachChiLan_004;
USE HCM_K25_CNTT8_BachChiLan_004;

-- Phan 1
-- Tao bang
CREATE TABLE Readers(
reader_id INT AUTO_INCREMENT PRIMARY KEY,
full_name VARCHAR(10) NOT NULL,
email CHAR(30) NOT NULL UNIQUE,
phone_number CHAR(20) NOT NULL UNIQUE,
created_at DATE DEFAULT (CURRENT_DATE)
);

CREATE TABLE Membership_Details(
card_id VARCHAR(15) PRIMARY KEY,
reader_id INT,
FOREIGN KEY reader_id REFERENCES Membership_Details(reader_id),
card_rank VARCHAR(10),
expiry_date DATE NOT NULL,
citizen_id CHAR(15) NOT NULL UNIQUE
);

CREATE TABLE Categories(
category_id INT AUTO_INCREMENT PRIMARY KEY,
category_name VARCHAR(15) NOT NULL UNIQUE,
description TEXT NOT NULL
);

CREATE TABLE Books(
book_id INT AUTO_INCREMENT PRIMARY KEY,
title VARCHAR(20) NOT NULL UNIQUE,
author CHAR (15) NOT NULL,
category_id INT,
FOREIGN KEY category_id REFERENCES Categories(category_id),
price DECIMAL(12, 2) NOT NULL CHECK (price > 0),
stock_quantity INT NOT NULL CHECK (stock_quantity >= 0)
);

CREATE TABLE Loan_Records(
loan_id CHAR(5) PRIMARY KEY,
reader_id INT,
book_id INT,
FOREIGN KEY reader_id REFERENCES Loan_Records(reader_id),
FOREIGN KEY book_id REFERENCES Books(book_id),
borrow_date DATE NOT NULL,
due_date DATE NOT NULL CHECK(due_date > borrow_date),
return_date DATE
);

-- Chen du lieu
INSERT INTO Readers
VALUES (1, 'Nguyen Van A', 'anv@gmail.com', '901234567', '2022/1/15'),
	   (2, 'Tran Thi B', 'btt@gmail.com', '912345678', '2022/5/20'),
       (3, 'Le Van C', 'cle@yahoo.com', '922334455', '2023/2/10'),
       (1, 'Pham Minh D', 'dpham@hotmail.com', '933445566', '2023/11/5'),
       (1, 'Hoang Anh E', 'ehoang@gmail.com', '944556677', '2023/1/12');
       
INSERT INTO Membership_Details
VALUES ('CARD-001', 1, 'Standard', '2025/1/15', '123456789'),
       ('CARD-002', 2, 'VIP', '2025/5/20', '234567890'),
       ('CARD-003', 3, 'Standard', '2024/2/10', '345678901'),
       ('CARD-004', 4, 'VIP', '2025/11/5', '456789012'),
       ('CARD-005', 5, 'Standard', '2026/1/12', '567890123');
       
INSERT INTO Categories
VALUES (1, 'IT', 'Sach ve cong nghe thong tin va lap trinh'),
       (2, 'Kinh Te', 'Sach kinh doanh, tai chinh, khoi nghiep'),
       (3, 'Van Hoc', 'Tieu thuyet, truyen ngan, tho'),
       (4, 'Ngoai Ngu', 'Sach hoc tieng Anh, Nhat, Han'),
       (5, 'Lich Su', 'Sach nghien cuu lich su, van hoa');
       
INSERT INTO Books
VALUES (1, 'Clean Code', 'Robert C.Martin', 1, '450000', 10),
       (2, 'Dac Nhan Tam', 'Dale Carnegie', 2, '150000', 50),
       (3, 'Harry Potter 1', 'J.K. Rowling', 3, '250000', 5),
       (4, 'IELTS', 'Cambridge', 4, '180000', 0),
       (5, 'Dai Viet Su Ky', 'Le Van Huu', 5, '300000', 20);
       
INSERT INTO Loan_Records
VALUES ('101', 1, 1, '2023/11/15', '2023/11/22', '2023/11/20'),
       ('102', 2, 2, '2023/12/1', '2023/12/8', '2023/12/5'),
       ('103', 1, 3, '2024/1/10 ', '2024/1/17', 'NULL'),
       ('104', 3, 4, '2023/5/20', '2023/5/27', 'NULL'),
       ('105', 4, 1, '2023/1/18', '2024/1/25', 'NULL');
       
UPDATE TABLE Loan_Records
SET due_date = '2024/1/24'
WHERE loan_id = '103';

DELETE FROM Loan_Records 
WHERE return_date IS NOT NULL AND borrow_date < '10/2023';

-- Phan 2
-- Cau 1
SELECT (book_id, title, price) 
FROM Books
WHERE category_id = 1 AND price > 200000;

-- Cau 2
SELECT (reader_id, full_name, email)
FROM Readers
WHERE created_at LIKE '2022%' AND email LIKE '%@gmail.com';

-- Cau 3
SELECT *
FROM Books
ORDER BY price DESC
LIMIT 4 OFFSET 2;

-- Phan 3
-- Cau 1
SELECT 

-- Cau 3
SELECT r.full_name, b.books
FROM Readers AS r
JOIN Books AS b
WHERE card_rank = 'VIP' AND price > 300000;

-- Phan 4
-- Cau 1
CREATE INDEX idx_loan_dates
ON Loan_Records (borrow_date, return_date);
   
-- Cau 2
CREATE VIEW vw_overdue_loans AS



       

