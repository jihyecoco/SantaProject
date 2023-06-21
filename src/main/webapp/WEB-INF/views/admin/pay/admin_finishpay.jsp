<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file ="../../common/common_top.jsp" %>
<%@ include file ="../../common/common_nav_admin.jsp" %>
	<div class="container-fluid py-5">
        <div class="container">
            <div class="text-center mx-auto wow fadeInUp" data-wow-delay="0.1s" style="max-width: 500px;">
                <h1 class="display-5 mb-5">결제 승인완료 내역 </h1>
        	</div>
                
            <div class="row justify-content-center">
                <div class="col-lg-7 mx-auto">
                    <div class="bg-light rounded p-4 p-sm-5 wow fadeInUp" data-wow-delay="0.1s">
                        <div class="row g-3 mx-auto" >
                         	<table class="table table-hover table-borded align-middle">
                         		<thead>
                         			<tr align="center">
                         				<th>결제일</th>
                         				<th>상품명</th>
                         				<th>가격</th>
                         				<th>구매자 아이디</th>
                         				<th>판매자 아이디</th>
                         				<th>판매자 포인트 지급여부</th>
                         			</tr>
                         		</thead>
                         			<c:if test="${paylist.size() == 0}">
                         				<td colspan="5" align="center">
                         					결과가 없습니다.
                         				</td>
                         			</c:if>
                         			<c:if test="${paylist.size() != 0}">
                         				<c:forEach var="paylist" items="${paylist}">
                         					<tr align="center">
	                         					<td>${paylist.regdate}</td>
	                         					<td>${paylist.prdname}</td>
	                         					<td>${paylist.price}</td>
	                         					<td>${paylist.buyer}</td>
	                         					<td>
	                         						<input type="button" class="btn btn-secondary btn-sm" value="승인" 
	                         							onclick="javascript:approval('${paylist.buyer}', '${paylist.prdname}', '${paylist.paynum}')">
	                         						<input type="button" class="btn btn-secondary btn-sm" value="취소" onclick="javascript:cancel()">
	                         					</td>
                         					</tr>
                         				</c:forEach>
                         			</c:if>
                         		</table>
                            </div><!--//row g-3  -->
                        </div><!-- //bg-light -->
                    </div><!-- //col-lg-7 -->
                </div><!-- //row justify-content-center -->
            </div><!-- //container -->
        </div>

<%@ include file ="../../common/common_bottom.jsp" %>