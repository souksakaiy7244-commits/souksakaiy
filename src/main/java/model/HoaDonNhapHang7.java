package model;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import util.ParamUtil;

/** Hóa đơn nhập hàng (một lần nhập hàng từ một nhà cung cấp). */
public class HoaDonNhapHang7 {
    private int id;
    private String ma;
    private Supplier7 supplier;
    private Employee7 manager;
    private LocalDate ngayNhap;
    private int tongSoLuong; // dùng cho danh sách các lần nhập
    private long tongTien;   // dùng cho danh sách các lần nhập
    private List<ImportDetail7> details = new ArrayList<>();

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getMa() { return ma; }
    public void setMa(String ma) { this.ma = ma; }
    public Supplier7 getSupplier() { return supplier; }
    public void setSupplier(Supplier7 supplier) { this.supplier = supplier; }
    public Employee7 getManager() { return manager; }
    public void setManager(Employee7 manager) { this.manager = manager; }
    public LocalDate getNgayNhap() { return ngayNhap; }
    public void setNgayNhap(LocalDate ngayNhap) { this.ngayNhap = ngayNhap; }
    public void setTongSoLuong(int tongSoLuong) { this.tongSoLuong = tongSoLuong; }
    public void setTongTien(long tongTien) { this.tongTien = tongTien; }
    public List<ImportDetail7> getDetails() { return details; }
    public void setDetails(List<ImportDetail7> details) { this.details = details; }

    public int getTongSoLuong() {
        if (!details.isEmpty()) {
            int t = 0;
            for (ImportDetail7 d : details) t += d.getSoLuong();
            return t;
        }
        return tongSoLuong;
    }
    public long getTongTien() {
        if (!details.isEmpty()) {
            long t = 0;
            for (ImportDetail7 d : details) t += d.getThanhTien();
            return t;
        }
        return tongTien;
    }
    public String getTongTienText() { return ParamUtil.money(getTongTien()); }
    public String getNgayNhapText() { return ngayNhap == null ? "" : ngayNhap.format(ParamUtil.VN_DATE); }
}
