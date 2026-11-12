<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/jspf/checkCustomer.jspf" %>
<%@ page import="dao.HoaDonBanHang7DAO, model.HoaDonBanHang7, util.ParamUtil" %>
<%
    Integer invoiceId = ParamUtil.parseInt(request.getParameter("id"));
    HoaDonBanHang7 inv = null;
    if (invoiceId != null) {
        // getItem kiểm tra luôn hóa đơn có thuộc khách hàng đang đăng nhập hay không
        inv = new HoaDonBanHang7DAO().getItem(invoiceId, _me.getId());
    }
    request.setAttribute("inv", inv);
%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Chi tiết hóa đơn - ShopMan</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<header>
  <strong>ShopMan</strong>
  <span>Xin chào, <c:out value="${member.hoTen}"/>
    <a href="${pageContext.request.contextPath}/logout.jsp">Đăng xuất</a></span>
</header>
<main>
  <h2>Chi tiết hóa đơn</h2>
  <c:choose>
    <c:when test="${empty inv}">
      <div class="error">Không tìm thấy hóa đơn</div>
    </c:when>
    <c:otherwise>
      <dl class="info-grid">
        <dt>Mã hóa đơn</dt><dd><c:out value="${inv.ma}"/></dd>
        <dt>Ngày lập</dt><dd>${inv.ngayLapText}</dd>
        <dt>Khách hàng</dt><dd><c:out value="${inv.customer.hoTen}"/></dd>
        <dt>Trạng thái</dt><dd><span class="badge ${inv.trangThai}"><c:out value="${inv.trangThaiText}"/></span></dd>
        <dt>Tổng tiền</dt><dd><b>${inv.tongTienText}</b></dd>
      </dl>

      <h3>Chi tiết hàng hóa</h3>
      <table>
        <thead>
          <tr><th>STT</th><th>Tên hàng hóa</th><th class="num">Đơn giá</th><th class="num">Số lượng</th><th class="num">Thành tiền</th></tr>
        </thead>
        <tbody>
          <c:forEach var="d" items="${inv.details}" varStatus="st">
            <tr>
              <td>${st.count}</td>
              <td><c:out value="${d.product.ten}"/></td>
              <td class="num">${d.donGiaText}</td>
              <td class="num">${d.soLuong}</td>
              <td class="num">${d.thanhTienText}</td>
            </tr>
          </c:forEach>
        </tbody>
        <tfoot>
          <tr><th colspan="4" class="num">Tổng tiền</th><th class="num">${inv.tongTienText}</th></tr>
        </tfoot>
      </table>
    </c:otherwise>
  </c:choose>
  <a class="btn secondary" href="GDDanhSachHoaDonBanHang7.jsp">Quay lại danh sách</a>
</main>
</body>
</html>
