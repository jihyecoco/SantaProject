<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- stampCertList.jsp -->
<%@ include file="../common/common_top.jsp" %>
<style>
	th, td {
	  text-align: center;
	}
</style>
	<!-- Page Header Start -->
    <div class="container-fluid page-header py-5 mb-5 wow fadeIn" data-wow-delay="0.1s">
        <div class="container text-center py-5">
            <h1 class="display-3 text-white mb-4 animated slideInDown">완등내역 관리</h1>
        </div>
    </div>
    <!-- Page Header End -->
    
    <!-- 산 목록 Start -->
        <div class="container">
            <div class="text-center mx-auto" style="max-width: 500px;">
                <h1 class="display-5 mb-5">완등내역 관리</h1>
            </div>
            
                 <!-- 검색창 -->
				            <nav class="navbar navbar-light bg-light">
				  				<div class="container" style="display:table-cell; vertical-align:middle;">
				   				 	<form class="d-flex" action="/stamp/admin/adminlist.stp" method="get">
				   				 		<div class="col-sm-2">
					   				 		<select name="whatColumn" class="form-select">
					   				 			<option value="">전체</option>
					   				 			<option value="아이디">아이디</option>
					   				 		</select>
				   				 		</div>
				   				 		<div class="col-sm-8">
				     						<input class="form-control me-2" type="text" name="keyword">
				      					</div>
				      					<div class="col-sm-2" align="center">
				      						<button class="btn btn-outline-success" type="submit">Search</button>
				      					</div>
				    				</form>
				 			 	</div>
							</nav>
							<br>
				 <!-- //검색창 -->
			    
							
                            <!-- 인증신청 목록 Start -->
							<table border="1" class="table table-hover table-borded" border="1">
							  <thead>
							    <tr align="center">
							      <th scope="col">번호</th>
							      <th scope="col">아이디</th>
							      <th scope="col">보유 스탬프</th>
							      <th scope="col">인증신청 산 번호</th>
							      <th scope="col">인증사진 확인</th>
							      <th scope="col">인증상태</th>
							    </tr>
							  </thead>
							  <tbody>
							  	<c:if test="${stampList == null}">
							  		<td colspan="7">등록된 데이터가 없습니다.</td>
							  	</c:if>
							  	<c:forEach var="sl" items="${stampList}">
							    <tr>
							      <th scope="row">${sl.stampnum}</th>
							      <td>${sl.usersid}</td>
							      <td>
								  <c:set var="applyCount" value="0"/>
							    	<c:forEach var="sl2" items="${stampList}">
							    		<c:if test="${sl2.stampapply == 1}">
							    			<c:set var="applyCount" value="${applyCount + 1}"/>
							    		</c:if>
							    	</c:forEach>
							    	${applyCount}</td>
							      <td>${sl.mountainnum}</td>
							      <td>
							      <a href="#"><img alt="돋보기" src="<%=request.getContextPath()%>/resources/images/icon/detailview.png"></a>
							      </td>
							      <td>
									<select id="stampapply" class="form-select" onChange="updateApply('${sl.stampnum}')">
										<option value="0" <c:if test="${sl.stampapply == 0}">selected</c:if>>대기</option>
										<option value="1" <c:if test="${sl.stampapply == 1}">selected</c:if>>승인</option>
										<option value="2" <c:if test="${sl.stampapply == 2}">selected</c:if>>거절</option>
									</select>
								  </td>
							    </tr>
							  	</c:forEach>
							  </tbody>
							</table>
                            <!-- //인증신청 목록 End -->
						<!-- 페이지 표시 -->
						<div align="center">
						 	${pageInfo.pagingHtml}
						</div>
						<!-- //페이지 표시 -->
                        </div>
    <!-- //완등내역 End -->
    <script>
    	function updateApply(stampnum){
    		var selector = document.getElementById('stampapply');
    		
    		var selectItem = selector.options[selector.selectedIndex].value;
    		
    		console.log(selectItem+","+stampnum);
    		
    		location.href='/stamp/admin/update.stp?stampapply='+selectItem+'&stampnum='+stampnum;
    	}
    </script>
<%@ include file="../common/common_bottom.jsp" %>