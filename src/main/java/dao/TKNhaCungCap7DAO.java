package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import model.Supplier7;
import model.TKNhaCungCap7;

/** Module "Thống kê nhà cung cấp theo lượng hàng nhập". */
public class TKNhaCungCap7DAO extends DAO {

    /**
     * Tổng hợp lượng hàng và tiền nhập theo từng nhà cung cấp trong [startDate, endDate],
     * sắp xếp theo lượng hàng nhập giảm dần.
     */
    public List<TKNhaCungCap7> getSupplierStatistic(LocalDate startDate, LocalDate endDate) {
        String sql = "SELECT s.id, s.ma, s.ten, s.diaChi, s.sdt, s.email, "
                   + "       SUM(c.soLuong) AS tongSoLuong, "
                   + "       SUM(c.soLuong * c.donGiaNhap) AS tongTien "
                   + "FROM tblNhaCungCap7 s "
                   + "JOIN tblHoaDonNhapHang7 h ON h.nhaCungCapId = s.id "
                   + "JOIN tblChiTietNhapHang7 c ON c.hoaDonNhapId = h.id "
                   + "WHERE h.ngayNhap BETWEEN ? AND ? "
                   + "GROUP BY s.id, s.ma, s.ten, s.diaChi, s.sdt, s.email "
                   + "ORDER BY tongSoLuong DESC, s.ten";
        List<TKNhaCungCap7> list = new ArrayList<>();
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setDate(1, Date.valueOf(startDate));
            ps.setDate(2, Date.valueOf(endDate));
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Supplier7 s = Supplier7DAO.map(rs);
                    TKNhaCungCap7 t = new TKNhaCungCap7();
                    t.setSupplier(s);
                    t.setTongSoLuong(rs.getLong("tongSoLuong"));
                    t.setTongTien(rs.getLong("tongTien"));
                    list.add(t);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi thống kê nhà cung cấp", e);
        }
        return list;
    }
}
