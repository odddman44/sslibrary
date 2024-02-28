<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" 
	import="java.util.*"
	import="sslibrary.frontweb.database.*" 
	import="sslibrary.frontweb.vo.*" 
	import="backendweb.z01_vo.*"
	%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<!DOCTYPE html>
<%--
	회원정보조회 및 수정 페이지

 --%>


<html>
<head>
<!-- Meta -->
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width,initial-scale=1,minimum-scale=1">

<!-- Title -->
<title>..:: SSLIBRRY ::..</title>

<!-- Favicon -->
<link href="${path}/com/images/logo.png" rel="icon" type="image/x-icon" />

<!-- Fonts -->
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i,800,800i%7CLato:100,100i,300,300i,400,400i,700,700i,900,900i"
	rel="stylesheet" />
<link href="${path}/com/css/font-awesome.min.css" rel="stylesheet"
	type="text/css" />

<!-- Mobile Menu -->
<link href="${path}/com/css/mmenu.css" rel="stylesheet" type="text/css" />
<link href="${path}/com/css/mmenu.positioning.css" rel="stylesheet"
	type="text/css" />

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
<link rel="stylesheet" href="${path}/a00_com/bootstrap.min.css">
<link rel="stylesheet" href="${path}/a00_com/jquery-ui.css">
<style>
td {
	text-align: center;
}
   label {
            width:300px;
            height:30px;
            margin-top :4px;
            text-align: center;
        }
        input {
            width: 300px;
            height: 40px;
            border : 1px solid #8D6E63;
            border-radius:5px;
            padding: 0 10px;
            margin-bottom: 10px;
        }
 


</style>
<% 
 
%>
<script src="${path}/a00_com/jquery.min.js"></script>
<script src="${path}/a00_com/popper.min.js"></script>
<script src="${path}/a00_com/bootstrap.min.js"></script>
<script src="${path}/a00_com/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script
	src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api"
	type="text/javascript"></script>
<script type="text/javascript">
	$(document).ready(function() {
<%-- 
		
		--%>
	});
</script>
<script>
	
	function goMyLibrary(){ // 나의 도서관 메인페이지로 이동하는 함수
		if(confirm("정말로 회원수정을 취소하시겠습니까?")){
			location.href = "a01_myl_000.jsp";	
			}
	}
	function isValid(){ // form 유효성 체크 함수
		
		// input value값 받아오기
		var pwd = document.forms["myForm"]["pwd"].value;
		var phone = document.forms["myForm"]["phone"].value;
		var pwdconfirm = document.forms["myForm"]["pwdconfirm"].value;
		var email = document.forms["myForm"]["email"].value;
		// 비밀번호와 비밀번호 확인은 필수입력
		if(pwd.trim()===""){
			alert("비밀번호를 입력하십시오.")
			myForm.pwd.focus();
			return false;
		}
		if(pwdconfirm.trim()===""){
			alert("비밀번호를 확인하십시오")
			myForm.pwdcofirm.focus();
			return false;
		}
		if(pwdconfirm.trim()!==pwd.trim()){
			alert("비밀번호가 일치하지 않습니다.")
			myForm.pwdcofirm.focus();
			return false;
		}
		return true;
		
		
	}
</script>
<%
	// 현재 로그인 중인 session 객체 가져오기
	Customer c01 = (Customer) session.getAttribute("customer");
	String cnoStr = request.getParameter("cno");
	int cno=0;
	if(cnoStr!=null){ // 회원번호가 있을 때 form에서 받아온 데이터 처리
		
		cno = Integer.parseInt(cnoStr); }// 회원번호
		String name = request.getParameter("name"); // 회원명
		String id = request.getParameter("id"); // 아이디
		log("#id:"+id);
		// 사용자 입력값 처리
		String pwd = request.getParameter("pwd");
		if(pwd==null) pwd="";
		log("##pwd:"+pwd);
		String email = request.getParameter("email");
		if(email==null) email=c01.getEmail(); // 사용자가 이메일을 입력 안하면 기존 이메일로 설정
		log("##email"+email);
		String phone = request.getParameter("phone");
		if(phone==null) phone=c01.getPhone(); // 사용자가 휴대폰 번호 입력 안하면 기존 휴대폰 번호로 설정
		log("##phone"+phone);
		int isUpt = 0;
	if(id!=null){ // 아이다가 null이 아니면 수정 진행
		MyLibraryDao dao = new MyLibraryDao(); // dao 객체 생성
		// int cno, String id, String password, String name, String email, String phone
		Customer upt = new Customer(cno, id, pwd, name, email, phone); // 수정된 내용 객체 저장
		isUpt = dao.updateCustomer(upt); // 업데이트 성공 여부 저장 변수 0이면 실패 1이면 성공
		System.out.println(isUpt); // 업데이트 됐는지 출력해보기
	} 
	
	
