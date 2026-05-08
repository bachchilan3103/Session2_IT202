CREATE DATABASE CompanyDB;
USE CompanyDB;

CREATE TABLE Department (
    dept_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    dept_name VARCHAR(100) NOT NULL,
    location VARCHAR(100)
);

CREATE TABLE Employee (
    emp_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    emp_name VARCHAR(100) NOT NULL,
    gender INT DEFAULT 1,
    birth_date DATE,
    salary DECIMAL(12, 2) CHECK (salary >= 0),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

CREATE TABLE Project (
    pro_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    pro_name VARCHAR(150) NOT NULL,
    emp_id INT, 
    start_date DATE DEFAULT (current_date),
    end_date DATE,
    FOREIGN KEY (emp_id) REFERENCES Employee(emp_id)
);

ALTER TABLE Employee
ADD Email VARCHAR(100) UNIQUE;

ALTER TABLE Project
MODIFY pro_name VARCHAR(200);

ALTER TABLE Project
ADD CONSTRAINT ck_pro
CHECK (end_date IS NULL OR (end_date >= start_date));

INSERT INTO Department
VALUES (1, 'IT', 'Ha Noi'),
       (2, 'HR', 'HCM'),
       (3, 'Marketing', 'Da Nang');
       
INSERT INTO Employee
VALUES (1, 'Nguyen Van A', 1, '1990-01-15', 1500, 1, 'a@gmail.com'),
	   (2, 'Tran Thi B', 0, '1995-05-20', 1200, 1, 'b@gmail.com'),
       (3, 'Le Minh C', 1, '1988-10-10', 2000, 2, 'c@gmail.com'),
	   (4, 'Pham Thi D', 0, '1992-12-05', 1800, 3, 'd@gmail.com');

INSERT INTO Project
VALUES (101, 'Website Redesign', 1, '2024-01-01', '2024-06-01'),
       (102, 'Recruitment System', 3, '2024-02-01', '2024-08-01'),
       (103, 'Marketing Campaign', 4, '2024-03-01', NULL);
       
UPDATE Employee 
SET salary = salary + 200 
WHERE dept_id = 1;

SET SQL_SAFE_UPDATES = 0;
UPDATE Project 
SET end_date = '2024-12-31' 
WHERE end_date IS NULL;

DELETE FROM Project 
WHERE start_date < '2024-02-01';






 