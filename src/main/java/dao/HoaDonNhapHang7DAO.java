package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import model.Employee7;
import model.HoaDonNhapHang7;
import model.ImportDetail7;
import model.Product7;

public class HoaDonNhapHang7DAO extends DAO {

    /** Các lần nhập hàng của một nhà cung cấp trong [startDate, endDate]. */
    public List<HoaDonNhapHang7> getImportBySupplier(int supplierId, LocalDate startDate, LocalDate endDate) {
        String sql = "SELECT h.id, h.ma, h.ngayNhap, "
                   + "       SUM(c.soLuong) AS tongSoLuong, "
                   + "       SUM(c.soLuong * c.donGiaNhap) AS tongTien "
                   + "FROM tblHoaDonNhapHang7 h "
                   + "JOIN tblChiTietNhapHang7 c ON c.hoaDonNhapId = h.id "
                   + "WHERE h.nhaCungCapId = ? AND h.ngayNhap BETWEEN ? AND ? "
                   + "GROUP BY h.id, h.ma, h.ngayNhap "
                   + "ORDER BY h.ngayNhap, h.id";
        List<HoaDonNhapHang7> list = new ArrayList<>();
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, supplierId);
            ps.setDate(2, Date.valueOf(startDate));
            ps.setDate(3, Date.valueOf(endDate));
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    HoaDonNhapHang7 h = new HoaDonNhapHang7();
                    h.setId(rs.getInt("id"));
                    h.setMa(rs.getString("ma"));
                    h.setNgayNhap(rs.getDate("ngayNhap").toLocalDate());
                    h.setTongSoLuong(rs.getInt("tongSoLuong"));
                    h.setTongTien(rs.getLong("tongTien"));
                    list.add(h);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi lấy các lần nhập hàng", e);
        }
        return list;
    }

    /** Chi tiết một hóa đơn nhập (kèm nhà cung cấp, người nhập, danh sách hàng). Không có -> null. */
    public HoaDonNhapHang7 getHoaDonNhapHang(int importInvoiceId) {
        String sqlHead = "SELECT h.id, h.ma, h.ngayNhap, "
                       + "       s.id AS sId, s.ma AS sMa, s.ten AS sTen, s.diaChi, s.sdt, s.email, "
                       + "       q.id AS qId, t.hoTen AS qTen "
                       + "FROM tblHoaDonNhapHang7 h "
                       + "JOIN tblNhaCungCap7 s ON s.id = h.nhaCungCapId "
                       + "JOIN tblNhanVien7 q ON q.id = h.quanLyId "
                       + "JOIN tblThanhVien7 t ON t.id = q.id "
                       + "WHERE h.id = ?";
        String sqlItems = "SELECT g.id, g.ten, c.soLuong, c.donGiaNhap "
                        + "FROM tblChiTietNhapHang7 c "
                        + "JOIN tblHangHoa7 g ON g.id = c.hangHoaId "
                        + "WHERE c.hoaDonNhapId = ? ORDER BY c.id";
        try (Connection con = getConnection()) {
            HoaDonNhapHang7 h;
            try (PreparedStatement ps = con.prepareStatement(sqlHead)) {
                ps.setInt(1, importInvoiceId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (!rs.next()) return null;
                    h = new HoaDonNhapHang7();
                    h.setId(rs.getInt("id"));
                    h.setMa(rs.getString("ma"));
                    h.setNgayNhap(rs.getDate("ngayNhap").toLocalDate());
                    model.Supplier7 s = new model.Supplier7();
                    s.setId(rs.getInt("sId"));
                    s.setMa(rs.getString("sMa"));
                    s.setTen(rs.getString("sTen"));
                    s.setDiaChi(rs.getString("diaChi"));
                    s.setSdt(rs.getString("sdt"));
                    s.setEmail(rs.getString("email"));
                    h.setSupplier(s);
                    Employee7 q = new Employee7();
                    q.setId(rs.getInt("qId"));
                    q.setHoTen(rs.getString("qTen"));
                    h.setManager(q);
                }
            }
            try (PreparedStatement ps = con.prepareStatement(sqlItems)) {
                ps.setInt(1, importInvoiceId);
                try (ResultSet rs = ps.executeQuery()) {
                    List<ImportDetail7> details = new ArrayList<>();
                    while (rs.next()) {
                        Product7 p = new Product7();
                        p.setId(rs.getInt("id"));
                        p.setTen(rs.getString("ten"));
                        ImportDetail7 d = new ImportDetail7();
                        d.setProduct(p);
                        d.setSoLuong(rs.getInt("soLuong"));
                        d.setDonGiaNhap(rs.getLong("donGiaNhap"));
                        details.add(d);
                    }
                    h.setDetails(details);
                }
            }
            return h;
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi lấy hóa đơn nhập", e);
        }
    }
}
