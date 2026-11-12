<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="dao.MemberDAO7, model.Member7" %>
<%
    request.setCharacterEncoding("UTF-8");
    String error = null;
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String u = request.getParameter("username");
        String p = request.getParameter("password");
        if (u == null || u.isBlank() || p == null || p.isEmpty()) {
            error = "Vui lòng nhập tên đăng nhập và mật khẩu";
        } else {
            Member7 m = new MemberDAO7().login(u.trim(), p);
            if (m == null) {
                error = "Sai tên đăng nhập hoặc mật khẩu";
            } else {
                session.invalidate();
                session = request.getSession(true);
                session.setAttribute("member", m);
                String ctx = request.getContextPath();
                if ("CUSTOMER".equals(m.getRole())) {
                    response.sendRedirect(ctx + "/customer/GDChinhKhachHang7.jsp");
                } else if ("MANAGER".equals(m.getRole())) {
                    response.sendRedirect(ctx + "/manager/GDChinhQuanLy7.jsp");
                } else {
                    error = "Vai trò nhân viên bán hàng chưa có giao diện trong phạm vi hai module này.";
                    session.invalidate();
                }
                if (error == null) return;
            }
        }
    }
    request.setAttribute("error", error);
%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Đăng nhập - ShopMan</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<header><strong>ShopMan</strong></header>
<main>
  <h2 style="text-align:center">Đăng nhập</h2>
  <c:if test="${not empty error}"><div class="error"><c:out value="${error}"/></div></c:if>
  <form class="login" method="post" action="login.jsp">
    <label for="username">Tên đăng nhập</label>
    <input type="text" id="username" name="username" required autofocus>
    <label for="password">Mật khẩu</label>
    <input type="password" id="password" name="password" required>
    <button type="submit" style="width:100%">Đăng nhập</button>
  </form>
  <div class="info" style="max-width:340px;margin:20px auto 0">
    Tài khoản mẫu (mật khẩu <b>123456</b>):<br>
    Khách hàng: <b>khach1</b> &nbsp;|&nbsp; Quản lí: <b>quanly1</b>
  </div>
</main>
</body>
</html>
