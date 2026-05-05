SELECT *
FROM Orders
WHERE reason = 'KHACH_HUY'
   OR reason = 'QUAN_DONG_CUA'
   OR reason = 'KHONG_CO_TAI_XE'
   OR reason = 'BOM_HANG';
   
SELECT *
FROM Orders
WHERE reason IN ('KHANH_HUY', 'QUAN_DONG_CUA', 'KHONG_CO_TAI_XE', 'BOM_HANG');

-- o giai phap 1 co the thay dc neu muon sap xep 20 nguyen nhan thi se rat dai dong lap lai qua nhieu lan
-- rat kho de bao tri do cau lenh qua dai

-- o giai phap 2 ngan gon tiet kiem cog suc de doc de hieu va dat duoc hieu qua hon de bao tri hon
-- muon them gia tri chi can bo sung vao trong ngoac don trong danh sach boi vi IN dc dung de tap hop gia tri

-- cach tot nhat de kh bi loi la trc khi gui lenh xuong dtb thi minh ktra thu xem  mang co rong hay kh, neu rong thi chay sql con neu kh rong thi se gay nen loi cu phap IN
-- chot lai thi chta nen dung IN vi IN de dung va toi uu, tiet kiem thoi gian hon so voi gp1