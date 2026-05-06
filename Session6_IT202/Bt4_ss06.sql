CREATE DATABASE bt4_ss06;
USE bt4_ss06;

-- cach 1 gom nhom tca don hang theo hotel_id gom ca don loi va huy
-- sau do dung HAVING de ktra so luong don thanh cong(status = 'COMPLETED') doanh thu trung binh

-- cach 2 dung WHERE status = 'COMPLETED' de loai bo ngay tu dau cac don huy va loi
-- sau đó gom GROUP BY hotel_id
-- dung HAVING de ktra so luong don ≥ 50, doanh thu trung bình > 3000000

-- cach 1 thi giup gom tat ca don thanh cong, loi, huy
-- hieu qua cao nhung tinh toan nhieu qua muc can thiet cua bai, ton nhieu du lieu va dug luong
-- hoi kho doc va cung co the hoi de nham lan

-- cach 2 chi lay nhung don thanh cong, hieu nang nhe hon va xu li nhanh hon
-- ro rang de doc hon va de bao quan code hon

SELECT 
    hotel_id,
    COUNT(*) AS total_order_done,
    AVG(total_price) AS average_revenue
FROM Bookings
WHERE status = 'COMPLETED'
GROUP BY hotel_id
HAVING COUNT(*) >= 50
   AND AVG(total_price) > 3000000;