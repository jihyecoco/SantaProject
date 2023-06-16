<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- qnaInsertAnswerForm.jsp -->
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
                    <li class="breadcrumb-item" aria-current="page">질문등록</li>
                </ol>
            </nav>
        </div>
    </div>
    <!-- Page Header End -->


    <!-- Answer Insert Form Start -->
    <div class="container-fluid py-5">
        <div class="container">
        	<!-- 타이틀 -->
            <div class="text-center mx-auto wow fadeInUp" data-wow-delay="0.1s" style="max-width: 500px;">
                <p class="fs-5 fw-bold text-primary">Q&A</p>
                <h1 class="display-5 mb-5">답변등록</h1>
            </div>
            <!-- //타이틀 -->
            
            <!-- 폼 -->
            <div class="row justify-content-center">
                <div class="col-lg-7">
                    <div class="bg-light rounded p-4 p-sm-5 wow fadeInUp" data-wow-delay="0.1s">
                    	<div class="mb-2 mx-1"><b>질문내용 : </b></div>
	                    <div class="card mb-3">
	                		<div class="card-body">
								<h6 class="card-title"><b>${qnaBean.qnasubject}</b></h6>
								<p class="card-text">${qnaBean.qnaquestion}</p>
							</div>
	                    </div>
	                    
            			<form:form action="/qna/admin/insertAnswer.qna" method="post">
                        
                        <!-- hidden으로 num넘기기 -->
                        <input type="hidden" name="qnanum" value="${qnaBean.qnanum}">
                        <!-- //hidden으로 num넘기기 -->
                            
                        <!-- 답변 내용 입력 -->
                        <div class="col-12">
                        	<div class="mb-2 mx-1"><b>답변 내용 : </b></div>
                            <textarea name="qnaanswer" class="form-control border-0 mb-3" placeholder="답변 내용" id="message" style="height: 200px">${qnaBean.qnaanswer}</textarea>
                        </div>
                        <!-- //답변 내용 입력 -->
                            
                        <!-- 답변하기 버튼 -->
                        <div class="col-12 text-center">
                        	<button class="btn btn-primary py-2 px-4" type="submit">답변하기</button>
                        </div>
                        <!-- //답변하기 버튼 -->
			            </form:form>
                        </div>
                    </div>
                </div>
            </div>
            <!-- //폼 end -->
        </div>
    	<!-- //Answer Insert Form End-->

<%@ include file="../common/common_bottom.jsp" %>