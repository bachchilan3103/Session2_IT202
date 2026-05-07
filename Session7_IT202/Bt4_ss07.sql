CREATE DATABASE bt4_ss07;
USE bt4_ss07;

-- logic boolean SQL, NOT IN (1, 2, NULL)
-- SQL se ktra xem no co = bat ki ptu nao trong tap (1, 2, NULL)hay la kh
-- khi gap NULL, phep so sanh = NULL tra ve UNKNOWN
-- toan bo NOT IN se tro thanh UNKNOWN neu trong tap co chua NULL
-- dan den moi dong ben ngoai se bi bo qua 

-- cach 1 co the thay = notin va loc null
SELECT c.course_id, c.course_name
FROM Courses as c
WHERE c.course_id NOT IN (
    SELECT e.course_id
    FROM Enrollments as e
    WHERE e.course_id IS NOT NULL
);
-- cach 2 dung not exists 
SELECT c.course_id, c.course_name
FROM Courses as c
WHERE NOT EXISTS (
    SELECT 1
    FROM Enrollments as e
    WHERE e.course_id = c.course_id
);