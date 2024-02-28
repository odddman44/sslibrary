<%@page import="sslibrary.frontweb.vo.EbookDetail"%>
<%@page import="sslibrary.frontweb.vo.ReviewList"%>
<%@page import="sslibrary.frontweb.vo.Ebook"%>
<%@page import="sslibrary.frontweb.database.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*"
    import="backendweb.z01_vo.*"
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<fmt:requestEncoding value="utf-8"/>     
<!DOCTYPE html>
<%--


 --%>
 
 
<html>
<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
         <!-- Meta -->
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1">

        <!-- Title -->
        <title>..:: SSLIBRRY ::..</title>

        <!-- Favicon -->
        <link href="${path}/com/images/logo.png" rel="icon" type="image/x-icon" />

        <!-- Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i,800,800i%7CLato:100,100i,300,300i,400,400i,700,700i,900,900i" rel="stylesheet" />
        <link href="${path}/com/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
        
        <!-- Mobile Menu -->
        <link href="${path}/com/css/mmenu.css" rel="stylesheet" type="text/css" />
        <link href="${path}/com/css/mmenu.positioning.css" rel="stylesheet" type="text/css" />

        <!-- Stylesheet -->
        <link href="${path}/com/style.css" rel="stylesheet" type="text/css" />

        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
        <script src="js/html5shiv.min.js"></script>
        <script src="js/respond.min.js"></script>
        <![endif]-->
</head>
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

<body>
<%
Customer c01 = (Customer) session.getAttribute("customer");
String isbnStr = request.getParameter("isbn");
int isbn = 0;
Ebook book = new Ebook();
EbookDetail bookd = new EbookDetail();
UserDao dao = new UserDao();
if(isbnStr!=null) {
	isbn = Integer.parseInt(isbnStr);
	book = dao.getBookInfo(isbn);
	bookd = dao.getBookDetail(isbn);
	
    if(book == null || bookd == null) {
        // 책 정보가 없는 경우, 오류 메시지 표시 또는 다른 페이지로 리디렉션
        out.println("<script>alert('책 정보를 찾을 수 없습니다.'); location.href='search.jsp';</script>");
        return; // 이후 코드 실행 방지
    }
}
%>
<script type="text/javascript">
	$(document).ready(function(){
		<%-- 
		
		--%>	
	});
	
	function showReviewPopup() {
		<%if(c01!=null){%>
		    window.open(
		        "review.jsp?cno="+<%=c01.getCno()%>+"&isbn="+<%=book.getIsbn() %>,
		        "Child",
		        "width=550, height=500, top=100, left=200"
		    );
		    <%}else{%>
		    alert("로그인이 필요합니다. 로그인 후 이용해 주세요.");
		    <%}%>
	}
	
	function showReportPopup(rno) {
		<%if(c01!=null){%>
	    window.open(
	    		"report.jsp?cno="+<%=c01.getCno()%>+"&rno="+rno,
		        "Child",
		        "width=550, height=400, top=100, left=200"
	    );
	    <%}else{%>
	    alert("로그인이 필요합니다. 로그인 후 이용해 주세요.");
	    <%}%>
	}
	function setLike(isbn) {
	    location.href = "updateLikes.jsp?isbn="+isbn;
	}
	function setThumbs(isbn) {
	    location.href = "updateThumbs.jsp?isbn="+isbn;
	}
	function insertBook(isbn) {
	    location.href = "insertBook.jsp?isbn="+isbn;
	}
	function deletes(rno){
		location.href = "deleteReview.jsp?rno="+rno+"&isbn="+<%=isbn%>;
	}
	<%--function reReviewPopup() {
		
		    window.open(
		        "review.jsp?cno="+<%=c01.getCno()%>+"&isbn="+<%=book.getIsbn() %>,
		        "Child",
		        "width=550, height=500, top=100, left=200"
		    );
		    
		    alert("로그인이 필요합니다. 로그인 후 이용해 주세요.");
		    
	}--%>
	
</script>
        <%@ include file="/module/header.jsp"%>
        <%@ include file="/module/search_bar.jsp"%>

        <!-- Start: Products Section -->
        <hr>
        <div id="content" class="site-content">
            <div id="primary" class="content-area">
                <main id="main" class="site-main">
                    <div class="booksmedia-detail-main">
                        <div class="container">
                            <div class="booksmedia-detail-box">
                                <div class="detailed-box">
                                    <div class="col-xs-12 col-sm-5 col-md-3">
                                        <div class="post-thumbnail">
                                            <img src="${path}/com/images/book/<%=book.getIsbn() %>.PNG" alt="Book Image">
                                        </div>
                                    </div>
                                    <div class="col-xs-12 col-sm-7 col-md-6">
                                        <div class="post-center-content">
                                            <h2><%=book.getTitle() %></h2><br><br>
                                            <p><strong>작가:</strong> <%=book.getAuthorName() %></p><br>
                                            <p><strong>출판사:</strong> <%=book.getPublisher() %></p><br>
                                            <p><strong>출판년도:</strong> <%=book.getYear() %>년</p><br>
                                            <p><strong>ISBN:</strong> <%=book.getIsbn() %></p><br>
                                            <p><strong>추천수:</strong> <%=bookd.getThumbs() %></p><br>
                                            <p><strong>좋아요수:</strong> <%=bookd.getLikes() %></p>
                                            <div class="actions">
                                                <ul>
                                                    <li>
                                                        <a href="#" target="_blank" data-toggle="blog-tags" data-placement="top" title="" data-original-title="대출" onclick="insertBook('<%=book.getIsbn() %>')">
                                                            <i class="fa-solid fa-download"></i>
                                                        </a>
                                                    </li>
                                                    <li>
                                                        <a href="#" target="_blank" data-toggle="blog-tags" data-placement="top" title="" data-original-title="좋아요" onclick="setLike('<%=book.getIsbn() %>')">
                                                            <i class="fa fa-heart"></i>
                                                        </a>
                                                    </li>
                                                    <li>
                                                        <a href="#" target="_blank" data-toggle="blog-tags" data-placement="top" title="" data-original-title="추천" onclick="setThumbs('<%=book.getIsbn() %>')">
                                                            <i class="fa-solid fa-thumbs-up"></i>
                                                        </a>
                                                    </li>
                                                    <li></li>
                                                    <li></li>
                                                    <li></li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                    
                                </div>
                                <%List<ReviewList> reL = dao.showReviews(isbn); %>
                                <div class="clearfix"></div>
                                <div class="table-tabs" id="responsiveTabs">
                                    <ul class="nav nav-tabs">
									    <li><b class="arrow-up"></b><a data-toggle="tab" href="#sectionA">책소개</a></li>
									    <li><b class="arrow-up"></b><a data-toggle="tab" href="#sectionB">작가소개</a></li>
									    <li class="active"><b class="arrow-up"></b><a data-toggle="tab" href="#sectionC">리뷰(<%=reL.size() %>)</a></li>
									</ul>
                                    <div class="tab-content">
                                        <div id="sectionC" class="tab-pane fade in active">
                                        <style>
                                        .float-right-btn {
											float: right;
											background-color: #3498db;
										}
																			        
										.report-btn {
											background-color: red;
										}
                                        </style>
