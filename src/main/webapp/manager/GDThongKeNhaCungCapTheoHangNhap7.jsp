<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/jspf/checkManager.jspf" %>
<%@ page import="dao.TKNhaCungCap7DAO, java.time.LocalDate, util.ParamUtil" %>
<%
    String fromParam = request.getParameter("from");
    String toParam = request.getParameter("to");
    LocalDate from = ParamUtil.parseDate(fromParam);
    LocalDate to = ParamUtil.parseDate(toParam);
    String error = null;
    boolean submitted = fromParam != null || toParam != null;

    if (submitted) {
        if (from == null || to == null) {
            error = "Vui lòng chọn ngày bắt đầu và ngày kết thúc";
        } else if (from.isAfter(to)) {
            error = "Khoảng thời gian không hợp lệ";   // ngày bắt đầu phải <= ngày kết thúc
        } else {
            request.setAttribute("stats", new TKNhaCungCap7DAO().getSupplierStatistic(from, to));
        }
    }
    request.setAttribute("submitted", submitted && error == null);
    request.setAttribute("error", error);
    request.setAttribute("fromVal", from == null ? "" : from.toString());
    request.setAttribute("toVal", to == null ? "" : to.toString());
%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Thống kê nhà cung cấp - ShopMan</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<header>
  <strong>ShopMan</strong>
  <span>Xin chào, <c:out value="${member.hoTen}"/>
    <a href="${pageContext.request.contextPath}/logout.jsp">Đăng xuất</a></span>
</header>
<main>
  <h2>Thống kê nhà cung cấp theo lượng hàng nhập</h2>

  <form method="get" action="GDThongKeNhaCungCapTheoHangNhap7.jsp">
    <label for="from">Từ ngày</label>
    <input type="date" id="from" name="from" value="${fromVal}" required>
    <label for="to">Đến ngày</label>
    <input type="date" id="to" name="to" value="${toVal}" required>
    <button type="submit">Xem thống kê</button>
  </form>

  <c:if test="${not empty error}"><div class="error"><c:out value="${error}"/></div></c:if>

  <c:if test="${submitted}">
    <c:choose>
      <c:when test="${empty stats}">
        <div class="info">Không có dữ liệu nhập hàng trong khoảng thời gian đã chọn</div>
      </c:when>
      <c:otherwise>
        <table>
          <thead>
            <tr><th>TT</th><th>Mã NCC</th><th>Tên nhà cung cấp</th><th>Số điện thoại</th>
                <th class="num">Lượng hàng nhập</th><th class="num">Tổng tiền</th></tr>
          </thead>
          <tbody>
            <c:forEach var="t" items="${stats}" varStatus="st">
              <tr>
                <td>${st.count}</td>
                <td><c:out value="${t.supplier.ma}"/></td>
                <td><a href="GDCacLanNhapHang7.jsp?supplierId=${t.supplier.id}&from=${fromVal}&to=${toVal}">
                      <c:out value="${t.supplier.ten}"/></a></td>
                <td><c:out value="${t.supplier.sdt}"/></td>
                <td class="num">${t.tongSoLuong}</td>
                <td class="num">${t.tongTienText}</td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
        <p><small>Bấm vào tên nhà cung cấp để xem các lần nhập hàng.</small></p>
      </c:otherwise>
    </c:choose>
  </c:if>

  <p><a class="btn secondary" href="GDChonCachThongKe7.jsp">Quay lại</a></p>
</main>
</body>
</html>
