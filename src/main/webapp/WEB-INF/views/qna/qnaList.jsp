<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 권한에 따른 페이지 열람을 위한 라이브러리 추가 -->
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<!-- qnaList.jsp -->
<%@ include file="../common/common_top.jsp" %>
	<style type="text/css">
		html,body {
		  font-family: Helvetica, Arial, sans-serif;
		  margin: 0;
		}
		.panel-faq-container {
		  margin-bottom: -16px;
		}
		.panel-faq-title {
		  color: #00eaea;
		  cursor: pointer;
		}
		.panel-faq-answer {
		  height: 0;
		  overflow: hidden;
		  /* 변화가 시작되는 쪽에다가 transition 적용해준다 0 -> 300px 
		  왜? 닫기 버튼을 누를 때 변화가 티남 */
		  transition: all 1s;
		}
		#btn-all-close {
		  margin-bottom: 10px;
		  background-color: #726996;
		  border: none;
		  color: #fff;
		  cursor: pointer;
		  padding: 10px 25px;
		  float: right;
		}
		#btn-all-close:hover {
		  background-color: yellow;
		  color: #000;
		  transition: all 0.35s;
		}
		#btn-insert {
		  margin-bottom: 10px;
		  background-color: #726996;
		  border: none;
		  color: #fff;
		  cursor: pointer;
		  padding: 10px 25px;
		  float: right;
		}
		#btn-insert:hover {
		  background-color: yellow;
		  color: #000;
		  transition: all 0.35s;
		}
		.activeList {
		  display: block;
		  /* 높이를 정해줘야지만 transition이 적용됨 */
		  height: 300px;
		}
		#uploadimage{
			width:20px;
		}
	</style>
	
	<!-- Page Header Start -->
    <div class="container-fluid page-header py-5 mb-5 wow fadeIn" data-wow-delay="0.1s">
        <div class="container text-center py-5">
            <h1 class="display-3 text-white mb-4 animated slideInDown">QnA</h1>
            <nav aria-label="breadcrumb animated slideInDown">
                <ol class="breadcrumb justify-content-center mb-0">
                    <li class="breadcrumb-item"><a href="#">Home</a></li>
                    <li class="breadcrumb-item" aria-current="page">QnA</li>
                </ol>
            </nav>
        </div>
    </div>
    <!-- Page Header End -->
	
	<security:authorize access="hasRole('admin')">
		<c:set var="activeflag" value="true"/>
	</security:authorize>
    <!-- Qna Start -->
    	<!-- qna 검색 -->
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
    	<!-- //qna 검색 -->
    	
    	<!-- qna 목록 -->
		<div class="container">
    	<br>
		<table id="qna-table" class="table table-bordered table-striped table-dark table-hover">
			<thead class="thead-light text-center">
        		<tr>
        			<th>No</th>
        			<th>Category</th>
        			<th>QnA Title</th>
        			<th>ID</th>
        			<th>Date</th>
        		</tr>
			</thead>
			<tbody class="text-center">
			<c:forEach var="i" begin="0" end="${fn:length(qnaLists)-1}">
			<tr>
				<td>${qnaLists[i].qnanum}</td>
				<td>${qnaLists[i].qnacategory}</td>
				<td class="text-left" width="50%">
				<div class="panel-faq-container">
					<p class="panel-faq-title">
					
					<!-- 비밀글이면 -->
					<c:if test="${qnaLists[i].qnasecret==1}">
						<!-- 자물쇠 이미지 출력 -->
						<img src="../../resources/images/qna/lock_16x.png">
					</c:if>
					<!-- 비밀글 출력 end -->
					
					${qnaLists[i].qnasubject}</p>
					<div class="panel-faq-answer">
						<p>Q : ${qnaLists[i].qnaquestion}</p>
						<c:set var="imageall" value="${fn:split((qnaLists[i].qnaimage),',')}"/>
						<c:forEach var="multiimage" items="${imageall}">
							<img id="uploadimage" src="${multiimage}">
						</c:forEach>
						<!-- 답변이 null이 아닐 때만 출력 -->
						<c:if test="${qnaLists[i].qnaanswer != null}">
						<p>A : ${qnaLists[i].qnaanswer}</p>
						</c:if>
						
						<!-- 로그인한 id가 admin일 때 현재 글 삭제, 답변이 없을 때 답변 등록 가능-->
						<!-- 로그인한 id가 작성자와 같을 때 현재 글 수정 가능-->
						<c:choose>
						<c:when test="${principal.getName() == 'admin'}">
							<c:set var="qnanum" value="${qnaLists[i].qnanum}"/>
							<button class="btn btn-primary" onClick="deleteQna()">질문삭제</button>
							<c:if test="${qnaLists[i].qnaanswer == null}">
    							<button class="btn btn-primary" onClick="location.href='/qna/admin/insertAnswer.qna?qnanum=${qnaLists[i].qnanum}&pageNumber=${pageNumber}'">답변등록/수정</button>
							</c:if>
						</c:when>
						<c:when test="${principal.getName() == qnaLists[i].usersid}">
							<c:set var="qnanum" value="${qnaLists[i].qnanum}"/>
							<c:if test="${qnaLists[i].qnaanswer == null}">
    							<button class="btn btn-primary" onClick="location.href='/qna/admin/update.qna'">질문수정</button>
    							<button class="btn btn-primary" onClick="deleteQna()">질문삭제</button>
							</c:if>
						</c:when>
						</c:choose>
						
					</div>
				</div>
				</td>
          		<td>${qnaLists[i].usersid}</td>
          		<td>
          			<fmt:formatDate var="fdate" value="${qnaLists[i].qnadate}" pattern="yyyy-MM-dd HH:mm"/>
          			${fdate }
          		</td>
        	</tr>
			</c:forEach>
			<tr class="bg-info">
				<td colspan=4 class="text-left">QnA 총 합계</td>
				<td>${pageInfo.totalCount }</td>
			</tr>
			</tbody>
		</table>
    	<!-- 모두 닫기/질문 등록 버튼 -->
        <button id="btn-all-close" style="margin-left: 5px;">QnA ALL Close</button>
        <button id="btn-insert" onClick="location.href='/qna/user/insertQuestion.qna'">질문등록</button>
    	<!-- //모두 닫기/질문 등록 버튼 -->
		</div>
    	<!-- //qna 목록 -->
    	<!-- Qna End -->
    	
		<script type="text/javascript">
			window.onload = () => {
		  // panel-faq-container
		  const panelFaqContainer = document.querySelectorAll(".panel-faq-container"); // NodeList 객체
		  
		  // panel-faq-answer
		  let panelFaqAnswer = document.querySelectorAll(".panel-faq-answer");

		  // btn-all-close
		  const btnAllClose = document.querySelector("#btn-all-close");
		  
		  // 반복문 순회하면서 해당 Qna제목 클릭시 콜백 처리
		  for( let i=0; i < panelFaqContainer.length; i++ ) {
		    panelFaqContainer[i].addEventListener('click', function() { // 클릭시 처리할 일
		    	// FAQ 제목 클릭시 -> 본문이 보이게끔 -> active 클래스 추가
		      panelFaqAnswer[i].classList.toggle('activeList');
		    });
		  };
		  
		  btnAllClose.addEventListener('click', function() {
		    // 버튼 클릭시 처리할 일  
		    for(let i=0; i < panelFaqAnswer.length; i++) {
		        panelFaqAnswer[i].classList.remove('activeList');
		    };
		  });
		}
			//현재 글 삭제를 눌렀을 때=>deleteqna
			function deleteQna(){
				var qnanum = "<c:out value='${qnanum}'/>";
				
				if(!confirm('해당 글을 삭제하시겠습니까?')){
					//취소를 눌렀을 때
					//돌아가기
					return;
				}else{
					//확인을 눌렀을 때
					//delete 컨트롤러로 이동
					location.href="/qna/user/deleteQna.qna?qnanum="+qnanum+"&pageNumber=${pageNumber}";
				}//if~else
			}//deleteqna end
		
    </script>
<%@ include file="../common/common_bottom.jsp" %>
</html>