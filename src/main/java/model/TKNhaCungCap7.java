package model;

import util.ParamUtil;

/** Thống kê nhà cung cấp: nhà cung cấp + tổng lượng hàng nhập trong khoảng thời gian. */
public class TKNhaCungCap7 {
    private Supplier7 supplier;
    private long tongSoLuong;
    private long tongTien;

    public Supplier7 getSupplier() { return supplier; }
    public void setSupplier(Supplier7 supplier) { this.supplier = supplier; }
    public long getTongSoLuong() { return tongSoLuong; }
    public void setTongSoLuong(long tongSoLuong) { this.tongSoLuong = tongSoLuong; }
    public long getTongTien() { return tongTien; }
    public void setTongTien(long tongTien) { this.tongTien = tongTien; }
    public String getTongTienText() { return ParamUtil.money(tongTien); }
}
