<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common_top.jsp" %>
<!-- Service Start -->
    <div class="container-xxl py-5">
        <div class="container">
            <div class="text-center mx-auto wow fadeInUp" data-wow-delay="0.1s" style="max-width: 500px;">
                <p class="fs-5 fw-bold text-primary">정상적으로 결제 완료됐습니다.</p>
                <h1 class="display-5 mb-5">결제 내역</h1>
            </div>
            
            <table class="table table-hover">
            	<tr align="center">
            		<th>상품</th>
            		<th>상품명</th>
            		<th>결제일자</th>
            		<th>결제금액</th>
            		<th>결제방법</th>
            	</tr>
            	<tr align="center">
            		<!-- 대표 이미지 하나 가져오기 -->
					<c:set var="thumbnail" value="${fn:split(pb.image, ',')}" />
					<!-- //대표 이미지 하나 가져오기 -->
					
            		<td>
            			<a href="/products/user/detail.prd?num=${pay_result.prdnum}&pageNumber=${pageNumber}">
            				<img src="<%=request.getContextPath()%>/resources/images/products/${thumbnail[0]}">
            			</a>
            		</td>
            		<td>${pb.name}</td>
            		<td>${pay_result.regdate}</td>
            		<td>${pay_result.price}원</td>
            		<td>${pay_result.payment}</td>
            	</tr>
            </table>
            
            <div class="container">
            	<input type="button" value="홈">
            	<input type="button" value="계속 보기" onclick="location.href='/products/all/list.prd'">
            </div>
        </div>
    </div>
    <!-- Service End -->

<%@ include file="../common/common_bottom.jsp" %>