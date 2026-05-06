CREATE DATABASE bt2_ss06;
USE bt2_ss06;

SELECT hotel_id, MIN(price) AS gia_re_nhat
FROM Rooms
GROUP BY hotel_id;