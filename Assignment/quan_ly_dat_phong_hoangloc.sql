drop DATABASE IF EXISTS quan_ly_dat_phong_hoangloc;
CREATE DATABASE quan_ly_dat_phong_hoangloc;
USE quan_ly_dat_phong_hoangloc;

Alter database  quan_ly_dat_phong_hoangloc CHARACTER set utf8mb4
collate utf8mb4_unicode_ci;

DROP TABLE IF EXISTS KHACH_HANG;
CREATE TABLE KHACH_HANG(
	MaKH		INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    TenKH		varchar(50) NOT NULL,
    DiaChi		varchar(50) NOT NULL,
    SoDT 		varchar(11) NOT NULL
);
insert into KHACH_HANG(TenKH,DiaChi,SoDT)
VALUE	
	('Phạm Văn An','Hà Nội', '0903875624'),
    ('Nguyễn Khánh Linh','HCM', '0903675429'),
    ('Phạm Văn Chính','Đà Nẵng', '0903876425'),
    ('Phạm Văn Danh','Hải Phòng', '0903536289'),
    ('Phạm Văn Tài Em','Cần Thơ', '0903592876'),
    ('Nguyễn Văn Bo','Nhật Bản', '0953592977'),
    ('Nguyễn Văn Beo','Nhật Bản', '0953592977'),
    ('Nguyễn Văn Hổ','Nhật Bản', '0953592977'),
    ('Nguyễn Văn Hùng','Nhật Bản', '0953592977'),
    ('Nguyễn Văn Tí','Nhật Bản', '0953592977'),
    ('Nguyễn Văn dê','Nhật Bản', '0953592977');
DROP TABLE IF EXISTS PHONG;
CREATE TABLE PHONG(
	MaPhong 		INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    LoaiPhong		INT NOT NULL,
    SoKhachToiDa	INT NOT NULL,
    GiaPhong		DECIMAL(10) NOT NULL,
    MoTa			varchar(255)
);
insert into PHONG(LoaiPhong,SoKhachToiDa,GiaPhong,MoTa)
VALUE
	(1,10,300000,'sạch đẹp'),
    (3,10,1000000,'sạch sẽ kín đáo'),
    (2,10,500000,'sạch sẽ sang trọng'),
    (1,10,300000,'sạch sẽ kín đáo'),
    (2,10,1000000,'sạch sẽ sang trọng');
DROP TABLE IF EXISTS Dich_Vu_Di_Kem;
CREATE TABLE Dich_Vu_Di_Kem(
	MaDV 				INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	TenDV				Varchar(20) NOT NULL,
	DonViTinh			INT NOT NULL,
	DonGia				DECIMAL(10) NOT NULL
);
insert into Dich_Vu_Di_Kem(TenDV,DonViTinh,DonGia)
VALUE
	('Bia',10,50000),
    ('Nước Ngọt',10,20000),
    ('Rượu',5,100000),
    ('Trái Cây',2,50000),
    ('Khăn ướt',10,5000);
DROP TABLE IF EXISTS Dat_Phong;
CREATE TABLE Dat_Phong(
	MaDatPhong			INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    MaPhong				INT NOT NULL,
    MaKH				INT NOT NULL,
    NgayDat				DATE,
    TienDatCoc			DECIMAL(10) DEFAULT 0,
    GhiChu				varchar(255),
    TrangThaiDat		enum('đã đặt','đã huỷ'),
    FOREIGN KEY (MaPhong) REFERENCES PHONG(MaPhong) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (MaKH) REFERENCES KHACH_HANG(MaKH) ON DELETE CASCADE ON UPDATE CASCADE
);
insert into Dat_Phong(MaPhong,MaKH,NgayDat,TienDatCoc,GhiChu,TrangThaiDat)
VALUE
	(1,2,'2021-10-10',100000,'khach VIP','đã đặt'),
    (2,3,'2021-10-01',0,'khach VIP','đã đặt'),
    (3,4,'2021-10-05',0,'khach VIP','đã đặt'),
    (4,5,'2021-10-08',50000,'khach bèo','đã đặt'),
    (5,1,'2021-10-09',100000,'khach bèo','đã đặt'),
    (4,5,'2021-10-18',500000,'khach bèo','đã đặt');
DROP TABLE IF EXISTS CHI_TIET_SU_DUNG_DV;
CREATE TABLE CHI_TIET_SU_DUNG_DV(
	MaDatPhong			INT NOT NULL,
    MaDV				INT NOT NULL,
    SoLuong				INT,
    PRIMARY KEY(MaDatPhong,MaDV),
    FOREIGN KEY (MaDatPhong) REFERENCES Dat_Phong(MaDatPhong) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (MaDV) REFERENCES Dich_Vu_Di_Kem(MaDV) ON DELETE CASCADE ON UPDATE CASCADE
    );
    insert into CHI_TIET_SU_DUNG_DV(MaDatPhong,MaDV,SoLuong)
