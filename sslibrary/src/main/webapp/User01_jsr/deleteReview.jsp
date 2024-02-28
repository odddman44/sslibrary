<%@page import="sslibrary.frontweb.database.UserDao"%>
<%@page import="sslibrary.frontweb.vo.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*"
    import="backendweb.z01_vo.*"
    import="backendweb.d01_dao.*"
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String isbnStr = request.getParameter("isbn");
String rnoStr = request.getParameter("rno");
UserDao dao = new UserDao();
int rno = 0;
int isbn = 0;
isbn = Integer.parseInt(isbnStr);
rno = Integer.parseInt(rnoStr);
%>
<script type="text/javascript">
    var isConfirmed = confirm("리뷰를 삭제하시겠습니까?");
    
    if (isConfirmed) {
    	<%dao.deleteReview(rno);%>
        alert("삭제완료!");
        window.location.href = "detail.jsp?isbn=<%= isbn %>";
    } else {
        alert("삭제가 취소되었습니다.");
        window.location.href = "detail.jsp?isbn=<%= isbn %>";
    }
</script>
</body>
</html>