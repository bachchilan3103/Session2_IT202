CREATE DATABASE bt5_ss06;
USE bt5_ss06;

-- cach 1  loai bo null va sua lai thanh IS NOT NULL
-- sua lai thanh WHERE room_id NOT IN (SELECT room_id FROM Bookings WHERE room_id IS NOT NULL)

-- cach 2 dung LEFT JOIN va IS NULL 
-- de lay tat ca phong tu bang rooms
-- chi giu lai nhung phong kco ban ghi trong bang bookings

SELECT r.room_id, r.room_name
FROM Rooms as r
LEFT JOIN Bookings as b 
ON r.room_id = b.room_id
WHERE b.room_id IS NULL;