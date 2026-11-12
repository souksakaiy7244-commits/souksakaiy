package dao;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Member7;

public class MemberDAO7 extends DAO {

    /** Đăng nhập: trả về thành viên nếu đúng tài khoản/mật khẩu, ngược lại null. */
    public Member7 login(String username, String password) {
        String sql = "SELECT id, username, hoTen, sdt, email, role FROM tblThanhVien7 "
                   + "WHERE username = ? AND password = ?";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, sha256(password));
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Member7 m = new Member7();
                    m.setId(rs.getInt("id"));
                    m.setUsername(rs.getString("username"));
                    m.setHoTen(rs.getString("hoTen"));
                    m.setSdt(rs.getString("sdt"));
                    m.setEmail(rs.getString("email"));
                    m.setRole(rs.getString("role"));
                    return m;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi truy vấn đăng nhập", e);
        }
        return null;
    }

    static String sha256(String s) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] h = md.digest(s.getBytes(StandardCharsets.UTF_8));
            StringBuilder sb = new StringBuilder();
            for (byte b : h) sb.append(String.format("%02x", b));
            return sb.toString();
        } catch (Exception e) {
            throw new IllegalStateException(e);
        }
    }
}
