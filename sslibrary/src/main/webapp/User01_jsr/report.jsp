<%@page import="sslibrary.frontweb.vo.Report"%>
<%@page import="sslibrary.frontweb.database.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*"
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<fmt:requestEncoding value="utf-8"/>     
<!DOCTYPE html>
<html>
<head>
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
        <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
        <![endif]-->
</head>
<body>
<style>
body {
    background-color: #f8f9fa;
  }
hr {
    margin-top: 20px;
    border-color: #ff530a;
  }
  #myform {
    max-width: 600px;
    margin: 0 auto;
    background-color: #fff;
    padding: 20px;
    border-radius: 10px;
  }
  #hi{
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 450px;
}
#myform h2 {
    text-align: center;
    color: #ff530a;
    font-size: 2em;
    font-family: 'Arial', sans-serif;
  }
</style>
<body>
<%
String cnoStr = request.getParameter("cno");
String rnoStr = request.getParameter("rno");
int rno = 0;
int cno = 0;
rno = Integer.parseInt(rnoStr);
cno = Integer.parseInt(cnoStr);
String reason = request.getParameter("reason");
if(reason==null) reason="";
if(!reason.isEmpty()){
	UserDao dao = new UserDao();
	dao.insertReport(new Report(rno,cno,reason));
%>
	<script>
		alert("신고되었습니다. 검토 후 삭제하겠습니다.")
		window.close();
	</script>
<%}%>
	
<%--<script type="text/javascript">
	function reason(){
	var reasonVal = $("[name=reason]").val();
	//alert(reviewStarVal);
	if(reasonVal==null){
		alert("신고사유를 선택해주세요")
		return;
	}else{
		$("#myform").submit();
	}
}

</script>--%>
<div id="hi">
 	<form class="mb-3" name="myform" id="myform" method="post">
		<h2>신고사유</h2><hr>
	<fieldset>
		<input type="radio" name="reason" value="영리목적/홍보성" ><label
			>영리목적/홍보성</label><br>
		<input type="radio" name="reason" value="동일내용 반복 게시(도배)" ><label
			>동일내용 반복 게시(도배)</label><br>
		<input type="radio" name="reason" value="개인정보노출" ><label
			>개인정보노출</label><br>
		<input type="radio" name="reason" value="책과 연과성이 없음" ><label
			>책과 연과성이 없음</label><br>
		<input type="radio" name="reason" value="기타" ><label
			>기타</label><br>
	</fieldset>
	<div style="text-align:right;">
	<button onclick="window.close();">취소</button>
	<button class="btn btn-info" type="submit">등록</button>
	</div>
	</form>
	</div>


      <!-- jQuery Latest Version 1.x -->
        <script type="text/javascript" src="js/jquery-1.12.4.min.js"></script>
        
        <!-- jQuery UI -->
        <script type="text/javascript" src="js/jquery-ui.min.js"></script>
        
        <!-- jQuery Easing -->
        <script type="text/javascript" src="js/jquery.easing.1.3.js"></script>

        <!-- Bootstrap -->
        <script type="text/javascript" src="js/bootstrap.min.js"></script>
        
        <!-- Mobile Menu -->
        <script type="text/javascript" src="js/mmenu.min.js"></script>
        
        <!-- Harvey - State manager for media queries -->
        <script type="text/javascript" src="js/harvey.min.js"></script>
        
        <!-- Waypoints - Load Elements on View -->
        <script type="text/javascript" src="js/waypoints.min.js"></script>

        <!-- Facts Counter -->
        <script type="text/javascript" src="js/facts.counter.min.js"></script>

        <!-- MixItUp - Category Filter -->
        <script type="text/javascript" src="js/mixitup.min.js"></script>

        <!-- Owl Carousel -->
        <script type="text/javascript" src="js/owl.carousel.min.js"></script>
        
        <!-- Accordion -->
        <script type="text/javascript" src="js/accordion.min.js"></script>
        
        <!-- Responsive Tabs -->
        <script type="text/javascript" src="js/responsive.tabs.min.js"></script>
        
        <!-- Responsive Table -->
        <script type="text/javascript" src="js/responsive.table.min.js"></script>
        
        <!-- Masonry -->
        <script type="text/javascript" src="js/masonry.min.js"></script>
        
        <!-- Carousel Swipe -->
        <script type="text/javascript" src="js/carousel.swipe.min.js"></script>
        
        <!-- bxSlider -->
        <script type="text/javascript" src="js/bxslider.min.js"></script>
        
        <!-- Custom Scripts -->
        <script type="text/javascript" src="js/main.js"></script>
</body>
</html>