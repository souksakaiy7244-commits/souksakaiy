package model;

import util.ParamUtil;

/** Chi tiết nhập hàng: một hàng hóa trong một hóa đơn nhập. */
public class ImportDetail7 {
    private Product7 product;
    private int soLuong;
    private long donGiaNhap;

    public Product7 getProduct() { return product; }
    public void setProduct(Product7 product) { this.product = product; }
    public int getSoLuong() { return soLuong; }
    public void setSoLuong(int soLuong) { this.soLuong = soLuong; }
    public long getDonGiaNhap() { return donGiaNhap; }
    public void setDonGiaNhap(long donGiaNhap) { this.donGiaNhap = donGiaNhap; }

    public long getThanhTien() { return donGiaNhap * soLuong; }
    public String getDonGiaNhapText() { return ParamUtil.money(donGiaNhap); }
    public String getThanhTienText() { return ParamUtil.money(getThanhTien()); }
}
