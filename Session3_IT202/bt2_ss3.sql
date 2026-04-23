CREATE TABLE shippers ( 
    shipper_id INT PRIMARY KEY AUTO_INCREMENT, 
    shipper_name VARCHAR( 255), 
    phone VARCHAR(20 ) 
);

INSERT INTO shippers (shipper_name, phone)
VALUES ( 'Giao hàng nhanh', '0901234567' );

INSERT INTO shippers (shipper_name, phone)
VALUES ( 'Viettel Post' , '0123456789' );