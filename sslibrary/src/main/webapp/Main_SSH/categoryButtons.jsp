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

<style>


.maincategory{
	background-image : url('https://static.vecteezy.com/system/resources/thumbnails/033/320/146/small/a-bookshelf-with-many-old-books-ai-generative-photo.jpg')
	
	}
.ancient{
	width : 800px;
	height : 300px;
	margin-left:auto; 
    margin-right:auto;

}
td{
	background-color : #8D6E63;
	width : 200px;
	height : 100px;
	margin: 5px;
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

        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
        <script src="js/html5shiv.min.js"></script>
        <script src="js/respond.min.js"></script>
        <![endif]-->
</head>


 <section class="maincategory">  
                                   
            <div class="category">
            
                 <table class="ancient" style="text-align: center;">
				   	
                    <tr>
                    <td><a href="/contents/list?t=EB&m=016&s=095"><img src="images\ca-novel.png" alt="">
                            <p style= color:white;>소설</p>
                        </a></td>
                    <td><a href="/contents/list?t=EB&m=013"><img src="images\ca-lang.png" alt="">
                            <p style= color:white;>외국어</p>
                        </a></td>
                    <td><a href="/contents/list?t=EB&m=003"><img src="images\ca-human.png" alt="">
                            <p style= color:white;>인문</p>
                        </a></td>
                    <td><a href="/contents/list?t=EB&m=002&s=010"><img src="images\ca-time.png" alt="">
                            <p style= color:white;>자기관리</p>
                        </a></td></tr>
                    <tr><td><a href="/contents/list?t=EB&m=002"><img src="images\ca-economic.png" alt="">
                            <p style= color:white;>경제/경영</p>
                        </a></td>
                    <td><a href="/contents/list?t=EB&m=001"><img src="images\ca-family.png" alt="">
                            <p style= color:white;>가정생활</p>
                        </a></td>
                    <td><a href="/contents/list?t=EB&m=006"><img src="images\ca-culture.png" alt="">
                            <p style= color:white;>역사문화</p>
                        </a></td>
                    <td><a href="/contents/list?t=EB&m=014"><img src="images\ca-child.png" alt="">
                            <p style= color:white;>유아/어린이</p>
                        </a></td></tr>
                </table>

            </div>
 </section>
  
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