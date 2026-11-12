<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/jspf/checkManager.jspf" %>
<%@ page import="dao.HoaDonNhapHang7DAO, model.HoaDonNhapHang7, java.time.LocalDate, util.ParamUtil" %>
<%
    Integer id = ParamUtil.parseInt(request.getParameter("id"));
    Integer supplierId = ParamUtil.parseInt(request.getParameter("supplierId"));
    LocalDate from = ParamUtil.parseDate(request.getParameter("from"));
    LocalDate to = ParamUtil.parseDate(request.getParameter("to"));

    HoaDonNhapHang7 inv = (id == null) ? null : new HoaDonNhapHang7DAO().getHoaDonNhapHang(id);
    request.setAttribute("inv", inv);

    // Đường quay lại danh sách các lần nhập (nếu đủ tham số), ngược lại về trang thống kê
    String back = "GDThongKeNhaCungCapTheoHangNhap7.jsp";
    if (supplierId != null && from != null && to != null) {
        back = "GDCacLanNhapHang7.jsp?supplierId=" + supplierId + "&from=" + from + "&to=" + to;
    }
    request.setAttribute("back", back);
%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Hóa đơn nhập hàng - ShopMan</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<header>
  <strong>ShopMan</strong>
  <span>Xin chào, <c:out value="${member.hoTen}"/>
    <a href="${pageContext.request.contextPath}/logout.jsp">Đăng xuất</a></span>
</header>
<main>
  <h2>Hóa đơn nhập hàng</h2>
  <c:choose>
    <c:when test="${empty inv}">
      <div class="error">Không tìm thấy hóa đơn nhập</div>
    </c:when>
    <c:otherwise>
      <dl class="info-grid">
        <dt>Mã hóa đơn nhập</dt><dd><c:out value="${inv.ma}"/></dd>
        <dt>Ngày nhập</dt><dd>${inv.ngayNhapText}</dd>
        <dt>Nhà cung cấp</dt><dd><c:out value="${inv.supplier.ten}"/></dd>
        <dt>Người nhập</dt><dd><c:out value="${inv.manager.hoTen}"/></dd>
        <dt>Tổng tiền</dt><dd><b>${inv.tongTienText}</b></dd>
      </dl>

      <h3>Chi tiết hàng nhập</h3>
      <table>
        <thead>
          <tr><th>STT</th><th>Tên hàng hóa</th><th class="num">Đơn giá nhập</th><th class="num">Số lượng</th><th class="num">Thành tiền</th></tr>
        </thead>
        <tbody>
          <c:forEach var="d" items="${inv.details}" varStatus="st">
            <tr>
              <td>${st.count}</td>
              <td><c:out value="${d.product.ten}"/></td>
              <td class="num">${d.donGiaNhapText}</td>
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
  <a class="btn secondary" href="${back}">Quay lại</a>
</main>
</body>
</html>
