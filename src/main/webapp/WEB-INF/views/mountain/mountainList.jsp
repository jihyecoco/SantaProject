<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- mountainList.jsp -->
<%@ include file="../common/common_top.jsp" %>

    <!-- Page Header Start -->
    <div class="container-fluid page-header py-5 mb-5 wow fadeIn" data-wow-delay="0.1s">
        <div class="container text-center py-5">
            <h1 class="display-3 text-white mb-4 animated slideInDown">Free Quote</h1>
            <nav aria-label="breadcrumb animated slideInDown">
                <ol class="breadcrumb justify-content-center mb-0">
                    <li class="breadcrumb-item"><a href="#">Home</a></li>
                    <li class="breadcrumb-item active" aria-current="page">산별정보</li>
                </ol>
            </nav>
        </div>
    </div>
    <!-- Page Header End -->

    <!-- navbar -->
    <%@ include file="../common/common_nav_mountain.jsp" %>
    
	<!-- mountain 검색 Start -->
    <div class="container">
    	<form action="list.qna" method="get">
    		<!-- 검색할 카테고리 -->
    		<select name="whatColumn" class="form-select btn-primary py-2 position-relative top-0 start-0 mt-2 me-2" style="width:8%;display:inline-block;">
	    		<option value="">전체</option>
	    		<option value="계정">계정</option>
	    		<option value="크루">크루</option>
	    		<option value="게시판">게시판</option>
	    		<option value="거래/나눔">거래/나눔</option>
	    		<option value="기타">기타</option>
    		</select>
    		<!-- //검색할 카테고리 -->
    		<!-- 검색할 키워드 -->
    		<div class="position-relative w-25" style="display:inline-block;">
                <input name="keyword" type="text" class="form-control bg-light border-light w-100 py-2 ps-4 pe-5">
                <input value="검색" type="submit" class="btn btn-primary py-1 position-absolute top-0 end-0 mt-1 me-2">
                <!-- <button type="button" class="btn btn-primary py-2 position-absolute top-0 end-0 mt-2 me-2">검색</button> -->
            </div>
    		<!-- //검색할 키워드 -->
    	</form>
    </div>
    <!-- //mountain 검색 End -->
    
    <!-- 산 목록 Start -->
    <div class="container-fluid py-5">
        <div class="container">
            <div class="text-center mx-auto wow fadeInUp" data-wow-delay="0.1s" style="max-width: 500px;">
                <p class="fs-5 fw-bold text-primary">산별정보</p>
                <h1 class="display-5 mb-5">산 목록</h1>
            </div>
            <div class="row justify-content-center">
                <div class="col-lg-7">
                    <div class="bg-light rounded p-4 p-sm-5 wow fadeInUp" data-wow-delay="0.1s">
                        <div class="row g-3">
                            <!-- 산 목록 Start -->

                            
                            <!-- //산 목록 End -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- //산 목록 End -->


<%@ include file="../common/common_bottom.jsp" %>