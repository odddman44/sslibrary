<%@page import="sslibrary.frontweb.vo.Reviews"%>
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
<%
String isbnStr = request.getParameter("isbn");
String cnoStr = request.getParameter("cno");
String reviewStarStr = request.getParameter("reviewStar");
String reviewContents = request.getParameter("reviewContent");
int isbn = 0;
int cno = 0;
int reviewStar = 0;
isbn = Integer.parseInt(isbnStr);
cno = Integer.parseInt(cnoStr);
if (reviewStarStr != null && !reviewStarStr.isEmpty()) {
reviewStar = Integer.parseInt(reviewStarStr);
}
if(reviewContents==null) reviewContents="";
log(reviewContents);
log(reviewStarStr);
UserDao dao = new UserDao();
Reviews re=new Reviews(isbn,cno,reviewStar,reviewContents);

if(reviewStarStr!=null&&reviewContents!=null){
	int insCnt = dao.insertReviews(re);
%>
	<script>
		var intCnt = "<%=insCnt%>";
		alert(intCnt=="0"?"등록실패":"등록성공")
		if(intCnt!="0"){
			window.opener.location.reload();
			window.close();
		}
	</script>
<%	
}
%>

<script type="text/javascript">
function counter(text,length){ // 입력 글자 갯수 출력
	var limit=length;
	var str=text.value.length;
	if(str>limit){
		alert("최대 200자까지 입력 가능합니다.");
		text.value=text.value.substring(0,limit);
		text.focus();
	}
	document.getElementById("textLengthCheck").innerHTML="("+text.value.length+"자/200자)";
}

function insert(){
	var reviewStarVal = $("[name=reviewStar]").val();
	//alert(reviewStarVal);
	if(reviewStarVal==""||reviewStarVal==null){
		alert("별점 체크 하세요");
		return;
	}
	var reviewContentsVal =  $("#reviewContents").val();
	if(reviewContentsVal==""||reviewContentsVal==null){
		alert("리뷰를 입력 하세요");
		return;
	}	
	$("#myform").submit();
}

</script>
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
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  }
#myform fieldset{
    display: inline-block;
    direction: rtl;
    border:0;
}
#myform fieldset legend{
    text-align: right;
}
#myform input[type=radio]{
    display: none;
}
#myform label{
    font-size: 3em;
    color: transparent;
    text-shadow: 0 0 0 #f0f0f0;
}
#myform label:hover{
    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
#myform label:hover ~ label{
    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
#myform input[type=radio]:checked ~ label{
    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
#myform h2 {
    text-align: center;
    color: #ff530a;
    font-size: 2em;
    font-family: 'Arial', sans-serif;
  }
#reviewContents {
    width: 100%;
    height: 150px;
    padding: 10px;
    box-sizing: border-box;
    border: solid 1.5px #D3D3D3;
    border-radius: 5px;
    font-size: 16px;
    resize: none;
}
#hi{
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 450px;
}
</style>

<div id="hi">
 	<form class="mb-3" name="myform" id="myform" method="post">
	<h2>평점 및 리뷰</h2><hr>
	<fieldset>
		<span class="text-bold">평점 </span>
		<input type="radio" name="reviewStar" value="5" id="rate1"><label
			for="rate1">★</label>
		<input type="radio" name="reviewStar" value="4" id="rate2"><label
			for="rate2">★</label>
		<input type="radio" name="reviewStar" value="3" id="rate3"><label
			for="rate3">★</label>
		<input type="radio" name="reviewStar" value="2" id="rate4"><label
			for="rate4">★</label>
		<input type="radio" name="reviewStar" value="1" id="rate5"><label
			for="rate5">★</label>
	</fieldset> 
	<div>
		<span class="text-bold">리뷰</span>
		<textarea class="col-auto form-control" type="text" id="reviewContents" name="reviewContent"
				  style="resize: none;" onkeyup="counter(this,200)" placeholder="리뷰를 입력해주세요."></textarea>
	<div style="text-align:right;">
    <span id="textLengthCheck" >(0자/200자)</span>
  </div>
	</div>
	<div style="text-align:right;">
	<button onclick="window.close();">취소</button>
	<button class="btn btn-info" type="button" onclick="insert()">등록</button>
	</div>
</form>	
</div>	
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