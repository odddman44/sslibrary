<%@page import="sslibrary.frontweb.database.UserDao"%>
<%@page import="sslibrary.frontweb.vo.Customer"%>
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
HttpSession sess = request.getSession();
Customer customer = (Customer) session.getAttribute("customer");
String isbnStr = request.getParameter("isbn");
UserDao dao = new UserDao();
int isbn = 0;
isbn = Integer.parseInt(isbnStr);
if (customer != null) {
%>
<script type="text/javascript">
    var isConfirmed = confirm("대출하시겠습니까?");
    
    if (isConfirmed) {
    	<%dao.insertRental(isbn,customer.getCno());%>
        alert("대출완료!");
        window.location.href = "detail.jsp?isbn=<%= isbn %>";
    } else {
        alert("대출이 취소되었습니다.");
        window.location.href = "detail.jsp?isbn=<%= isbn %>";
    }
</script>
<%
} else {
%>
<script type="text/javascript">
        // 서버에서 좋아요 업데이트 후 클라이언트 측에서 리다이렉트
        alert("로그인이 필요합니다!");
        window.location.href = "${path}/sslibrary/Main_SSH/loginPage.jsp";
    </script>
<%
}


%>
</body>
</html>