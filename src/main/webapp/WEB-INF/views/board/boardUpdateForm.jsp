<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common_top.jsp" %> 
<style type="text/css">
	.err{
		color:red;
		font-weight: bold;
		font-size: 7px;
	}
</style>

   <!--  boardUpdateForm.jsp<br> -->
   
   <!-- Page Header Start -->
    <div class="container-fluid page-header py-5 mb-5 wow fadeIn" data-wow-delay="0.1s">
        <div class="container text-center py-5">
            <h1 class="display-3 text-white mb-4 animated slideInDown">자유 게시판</h1>
            <nav aria-label="breadcrumb animated slideInDown">
                <ol class="breadcrumb justify-content-center mb-0">
                </ol>
            </nav>
        </div>
    </div>
    <!-- Page Header End -->
   
<%
	String[] cateArr = {"정보","후기","추천","잡담"};
%>


<!-- Quote Start -->
<form:form commandName="board" action="/board/user/update.br" method="post" enctype="multipart/form-data">
	<input type="hidden" name="num" value="${board.num }">
	<input type="hidden" name="pageNumber" value="${param.pageNumber }">
	
	<div class="container-fluid py-5">
		<div class="container">
			<div class="text-center mx-auto wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;">
				<p class="fs-5 fw-bold text-primary"></p>
				<h1 class="display-5 mb-5">자유 게시글 수정</h1>
			</div>
			<div class="row justify-content-center">
				<div class="col-lg-9">
					<div class="bg-light rounded p-4 p-sm-5 wow fadeInUp" data-wow-delay="0.1s">
						<div class="row g-3">		        		
                            
                        <!-- 작성자 -->   
		        		<div class="col-10">                      		
                        	<div class="form-floating">
                                <input type="text" class="form-control border-0" name="userid" id="userid" value="${board.userid}" readonly>
								<label for="userid">작성자</label>
                            </div>
                        </div>
                        <!-- //작성자 -->
                        
                        <!-- 카테고리 -->		        		
		        		<div class="col-10">                 		                  		
                        	<div class="form-floating">
                        		<select name="category" id="category" class="form-select">    
									<option value="">선택하세요</option>
									<c:forEach var="cate" items="<%=cateArr%>">
										<option value="${cate}" <c:if test="${board.category == cate}">selected</c:if>>${cate}
									</c:forEach>
								</select>
								<label for="category">카테고리</label> 
								<form:errors cssClass="err" path="category" />
                        	</div>
                        </div>
                        <!-- 카테고리 -->
                        
                        <!-- 글제목 -->	        		
		        		<div class="col-10">
                            <div class="form-floating">
                            	<input type="text" class="form-control border-0" name="subject" id="subject" value="${board.subject}"> 
								<label for="subject">글 제목</label>
								<form:errors cssClass="err" path="subject" />
                            </div>
                        </div> 
                        <!-- //글제목 -->
                        
                        <!-- 글내용 -->		
		        		<div class="col-10">
                            <div class="form-floating">
                            	<textarea name="content" class="form-control border-0" id="content" style="resize: none;" style="height:300px">${board.content}</textarea>
                                <label for="content">글 내용</label>
                                <form:errors cssClass="err" path="content" />
                            </div>
                        </div>
                        <!-- //글내용 -->
                        
                        <!-- 이미지 --> 	        		
		        		<div class="col-10">
                        	<h6>이미지 첨부</h6>
                           	<img src="<%=request.getContextPath()%>/resources/images/board/${board.image}" width="100px"><br>
							<input type="file" name="upload" id="upload" value="${board.upload}" class="form-control">
							<input type="hidden" name="upload2" value="${board.image}" class="form-control">
                            <%-- <form:errors cssClass="err" path="image"/> --%>                   	
                        </div>
                        <!-- //이미지 -->
                        
		        		<div class="col-10 text-center">                          	
                        	<input type="submit" value="수정하기" class="btn btn-success">
                            <input type="reset" value="다시작성" class="btn btn-success"> 
                            <input type="button" value="목록" class="btn btn-success" onclick="location.href='/board/all/list.br?pageNumber=${pageNumber}'">
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
    