%>




<body>
	<%@ include file="/module/header.jsp"%>
	<%@ include file="/module/search_bar_ml.jsp"%>

	<!-- Start: Products Section -->
	<hr>
	
	<script>
		var isUpt = <%=isUpt%> // java변수 script로 받아오기
			if (isUpt == 1) { // 업데이트가 성공하면
				if(confirm("회원 수정이 완료되었습니다!!")){
					window.location.href = "a03_myl-minfo-000.jsp"; // 회원정보수정화면 refresh
		}
	}
		
</script>
	<div class="container">
	
	<div id="content" class="site-content">
		<label id="title" class="col-sm-2 col-form-label">회원정보수정</label>
		<label style="color:red;">*표시된 항목은 필수입력 항목입니다.</label>
		
		<br>
		<br>
		<%-- form 태그 --%>
		<form id="myForm" method="post">
			<label class="col-sm-2 col-form-label">회원번호</label>
			<div class="col-sm-10">
				<input type="number" readonly class="form-control-plaintext" name="cno"
					value="${customer.cno}">
			</div>
			<label class="col-sm-2 col-form-label">회원명</label> 
			<div class="col-sm-10">
				<input type="text" readonly class="form-control-plaintext" name="name"
					value="${customer.name}">
			</div>
			<label class="col-sm-2 col-form-label">아이디</label>
			<div class="col-sm-10">
				<input type="text" readonly class="form-control-plaintext" name="id"
					value="${customer.id}">
			</div>
		
			<label class="col-sm-2 col-form-label" >비밀번호(*)</label>
			<div class="col-sm-10">
				<input type="password" name="pwd">
			</div>
			<label class="col-sm-2 col-form-label">비밀번호 확인(*)</label>
			<div class="col-sm-10">
				<input type="password" name="pwdconfirm">
			</div>
			<label for="email" class="col-sm-2 col-form-label">이메일</label>
			<div class="col-sm-10">
				<input type="email" class="form-control-plaintext"
					placeholder="${customer.email}" name="email">
			</div>
			<label for="phone" class="col-sm-2 col-form-label">휴대폰 번호</label>
			
			<div class="col-sm-10">
				<input type="text" class="form-control-plaintext" placeholder="${customer.phone}"
					name="phone">
					
			</div>
			<div class="button">
				<input onclick="goMyLibrary()" type="button" value="취소">
				<input onclick="return isValid()" type="submit" value="수정">
			</div>
		</form>
	
	</div>
</div>
	<!-- End: Products Section -->

	<!-- jQuery Latest Version 1.x -->
	<script type="text/javascript"
		src="${path}/com/js/jquery-1.12.4.min.js"></script>

	<!-- jQuery UI -->
	<script type="text/javascript" src="${path}/com/js/jquery-ui.min.js"></script>

	<!-- jQuery Easing -->
	<script type="text/javascript"
		src="${path}/com/js/jquery.easing.1.3.js"></script>

	<!-- Bootstrap -->
	<script type="text/javascript" src="${path}/com/js/bootstrap.min.js"></script>

	<!-- Mobile Menu -->
	<script type="text/javascript" src="${path}/com/js/mmenu.min.js"></script>

	<!-- Harvey - State manager for media queries -->
	<script type="text/javascript" src="${path}/com/js/harvey.min.js"></script>

	<!-- Waypoints - Load Elements on View -->
	<script type="text/javascript" src="${path}/com/js/waypoints.min.js"></script>

	<!-- Facts Counter -->
	<script type="text/javascript"
		src="${path}/com/js/facts.counter.min.js"></script>

	<!-- MixItUp - Category Filter -->
	<script type="text/javascript" src="${path}/com/js/mixitup.min.js"></script>

	<!-- Owl Carousel -->
	<script type="text/javascript" src="${path}/com/js/owl.carousel.min.js"></script>

	<!-- Accordion -->
	<script type="text/javascript" src="${path}/com/js/accordion.min.js"></script>

	<!-- Responsive Tabs -->
	<script type="text/javascript"
		src="${path}/com/js/responsive.tabs.min.js"></script>

	<!-- Responsive Table -->
	<script type="text/javascript"
		src="${path}/com/js/responsive.table.min.js"></script>

	<!-- Masonry -->
	<script type="text/javascript" src="${path}/com/js/masonry.min.js"></script>

	<!-- Carousel Swipe -->
	<script type="text/javascript"
		src="${path}/com/js/carousel.swipe.min.js"></script>

	<!-- bxSlider -->
	<script type="text/javascript" src="${path}/com/js/bxslider.min.js"></script>

	<!-- Custom Scripts -->
	<script type="text/javascript" src="${path}/com/js/main.js"></script>

</body>


</html>