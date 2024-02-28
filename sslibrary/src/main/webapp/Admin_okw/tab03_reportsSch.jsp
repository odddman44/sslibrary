<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"    
    import="java.util.*"
    import ="sslibrary.frontweb.vo.*"
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
        <title>리뷰 신고 내역 조회 - 관리자페이지</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet"/>
        <link href="css/styles.css" rel="stylesheet" />
        <link href="css/custom_styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.css">
		<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.js"></script>
		<script type="text/javascript" src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.js"></script>

    </head>
    
    <script>
		$(document).ready( function () {
		    $('#myTable').DataTable();
		} );
	</script>
    <body class="sb-nav-fixed">
        <%@ include file="header_nav.jsp" %>
        
		<div id="layoutSidenav">
        <%@ include file="side_nav.jsp" %>
        
            <div id="layoutSidenav_content">
			<main>
				<br>
				<h1 class="font-weight-bold text-center">리뷰 신고내역조회</h1>
				<div class="container">
					<table id="datatablesSimple" class="table table-hover table-striped">
						<thead>
							<tr class="table-success text-center">
							<!-- int rno, String content, Date rdate, String reporter, String reason -->
								<th>리뷰 번호</th>
								<th>내용</th>
								<th>등록날짜</th>
								<th>신고자 id</th>
								<th>신고 사유</th>
								
							</tr>
						</thead>
						<jsp:useBean id="dao" class="sslibrary.frontweb.database.AdminDao" />
						<jsp:useBean id="sch"
							class="sslibrary.frontweb.vo.ReportDetail" />
						<jsp:setProperty name="sch" property="*" />
						<tbody>
							<c:forEach var="rp"
								items="${dao.reportInfo()}">
								<tr class="table-light text-center">
									<!-- 테이블 데이터 셀 -->
									<td>${rp.rno}</td>
									<td>${rp.content}</td>
									<td>${rp.rdate}</td>
									<td>${rp.reporter}</td>
									<td>${rp.reason}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
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