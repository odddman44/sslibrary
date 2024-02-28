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
        <!-- db테이블 페이징 관련 링크, table id=myTable로 하셈. -->
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.css">
        <script type="text/javascript" src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.js"></script>
		<script>
		$(document).ready(function() {
		    $(".return-btn").click(function() {
		        var isbn = $(this).data("isbn");
		        var cno = $(this).data("cno");
		        if(confirm("해당 도서를 반납하시겠습니까?")) {
		            window.location.href = "returnBookAction.jsp?action=return&isbn=" + isbn + "&cno=" + cno;
		        }
		    });

		    $(".extend-btn").click(function() {
		        var isbn = $(this).data("isbn");
		        var cno = $(this).data("cno");
		        if(confirm("도서 기한을 7일연장하시겠습니까?")) {
		            window.location.href = "returnBookAction.jsp?action=extend&isbn=" + isbn + "&cno=" + cno;
		        }
		    });
		    
		    $('#myTable').DataTable();
		});
		</script>
    </head>
<body class="sb-nav-fixed">
	<%@ include file="header_nav.jsp"%>

	<div id="layoutSidenav">
		<%@ include file="side_nav.jsp"%>
		<div id="layoutSidenav_content">
		
			<main>
			<br>
			<h1 class="font-weight-bold text-center">회원 대출 관리</h1>
				<div class="container">
				<h6 class="text-muted">책 제목, 저자, 출판사, 회원명, 회원id로 검색.. </h6>
				    <form id="frmSearch" class="form" method="post">
						<nav class="navbar navbar-expand-lg navbar-light bg-light">
							<div class="navbar-nav row w-100">
								<div class="col-md-10">
									<input placeholder="검색할 키워드를 입력.." name="searchKeyword"
										value="${param.searchKeyword}" class="form-control" />
								</div>
								<div class="col-md-2">
									<button class="btn btn-outline-success w-100" type="submit">Search</button>
								</div>
							</div>
						</nav>
					</form>
					<table id="myTable" class="table table-hover table-striped">
						<thead>
							<tr class="table-success text-center">
								<!-- 테이블 헤더 // isbn, title, author_name, publisher, year, 
								customer_id, customer_name, rental_date, return_date -->
								<th>ISBN</th>
								<th>책 제목</th>
								<th>작가</th>
								<th>출판사</th>
								<th>출판년도</th>
								<th>회원ID</th>
								<th>회원명</th>
								<th>대출일</th>
								<th>반납기한</th>
								<th>반납처리</th>
								<th>기한연장</th>
							</tr>
						</thead>
					<jsp:useBean id="dao" class="sslibrary.frontweb.database.AdminDao" />
					<jsp:useBean id="search" class="sslibrary.frontweb.vo.RentalInfoForAdmin" />
					<jsp:setProperty name="search" property="*" />
						<tbody>
							<c:forEach var="record" items="${dao.searchRentalRecords(param.searchKeyword)}">
								<tr class="table-light text-center">
									<!-- 테이블 데이터 셀 -->
									<td>${record.isbn}</td>
									<td>${record.title}</td>
									<td>${record.author_name}</td>
									<td>${record.publisher}</td>
									<td>${record.year}</td>
									<td>${record.customer_id}</td>
									<td>${record.customer_name}</td>
									<td>${record.rental_date}</td>
									<td>${record.return_date}</td>
									
									<td><button data-isbn="${record.isbn}" data-cno="${record.cno}"
									class="btn btn-primary return-btn">반납</button></td>
									<td><button data-isbn="${record.isbn}" data-cno="${record.cno}"
    								class="btn btn-success extend-btn">연장</button></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
		
				</div>
			</main>
			
			<%@ include file="footer.jsp"%>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
	<script src="js/scripts.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"
		crossorigin="anonymous"></script>
	<script src="assets/demo/chart-area-demo.js"></script>
	<script src="assets/demo/chart-bar-demo.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
		crossorigin="anonymous"></script>
	<script src="js/datatables-simple-demo.js"></script>
</body>
</html>