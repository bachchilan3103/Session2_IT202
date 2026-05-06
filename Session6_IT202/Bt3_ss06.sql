CREATE DATABASE bt3_ss06;
USE bt3_ss06;

SELECT 
    user_id,
    COUNT(*) AS total_order,
    SUM(CASE WHEN status = 'CANCELLED' THEN 1 ELSE 0 END) as order_canceled
FROM Bookings
GROUP BY user_id
HAVING COUNT(*) >= 10
   AND SUM(CASE WHEN status = 'CANCELLED' THEN 1 ELSE 0 END) > 5;