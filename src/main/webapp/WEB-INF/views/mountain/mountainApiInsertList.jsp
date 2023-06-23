<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/common_top.jsp"%>
<%@ include file="../common/common_nav_admin.jsp"%>
<!-- mountainApiInsertList.jsp -->
<style>
	th, td {
	  text-align: center;
	}
</style>
    
    <!-- 산 목록 Start -->
        <div class="container">
            <div class="text-center mx-auto" style="max-width: 500px;">
                <h1 class="display-5 mt-5 mb-5">API 산 정보</h1>
            </div>
				<div class="container-fluid py-5">
				        <div class="container">
				            <div class="text-center mx-auto" style="max-width: 500px;">
				                <h1 class="display-5 mb-5">산 목록</h1>
				            </div>
                            <!-- 산 목록 Start -->
                            <div class="container">
							<table class="table table-hover table-borded" border="1">
							  <thead>
							    <tr align="center">
							      <th scope="col">번호</th>
							      <th scope="col" class="w-25">이름</th>
							      <th scope="col" class="w-25">지역</th>
							      <th scope="col">높이</th>
							      <th scope="col">난이도</th>
							      <th scope="col">국립공원</th>
							      <th scope="col">상세보기</th>
							      <th scope="col">이미지</th>
							      <th scope="col">100대명산</th>
							    </tr>
							  </thead>
							  <tbody>
							  	<c:if test="${map == null}">
							  		<tr><td colspan="9">등록된 데이터가 없습니다.</td></tr>
							  	</c:if>
							  	<c:forEach var="m" items="${map}">
							    <tr>
							      <th scope="row">${m.mountainnum}</th>
							      <td>${m.mountainname}</td>
							      <td>${m.mountainlocal}</td>
							      <td>${m.mountainheight}</td>
							      <td>${m.mountaincontent}</td>
							      <td>${m.mountainimage}</td>
							      <td>${m.mountaingreat}</td>
							    </tr>
							  	</c:forEach>
							  </tbody>
							</table>
							</div>
                            <!-- 페이지 표시 -->
							<!-- //페이지 표시 -->
                        </div>
                    </div>
                    
                    <!-- 정보 등록 버튼(관리자만 볼 수 있음) -->
                    <c:if test="${principal.getName() == 'admin'}">
                    <div class="container">
    				<div align="right">
                    	<button class="btn btn-success" onClick="location.href='/mountain/admin/api.mnt'">산 api 등록</button>
                    	<button class="btn btn-success" onclick="fnGetdata()">전체 삭제</button>
                    </div>
                    </div>
                    </c:if>
                    <!-- //정보 등록 버튼 end -->
                    </div>
<%@ include file="../common/common_bottom.jsp" %>