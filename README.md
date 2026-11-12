# ShopMan – Bài tập lớn PTTK HTTT (Đề 37)

Code cho 2 module trong báo cáo:
1. **Khách hàng theo dõi hóa đơn** (`customer/*.jsp`, `HoaDonBanHang7DAO`)
2. **Thống kê nhà cung cấp theo lượng hàng nhập** (`manager/*.jsp`, `TKNhaCungCap7DAO`, `HoaDonNhapHang7DAO`, `Supplier7DAO`)

Kiến trúc đúng theo mục "Thiết kế": JSP (view) → DAO → MySQL, các lớp thực thể trong gói `model`, không có tầng controller.

## Yêu cầu
- JDK 11+, Maven 3.8+, Apache Tomcat 9 (javax.servlet), MySQL 8

## Chạy
1. Chạy `sql/shopman.sql` trong MySQL (tạo CSDL `shopman` + dữ liệu mẫu).
2. Nếu MySQL không phải `root` / mật khẩu rỗng, đặt biến môi trường `DB_URL`, `DB_USER`, `DB_PASS`
   (hoặc sửa mặc định trong `dao/DAO.java`).
3. `mvn clean package` → copy `target/shopman.war` vào `TOMCAT/webapps`, chạy Tomcat 9.
4. Mở `http://localhost:8080/shopman/`.

## Tài khoản mẫu (mật khẩu: 123456)
| Vai trò | Tên đăng nhập |
|---|---|
| Khách hàng | khach1 (có HD001, HD002), khach2 |
| Nhân viên quản lí | quanly1 |

## Luồng kiểm thử
- **khach1** → Theo dõi hóa đơn → Xem chi tiết HD002 (Gạo, Nước uống, Dầu ăn = 1.000.000 đ).
  Thử `GDChiTietHoaDonBanHang7.jsp?id=3` (hóa đơn của khach2) → "Không tìm thấy hóa đơn".
- **quanly1** → Xem báo cáo → Thống kê nhà cung cấp theo lượng hàng nhập → chọn 01/01/2026 – 17/09/2026
  → click nhà cung cấp → click "Xem hóa đơn".
  Thử ngày bắt đầu > ngày kết thúc → "Khoảng thời gian không hợp lệ".

## Cấu trúc
```
sql/shopman.sql
src/main/java/model   Member7, Customer7, Employee7, Supplier7, Product7,
                      HoaDonBanHang7, InvoiceDetail7, HoaDonNhapHang7, ImportDetail7, TKNhaCungCap7
src/main/java/dao     DAO, MemberDAO7, HoaDonBanHang7DAO (getAll, getItem),
                      TKNhaCungCap7DAO (getSupplierStatistic), Supplier7DAO (getSupplierInfo),
                      HoaDonNhapHang7DAO (getImportBySupplier, getHoaDonNhapHang)
src/main/java/util    ParamUtil
src/main/webapp       login.jsp, logout.jsp, customer/, manager/, css/, WEB-INF/
```

## Ghi chú
- Tên lớp/hàm bám theo kịch bản v3.0 trong báo cáo (ví dụ `getAll(customerId)`, `getItem(invoiceId, customerId)`,
  `getSupplierStatistic(startDate, endDate)`, `getImportBySupplier(...)`, `getHoaDonNhapHang(id)`).
  Nếu thầy/cô yêu cầu hậu tố khác (vd. `458`) thì đổi tên lớp/file tương ứng.
- Mật khẩu lưu dạng SHA-256; mọi truy vấn dùng PreparedStatement; mọi dữ liệu hiển thị qua `<c:out>`.
- Các chức năng ngoài hai module (đặt hàng, nhập hàng, duyệt hóa đơn…) hiện là nút bị vô hiệu hóa.
