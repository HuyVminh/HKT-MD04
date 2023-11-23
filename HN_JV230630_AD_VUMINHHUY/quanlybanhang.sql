-- BÀI 1 : Tạo CSDL
CREATE DATABASE QUANLYBANHANG;
USE QUANLYBANHANG;

CREATE TABLE CUSTOMERS(
	customer_id VARCHAR(4) PRIMARY KEY NOT NULL,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(25) NOT NULL UNIQUE,
    address VARCHAR(255) NOT NULL UNIQUE
);
CREATE TABLE ORDERS(
	order_id VARCHAR(4) PRIMARY KEY NOT NULL,
    customer_id VARCHAR(4) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES CUSTOMERS (customer_id),
    order_date DATE NOT NULL,
    total_amount DOUBLE NOT NULL
);
CREATE TABLE PRODUCTS(
	product_id VARCHAR(4) PRIMARY KEY NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DOUBLE NOT NULL,
    status BIT(1) NOT NULL DEFAULT(1)
);
CREATE TABLE ORDERS_DETAILS(
	order_id VARCHAR(4) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES ORDERS (order_id),
    product_id VARCHAR(4) NOT NULL,
    FOREIGN KEY (product_id) REFERENCES PRODUCTS (product_id),
    PRIMARY KEY (order_id, product_id),
    quantity INT(11) NOT NULL,
    price DOUBLE NOT NULL
);

-- BÀI 2 : Thêm dữ liệu

INSERT INTO CUSTOMERS (customer_id,name,email,phone,address) VALUES
	('C001','Nguyễn Trung Mạnh','manhnt@gmail.com','984756322','Cầu Giấy, Hà Nội'),
    ('C002','Hồ Hải Nam','namhh@gmail.com','984875926','Ba Vì, Hà Nội'),
	('C003','Tô Ngọc Vũ','vutn@gmail.com','904725784','Mộc Châu, Sơn La'),
    ('C004','Phạm Ngọc Anh','anhpn@gmail.com','984635635','Vinh, Nghệ An'),
    ('C005','Trương Minh Cường','cuongtm@gmail.com','989735624','Hai Bà Trưng, Hà Nội');

INSERT INTO PRODUCTS (product_id,name,description,price) VALUES
	('P001','Iphone 13 Promax','Bản 512GB, xanh lá','22999999'),
    ('P002','Dell Vostro V3510','Core i5, RAM 8GB','14999999'),
	('P003','Macbook Pro M2','8CPU 10GPU 8GB 256GB','28999999'),
    ('P004','Apple Watch Ultra','Titanium Alpine Loop Small',18999999),
    ('P005','Airpods 2 2022','Spatial Audio','4090000');

INSERT INTO ORDERS (order_id,customer_id,total_amount,order_date) VALUES
	('H001','C001',52999997,'2023/2/22'),
    ('H002','C001',80999997,'2023/3/11'),
    ('H003','C002',54359998,'2023/1/22'),
    ('H004','C003',102999995,'2023/3/14'),
    ('H005','C003',80999997,'2022/3/12'),
    ('H006','C004',110449994,'2023/2/1'),
    ('H007','C004',79999996,'2023/3/29'),
    ('H008','C005',29999998,'2023/2/14'),
    ('H009','C005',28999999,'2023/1/10'),
    ('H010','C005',149999994,'2023/4/1');
    
INSERT INTO ORDERS_DETAILS (order_id,product_id,price,quantity) VALUES
	('H001','P002',14999999,1),
    ('H001','P004',18999999,2),
    ('H002','P001',22999999,1),
    ('H002','P003',28999999,2),
    ('H003','P004',18999999,2),
    ('H003','P005',4090000,4),
    ('H004','P002',14999999,3),
    ('H004','P003',28999999,2),
    ('H005','P001',22999999,1),
    ('H005','P003',28999999,2),
    ('H006','P005',4090000,5),
    ('H006','P002',14999999,6),
    ('H007','P004',18999999,3),
    ('H007','P001',22999999,1),
    ('H008','P002',14999999,2),
    ('H009','P003',28999999,1),
    ('H010','P003',28999999,2),
    ('H010','P001',22999999,4);
    
-- BÀI 3 : TRUY VẤN DỮ LIỆU
-- 1. Lấy ra tất cả thông tin gồm: tên, email, số điện thoại và địa chỉ trong bảng Customers

SELECT customer_id as 'Mã Khách Hàng',name as 'Tên', email, phone as 'Số điện thoại', address as 'Địa chỉ'
FROM CUSTOMERS;

