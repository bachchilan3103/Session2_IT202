CREATE DATABASE bt1_ss06;
USE bt1_ss06;

SELECT city, SUM(total_price) AS revenue
FROM Bookings
GROUP BY city
HAVING SUM(total_price) > 0;