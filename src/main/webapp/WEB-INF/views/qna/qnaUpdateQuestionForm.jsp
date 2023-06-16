<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- qnaUpdateQuestionForm.jsp -->
<%@ include file="../common/common_top.jsp" %>
<style type="text/css">
	.err {
		font-weight: bold;
		color: red;
	}
</style>
    <!-- Page Header Start -->
    <div class="container-fluid page-header py-5 mb-5 wow fadeIn" data-wow-delay="0.1s">
        <div class="container text-center py-5">
            <h1 class="display-3 text-white mb-4 animated slideInDown">Q&A</h1>
            <nav aria-label="breadcrumb animated slideInDown">
                <ol class="breadcrumb justify-content-center mb-0">
                    <li class="breadcrumb-item"><a href="/users/all/main.lg">Home</a></li>
                    <li class="breadcrumb-item"><a href="/qna/all/list.qna">Q&A</a></li>
                    <li class="breadcrumb-item" aria-current="page">질문수정</li>
                </ol>
            </nav>
        </div>
    </div>
    <!-- Page Header End -->


    <!-- qna Insert Form Start -->
    <div class="container-fluid py-5">
        <div class="container">
        	<!-- 타이틀 -->
            <div class="text-center mx-auto wow fadeInUp" data-wow-delay="0.1s" style="max-width: 500px;">
                <p class="fs-5 fw-bold text-primary">Q&A</p>
                <h1 class="display-5 mb-5">질문수정</h1>
            </div>
            <!-- //타이틀 -->
            
            <!-- 폼 -->
            <form:form commandName="qnaBean" action="/qna/user/update.qna" method="post" enctype="multipart/form-data">
            <div class="row justify-content-center">
                <div class="col-lg-7">
                    <div class="bg-light rounded p-4 p-sm-5 wow fadeInUp" data-wow-delay="0.1s">
                        <div class="row g-3" style="margin-bottom:-10px;">
                        	
                        	<!-- 제목 입력 -->
                            <div class="col-sm-9" style="margin-bottom:-10px;">
                                <div class="mb-2 mx-1"><b>제목 : </b></div>
                                    <input type="text" value="${qnaBean.qnasubject}" class="form-control border-0" id="subject" name="qnasubject"><br>
                            </div>
                        	<span class="col-12" style="margin-top:-3px;margin-bottom:-3px;"><form:errors cssClass="err" path="qnasubject"/></span>
                        	<!-- //제목 입력 -->
                        	
                        	<!-- 카테고리 입력 -->
                            <div class="col-sm-3" style="margin-bottom:-10px;">
                                	<div class="mb-2 mx-1"><b>카테고리 : </b></div>
                                	<select name="qnacategory" class="form-select border-0">
                                		<option value="">선택</option>
	    								<option value="계정" <c:if test="${qnaBean.qnacategory=='계정'}">selected</c:if>>계정</option>
					    				<option value="크루" <c:if test="${qnaBean.qnacategory=='크루'}">selected</c:if>>크루</option>
					    				<option value="게시판" <c:if test="${qnaBean.qnacategory=='게시판'}">selected</c:if>>게시판</option>
					    				<option value="거래/나눔" <c:if test="${qnaBean.qnacategory=='거래/나눔'}">selected</c:if>>거래/나눔</option>
					    				<option value="기타" <c:if test="${qnaBean.qnacategory=='기타'}">selected</c:if>>기타</option>
                                	</select>
                            </div>
                            <span class="col-12" style="margin-bottom:-3px;"><form:errors cssClass="err" path="qnacategory"/></span>
                        	<!-- //카테고리 입력 -->
                            
                            <!-- 사진 첨부 -->
                            <div class="mb-1">
                                <div class="mb-2 mx-1"><b>참고 사진 : </b></div>
  								<input class="form-control" type="file" id="formFileMultiple" name="upload" multiple>
								<span style="font-size:10px; color: gray;">※첨부파일은 최대 10개까지 등록이 가능합니다.</span>
							</div>
                            <!-- //사진 첨부 -->
                            
                        	<!-- 질문 내용 입력 -->
                            <div class="col-12">
                            	<div class="mb-2 mx-1"><b>질문 내용 : </b></div>
                            	<textarea name="qnaquestion" class="form-control border-0" placeholder="질문 내용" id="message" style="height: 200px">${qnaBean.qnaquestion}</textarea>
                            </div>
                        	<!-- //질문 내용 입력 -->
                        	
                            <!-- 질문 내용 오류 메세지 출력 -->
                            <span class="col-12"><form:errors cssClass="err" path="qnaquestion"/></span>
                            <!-- //질문 내용 오류 메세지 출력 -->
                            
                            <!-- 비밀글 설정 출력 -->
                            <div class="col-12">
                            	<div class="mb-2 mx-1"><b>비밀글 : </b></div>
								<div class="form-check form-check-inline">
								  <input name="qnasecret" value="0" <c:if test="${qnaBean.qnasecret=='0'}">checked</c:if> class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault1">
								  <label class="form-check-label" for="flexRadioDefault1">
								    전체글
								  </label>
								</div>
								<div class="form-check form-check-inline">
								  <input name="qnasecret" value="1" <c:if test="${qnaBean.qnasecret=='1'}">checked</c:if> class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault2">
								  <label class="form-check-label" for="flexRadioDefault2">
								    비밀글
								  </label>
								</div>
                            </div>
                            <span class="col-12" style="margin-bottom:-3px;"><form:errors cssClass="err" path="qnasecret"/></span>
                            <!-- //비밀글 설정 출력 -->
                            
                            <!-- 질문하기 버튼 -->
                            <div class="col-12 text-center">
                                <button class="btn btn-primary py-2 px-4" type="submit">수정하기</button>
                            </div>
                            <!-- //질문하기 버튼 -->
                        </div>
                    </div>
                </div>
            </div>
            </form:form>
            <!-- //폼 end -->
        </div>
    </div>
    <!-- qna Insert Form End -->

<%@ include file="../common/common_bottom.jsp" %>