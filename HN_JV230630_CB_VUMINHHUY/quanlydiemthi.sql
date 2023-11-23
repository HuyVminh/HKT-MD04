-- BÀI 1 : TẠO CƠ SỞ DỮ LIỆU

CREATE DATABASE QUANLYDIEMTHI;
USE QUANLYDIEMTHI;

CREATE TABLE STUDENT(
	studentId VARCHAR(4) PRIMARY KEY NOT NULL,
    studentName VARCHAR(100) NOT NULL,
    birthday DATE NOT NULL,
    gender BIT(1) NOT NULL,
    address TEXT,
    phoneNumber VARCHAR(45) UNIQUE
);

CREATE TABLE SUBJECT(
	subjectId VARCHAR(4) PRIMARY KEY NOT NULL,
    subjectName VARCHAR(45) NOT NULL,
    priority INT(11) NOT NULL
);

CREATE TABLE MARK(
	subjectId VARCHAR(4) NOT NULL,
    FOREIGN KEY (studentId) REFERENCES STUDENT(studentId),
    studentId VARCHAR(4) NOT NULL,
    FOREIGN KEY (subjectId) REFERENCES SUBJECT(subjectId),
    PRIMARY KEY (subjectId, studentId),
    point DOUBLE NOT NULL
);

-- BÀI 2 : THÊM, SỬA, XÓA DỮ LIỆU
-- 1. Thêm dữ liệu vào bảng :

INSERT INTO STUDENT(studentId,studentName,birthday,gender,address,phoneNumber) VALUES
	('S001','Nguyễn Thế Anh','1999/1/11',1,'Hà Nội','984678082'),
    ('S002','Đặng Bảo Trâm','1998/12/22',0,'Lào Cai','904982654'),
    ('S003','Trần Hà Phương','2000/5/5',0,'Nghệ An','947645363'),
    ('S004','Đỗ Tiến Mạnh','1999/3/26',1,'Hà Nội','983665353'),
    ('S005','Phạm Duy Nhất','1998/10/4',1,'Tuyên Quang','987242678'),
    ('S006','Mai Văn Thái','2002/6/22',1,'Nam Định','982654268'),
    ('S007','Giang Gia Hân','1996/11/10',0,'Phú Thọ','982364753'),
    ('S008','Nguyễn Ngọc Bảo My','1999/1/22',0,'Hà Nam','927867453'),
    ('S009','Nguyễn Tiến Đạt','1998/8/7',1,'Tuyên Quang','989274673'),
    ('S010','Nguyễn Thiều Quang','2000/9/18',1,'Hà Nội','984378291');

INSERT INTO SUBJECT (subjectId,subjectName,priority) VALUES
	('MH01','Toán',2),
    ('MH02','Vật Lý',2),
    ('MH03','Hóa Học',1),
    ('MH04','Ngữ Văn',1),
    ('MH05','Toán',2);
    
INSERT INTO MARK (subjectId, studentId, point) VALUES
	('MH01','S001',8.5),
    ('MH02','S001',7),
    ('MH03','S001',9),
    ('MH04','S001',9),
    ('MH05','S001',5),
    
    ('MH01','S002',9),
    ('MH02','S002',8),
    ('MH03','S002',6.5),
    ('MH04','S002',8),
    ('MH05','S002',6),
    
    ('MH01','S003',7.5),
    ('MH02','S003',6.5),
    ('MH03','S003',8),
    ('MH04','S003',7),
    ('MH05','S003',7),
    
    ('MH01','S004',6),
    ('MH02','S004',7),
    ('MH03','S004',5),
    ('MH04','S004',6.5),
    ('MH05','S004',8),
    
    ('MH01','S005',5.5),
    ('MH02','S005',8),
    ('MH03','S005',7.5),
    ('MH04','S005',8.5),
    ('MH05','S005',9),
    
    ('MH01','S006',8),
    ('MH02','S006',10),
    ('MH03','S006',9),
    ('MH04','S006',7.5),
    ('MH05','S006',6.5),
    
    ('MH01','S007',8.5),
    ('MH02','S007',9),
    ('MH03','S007',6),
    ('MH04','S007',9),
    ('MH05','S007',4),
    
    ('MH01','S008',10),
    ('MH02','S008',8.5),
    ('MH03','S008',8.5),
    ('MH04','S008',6),
    ('MH05','S008',9.5),
    
    ('MH01','S009',7.5),
    ('MH02','S009',8),
    ('MH03','S009',5.5),
    ('MH04','S009',4),
    ('MH05','S009',7),
    
    ('MH01','S010',6.5),
    ('MH02','S010',8),
    ('MH03','S010',5.5),
    ('MH04','S010',4),
    ('MH05','S010',7);
    
-- 2. Cập nhật dữ liệu
--    + Sửa tên sinh viên có mã 'S004' thành 'Đỗ Đức Mạnh'

UPDATE STUDENT SET studentName = 'Đỗ Đức Mạnh' WHERE studentId = 'S004';

--    + Sửa tên và hệ số môn học có mã 'MH05' thành 'Ngoại Ngữ' và hệ số là 1

UPDATE SUBJECT SET subjectName = 'Ngoại Ngữ' , priority = 1 where subjectId = 'MH05';

--    + Cập nhạt lại điểm của học sinh mã 'S009' thành (MH01:8.5,MH02:7,MH03:5.5,MH04:6,MH05:9)

UPDATE MARK SET point = 8.5 WHERE studentId = 'S009' AND subjectId = 'MH01';
UPDATE MARK SET point = 7 WHERE studentId = 'S009' AND subjectId = 'MH02';
UPDATE MARK SET point = 5.5 WHERE studentId = 'S009' AND subjectId = 'MH03';
UPDATE MARK SET point = 6 WHERE studentId = 'S009' AND subjectId = 'MH04';
UPDATE MARK SET point = 9 WHERE studentId = 'S009' AND subjectId = 'MH05';

