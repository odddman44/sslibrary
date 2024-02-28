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
String isbnStr = request.getParameter("isbn");
int isbn = 0;
Ebook book = new Ebook();
if(isbnStr!=null) {
	isbn = Integer.parseInt(isbnStr);
	AdminDao dao = new AdminDao();
	book = dao.getBookInfo(isbn);
	
    if(book == null) {
        // 책 정보가 없는 경우, 오류 메시지 표시 또는 다른 페이지로 리디렉션
        out.println("<script>alert('책 정보를 찾을 수 없습니다.'); location.href='tab06_newBook.jsp';</script>");
        return; // 이후 코드 실행 방지
    }
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
        <title>도서상세정보 - 관리자페이지</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet"/>
        <link href="css/styles.css" rel="stylesheet" />
        <link href="css/custom_styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        
        <script src="${path}/com/jquery-3.6.0.js"></script>
		<script>
		$(document).ready( function(){
			$("h2").text("책 상세 정보 : ISBN <%=isbn%>");
			$("#uptBtn").click(function(){
				if(confirm("수정하시겠습니까?")){
					$("[name=proc]").val("upt")
					$("form").attr("action", "tab06_2_bookProc.jsp");
					$("form").submit();
				}
			})
			$("#delBtn").click(function(){
				if(confirm("정말 삭제하시겠습니까?")){
					$("[name=proc]").val("del")
					$("form").attr("action", "tab06_2_bookProc.jsp");
					$("form").submit();
				}
			})
		})
		</script>
    </head>
    <body class="sb-nav-fixed">
        <%@ include file="header_nav.jsp" %>
        
		<div id="layoutSidenav">
        <%@ include file="side_nav.jsp" %>
        
            <div id="layoutSidenav_content">
                <main style="padding-top: 60px;">
    				<div class="container-fluid px-4">
					    <h2 align="center"></h2>
					    <form>
					        <input type="hidden" name="proc"/>
					    <div class="table-responsive" style="max-width: 800px; margin: auto;"> 
            				<table class="table table-bordered table-striped table-hover">
					            <col width="40%">
					            <tr>
					                <th>ISBN</th>
					                <td><input type="number" class="form-control" name="isbn" value="<%=book.getIsbn() %>" readonly/></td>
					            </tr>
					            <tr>
					                <th>책 제목</th>
					                <td><input type="text" class="form-control" name="title" value="<%=book.getTitle() %>"/></td>
					            </tr>
					            <tr>
					                <th>저자</th>
					                <td><input type="text" class="form-control" name="authorName" value="<%=book.getAuthorName() %>"/></td>
					            </tr>
					            <tr>
					                <th>출판사</th>
					                <td><input type="text" class="form-control" name="publisher" value="<%=book.getPublisher() %>"/></td>
					            </tr>
					            <tr>
					                <th>출판년도</th>
					                <td><input type="number" class="form-control" name="year" value="<%=book.getYear() %>"/></td>
					            </tr>
					            <tr>
					                <th colspan="2" class="text-center">
					                    <button type="button" id="uptBtn" class="btn btn-success">수정</button>
					                    <button type="button" id="delBtn" class="btn btn-danger">삭제</button>
					                    <button type="button" class="btn btn-primary" onclick="location.href='tab06_newBook.jsp'">메인리스트화면</button>
					                </th>
					            </tr>
					        </table>
					    </div>
					    </form>
					</div>
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