CREATE DATABASE bt3_ss07;
USE bt3_ss07;

-- NOT IN bat hthong phai dung toan bo tap hop student_id tu bang payments
-- roi so sanh voi hoc vien trong studens, du lieu lon anh huong den hieu nang
-- neu NULL kqua con sai nua

-- NOT EXISTS truy van long, tung hoc vien chi ktra co ton tai trong gdich trong 2024 hay kh
-- neu tim thay thi se dung ctrinh ma kh can duyet toan bo bang cho nen se toi uu hieu nang hon
 
-- cho nen dung NOT EXISTS la ok nhat

SELECT s.email
FROM Students as s
WHERE NOT EXISTS (
    SELECT 1
    FROM Payments p
    WHERE p.student_id = s.id
      AND year(p.payment_date) = 2024
);