-- 3. Xóa dữ liệu
--    + Xóa toàn bộ thông tin học sinh có mã 'S010' bao gồm điểm thi ở bảng mark và 
--    thông tin học sinh này ở bảng student

DELETE FROM MARK WHERE studentId = 'S010';
DELETE FROM STUDENT WHERE studentId = 'S010';


-- BÀI 3 : TRUY VẤN DỮ LIỆU :
-- 1. Lấy ra tất cả thông tin của sinh viên trong bảng Student

SELECT * FROM STUDENT;

-- 2. Hiển thị tên và mã môn học của những môn có hệ số bằng 1

SELECT subjectId,subjectName FROM SUBJECT WHERE priority = 1;

-- 3. Hiển thị thông tin học sinh bao gồm : mã hs, tên hs, tuổi (bằng năm hiện tại - năm sinh), giới tính và quê quán của tất cả học sinh

SELECT studentId as 'Mã Học sinh', studentName as 'Tên học sinh',(year(curdate())-year(birthday)) as 'Tuổi', (CASE WHEN gender = 1 THEN 'Nam' ELSE 'Nữ' END) as 'Giới tính', address as 'Quê quán' FROM STUDENT;

-- 4. Hiển thị thông tin bao gồm : tên hs, tên môn học, điểm thi của tất 
--    cả hs của môn toán và sắp xếp theo điểm giảm dần

SELECT s.studentName as 'Tên học sinh',sj.subjectName as 'Tên môn học',m.point as 'Điểm thi'
FROM MARK m
JOIN STUDENT s ON m.studentId = s.studentId
JOIN SUBJECT sj ON m.subjectId = sj.subjectId
WHERE sj.subjectName = 'Toán'
ORDER BY m.point DESC;

-- 5. Thống kê số lượng học sinh theo giới tính ở trong bảng (gồm 2 cột : giới tính và số lượng)

SELECT (CASE WHEN gender = 1 THEN 'Nam' ELSE 'Nữ' END) as 'Giới tính', COUNT(*) as 'Số lượng'
FROM STUDENT
GROUP BY gender;

-- 6. Tính tổng điểm và điểm trung bình của các môn học theo từng học sinh (yêu cầu sử dụng hàm
-- để tính toán) , bảng gồm mã học sinh, tên hoc sinh, tổng điểm và điểm trung bình.

SELECT m.studentId as 'Mã học sinh', s.studentName as 'Tên học sinh', SUM(m.point) as 'Tổng điểm', AVG(m.point) as 'Điểm trung bình'
FROM MARK m
JOIN STUDENT s on m.studentId = s.studentId
GROUP BY m.studentId, s.studentName;

-- BÀI 4 : TẠO VIEW, INDEX, PROCEDURE
-- 1.Tạo VIEW có tên STUDENT_VIEW lấy thông tin sinh viên bao gồm : mã học sinh, tên học
-- sinh, giới tính , quê quán 

CREATE VIEW STUDENT_VIEW AS
SELECT studentId as 'Mã học sinh', studentName as 'Tên học sinh', (CASE WHEN gender = 1 THEN 'Nam' ELSE 'Nữ' END) as 'Giới tính', address as 'Quê quán'
FROM STUDENT;

-- 2.Tạo VIEW có tên AVERAGE_MARK_VIEW lấy thông tin gồm:mã học sinh, tên học sinh,
-- điểm trung bình các môn học .

CREATE VIEW AVERAGE_MARK_VIEW AS
SELECT m.studentId as 'Mã học sinh', s.studentName as 'Tên học sinh', AVG(m.point) as 'Điểm trung bình'
FROM MARK m
JOIN STUDENT s ON m.studentId = s.studentId
GROUP BY m.studentId, s.studentName;

-- 3. Đánh Index cho trường `phoneNumber` của bảng STUDENT.

CREATE INDEX idx_phoneNumber ON STUDENT (phoneNumber);

-- 4. Tạo các PROCEDURE sau:
--     + Tạo PROC_INSERTSTUDENT dùng để thêm mới 1 học sinh bao gồm tất cả thông tin học sinh đó.

DELIMITER //
CREATE PROCEDURE PROC_INSERTSTUDENT
(
   IN id VARCHAR(4),
   IN name VARCHAR(100),
   IN birth DATE,
   IN gend BIT(1),
   IN country TEXT,
   IN phone VARCHAR(45)
)
BEGIN
    INSERT INTO STUDENT (studentId, studentName, birthday, gender, address, phoneNumber)
    VALUES (id, name, birth, gend, country, phone);
END;
//

--     + Tạo PROC_UPDATESUBJECT dùng để cập nhật tên môn học theo mã môn học.

DELIMITER //
CREATE PROCEDURE PROC_UPDATESUBJECT
(
   IN id VARCHAR(4),
   IN name VARCHAR(45)
)
BEGIN
    UPDATE SUBJECT SET subjectName = name WHERE subjectId = id;
END;
//

--     + Tạo PROC_DELETEMARK dùng để xoá toàn bộ điểm các môn học theo mã học sinh 
--     và trả về số bản ghi đã xóa.

DELIMITER //
CREATE PROCEDURE PROC_DELETEMARK
(
    IN id VARCHAR(4),
    OUT deletedCount INT
)
BEGIN
    DELETE FROM MARK WHERE studentId = id;
    SET deletedCount = ROW_COUNT();
END //
DELIMITER ;

CALL PROC_DELETEMARK('S002', @deletedCount);
select @deletedCount AS 'Số bản ghi đã xóa';