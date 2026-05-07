CREATE DATABASE bt5_ss07;
USE bt5_ss07;

-- Scalar Subquery la truy van tra ve 1 gia tr duy nhat
-- khi dat trong menh de SELECT, moi dong cua bang chinh 
-- dc tinh toan them 1 cot dua tren gia tri duy nhat do
-- Scalar Subquery cho phep xem chi tiet
-- vua xem trung binh toan san trong cung 1 cau lenh

SELECT 
    c.title,
    c.price,
    c.price - (SELECT AVG(price) FROM Courses)
    as Price_Difference
FROM Courses as c;