VALUE
	(1,5,2),
    (2,5,3),
    (3,3,4),
    (4,3,5),
    (5,2,6);

 
 -- 2. Hiển thị loại phòng đã thuê, tên dịch vụ đã sử dụng của khách hàng có tên là “Nguyễn Khánh Linh”
  select LoaiPhong,TenDV
  from PHONG p
  right join (
			select MaPhong,TenDV
			from Dich_Vu_Di_Kem d
			join (select MaPhong,MaDV
				from Dat_Phong d
				right join KHACH_HANG k
				on d.MaKH = k.maKH
				left join CHI_TIET_SU_DUNG_DV c
				on d.MaDatPhong = c.MaDatPhong
                 where TenKH='Nguyễn Khánh Linh') as khachdatphong
			on d.MaDV=khachdatphong.MaDV)as dichvu
on p.MaPhong=dichvu.MaPhong ;
 -- 3. Viết Function để trả về Số điện thoại của Khách hàng thuê nhiều phòng nhất trong năm 2020
--  4.Viết thủ tục tăng giá phòng thêm 10,000 VNĐ so với giá phòng hiện tại cho những phòng có số khách tối đa lớn hơn 
DROP PROCEDURE IF EXISTS tang_gia_phong;
DELIMITER $$
	CREATE PROCEDURE tang_gia_phong()
    BEGIN 
		SELECT (count(MaPhong))
                FROM Dat_Phong
                WHERE MaPhong = new.MaPhong 
                GROUP BY (MaPhong);
		if count(MaPhong)>6
    END $$ 
	delimiter ;
-- 5. Viết thủ tục thống kê khách hàng và số lần thuê phòng tương ứng của từng khách hàng trong năm nay.
    DROP PROCEDURE IF EXISTS thong_ke_khach_trong_nam;
DELIMITER $$
	CREATE PROCEDURE thong_ke_khach_trong_nam()
    BEGIN 
		select TenKH, count(k.MaKH)
		from KHACH_HANG k
		right join Dat_Phong d
		on k.MaKH=d.maKH
		where year(NgayDat)=year(curdate())
		group by k.MaKH;
    END $$ 
	delimiter ;

   call thong_ke_khach_trong_nam();
-- 6. Viết thủ tục hiển thị 5 đơn đặt phòng gần nhất bao gồm có các thông tin: Mã đặt phòng, tên khách hàng, loại phòng, giá phòng.
	DROP PROCEDURE IF EXISTS hien_thi_5_don_hang_gan_nhat;
	DELIMITER $$
	CREATE PROCEDURE hien_thi_5_don_hang_gan_nhat()
    BEGIN 
    select MaDatPhong,TenKH,LoaiPhong,GIaPhong
		from(select MaDatPhong,TenKH,MaPhong
				from(
					select MaDatPhong,MaKH,MaPhong
					from Dat_Phong
					ORDER BY NgayDat asc limit 5) as tbl1
				left join KHACH_HANG k
				on tbl1.MaKH = k.MaKH) as tbl2
		left join PHONG p
		on tbl2.MaPhong=p.MaPhong;
    END $$ 
	delimiter ;
    
		call hien_thi_5_don_hang_gan_nhat();
        
-- 7.  Viết Trigger kiểm tra khi thêm phòng mới có Số khách tối đa vượt quá 10 người thì không cho thêm mới và hiển thị thông báo “Vượt quá số người cho phép”.
DROP TRIGGER IF EXISTS tri_cau_hinh_khi_them_phong_moi_khong_qua_10_nguoi;
    delimiter $$
    CREATE TRIGGER tri_cau_hinh_khi_them_phong_moi_khong_qua_10_nguoi
		BEFORE INSERT on Dat_Phong
		FOR EACH ROW
			BEGIN
				DECLARE khachcount int;
				SELECT (count(MaPhong)) into khachcount 
                FROM Dat_Phong
                WHERE MaPhong = new.MaPhong 
                GROUP BY (MaPhong);
                IF 
					khachcount >= 10
                    THEN
                    SIGNAL SQLSTATE '12345'
                    SET MESSAGE_TEXT = 'Vượt quá số người cho phép';
				END IF;
			END$$
	delimiter ;
    select count(MaPhong)
    from Dat_Phong
    group by MaPhong
    order by MaPhong;
    insert into Dat_Phong(MaPhong,MaKH,NgayDat,TienDatCoc,GhiChu,TrangThaiDat)
VALUE
	(4,10,'2021-10-10',100000,'khach VIP','đã đặt');
    
    
