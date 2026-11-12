package model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import util.ParamUtil;

/** Hóa đơn bán hàng (đơn khách hàng đặt trực tuyến). */
public class HoaDonBanHang7 {
    private int id;
    private String ma;
    private Customer7 customer;
    private LocalDateTime ngayLap;
    private String trangThai;
    private long tongTien; // dùng cho danh sách (không cần nạp chi tiết)
    private List<InvoiceDetail7> details = new ArrayList<>();

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getMa() { return ma; }
    public void setMa(String ma) { this.ma = ma; }
    public Customer7 getCustomer() { return customer; }
    public void setCustomer(Customer7 customer) { this.customer = customer; }
    public LocalDateTime getNgayLap() { return ngayLap; }
    public void setNgayLap(LocalDateTime ngayLap) { this.ngayLap = ngayLap; }
    public String getTrangThai() { return trangThai; }
    public void setTrangThai(String trangThai) { this.trangThai = trangThai; }
    public void setTongTien(long tongTien) { this.tongTien = tongTien; }
    public List<InvoiceDetail7> getDetails() { return details; }
    public void setDetails(List<InvoiceDetail7> details) { this.details = details; }

    public long getTongTien() {
        if (!details.isEmpty()) {
            long t = 0;
            for (InvoiceDetail7 d : details) t += d.getThanhTien();
            return t;
        }
        return tongTien;
    }
    public String getTongTienText() { return ParamUtil.money(getTongTien()); }

    public String getNgayLapText() {
        return ngayLap == null ? "" : ngayLap.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
    }

    public String getTrangThaiText() {
        if (trangThai == null) return "";
        switch (trangThai) {
            case "CHO_DUYET":      return "Chờ duyệt";
            case "DA_DUYET":       return "Đã duyệt";
            case "DANG_DONG_HANG": return "Đang đóng hàng";
            case "DA_BAN_GIAO":    return "Đã bàn giao";
            case "DA_GIAO":        return "Đã giao hàng";
            default:               return trangThai;
        }
    }
}
