<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common_top.jsp" %> 

    <!-- boardDetailView.jsp<br> -->

<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.js"></script> 
<script type="text/javascript">
	
	$(document).ready(function(){ 
		alert('document');
		//getAllComments();   
	})
	 
	
	//댓글 목록 가져오기
	function getAllComments(){
		alert('getAllComments');
		var userid = $('input[name=userid]').val(); // 현재 로그인 아이디
		var pageNumber2 = $('input[name=pageNumber]').val(); // 현재 페이지
		
		$.ajax({
			url : '/boardcomments/user/list.bcmt',
			type : 'post',
			data : ({
				bnum : $('input[name=bnum]').val(), ///
				pageNumber : $('input[name=pageNumber]').val()
			}),
			success : function(data){
				alert('성공');
				var result = "<table class='table table-hover'>";
				$.each(data,function(bnum, value) { //값이 여러개라서 반복문 사용
                	result += "<tr><td>";
                	
                	if(value.isdeleted == 'Y'){ //삭제된 댓글일 경우
                		result += "삭제된 댓글입니다</td><td></td></tr>";
                	}else{ 
	                	result += "작성자 : "+value.userid+"<br>";
	                	result += "<span id='bcmt_update"+value.num+"'>"+value.content+" ";
	                	result += "<input type='button' value='답글달기' ";
	                	result += "onclick='replybcmt("+value.num+","+value.bnum+","+value.ref+","+value.restep+","+value.relevel+","+value.pageNumber+")'><br>"+value.regdate+"<br>";
	                	result += "<span id='replybcmt_area"+value.num+"'></span></td></span>";
	                	if(value.userid == userid ){ // 댓글 작성자라면 수정, 삭제 보임
	                		result += "<td align='right'><a href='javascript:updateComments("+value.num+","+pageNumber2+","+value.bnum+")'>수정</a>/";
	                		result += "<a href='javascript:deleteComments("+value.num+","+pageNumber2+","+value.bnum+")'>삭제</a></td>";
	                	}
	                	result += "</tr>";
                	}               	
	        	}//each 
				 result += "</table>";
	             $('#comments_area').html(result);
			},//success
			error : function(request, error) {
				alert("error");
				//error 발생이유
				//alert("code : "+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		}); //ajax
	}//getAllComments
	
	
	//글의 삭제버튼을 클릭했을때
	function deleteboard(num, pageNumber){
		
		var isDel = confirm("정말 삭제하시겠습니까?"); //확인:true, 취소:false
		if(isDel == true){
			location.href="/board/user/delete.br?num="+num+"&pageNumber="+pageNumber;
		}			
	}	
	
	//댓글의 삭제 버튼 클릭
	function deleteComments(num, pageNumber, bnum){
		alert("삭제할 댓글의 번호: "+num);
		var bcmt_result = confirm('정말 삭제하시겠습니까?');
		if(bcmt_result == true){
			location.href = '/boardcomments/user/delete.ncmt?num='+num+'&pageNumber='+pageNumber+'&bnum='+bnum;
		}
	}
	
	
</script>

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
            <h1 class="display-3 text-white mb-4 animated slideInDown">자유 게시판</h1>
            <nav aria-label="breadcrumb animated slideInDown">
                <ol class="breadcrumb justify-content-center mb-0">
                </ol>
            </nav>
        </div>
    </div>
<!-- Page Header End -->

<h2>글 상세보기</h2>    
<table border="1" class="table">
	<tr>
		<td>글번호</td>
		<td>${board.num }</td>		
	</tr>
	<tr>
		<td>조회수</td>
		<td>${board.readcount }</td>
	</tr>
	<tr>
		<td>작성자</td>
		<td>${board.userid}</td>
	</tr>
	<tr>
		<td>작성일</td>
		<td>
			<fmt:parseDate var="newDay" value="${board.regdate}" pattern="yyyy-MM-dd"/>				
			<fmt:formatDate var="fNewDay" value="${newDay}" pattern="yyyy-MM-dd"/>
			${fNewDay }
		</td>
	</tr>
	<tr>
		<td>글제목</td>
		<td>${board.subject }</td>
	</tr>
	<tr>
		<td>글내용</td>
		<td><pre>${board.content }</pre></td>
	</tr>
	<tr>
		<td>이미지</td>
		<td><img src="<%=request.getContextPath() %>/resources/${board.image}"></td>
	</tr>
	<tr>
		<td colspan="2" align="center">			
			<!-- 수정, 삭제 버튼은 글 작성자에게만 보이도록 -->
			<c:if test="${board.userid == userid}">
				<input type="button" value="수정" class="btn btn-success" onClick="location.href='/board/user/update.br?num=${board.num}&pageNumber=${pageNumber}'">
				<input type="button" value="삭제" class="btn btn-success" onClick="deleteboard('${board.num}','${pageNumber}')">
			</c:if>	
			<!-- //수정, 삭제 버튼은 글 작성자에게만 보이도록 -->
				<input type="button" value="목록" class="btn btn-success" onclick="location.href='/board/all/list.br?pageNumber=${pageNumber}'">		
		</td>
	</tr>
</table>
    
<!-- 댓글 입력창 -->
<form action="/boardcomments/user/insert.bcmt" method="post">
	<input type="hidden" name="bnum" value="${board.num}"> 
	<input type="hidden" name="userid" value="${userid}"> 
	<input type="hidden" name="pageNumber" value="${pageNumber }">
	
	<div class="card mb-2">
		<div class="card-header bg-light">
			<i class="fa fa-comment fa"></i> COMMENTS
		</div>
		<div class="card-body">
			<ul class="list-group list-group-flush">
				<li class="list-group-item">
					<div class="form-inline mb-2"></div>					
					<textarea class="form-control" name="content" rows="3"></textarea>
					<form:errors cssClass="err" path="content"/><br>
					<input type="submit" class="btn btn-success" value="댓글달기">
				</li>
			</ul>
		</div>
	</div>
</form><br>
<!-- //댓글 입력창 -->


	<!-- 댓글 목록 -->		
	<%--<table border="1" class="table">
	 <c:if test="${fn:length(boardcomment) == 0}">
		<tr>
			<td colspan="5" align="center">
				등록된 댓글이 없습니다.
			</td>
		</tr>
	</c:if>
	
	<c:if test="${not empty boardcomment}">
	<c:forEach var="boardcomment" items="${boardcomment}">
		<tr>
			<td>댓글 번호: ${boardcomment.num}</td>
			<td>아이디: ${boardcomment.userid}</td>
			<td>내용: ${boardcomment.content}</td>
			<td>댓글 작성일: 
				<fmt:parseDate var="newDay2" value="${boardcomment.regdate}" pattern="yyyy-MM-dd"/>				
				<fmt:formatDate var="fNewDay2" value="${newDay2}" pattern="yyyy-MM-dd"/>
				${fNewDay2 }
			</td>
			<td>
				<input type="button" value="수정" class="btn btn-dark mt-3" onClick="">
				<input type="button" value="삭제" class="btn btn-dark mt-3" onClick="">
			</td>
		</tr>
	</c:forEach>
	</c:if>	
	</table>	 --%>
	<!-- //댓글 목록 -->			
	
	<!-- 댓글 목록 -->
	<div class="container">
	   	<span id="comments_area">
	   		<%-- <table border="1" class="table">
				<c:if test="${fn:length(boardcomment) == 0}">
					<tr>
						<td colspan="5" align="center">
							등록된 댓글이 없습니다.
						</td>
					</tr>
				</c:if>
			</table> --%>	
	   	</span>
	</div>
	<!-- //댓글 목록 -->
	   	

<%@ include file="../common/common_bottom.jsp"%>
