USE btth3;

CREATE TABLE sach (
    masach INT AUTO_INCREMENT PRIMARY KEY,
    tensach VARCHAR(100),
    theloai VARCHAR(50),
    giaban INT,
    namxuatban INT
);

CREATE TABLE khachhang (
    maKH INT PRIMARY KEY,
    tenKH VARCHAR(100),
    email VARCHAR(100)
);

INSERT INTO sach 
VALUES (1, 'Sherlock Holmes', 'Trinh thám', 90000, 2018),
       (2, 'Doraemon', 'Thiếu nhi', 50000, 2021),
       (3, 'Conan', 'Trinh thám', 120000, 2019),
       (4, 'Harry Potter', 'Giả tưởng', 200000, 2015),
       (5, 'Trinh thám 1', 'Trinh thám', 80000, 2017);

INSERT INTO khachhang 
VALUES (1, 'Nguyen Van A', 'a@gmail.com'),
       (2, 'Tran Thi B', 'b@yahoo.com'),
       (3, 'Le Van C', 'c@gmail.com'),
       (4, 'Pham Thi D', 'd@hotmail.com');

SELECT *
FROM sach
WHERE theloai = 'Trinh thám' AND giaban < 100000;

SELECT *
FROM khachhang
WHERE email = 'example@gmail.com';

SELECT *
FROM sach;

SET SQL_SAFE_UPDATES = 0;
UPDATE sach
SET giaban = giaban * 0.9
WHERE namxuatban < 2020;