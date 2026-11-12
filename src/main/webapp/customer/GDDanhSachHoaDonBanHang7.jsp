<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/jspf/checkCustomer.jspf" %>
<%@ page import="dao.HoaDonBanHang7DAO" %>
<%
    request.setAttribute("list", new HoaDonBanHang7DAO().getAll(_me.getId()));
%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Danh sách hóa đơn - ShopMan</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<header>
  <strong>ShopMan</strong>
  <span>Xin chào, <c:out value="${member.hoTen}"/>
    <a href="${pageContext.request.contextPath}/logout.jsp">Đăng xuất</a></span>
</header>
<main>
  <h2>Theo dõi hóa đơn</h2>
  <c:choose>
    <c:when test="${empty list}">
      <div class="info">Không có hóa đơn để theo dõi</div>
    </c:when>
    <c:otherwise>
      <table>
        <thead>
          <tr><th>TT</th><th>Mã hóa đơn</th><th>Ngày lập</th><th class="num">Tổng tiền</th><th>Trạng thái</th><th></th></tr>
        </thead>
        <tbody>
          <c:forEach var="h" items="${list}" varStatus="st">
            <tr>
              <td>${st.count}</td>
              <td><c:out value="${h.ma}"/></td>
              <td>${h.ngayLapText}</td>
              <td class="num">${h.tongTienText}</td>
              <td><span class="badge ${h.trangThai}"><c:out value="${h.trangThaiText}"/></span></td>
              <td><a class="btn" href="GDChiTietHoaDonBanHang7.jsp?id=${h.id}">Xem chi tiết</a></td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </c:otherwise>
  </c:choose>
  <a class="btn secondary" href="GDChinhKhachHang7.jsp">Quay lại</a>
</main>
</body>
</html>
