<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"    
    import="java.util.*"
    import ="sslibrary.frontweb.vo.*"
    import="sslibrary.frontweb.database.AdminDao"
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<fmt:requestEncoding value="utf-8"/>
<%
String proc = request.getParameter("proc");
String isbnStr = request.getParameter("isbn");
String title = request.getParameter("title");
String authorName = request.getParameter("authorName");
String publisher = request.getParameter("publisher");
String yearStr = request.getParameter("year");

log("##isbnStr:"+isbnStr);
int isbn = 0;
int year = 0;
if(yearStr!=null) year = Integer.parseInt(yearStr);
if(proc==null) proc="";
boolean isProc = false;
if(isbnStr!=null){
	isbn = Integer.parseInt(isbnStr);
	Ebook upt = new Ebook(isbn, title, authorName, publisher, year);
	log("##isbn:"+isbn);
	AdminDao dao = new AdminDao();
	if(proc.equals("upt")){
		dao.updateBook(upt);
	}
	if(proc.equals("del")){
		dao.deleteBook(isbn);
	}
	isProc = true;
}
%>     
<!DOCTYPE html>
<html>
<head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>관리자페이지 - 쌍용도서관</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet"/>
        <link href="css/styles.css" rel="stylesheet" />
        <link href="css/custom_styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <script src="${path}/com/jquery-3.6.0.js"></script>
		<script>
			var isProc = <%=isProc%>;
			var proc = "<%=proc%>";
			if(proc=="upt"){
				if(confirm("<%=isbn%>수정완료\n상세화면이동은 확인, 전체화면이동은 취소")){
					location.href="tab06_1_bookDetail.jsp?isbn=<%=isbn%>";
				}else{
					location.href="tab06_newBook.jsp";
				}
			}
			if(proc=="del"){
				alert("삭제완료\n 전체화면으로 이동")
				location.href="tab06_newBook.jsp";
			}
		$(document).ready( function(){
			$("h2").text("수정처리:<%=isbn%>");
		})
		</script>
    </head>
    <body class="sb-nav-fixed">
        <%@ include file="header_nav.jsp" %>
        
		<div id="layoutSidenav">
        <%@ include file="side_nav.jsp" %>
        
            <div id="layoutSidenav_content">
                <main>

                </main>
      			<%@ include file="footer.jsp" %>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="js/scripts.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src="assets/demo/chart-area-demo.js"></script>
        <script src="assets/demo/chart-bar-demo.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
        <script src="js/datatables-simple-demo.js"></script>
    </body>
</html>