-- 2. Thống kê những khách hàng mua hàng trong tháng 3/2023 (thông tin bao gồm tên, số điện
-- thoại và địa chỉ khách hàng).

SELECT c.name, c.phone, c.address
FROM ORDERS o
JOIN CUSTOMERS c ON o.customer_id = c.customer_id
WHERE o.order_date >= '2023-03-01' AND o.order_date <= '2023-03-31';

-- 3. Thống kê doanh thu theo từng tháng của cửa hàng trong năm 2023 (thông tin bao gồm
-- tháng và tổng doanh thu ).

SELECT MONTH(order_date) as 'Tháng', SUM(total_amount) as 'Doanh thu'
FROM ORDERS
WHERE YEAR(order_date) = 2023
GROUP BY MONTH(order_date);

-- 4.Thống kê những người dùng không mua hàng trong tháng 2/2023 (thông tin gồm tên khách
-- hàng, địa chỉ , email và số điên thoại).

SELECT name as 'Tên Khách Hàng',address as 'Địa chỉ', email as Email, phone as 'Điện thoại'
FROM CUSTOMERS
WHERE customer_id NOT IN (
	SELECT customer_id FROM ORDERS WHERE MONTH(order_date) = 2 AND YEAR(order_date) = 2023
);

-- 5.Thống kê số lượng từng sản phẩm được bán ra trong tháng 3/2023 (thông tin bao gồm mã
-- sản phẩm, tên sản phẩm và số lượng bán ra).

SELECT od.product_id as 'Mã Sản phẩm', p.name as 'Tên Sản phẩm', SUM(od.quantity) AS 'Số lượng bán ra'
FROM ORDERS o
JOIN ORDERS_DETAILS od ON o.order_id = od.order_id
JOIN PRODUCTS p ON od.product_id = p.product_id
WHERE MONTH(o.order_date) = 3 AND YEAR(o.order_date) = 2023
GROUP BY od.product_id, p.name;

-- 6.Thống kê tổng chi tiêu của từng khách hàng trong năm 2023 sắp xếp giảm dần theo mức chi
-- tiêu (thông tin bao gồm mã khách hàng, tên khách hàng và mức chi tiêu).

SELECT o.customer_id as 'Mã Khách Hàng', c.name as 'Tên Khách Hàng', SUM(O.total_amount) as 'Mức chi tiêu'
FROM ORDERS o
JOIN CUSTOMERS c ON o.customer_id = c.customer_id
WHERE YEAR(o.order_date) = 2023
GROUP BY o.customer_id, c.name
ORDER BY SUM(O.total_amount) DESC;

-- 7.Thống kê những đơn hàng mà tổng số lượng sản phẩm mua từ 5 trở lên (thông tin bao gồm
-- tên người mua, tổng tiền , ngày tạo hoá đơn, tổng số lượng sản phẩm).

SELECT c.name as 'Tên Người mua',o.total_amount as 'Tổng tiền', o.order_date as 'Ngày tạo hóa đơn', SUM(od.quantity) as 'Tổng số sản phẩm'
FROM ORDERS o
JOIN CUSTOMERS c ON o.customer_id = c.customer_id
JOIN ORDERS_DETAILS od ON o.order_id = od.order_id
GROUP BY c.name,o.total_amount, o.order_date
HAVING SUM(od.quantity) >= 5;

-- BÀI 4 : TẠO VIEW, PROCEDURE
-- 1.Tạo VIEW lấy các thông tin hoá đơn bao gồm : Tên khách hàng, số điện thoại, địa chỉ, tổng
-- tiền và ngày tạo hoá đơn

CREATE VIEW InforOrder as
SELECT c.name as 'Tên Khách hàng', c.phone as 'Số điện thoại', c.address as 'Địa chỉ', o.total_amount as 'Tổng tiền', o.order_date as 'Ngày tạo hóa đơn'
FROM CUSTOMERS c
JOIN ORDERS o ON c.customer_id = o.customer_id;

SELECT * FROM InforOrder;

-- 2.Tạo VIEW hiển thị thông tin khách hàng gồm : tên khách hàng, địa chỉ, số điện thoại và tổng
-- số đơn đã đặt.

CREATE VIEW InforCustomerOrdered as
SELECT c.name as 'Tên Khách hàng', c.phone as 'Số điện thoại', c.address as 'Địa chỉ', COUNT(o.order_id) as 'Tổng số đơn hàng'
FROM CUSTOMERS c
JOIN ORDERS o ON c.customer_id = o.customer_id
GROUP BY c.name,c.phone,c.address;
SELECT * FROM InforCustomerOrdered;

