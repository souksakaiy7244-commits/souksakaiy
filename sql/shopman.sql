-- ShopMan - CSDL MySQL 8
DROP DATABASE IF EXISTS shopman;
CREATE DATABASE shopman CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE shopman;

CREATE TABLE tblThanhVien7 (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) NOT NULL UNIQUE,
  password VARCHAR(64) NOT NULL,              -- SHA-256 (hex)
  hoTen VARCHAR(100) NOT NULL,
  sdt VARCHAR(20),
  email VARCHAR(100),
  role ENUM('CUSTOMER','MANAGER','SALESMAN') NOT NULL
);

CREATE TABLE tblKhachHang7 (
  id INT PRIMARY KEY,
  diaChi VARCHAR(255),
  FOREIGN KEY (id) REFERENCES tblThanhVien7(id)
);

CREATE TABLE tblNhanVien7 (
  id INT PRIMARY KEY,
  maNV VARCHAR(20) NOT NULL UNIQUE,
  viTri ENUM('MANAGER','SALESMAN') NOT NULL,
  FOREIGN KEY (id) REFERENCES tblThanhVien7(id)
);

CREATE TABLE tblNhaCungCap7 (
  id INT AUTO_INCREMENT PRIMARY KEY,
  ma VARCHAR(20) NOT NULL UNIQUE,
  ten VARCHAR(150) NOT NULL,
  diaChi VARCHAR(255),
  sdt VARCHAR(20),
  email VARCHAR(100)
);

CREATE TABLE tblHangHoa7 (
  id INT AUTO_INCREMENT PRIMARY KEY,
  ten VARCHAR(150) NOT NULL,
  moTa VARCHAR(255),
  donVi VARCHAR(30),
  giaBan BIGINT NOT NULL DEFAULT 0,
  soLuongTon INT NOT NULL DEFAULT 0
);

CREATE TABLE tblHoaDonBanHang7 (
  id INT AUTO_INCREMENT PRIMARY KEY,
  ma VARCHAR(20) NOT NULL UNIQUE,
  khachHangId INT NOT NULL,
  nhanVienBanHangId INT NULL,
  ngayLap DATETIME NOT NULL,
  trangThai ENUM('CHO_DUYET','DA_DUYET','DANG_DONG_HANG','DA_BAN_GIAO','DA_GIAO') NOT NULL DEFAULT 'CHO_DUYET',
  FOREIGN KEY (khachHangId) REFERENCES tblKhachHang7(id),
  FOREIGN KEY (nhanVienBanHangId) REFERENCES tblNhanVien7(id)
);

CREATE TABLE tblChiTietHoaDon7 (
  id INT AUTO_INCREMENT PRIMARY KEY,
  hoaDonId INT NOT NULL,
  hangHoaId INT NOT NULL,
  soLuong INT NOT NULL,
  donGia BIGINT NOT NULL,
  FOREIGN KEY (hoaDonId) REFERENCES tblHoaDonBanHang7(id),
  FOREIGN KEY (hangHoaId) REFERENCES tblHangHoa7(id)
);

CREATE TABLE tblHoaDonNhapHang7 (
  id INT AUTO_INCREMENT PRIMARY KEY,
  ma VARCHAR(20) NOT NULL UNIQUE,
  nhaCungCapId INT NOT NULL,
  quanLyId INT NOT NULL,
  ngayNhap DATE NOT NULL,
  FOREIGN KEY (nhaCungCapId) REFERENCES tblNhaCungCap7(id),
  FOREIGN KEY (quanLyId) REFERENCES tblNhanVien7(id)
);

CREATE TABLE tblChiTietNhapHang7 (
  id INT AUTO_INCREMENT PRIMARY KEY,
  hoaDonNhapId INT NOT NULL,
  hangHoaId INT NOT NULL,
  soLuong INT NOT NULL,
  donGiaNhap BIGINT NOT NULL,
  FOREIGN KEY (hoaDonNhapId) REFERENCES tblHoaDonNhapHang7(id),
  FOREIGN KEY (hangHoaId) REFERENCES tblHangHoa7(id)
);

-- ===== Dữ liệu mẫu (mật khẩu tất cả: 123456) =====
INSERT INTO tblThanhVien7 (id, username, password, hoTen, sdt, email, role) VALUES
 (1,'khach1',  SHA2('123456',256),'Nguyễn Văn A','0912345678','a@gmail.com','CUSTOMER'),
 (2,'khach2',  SHA2('123456',256),'Trần Thị B',  '0987654321','b@gmail.com','CUSTOMER'),
 (3,'quanly1', SHA2('123456',256),'Manager',     '0900000001','ql@shopman.vn','MANAGER'),
 (4,'banhang1',SHA2('123456',256),'Lê Văn Bán',  '0900000002','bh@shopman.vn','SALESMAN');
INSERT INTO tblKhachHang7 VALUES (1,'Hà Nội'),(2,'Hải Phòng');
INSERT INTO tblNhanVien7 VALUES (3,'NV001','MANAGER'),(4,'NV002','SALESMAN');

INSERT INTO tblNhaCungCap7 (id,ma,ten,diaChi,sdt,email) VALUES
 (1,'NCC001','Công ty ABC',      'Hà Nội',  '0900000011','abc@ncc.vn'),
 (2,'NCC002','Công ty XYZ',      'Đà Nẵng', '0800000022','xyz@ncc.vn'),
 (3,'NCC003','Công ty Minh Anh', 'TP.HCM',  '0300000033','minhanh@ncc.vn');

INSERT INTO tblHangHoa7 (id,ten,moTa,donVi,giaBan,soLuongTon) VALUES
 (1,'Gạo',      'Gạo thơm 5kg',  'bao',  200000,500),
 (2,'Nước uống','Thùng 24 chai', 'thùng',100000,300),
 (3,'Dầu ăn',   'Dầu ăn 5 lít',  'can',  400000,200);

INSERT INTO tblHoaDonBanHang7 (id,ma,khachHangId,nhanVienBanHangId,ngayLap,trangThai) VALUES
 (1,'HD001',1,4,'2026-09-01 09:00:00','DA_DUYET'),
 (2,'HD002',1,4,'2026-09-10 14:30:00','DANG_DONG_HANG'),
 (3,'HD003',2,NULL,'2026-09-12 10:15:00','CHO_DUYET');
INSERT INTO tblChiTietHoaDon7 (hoaDonId,hangHoaId,soLuong,donGia) VALUES
 (1,1,2,200000),(1,2,4,112500),
 (2,1,2,200000),(2,2,4,100000),(2,3,1,400000),
 (3,3,1,400000);

INSERT INTO tblHoaDonNhapHang7 (id,ma,nhaCungCapId,quanLyId,ngayNhap) VALUES
 (1,'PN001',1,3,'2026-02-10'),
 (2,'PN002',1,3,'2026-05-15'),
 (3,'PN003',1,3,'2026-08-20'),
 (4,'PN004',2,3,'2026-03-05'),
 (5,'PN005',2,3,'2026-07-07'),
 (6,'PN006',3,3,'2026-06-18');
INSERT INTO tblChiTietNhapHang7 (hoaDonNhapId,hangHoaId,soLuong,donGiaNhap) VALUES
 (1,1,300,200000),(1,2,200,100000),
 (2,1,100,200000),(2,3,50,100000),
 (3,1,250,200000),(3,2,150,100000),
 (4,2,600,100000),
 (5,3,400,100000),
 (6,1,500,190000),(6,3,250,95000);
