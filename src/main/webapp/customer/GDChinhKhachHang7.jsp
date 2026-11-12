<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/jspf/checkCustomer.jspf" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Trang chính khách hàng - ShopMan</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<header>
  <strong>ShopMan</strong>
  <span>Xin chào, <c:out value="${member.hoTen}"/>
    <a href="${pageContext.request.contextPath}/logout.jsp">Đăng xuất</a></span>
</header>
<main>
  <h2>Trang chính khách hàng</h2>
  <div class="menu">
    <a class="btn" href="GDDanhSachHoaDonBanHang7.jsp">Theo dõi hóa đơn</a>
  </div>
</main>
</body>
</html>
