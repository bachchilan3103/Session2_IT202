create database products_management;
use products_management;

create table products(
	pro_id char(5) primary key,
    pro_name varchar(100) not null,
    pro_price decimal(10, 2) not null,
    pro_stock int default 0
);

create table orders(
	or_id int primary key auto_increment,
    or_quantity int,
    or_date datetime default current_timestamp,
    pro_id char(5),
    foreign key (pro_id) references products(pro_id)
);

create table history_logs(
	logs_id INT primary key auto_increment,
    event_logs varchar(255) not null,
    descriptions text,
    date_logs datetime default current_timestamp
);

insert into products
values('p001', 'Ao so mi', 10000, 5),
('p002', 'Ao thun', 17000, 7),
('p003', 'Ao khoac', 15000, 10),
('p004', 'Quan tay', 30000, 8),
('p005', 'Quan short', 20000, 12);
-- Tạo trigger để xử lý các vấn đề sau 
-- Vấn đề 1: Trước khi thêm sản phẩm, hãy chuyển đổi tên sản phẩm thành chữ hoa
DELIMITER //
	CREATE TRIGGER trigger_before_insert_products 
    BEFORE INSERT ON products
    FOR EACH ROW
    BEGIN
		-- Logic xử lý chuyển đổi tên thành in hoa
        -- New là giá trị mới sau khi thao tác
        -- Lưu ý: Nếu như không dùng các thao tác như update, delete
        -- Mà muốn truy cập vào tên cột thì phải dùng từ khóa New or Old
        SET NEW.pro_name = UPPER(NEW.pro_name);
    END //
DELIMITER ;

insert into products
values('p006', 'Ao ba lo', 20000, 17);

insert into products
values('p007', 'Quan ong loe', 16000, 3);
-- New chỉ được sử dụng trong insert và update
-- Vấn đề 2: Trước khi tạo đơn hàng, phải kiểm tra số lượng tồn kho có đủ hay không?
DELIMITER //
	CREATE TRIGGER trigger_before_insert_orders 
    BEFORE INSERT ON orders
    FOR EACH ROW
    BEGIN
		-- B1: Mình phải tạo biến stock để lấy số lượng tồn kho từ bảng products ra
        DECLARE stock_temp INT default 0;
        SET stock_temp = (SELECT pro_stock FROM products WHERE pro_id = NEW.pro_id); -- 3
        -- B2: Dùng if else để kiểm tra nếu như sai thì văng ra lỗi
        IF NEW.or_quantity > stock_temp -- 3 < 5
			THEN SIGNAL SQLSTATE '45000'
				SET message_text = 'Số lượng trong kho không đủ!';
		END IF;
    END //
DELIMITER ;
insert into orders
values(null, 2, default, 'p007');

-- Yêu cầu 3: Sau khi mua hàng thành công, hãy trừ đi số lượng tồn kho trong bảng products
DELIMITER //
	CREATE TRIGGER trigger_after_insert_orders 
    AFTER INSERT ON orders
    FOR EACH ROW
    BEGIN
		-- Dùng update bảng products để cập nhật lại số lượng
        UPDATE products
        SET pro_stock = pro_stock - NEW.or_quantity
        WHERE pro_id = NEW.pro_id;
        -- Dùng new
        -- Số lượng mới = Số lượng cũ - Số lượng mua
    END //
DELIMITER ;
insert into orders
values(null, 3, default, 'p005');
-- Yêu cầu 4: Trước khi cập nhật số lượng mua, kiểm tra số lượng cập nhật không
-- được nhỏ hơn số lượng ban đầu
DELIMITER //
	CREATE TRIGGER trigger_before_update_orders 
    BEFORE UPDATE ON orders
    FOR EACH ROW
    BEGIN
       -- Dùng if else để kiểm tra NEW.or_quantity < OLD.or_quantity
       IF NEW.or_quantity < OLD.or_quantity
		 THEN signal sqlstate '45000'
			SET MESSAGE_TEXT = 'Không thể cập nhật số lượng nhỏ hơn số lượng ban đầu!';
		END IF;
       -- Văng lỗi
    END //
DELIMITER ;

UPDATE orders
SET or_quantity = 5
WHERE or_id = 2;
-- Yêu cầu 5: Sau khi thực hiện thao tác xóa đơn hàng, lưu lại lịch sử xóa đó vào bảng
-- history_logs để quản lý có thể biết xóa đơn hàng gì.
DELIMITER //
	CREATE TRIGGER trigger_after_delete_orders 
    AFTER DELETE ON orders
    FOR EACH ROW
    BEGIN
       INSERT INTO history_logs VALUES
       (null, 'DELETE', 
       CONCAT('Mã đơn hàng xóa: ', OLD.or_id, ' MÃ sản phẩm xóa: ', OLD.pro_id), 
       default);
    END //
DELIMITER ;

DELETE FROM orders
WHERE or_id = 2;
/*
create table history_logs(
	logs_id INT primary key auto_increment,
    event_logs varchar(255) not null,  Lưu sự kiện: Ví dụ Delete, UPdate, Insert
    descriptions text, Mô tả: ví dụ Mã đơn hàng: 2, Mã sản phẩm: p002, 
    date_logs datetime default current_timestamp - Ngày Xóa: 30-07-2026
);
*/

-- Yêu cầu 6: Sau khi xóa đơn hàng, cập nhật lại số lượng sản phẩm đó vào kho.
DELIMITER //
CREATE TRIGGER trigger_after_delete_orders_update_stock
AFTER DELETE ON orders
FOR EACH ROW
BEGIN
    UPDATE products
    SET pro_stock = pro_stock + OLD.or_quantity
    WHERE pro_id = OLD.pro_id;
END //
DELIMITER ;

DELETE FROM orders
WHERE or_id = 1;

-- Yêu cầu 7: Trước khi cập nhật số lượng mua, phải kiểm tra số lương tồn kho.
DELIMITER //
CREATE TRIGGER trigger_before_update_orders_check_stock
BEFORE UPDATE ON orders
FOR EACH ROW
BEGIN
    DECLARE stock_temp INT DEFAULT 0;
    DECLARE quantity_diff INT DEFAULT 0;
    SET stock_temp = (
        SELECT pro_stock
        FROM products
        WHERE pro_id = NEW.pro_id);
    SET quantity_diff = NEW.or_quantity - OLD.or_quantity;
    IF quantity_diff > stock_temp THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Không đủ số lượng tồn kho để cập nhật!';
    END IF;
END //
DELIMITER ;







