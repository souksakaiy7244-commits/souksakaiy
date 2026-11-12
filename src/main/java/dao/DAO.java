package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/** Lớp DAO cơ sở: cấp kết nối MySQL. Có thể đổi bằng biến môi trường DB_URL, DB_USER, DB_PASS. */
public class DAO {
    private static final String URL = env("DB_URL",
            "jdbc:mysql://localhost:3306/shopman?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Ho_Chi_Minh");
    private static final String USER = env("DB_USER", "root");
    private static final String PASS = env("DB_PASS", "");

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new ExceptionInInitializerError(e);
        }
    }

    private static String env(String key, String def) {
        String v = System.getenv(key);
        return (v == null || v.isEmpty()) ? def : v;
    }

    protected Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASS);
    }
}
