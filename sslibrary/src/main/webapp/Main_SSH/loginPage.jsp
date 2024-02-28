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
<title>로그인</title>
<style>
 * { box-sizing:border-box; }

       form {
            width:25%;
            height:25%;
            display : flex;
            flex-direction: column;
            align-items:center;
            position : relative;
            top:50%;
            left:50%;
    		border: 1px solid #8D6E63;
            transform: translate(-50%, 8%); 
        }

      .input-field {
            width: 65%;
            height: 40px;
            position : relative;
            border : 5px solid #8D6E63;
            border-radius:5px;
            padding: 0 10px;
            margin-bottom: 10px;
        }
       label {
            width:300px;
            height:30px;
            margin-top :4px;
        }

       .ancient {
            background-color: #8D6E63;
            color : white;
            width: 65%;
            height:50px;
            font-size: 17px;
            border : none;
            border-radius: 5px;
            margin : 20px 0 30px 0;
        }

       .title {
            font-size : 30px;
            margin: 40px 0 30px 0;
        }

       .msg {
            height: 30px;
            text-align:center;
            font-size:16px;
            color:red;
            margin-bottom: 20px;
        }
       
</style>

<head>
        <!-- Meta -->
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1">
        <!-- Title -->
        <title>..:: SSY LIBRARY ::..</title>
        <!-- Favicon -->
        <link href="${path}/com/images/favicon.ico" rel="icon" type="image/x-icon" />
        <!-- Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i,800,800i%7CLato:100,100i,300,300i,400,400i,700,700i,900,900i" rel="stylesheet" />
        <link href="${path}/com/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
        <!-- Mobile Menu -->
        <link href="${path}/com/css/mmenu.css" rel="stylesheet" type="text/css" />
        <link href="${path}/com/css/mmenu.positioning.css" rel="stylesheet" type="text/css" />
        <!-- Stylesheet -->
        <link href="${path}/com/style.css" rel="stylesheet" type="text/css" />
</head>
<%
String id = request.getParameter("id");
String password = request.getParameter("password");
if(id != null && password != null){
	AdminDao dao = new AdminDao();
	Customer customer = dao.login(id, password);

	if (customer != null) {
	    // 로그인 성공
	    session.setAttribute("customer", customer);
	    out.print("<script>alert('" + customer.getName()
	    + "님 환영합니다!');location.href='SSHindex.jsp';</script>");
	} else {
	    // 로그인 실패
	    out.print("<script>alert('로그인 실패'); location.href='loginPage.jsp';</script>");
	}
}
%>
   <%@ include file ="/module/header.jsp" %>
   <%@include file ="/module/search_bar_ml.jsp" %>
   
<body>
    <form>
    <div class="title">로그인</div>
    <div id="msg" class="msg"> </div> 
    <label for="">아이디</label>
    <input class="input-field" type="text" name="id" placeholder="8~12자리의 영대소문자와 숫자 조합">
    <label for="">패스워드</label>
    <input class="input-field" type="password" name="password" placeholder="8~12자리의 영대소문자와 숫자 조합">
    <input class="ancient" type="submit" value="LOGIN"/>
    </form>       
</body>
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
    

</html>