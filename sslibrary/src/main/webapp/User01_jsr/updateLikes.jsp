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
    dao.updateLikes(isbn);
%>
    <script type="text/javascript">
        // 서버에서 좋아요 업데이트 후 클라이언트 측에서 리다이렉트
        alert("좋아요!");
        window.location.href = "detail.jsp?isbn=<%= isbn %>";
    </script>
<%
}
%>

</body>
</html>