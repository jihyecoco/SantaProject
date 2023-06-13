<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		<table class="table table-bordered table-striped table-dark table-hover">
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
					<p class="panel-faq-title">${qnaLists[i].qnasubject}</p>
					<div class="panel-faq-answer">
						<p>Q : ${qnaLists[i].qnaquestion}</p>
						<p>A : ${qnaLists[i].qnaanswer}</p>
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
        <button id="btn-all-close">QnA ALL Close</button>
        <button id="btn-insert" onClick="location.href='/qna/user/insertQuestion.qna'">질문 등록</button>
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
		  
		  // 반복문 순회하면서 해당 FAQ제목 클릭시 콜백 처리
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
    </script>
<%@ include file="../common/common_bottom.jsp" %>
</html>