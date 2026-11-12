package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Supplier7;

public class Supplier7DAO extends DAO {

    public Supplier7 getSupplierInfo(int supplierId) {
        String sql = "SELECT id, ma, ten, diaChi, sdt, email FROM tblNhaCungCap7 WHERE id = ?";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, supplierId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return map(rs);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi lấy thông tin nhà cung cấp", e);
        }
        return null;
    }

    static Supplier7 map(ResultSet rs) throws SQLException {
        Supplier7 s = new Supplier7();
        s.setId(rs.getInt("id"));
        s.setMa(rs.getString("ma"));
        s.setTen(rs.getString("ten"));
        s.setDiaChi(rs.getString("diaChi"));
        s.setSdt(rs.getString("sdt"));
        s.setEmail(rs.getString("email"));
        return s;
    }
}
