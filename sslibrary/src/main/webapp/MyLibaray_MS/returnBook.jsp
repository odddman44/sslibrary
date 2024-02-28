<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*"
  	import="sslibrary.frontweb.database.*"
	import="sslibrary.frontweb.vo.*"
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<fmt:requestEncoding value="utf-8"/>     
<!DOCTYPE html>
<%--

// 책 읽기 jsp
 --%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${path}/a00_com/bootstrap.min.css" >
<link rel="stylesheet" href="${path}/a00_com/jquery-ui.css" >
<style>
	td{text-align:center;}
</style>
<script src="${path}/a00_com/jquery.min.js"></script>
<script src="${path}/a00_com/popper.min.js"></script>
<script src="${path}/a00_com/bootstrap.min.js"></script>
<script src="${path}/a00_com/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api" type="text/javascript"></script>
<script type="text/javascript">
	$(document).ready(function(){
		<%-- 
		
		--%>	
	});
</script>

</head>
<%
	Customer c01 = (Customer) session.getAttribute("customer");
	int cno = (c01 != null) ? c01.getCno() : 0;
	System.out.println("회원번호"+cno);
	int isbn = Integer.parseInt(request.getParameter("isbn"));
	int isReturn = 0; // 반납여부 0이면 반납x 1이면 반납 O
	if(cno!=0){
		MyLibraryDao dao = new MyLibraryDao();
		isReturn = dao.returnBook(isbn, cno);
	}
	String msg = "";
	msg = isReturn ==1 ? "도서가 정상적으로 반납되었습니다.":"도서 반납에 실패했습니다.";
	// pagaScope로 msg를 저장
	pageContext.setAttribute("msg", msg);
%>
<body>
<div class="jumbotron text-center"> 
  <h2>${msg}</h2>
  <button type="button" style="background-color:orange" onclick="window.close()">확인</button>

</div>
   
</body>
</html>