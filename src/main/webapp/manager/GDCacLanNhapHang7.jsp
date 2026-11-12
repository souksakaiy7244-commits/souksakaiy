<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/jspf/checkManager.jspf" %>
<%@ page import="dao.*, model.Supplier7, java.time.LocalDate, util.ParamUtil" %>
<%
    Integer supplierId = ParamUtil.parseInt(request.getParameter("supplierId"));
    LocalDate from = ParamUtil.parseDate(request.getParameter("from"));
    LocalDate to = ParamUtil.parseDate(request.getParameter("to"));
    Supplier7 supplier = null;
    boolean validRange = from != null && to != null && !from.isAfter(to);

    if (supplierId != null && validRange) {
        supplier = new Supplier7DAO().getSupplierInfo(supplierId);
        if (supplier != null) {
            request.setAttribute("imports", new HoaDonNhapHang7DAO().getImportBySupplier(supplierId, from, to));
        }
    }
    request.setAttribute("supplier", supplier);
    request.setAttribute("fromVal", from == null ? "" : from.toString());
    request.setAttribute("toVal", to == null ? "" : to.toString());
    request.setAttribute("fromText", from == null ? "" : from.format(ParamUtil.VN_DATE));
    request.setAttribute("toText", to == null ? "" : to.format(ParamUtil.VN_DATE));
%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Các lần nhập hàng - ShopMan</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<header>
  <strong>ShopMan</strong>
  <span>Xin chào, <c:out value="${member.hoTen}"/>
    <a href="${pageContext.request.contextPath}/logout.jsp">Đăng xuất</a></span>
</header>
<main>
  <h2>Các lần nhập hàng của nhà cung cấp</h2>
  <c:choose>
    <c:when test="${empty supplier}">
      <div class="error">Không tìm thấy nhà cung cấp hoặc khoảng thời gian không hợp lệ</div>
    </c:when>
    <c:otherwise>
      <dl class="info-grid">
        <dt>Nhà cung cấp</dt><dd><c:out value="${supplier.ten}"/> (<c:out value="${supplier.ma}"/>)</dd>
        <dt>Số điện thoại</dt><dd><c:out value="${supplier.sdt}"/></dd>
        <dt>Khoảng thời gian</dt><dd>${fromText} – ${toText}</dd>
      </dl>
      <c:choose>
        <c:when test="${empty imports}">
          <div class="info">Không có dữ liệu nhập hàng của nhà cung cấp</div>
        </c:when>
        <c:otherwise>
          <table>
            <thead>
              <tr><th>TT</th><th>Mã lần nhập</th><th>Ngày nhập</th>
                  <th class="num">Lượng hàng nhập</th><th class="num">Tổng tiền</th><th></th></tr>
            </thead>
            <tbody>
              <c:forEach var="h" items="${imports}" varStatus="st">
                <tr>
                  <td>${st.count}</td>
                  <td><c:out value="${h.ma}"/></td>
                  <td>${h.ngayNhapText}</td>
                  <td class="num">${h.tongSoLuong}</td>
                  <td class="num">${h.tongTienText}</td>
                  <td><a class="btn" href="GDChiTietHoaDonNhapHang7.jsp?id=${h.id}&supplierId=${supplier.id}&from=${fromVal}&to=${toVal}">Xem hóa đơn</a></td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </c:otherwise>
      </c:choose>
    </c:otherwise>
  </c:choose>
  <a class="btn secondary" href="GDThongKeNhaCungCapTheoHangNhap7.jsp?from=${fromVal}&to=${toVal}">Quay lại thống kê</a>
</main>
</body>
</html>
