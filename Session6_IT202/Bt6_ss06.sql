CREATE DATABASE bt6_ss06;
USE bt6_ss06;

-- GROUP BY: user_id, user_name, star_rating nvay thi 1 khach co the xuat hien dc o nhiu dong
-- vi cung 1 khach co the chi tieu o 2 khach san 4 va 5 sao nen se co 2 dong khac nhau

-- neu loc o WHERE: loai bo tu dau, giam du lieu phai gom lai thi hieu nang se tot hon
-- con neu loc o HAVING: gom xong moi loai bo thi ton dungluong hon vi phai xuli dulieu rac
-- cho nen dung WHERE la xin nhat

SELECT u.user_name, h.star_rating,
    SUM(b.total_price) as total_expenditure
FROM Users as u
JOIN Bookings as b 
ON u.user_id = b.user_id
JOIN Hotels as h 
ON b.hotel_id = h.hotel_id
WHERE b.status = 'COMPLETED' and b.total_price > 0
GROUP BY u.user_id, u.user_name, h.star_rating
HAVING SUM(b.total_price) > 50000000
ORDER BY h.star_rating DESC, total_expenditure DESC;