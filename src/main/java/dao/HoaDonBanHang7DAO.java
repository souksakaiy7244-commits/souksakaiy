package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import model.Customer7;
import model.HoaDonBanHang7;
import model.InvoiceDetail7;
import model.Product7;

/** Module "Khách hàng theo dõi hóa đơn". */
public class HoaDonBanHang7DAO extends DAO {

    /** Danh sách hóa đơn của khách hàng hiện tại (mới nhất trước). */
    public List<HoaDonBanHang7> getAll(int customerId) {
        String sql = "SELECT h.id, h.ma, h.ngayLap, h.trangThai, "
                   + "       COALESCE(SUM(c.soLuong * c.donGia), 0) AS tongTien "
                   + "FROM tblHoaDonBanHang7 h "
                   + "LEFT JOIN tblChiTietHoaDon7 c ON c.hoaDonId = h.id "
                   + "WHERE h.khachHangId = ? "
                   + "GROUP BY h.id, h.ma, h.ngayLap, h.trangThai "
                   + "ORDER BY h.ngayLap DESC";
        List<HoaDonBanHang7> list = new ArrayList<>();
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    HoaDonBanHang7 h = new HoaDonBanHang7();
                    h.setId(rs.getInt("id"));
                    h.setMa(rs.getString("ma"));
                    h.setNgayLap(rs.getTimestamp("ngayLap").toLocalDateTime());
                    h.setTrangThai(rs.getString("trangThai"));
                    h.setTongTien(rs.getLong("tongTien"));
                    list.add(h);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi lấy danh sách hóa đơn", e);
        }
        return list;
    }

    /**
     * Chi tiết một hóa đơn; chỉ trả về nếu hóa đơn thuộc khách hàng customerId
     * (ngược lại trả null -> "Không tìm thấy hóa đơn").
     */
    public HoaDonBanHang7 getItem(int invoiceId, int customerId) {
        String sqlHead = "SELECT h.id, h.ma, h.ngayLap, h.trangThai, t.id AS khId, t.hoTen "
                       + "FROM tblHoaDonBanHang7 h "
                       + "JOIN tblThanhVien7 t ON t.id = h.khachHangId "
                       + "WHERE h.id = ? AND h.khachHangId = ?";
        String sqlItems = "SELECT g.id, g.ten, c.soLuong, c.donGia "
                        + "FROM tblChiTietHoaDon7 c "
                        + "JOIN tblHangHoa7 g ON g.id = c.hangHoaId "
                        + "WHERE c.hoaDonId = ? ORDER BY c.id";
        try (Connection con = getConnection()) {
            HoaDonBanHang7 h;
            try (PreparedStatement ps = con.prepareStatement(sqlHead)) {
                ps.setInt(1, invoiceId);
                ps.setInt(2, customerId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (!rs.next()) return null;
                    h = new HoaDonBanHang7();
                    h.setId(rs.getInt("id"));
                    h.setMa(rs.getString("ma"));
                    Timestamp ts = rs.getTimestamp("ngayLap");
                    h.setNgayLap(ts.toLocalDateTime());
                    h.setTrangThai(rs.getString("trangThai"));
                    Customer7 c = new Customer7();
                    c.setId(rs.getInt("khId"));
                    c.setHoTen(rs.getString("hoTen"));
                    h.setCustomer(c);
                }
            }
            try (PreparedStatement ps = con.prepareStatement(sqlItems)) {
                ps.setInt(1, invoiceId);
                try (ResultSet rs = ps.executeQuery()) {
                    List<InvoiceDetail7> details = new ArrayList<>();
                    while (rs.next()) {
                        Product7 p = new Product7();
                        p.setId(rs.getInt("id"));
                        p.setTen(rs.getString("ten"));
                        InvoiceDetail7 d = new InvoiceDetail7();
                        d.setProduct(p);
                        d.setSoLuong(rs.getInt("soLuong"));
                        d.setDonGia(rs.getLong("donGia"));
                        details.add(d);
                    }
                    h.setDetails(details);
                }
            }
            return h;
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi lấy chi tiết hóa đơn", e);
        }
    }
}
