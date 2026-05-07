CREATE DATABASE bt2_ss07;
USE bt2_ss07;

-- derived table la 1 bang tam thoi dc 
-- tao ra tu 1 subquery trong menh de from, sql coi sub trong from nhu 1 bang ao
-- cho nen bat buoc phai co bi danh

SELECT SUM(amount) AS total_VIPrevenue
FROM payments
WHERE student_id IN (
    SELECT student_id
    FROM payments
    GROUP BY student_id
    HAVING SUM(amount) > 10000000
);

