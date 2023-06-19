<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common_top.jsp"%>

    <!-- suppotersDetailView.jsp<br> -->

<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.js"></script>
<script type="text/javascript">
	
	function deletesupporters(num, pageNumber){
	
		var isDel = confirm("정말 삭제하시겠습니까?"); 
		if(isDel == true){
			location.href="/supporters/admin/delete.su?num="+num+"&pageNumber="+pageNumber;
		}			
	}

	/* 좋아요 버튼 클릭 */
	var heart_flag = false;
	function heart(){
		if(heart_flag == false){ // 좋아요 클릭
			$('#heart').attr('src', '../../resources/images/icon/heart.png');
			heart_flag = true;
		}else{ // 좋아요 취소
			$('#heart').attr('src', '../../resources/images/icon/empty_heart.png');
			heart_flag = false;
		}
	}//heart

	/* 북마크 버튼 클릭 */
	var bookmark_flag = false;
	function bookmark(){
		if(bookmark_flag == false){ // 북마크 클릭
			$('#bookmark').attr('src', '../../resources/images/icon/bookmark.png');
			bookmark_flag = true;
		}else{ // 북마크 취소
			$('#bookmark').attr('src', '../../resources/images/icon/empty_bookmark.png');
			bookmark_flag = false;
		}
	}//bookmark	
	
</script>


<!-- Page Header Start -->
    <div class="container-fluid page-header py-5 mb-5 wow fadeIn" data-wow-delay="0.1s">
        <div class="container text-center py-5">
            <h1 class="display-3 text-white mb-4 animated slideInDown">서포터즈 게시판</h1>
            <nav aria-label="breadcrumb animated slideInDown">
                <ol class="breadcrumb justify-content-center mb-0">
                </ol>
            </nav>
        </div>
    </div>
<!-- Page Header End -->

<center>
<h2>글내용 보기</h2>    
<table border="1" width="600px">
	<%-- <tr >
		<td>글번호</td>
		<td>${supporters.num }</td>		
	</tr> --%>
	<tr>
		<td width="100px">서포터즈명</td>
		<td colspan="3" align="center">${supporters.supportersname }</td>
	</tr>
	<tr>
		<td width="100px">등록일</td>
		<td>
			<fmt:parseDate var="newDay" value="${supporters.regdate}" pattern="yyyy-MM-dd"/>				
			<fmt:formatDate var="fNewDay" value="${newDay}" pattern="yyyy-MM-dd"/>
			${fNewDay }
		</td>
		<td width="100px">조회수</td>
		<td>${supporters.readcount }</td>		
	</tr>
	<tr>
		<td>모집상태</td>
		<td colspan="3" align="center">
			<c:if test="${supporters.state == 0}"><font color="blue">[모집중]</font></c:if>
	    	<c:if test="${supporters.state == 1}"><font color="red">[모집완료]</font></c:if>
	    	<c:if test="${supporters.state == 2}"><font color="black">[모집기한 마감]</font></c:if>	
		</td>
	</tr>
	<tr>
		<td>모집기한</td>
		<td colspan="3" align="center">
			<fmt:parseDate var="newDay2" value="${supporters.deadline}" pattern="yyyy-MM-dd"/>				
			<fmt:formatDate var="fNewDay2" value="${newDay2}" pattern="yyyy-MM-dd"/>
			${fNewDay2 }
		</td>
	</tr>
	<tr>
		<td>모집대상</td>
		<td colspan="3" align="center">
			<c:if test="${supporters.target == 0}">전체회원</c:if>
	    	<c:if test="${supporters.target == 1}">우수회원</c:if>
		</td>
	</tr>
	<tr>
		<td>모집인원</td>
		<td>${supporters.limit }</td>
		<td>신청인원</td>
		<td>${supporters.applicant }</td>
	</tr>
	<tr>
		<td>활동 시작일</td>
		<td>
			<fmt:parseDate var="newDay3" value="${supporters.startdate}" pattern="yyyy-MM-dd"/>				
			<fmt:formatDate var="fNewDay3" value="${newDay3}" pattern="yyyy-MM-dd"/>
			${fNewDay3 }
		</td>
		<td>활동 종료일</td>
		<td>
			<fmt:parseDate var="newDay4" value="${supporters.enddate}" pattern="yyyy-MM-dd"/>				
			<fmt:formatDate var="fNewDay4" value="${newDay4}" pattern="yyyy-MM-dd"/>
			${fNewDay4}
		</td>
	</tr>
	<tr>
		<td>활동내용</td>
		<td colspan="3" align="center">${supporters.content }</td>
	</tr>
	<tr>
		<td colspan="4" align="center">
			<!-- <form action="/supporters/admin/update.su" method="post"> -->
				<%-- <input type="hidden" name="supportersname" value="${supporters.supportersname}">
		    	<input type="hidden" name="state" value="${supporters.state}">
		    	<input type="hidden" name="pageNumber" value="${pageInfo.pageNumber}"> --%>
			<input type="submit" value="신청하기" class="btn btn-success" onClick="">
			<input type="button" value="취소하기" class="btn btn-success" onClick="">
			<input type="button" value="목록" class="btn btn-success" onclick="location.href='/supporters/all/list.su?pageNumber=${pageNumber}'">									
		</td>
	</tr>
	<tr>
		<td colspan="4" align="center">
			<!-- 수정, 삭제 버튼은 관리자 에게만 보이도록 -->
			<c:if test="${'admin' == userid}">
				<input type="button" value="수정" class="btn btn-success" onClick="location.href='/supporters/admin/update.su?num=${supporters.num}&pageNumber=${pageNumber}'">
				<input type="button" value="삭제" class="btn btn-success" onClick="deletesupporters('${supporters.num}','${pageNumber}')">
			</c:if>	
			<!-- //수정, 삭제 버튼은 관리자에게만 보이도록 -->
		</td>
	</tr>
