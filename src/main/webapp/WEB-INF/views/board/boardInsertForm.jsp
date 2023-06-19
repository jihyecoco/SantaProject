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

    <!-- boardInsertForm.jsp<br> -->
    
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
<form:form commandName="board" action="/board/user/insert.br" method="post" enctype="multipart/form-data">
	<div class="container-fluid py-5">
		<div class="container">
			<div class="text-center mx-auto wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;">
				<p class="fs-5 fw-bold text-primary"></p>
				<h1 class="display-5 mb-5">자유 게시글 작성</h1>
			</div>
			<div class="row justify-content-center">
				<div class="col-lg-9">
					<div class="bg-light rounded p-4 p-sm-5 wow fadeInUp" data-wow-delay="0.1s">
						<div class="row g-3">
							
							<div class="col-12">                     		
                                <div class="form-floating">
                                	<h5>작성자</h5>
                                	${userId}
                                    <input type="hidden" class="form-control border-0" name="userid" id="userid" value="${userId}">
                                </div>
                            </div> 
							
							<div class="col-sm-5">               		                  		
                                <div class="form-floating">
                                <h5>카테고리</h5>      
                                	<select name="category" class="form-select">
										<option value="">선택하세요</option>
										<c:forEach var="cate" items="<%=cateArr%>">
											<option value="${cate}" <c:if test="${board.category == cate}">selected</c:if>>${cate}
										</c:forEach>
									</select> 
								<form:errors cssClass="err" path="category" />
                                </div>
                            </div>       
                            
                            <div class="col-12">
                        		<h5>글 제목</h5>
                                <div class="form-floating">
                                    <input type="text" class="form-control border-0" name="subject" style="width:600px;" value="${board.subject}"> 
									<form:errors cssClass="err" path="subject" />
                                </div>
                            </div>
                            <div class="col-12">
                            	<h5>내용</h5>
                               	<div class="form-floating">
                                    <textarea name="content" class="form-control border-0" style="height:400px">${board.content}</textarea>
                                    <label for="content">content</label>
                                    <form:errors cssClass="err" path="content" />
                                </div>
                            </div>
                            
                            <div>
                            	<h5>이미지 첨부</h5>
                            	<input type="file" name="upload" id="upload">
                            	<%-- <form:errors cssClass="err" path="image"/> --%>                          	
                            </div>

							<div class="col-12 text-center">                          	
                            	<input type="submit" value="글쓰기" class="btn btn-success">
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
