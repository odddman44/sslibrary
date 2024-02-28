<%@page import="sslibrary.frontweb.database.AdminDao"%>
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
        <title>회원정보조회 - 관리자페이지</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet"/>
        <link href="css/styles.css" rel="stylesheet" />
        <link href="css/custom_styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    </head>
<%
AdminDao dao = new AdminDao();
String id = request.getParameter("id");
String name = request.getParameter("name");
if(id ==null) id="";
if(name == null) name="";
List<Customer> cus = dao.schCustomer(id, name);
request.setAttribute("cus", cus); // JSP에 데이터 전달

%>
    <body class="sb-nav-fixed">
        <%@ include file="header_nav.jsp" %>
        
		<div id="layoutSidenav">
        <%@ include file="side_nav.jsp" %>
        
            <div id="layoutSidenav_content">
                <main>
					<div class="container-fluid px-4">
			            <h1 class="mt-4">회원 정보 조회</h1>
			            <ol class="breadcrumb mb-4">
			                <li class="breadcrumb-item active">테이블 보기</li>
			            </ol>
			            <div class="card mb-4">
					 		<div class="card-header">
					            <i class="fas fa-search"></i> 회원 검색
					        </div>
			                <div class="card-body">
					            <form action="tab05_memSch.jsp" method="get" class="form-inline">
						            <div class="row">
						                <div class="col-md-4">
						                    <input type="text" class="form-control mb-2 mr-sm-2" id="id" name="id" placeholder="회원 아이디 입력">
						                </div>
						                <div class="col-md-4">
						                    <input type="text" class="form-control mb-2 mr-sm-2" id="name" name="name" placeholder="이름 입력">
						                </div>
						                <div class="col-md-4 text-right">
						                    <button type="submit" class="btn btn-primary mb-2">검색</button>
						                </div>
						            </div>
						        </form>
			                    <table id="datatablesSimple" class="table">
			                        <thead>
			                            <tr>
			                                <th>회원 번호</th>
			                                <th>회원 아이디</th>
			                                <th>회원 비밀번호</th>
			                                <th>이름</th>
			                                <th>이메일</th>
			                                <th>전화번호</th>
			                            </tr>
			                        </thead>
			                        <tfoot>
			                            <tr>
			                            <tr>
			                                <th>회원 번호</th>
			                                <th>회원 아이디</th>
			                                <th>회원 비밀번호</th>
			                                <th>이름</th>
			                                <th>이메일</th>
			                                <th>전화번호</th>
			                            </tr>
			                        </tfoot>
			                        <tbody>
			                            <!-- jstl 예습 겸 사용해봤음.. -->
									    <c:forEach var="customer" items="${cus}">
									        <tr>
									            <td><c:out value="${customer.cno}"/></td>
									            <td><c:out value="${customer.id}"/></td>
									            <td><c:out value="${customer.password}"/></td>
									            <td><c:out value="${customer.name}"/></td>
									            <td><c:out value="${customer.email}"/></td>
									            <td><c:out value="${customer.phone}"/></td>
									        </tr>
									    </c:forEach>
			                        </tbody>
			                    </table>
			                </div>
			            </div>
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