</table>
</center>    

<!-- 좋아요, 북마크 아이콘 -->
<div class="container">
	<div align="right">
		<img src="<%=request.getContextPath()%>/resources/images/icon/empty_heart.png" id="heart" width="30" height="40" onclick="heart()">
	   	<img src="<%=request.getContextPath()%>/resources/images/icon/empty_bookmark.png" id="bookmark" width="30" height="30" onclick="bookmark()">
	</div><br>
</div>
<!-- // 좋아요, 북마크 아이콘 -->

<!-- 댓글 입력창 -->
<form action="/supporters/admin/insert.scmt" method="post">
	<input type="hidden" name="bnum" value="${supporters.num}"> 
	<input type="hidden" name="userid" value="${userid}"> 
	<input type="hidden" name="pageNumber" value="${pageNumber }">
	<input type="hidden" name="isSecret" value="N">
	
	<div class="card mb-2">
		<div class="card-header bg-light">
			<i class="fa fa-comment fa"></i> COMMENTS
		</div>
		<div class="card-body">
			<ul class="list-group list-group-flush">
				<li class="list-group-item">
					<div class="form-inline mb-2"></div>					
					<textarea class="form-control" name="content" rows="3"></textarea>
					<form:errors cssClass="err" path="content"/> <!-- 유효성검사 -->
					<div>
						<input type="checkbox" id="reply_secret" name="reply_secret" style="margin-bottom: 10px; margin-top: 10px; margin-right: 5px;" />
						<label for="reply_secret" style="cusor:pointer;">비밀댓글로 작성</label>
					</div>
					<div>
						<input type="submit" class="btn btn-success" value="댓글달기">
					</div>
				</li>
			</ul>
		</div>
	</div>
</form>
<!-- //댓글 입력창 -->	  


 	    

<%@ include file="../common/common_bottom.jsp"%>     