-- 3.Tạo VIEW hiển thị thông tin sản phẩm gồm: tên sản phẩm, mô tả, giá và tổng số lượng đã
-- bán ra của mỗi sản phẩm

CREATE VIEW InforProduct as
SELECT p.name as 'Tên Sản phẩm', p.description as 'Mô tả', p.price as 'Đơn giá', SUM(o.quantity) as 'Tổng số lượng đã bán'
FROM PRODUCTS p
JOIN ORDERS_DETAILS o ON p.product_id = o.product_id
GROUP BY p.name,p.description,p.price;
SELECT * FROM InforProduct;

-- 4. Đánh Index cho trường `phone` và `email` của bảng Customer

CREATE INDEX idx_phone ON CUSTOMERS (phone);
CREATE INDEX idx_email ON CUSTOMERS (email);

-- 5.Tạo PROCEDURE lấy tất cả thông tin của 1 khách hàng dựa trên mã số khách hàng

DELIMITER //
CREATE PROCEDURE GetCustomerInfo(IN id VARCHAR(4))
BEGIN
    SELECT *
    FROM CUSTOMERS
    WHERE customer_id = id;
END;
//
call GetCustomerInfo('C001');

-- 6. Tạo PROCEDURE lấy thông tin của tất cả sản phẩm

DELIMITER //
CREATE PROCEDURE GetAllProduct()
BEGIN
    SELECT product_id as 'Mã Sản phẩm',name as 'Tên sản phẩm',description as 'Mô tả',price as 'Đơn giá'
    FROM PRODUCTS;
END;
//
call GetAllProduct;

-- 7. Tạo PROCEDURE hiển thị danh sách hoá đơn dựa trên mã người dùng

DELIMITER //
CREATE PROCEDURE OrderListByCustomerId
(IN id VARCHAR(4))
BEGIN
    SELECT order_id as 'Mã Hóa đơn',total_amount as 'Tổng tiền',order_date as 'Ngày mua' 
    FROM ORDERS
    WHERE customer_id = id;
END;
//

call OrderListByCustomerId('C001');

-- 8. Tạo PROCEDURE tạo mới một đơn hàng với các tham số là mã khách hàng, tổng
-- tiền và ngày tạo hoá đơn, và hiển thị ra mã hoá đơn vừa tạo.

DELIMITER //
CREATE PROCEDURE proc_add_new_order
(IN id VARCHAR(4),IN cusId VARCHAR(4), IN total DOUBLE, IN create_at DATE)
BEGIN
    INSERT INTO ORDERS (order_id,customer_id,order_date,total_amount) 
    VALUES (id,cusId,total,create_at);
END;
//

-- 9. Tạo PROCEDURE thống kê số lượng bán ra của mỗi sản phẩm trong khoảng
-- thời gian cụ thể với 2 tham số là ngày bắt đầu và ngày kết thúc.

DELIMITER //
CREATE PROCEDURE proc_count_product
(IN date_begin DATE, IN date_end DATE)
BEGIN
    SELECT od.product_id as 'Mã sản phẩm', p.name as 'Tên sản phẩm', SUM(od.quantity) AS 'Số lượng đã bán ra'
    FROM ORDERS_DETAILS od
    JOIN PRODUCTS p ON od.product_id = p.product_id
    JOIN ORDERS o ON o.order_id = od.order_id
    WHERE o.order_date >= date_begin AND o.order_date <= date_end
    GROUP BY od.product_id,p.name;
END;
//

call proc_count_product('2023/3/1','2023/3/31');

-- 10. Tạo PROCEDURE thống kê số lượng của mỗi sản phẩm được bán ra theo thứ tự
-- giảm dần của tháng đó với tham số vào là tháng và năm cần thống kê.

DELIMITER //
CREATE PROCEDURE proc_sold_product_by_month
(IN month_in INT, IN year_in INT)
BEGIN
    SELECT od.product_id as 'Mã sản phẩm', p.name as 'Tên sản phẩm', SUM(od.quantity) AS 'Số lượng đã bán ra'
    FROM ORDERS_DETAILS od
    JOIN PRODUCTS p ON od.product_id = p.product_id
    JOIN ORDERS o ON o.order_id = od.order_id
    WHERE MONTH(o.order_date) = month_in AND YEAR(o.order_date) = year_in
    GROUP BY od.product_id,p.name
    ORDER BY SUM(od.quantity) DESC;
END;
//

call proc_sold_product_by_month(3,2023);