package model;

import util.ParamUtil;

/** Chi tiết hóa đơn bán: một hàng hóa trong một hóa đơn. */
public class InvoiceDetail7 {
    private Product7 product;
    private int soLuong;
    private long donGia;

    public Product7 getProduct() { return product; }
    public void setProduct(Product7 product) { this.product = product; }
    public int getSoLuong() { return soLuong; }
    public void setSoLuong(int soLuong) { this.soLuong = soLuong; }
    public long getDonGia() { return donGia; }
    public void setDonGia(long donGia) { this.donGia = donGia; }

    public long getThanhTien() { return donGia * soLuong; }
    public String getDonGiaText() { return ParamUtil.money(donGia); }
    public String getThanhTienText() { return ParamUtil.money(getThanhTien()); }
}
