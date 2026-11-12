<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/jspf/checkManager.jspf" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Chọn cách thống kê - ShopMan</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<header>
  <strong>ShopMan</strong>
  <span>Xin chào, <c:out value="${member.hoTen}"/>
    <a href="${pageContext.request.contextPath}/logout.jsp">Đăng xuất</a></span>
</header>
<main>
  <h2>Xem báo cáo</h2>
  <div class="menu">
    <a class="btn" href="GDThongKeNhaCungCapTheoHangNhap7.jsp">Thống kê nhà cung cấp theo lượng hàng nhập</a>
  </div>
  <p><a class="btn secondary" href="GDChinhQuanLy7.jsp">Quay lại</a></p>
</main>
</body>
</html>
