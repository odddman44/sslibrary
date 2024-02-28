<%@page import="sslibrary.frontweb.database.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*"
    import="backendweb.z01_vo.*"
    import="backendweb.d01_dao.*"
    %>
<!DOCTYPE html>
<%--


 --%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body>
<%
String isbnStr = request.getParameter("isbn");
int isbn = 0;
if(isbnStr != null) {
    isbn = Integer.parseInt(isbnStr);
    UserDao dao = new UserDao();
    dao.updateThumbs(isbn);
%>
    <script type="text/javascript">
        alert("추천합니다!");
        window.location.href = "detail.jsp?isbn=<%= isbn %>";
    </script>
<%
}
%>

</body>
</html>