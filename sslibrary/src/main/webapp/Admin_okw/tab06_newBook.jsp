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
        <title>새 도서 추가 - 관리자페이지</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet"/>
        <link href="css/styles.css" rel="stylesheet" />
        <link href="css/custom_styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    </head>
<%
boolean isIns = false;
String title = request.getParameter("title");
String authorName = request.getParameter("authorName");
String publisher = request.getParameter("publisher");
String yearStr = request.getParameter("year");
String bookAdded = request.getParameter("bookAdded");
String authorInfo = request.getParameter("authorInfo");
String ebookDetailInfo = request.getParameter("ebookDetailInfo");
if (title != null && authorName != null && publisher != null && yearStr != null
	&& (bookAdded == null || !bookAdded.equals("true"))) {
    int year = Integer.parseInt(yearStr);
    AdminDao dao = new AdminDao();
    // 중복 도서가 있는지 확인
    if(dao.isBookExists(title, authorName, publisher, year)) {
        // 이미 등록된 도서가 있을 경우
        out.println("<script>alert('이미 등록된 도서입니다.'); history.back();</script>");
        return; // 이후 코드 실행 방지
    } else {
        // 중복된 도서가 없을 경우, 도서 추가
        isIns = dao.addNewBook2(title, authorName, publisher, year, authorInfo, ebookDetailInfo) > 0;
        if(isIns){
            out.println("<script>alert('도서가 성공적으로 추가되었습니다.');</script>");
        } else {
            out.println("<script>alert('도서 추가에 실패했습니다.'); history.back();</script>");
        }
    }
}

%>  
<script>
var isIns = <%=isIns%>;
if(isIns){
    response.sendRedirect("tab06_newBook.jsp?bookAdded=true");
}else{
	
}
</script>
<script type="text/javascript">
	function goPage(isbn){
		location.href="tab06_1_bookDetail.jsp?isbn="+isbn;
	}
</script>
    <body class="sb-nav-fixed">
        <%@ include file="header_nav.jsp" %>
        
		<div id="layoutSidenav">
        <%@ include file="side_nav.jsp" %>
        
            <div id="layoutSidenav_content">
                <main>
                <div class="container-fluid px-4">
                    <div class="row justify-content-center">
                        <div class="col-lg-6">
                            <div class="card mt-5">
                                <div class="card-header">새 도서 추가</div>
                                <div class="card-body">
                                    <form action="tab06_newBook.jsp" method="post">
                                        <!-- 폼 필드들 -->
                                        <div class="mb-3">
                                            <label for="title" class="form-label">도서 제목</label>
                                            <input type="text" class="form-control" id="title" name="title" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="authorName" class="form-label">저자 이름</label>
                                            <input type="text" class="form-control" id="authorName" name="authorName" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="publisher" class="form-label">출판사</label>
                                            <input type="text" class="form-control" id="publisher" name="publisher" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="year" class="form-label">출판년도</label>
                                            <input type="text" class="form-control" id="year" name="year" required>
                                        </div>
										<div class="mb-3">
											<label for="authorInfo" class="form-label">작가 정보</label>
											<textarea class="form-control" id="authorInfo"
												name="authorInfo" rows="4" cols="50"></textarea>
										</div>
										<div class="mb-3">
											<label for="bookDetailInfo" class="form-label">도서 상세
												정보</label>
											<textarea class="form-control" id="ebookDetailInfo"
												name="ebookDetailInfo" rows="4" cols="50"></textarea>
										</div>
										<div class="text-end">
									        <button type="submit" class="btn btn-success">추가</button>
									    </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="container-fluid px-4">
			    <div class="card mt-4">
			        <div class="card-header">도서 목록</div>
			        <div class="card-body">
			            <table id="datatablesSimple" class="table" width="100%" cellspacing="0">
			                <thead>
			                    <tr>
			                        <th>ISBN</th>
			                        <th>제목</th>
			                        <th>저자번호</th>
			                        <th>저자</th>
			                        <th>출판사</th>
			                        <th>출판년도</th>
			                        <th>대출 가능 여부</th>
			                        <th>책 상세정보</th>
			                    </tr>
			                </thead>
			                <tbody>
			                    <%
			                    AdminDao dao = new AdminDao();
			                    List<Ebook> books = dao.showAllBooks();
			                    for(Ebook book : books) {
			                    %>
			                    <tr>
			                        <td><%= book.getIsbn() %></td>
			                        <td><%= book.getTitle() %></td>
			                        <td><%= book.getAuthor_id() %></td>
			                        <td><%= book.getAuthorName() %></td>
			                        <td><%= book.getPublisher() %></td>
			                        <td><%= book.getYear() %></td>
			                        <td><%= book.getAvailable() %></td>
			                        <td><button class="btn btn-info" onclick="goPage(<%=book.getIsbn()%>)" 
			                        data-toggle="modal" data-target="#exampleModalCenter">상세</button></td>
			                    </tr>
			                    <%} %>
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