package model;

/** Thành viên hệ thống (lớp cha của Employee7 và Customer7). */
public class Member7 {
    private int id;
    private String username;
    private String hoTen;
    private String sdt;
    private String email;
    private String role; // CUSTOMER | MANAGER | SALESMAN

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getHoTen() { return hoTen; }
    public void setHoTen(String hoTen) { this.hoTen = hoTen; }
    public String getSdt() { return sdt; }
    public void setSdt(String sdt) { this.sdt = sdt; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
}
