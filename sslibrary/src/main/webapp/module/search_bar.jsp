<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    %>
        <!-- Start: Page Banner -->
        <section class="page-banner services-banner">
            <div class="container">
                <div class="banner-header">
                    <h2>SSLIBRARY</h2>
                    <span class="underline center"></span>
                    <p class="lead">쌍용전자도서관</p>
                </div>
	           <div class="filter-box">
	                     <form action="${path}/User01_jsr/search.jsp" method="get">
	                <!-- 검색창 컬럼 크기 조정 -->
	                <div class="col-md-8 col-sm-12 col-12">
	                    <div class="form-group">
	                        <input class="form-control" placeholder="찾고 싶은 책의 키워드를 입력하세요" id="keywords" name="keywords" type="text">
	                    </div>
	                </div>
	                <div class="col-md-4 col-sm-12 col-12">
	                    <div class="form-group">
	                        <input class="form-control" type="submit" value="검색">
	                    </div>
	                </div>
	            </form>
	            </div>     
            </div>
        </section>

        <!-- End: Page Banner -->