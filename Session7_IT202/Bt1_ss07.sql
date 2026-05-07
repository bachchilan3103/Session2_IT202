CREATE DATABASE bt1_ss07;
USE bt1_ss07;

-- toan tu = la phep so sanh mot gia tri duy nhat voi mot gia tri khac
-- vi khi khop voi scalar subquery  chi tra ve 1 gia tri khi sluong > 1 gay ra sap hthong

SELECT *
FROM courses
WHERE price IN (
    SELECT DISTINCT price
    FROM courses
    WHERE instructor_id = 5
);