<!-- 							   <button class="float-right-btn" onclick="location.href='review.jsp'">리뷰쓰기</button> -->		
									   <button class="float-right-btn" onclick="showReviewPopup()">리뷰쓰기</button>
											<br><br><br>
									    <table class="table table-bordered">
                                                <thead>
                                                    <tr>
                                                        <th style="text-align: center;">아이디</th>
                                                        <th style="text-align: center;">리뷰</th>
                                                        <th style="text-align: center;">별점</th>
                                                        <th></th>
                                                    </tr>
                                                </thead>
                                                <tbody>
	                                                <%   for(ReviewList re : reL) {
									                %>
                                                    <tr>
                                                        <td><%=re.getId() %></td>
                                                        <td><%=re.getReview() %></td>
                                                        <td><%=re.getStar() %>점</td>
                                                        <% if(c01!=null){
                                                        	if(re.getId().equals(c01.getId())){ %>
                                                    	<td><button>수정</button>  <button onclick="deletes(<%=re.getRno()%>)">삭제</button></td>
                                                    		<%}else{ %>
                                                    	<td><button class="report-btn" onclick="showReportPopup(<%=re.getRno()%>)">신고</button></td>
                                                    		<%} 
                                                    		}else{%>
           												<td><button class="report-btn" onclick="showReportPopup()">신고</button></td>
           												<%} %>
                                                    </tr>
                                                    <%} %>
                                                </tbody>
                                            </table>
                                        </div>
                                        <div id="sectionA" class="tab-pane fade in">
                                            <h5><%=book.getTitle() %></h5>
											<p><%=bookd.getInfo() %></p>
                                        </div>
                                        <div id="sectionB" class="tab-pane fade in">
                                            <h5><%=book.getAuthorName() %></h5>
                                            <p><%=book.getInfo() %></p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>
        <!-- End: Products Section -->

         <!-- jQuery Latest Version 1.x -->
        <script type="text/javascript" src="${path}/com/js/jquery-1.12.4.min.js"></script>
        
        <!-- jQuery UI -->
        <script type="text/javascript" src="${path}/com/js/jquery-ui.min.js"></script>
        
        <!-- jQuery Easing -->
        <script type="text/javascript" src="${path}/com/js/jquery.easing.1.3.js"></script>

        <!-- Bootstrap -->
        <script type="text/javascript" src="${path}/com/js/bootstrap.min.js"></script>
        
        <!-- Mobile Menu -->
        <script type="text/javascript" src="${path}/com/js/mmenu.min.js"></script>
        
        <!-- Harvey - State manager for media queries -->
        <script type="text/javascript" src="${path}/com/js/harvey.min.js"></script>
        
        <!-- Waypoints - Load Elements on View -->
        <script type="text/javascript" src="${path}/com/js/waypoints.min.js"></script>

        <!-- Facts Counter -->
        <script type="text/javascript" src="${path}/com/js/facts.counter.min.js"></script>

        <!-- MixItUp - Category Filter -->
        <script type="text/javascript" src="${path}/com/js/mixitup.min.js"></script>

        <!-- Owl Carousel -->
        <script type="text/javascript" src="${path}/com/js/owl.carousel.min.js"></script>
        
        <!-- Accordion -->
        <script type="text/javascript" src="${path}/com/js/accordion.min.js"></script>
        
        <!-- Responsive Tabs -->
        <script type="text/javascript" src="${path}/com/js/responsive.tabs.min.js"></script>
        
        <!-- Responsive Table -->
        <script type="text/javascript" src="${path}/com/js/responsive.table.min.js"></script>
        
        <!-- Masonry -->
        <script type="text/javascript" src="${path}/com/js/masonry.min.js"></script>
        
        <!-- Carousel Swipe -->
        <script type="text/javascript" src="${path}/com/js/carousel.swipe.min.js"></script>
        
        <!-- bxSlider -->
        <script type="text/javascript" src="${path}/com/js/bxslider.min.js"></script>
        
        <!-- Custom Scripts -->
        <script type="text/javascript" src="${path}/com/js/main.js"></script>
    </body>


</html>