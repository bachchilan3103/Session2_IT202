-- giai phap 1: doi luon kieu du lieu
ALTER TABLE users 
MODIFY phone VARCHAR(15);
 
-- giai phap 2: tao cot moi
ALTER TABLE users 
ADD phone_new VARCHAR(15);

-- giai phap 1 don gian nhanh de lam hon
-- giai phap 2 an toan ve cau truc nhung chua xu li dc du lieu cu

-- chot giai phap van la giai phap 1 toi uu, nhanh, don gian hon