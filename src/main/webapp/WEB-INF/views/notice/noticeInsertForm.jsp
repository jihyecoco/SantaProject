<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common_top.jsp" %>  
<style type="text/css">
	.err{
		color:red;
		font-weight: bold;
		font-size: 9px;
	}
</style>
    
    <!-- Page Header Start -->
    <div class="container-fluid page-header py-5 mb-5 wow fadeIn" data-wow-delay="0.1s">
        <div class="container text-center py-5">
            <h1 class="display-3 text-white mb-4 animated slideInDown">공지사항</h1>
            <nav aria-label="breadcrumb animated slideInDown">
                <ol class="breadcrumb justify-content-center mb-0">
                </ol>
            </nav>
        </div>
    </div>
    <!-- Page Header End -->


<!-- Quote Start -->
<form:form commandName="notice" action="/notice/admin/insert.no" method="post">
<div class="container-fluid py-5">
	<div class="container">
            <div class="text-center mx-auto wow fadeInUp" data-wow-delay="0.1s" style="max-width: 500px;">
                <p class="fs-5 fw-bold text-primary"></p>
                <h1 class="display-5 mb-5">공지사항 글쓰기</h1>
            </div>
            <div class="row justify-content-center">
                <div class="col-lg-7">
                    <div class="bg-light rounded p-4 p-sm-5 wow fadeInUp" data-wow-delay="0.1s">
                        <div class="row g-3">
                        	                     	
                        	<div class="col-12">
                        		<h5>작성자</h5>
                                <div class="form-floating">
                                	${userId}
                                    <input type="hidden" class="form-control border-0" name="userid" id="userid" value="${userId}">
                                </div>
                            </div> 
                                         	
							<div class="col-12">
                        		<h5>글 제목</h5>
                                <div class="form-floating">
                                    <input class="form-control border-0" name="subject" id="subject" value="${notice.subject}">
                                	<form:errors cssClass="err" path="subject" />
                                </div>
                            </div>
							<div class="col-12">
                            	<h5>내용</h5>
                               	<div class="form-floating">
                                    <textarea class="form-control border-0" id="content" name="content" style="height: 200px">${notice.content}</textarea>
                                    <label for="content">content</label>
                                    <form:errors cssClass="err" path="content"/>
                                </div>
                            </div>
                            <div class="col-12 text-center">                          	
                            	<input type="submit" value="등록" class="btn btn-success">
                            	<input type="reset" value="다시작성" class="btn btn-success"> 
                            	<input type="button" value="목록" class="btn btn-success" onclick="location.href='/notice/all/list.no?pageNumber=${pageNumber}'">
                            </div>                           				
						</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form:form>  
<!-- //Quote Start -->
     
     
<%@ include file="../common/common_bottom.jsp"%>      