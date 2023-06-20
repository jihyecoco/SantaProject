<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common_top.jsp" %>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		getAllComments();
		
		//본 댓글창의 비밀 체크 박스를 클릭하면 이곳으로 와서 isSecret을 'N'에서 'Y'로 바꿈
		$("#reply_secret").change(function(){
			if($(this).prop("checked")){
				$('input[name=isSecret]').val('Y');
			}else{
				$('input[name=isSecret]').val('N');
			}
		});
		
		/* //대댓글창의 비밀 체크 박스를 클릭하면 이곳으로 와서 isSecret을 'N'에서 'Y'로 바꿈
		$('#reply_secret2').change(function(){
			alert('비밀');
			if($(this).prop("checked")){
				$('#isSecret2').attr('value','Y');
			}else{
				$('#isSecret2').attr('value', 'N');
			} 
		}); */
	})
	
	/* 댓글 목록 가져오기 */
	function getAllComments(){
		//alert('getAllComments');
		var loginId = $('input[name=writer]').val(); // 현재 로그인 아이디
		var pageNumber2 = $('input[name=pageNumber]').val(); // 현재 페이지
		
		$.ajax({
			url : '/crewcomments/user/list.ccmt',
			type : 'post',
			data : ({
				idx : $('input[name=idx]').val(),
				pageNumber : $('input[name=pageNumber]').val()
			}),
			success : function(data){
				//alert('성공');
				var result = "<h6 class='border-bottom pb-2 mb-0'>댓글 목록</h6>";
				$.each(data,function(index, value) { // 값이 여러개 일 때는 반복문 사용
	                result += "<div class='d-flex text-body-secondary pt-3'>";
					if(value.relevel>0){ // 대댓글일 경우
	                	var wid = value.relevel*15;
	                	result += "<img src='../../../resources/images/comments/level.gif' width='"+wid+"' height='32'>";
						result += "<img src='../../../resources/images/comments/re.png' width='32' height='32'>";
	                }
	                
	               		result += "<img class='bd-placeholder-img flex-shrink-0 me-2 rounded' src='../../../resources/images/comments/member.png' width='32' height='32'>";
	                	result += "<p class='pb-3 mb-0 small lh-sm border-bottom'>";
	               
	                if(value.deleteyn == 'Y'){ // 삭제된 댓글
	                	result += "삭제된 댓글입니다";
	                	result += "</p>";
	                }
					
	                else if(value.isSecret == 'Y'){ // 비밀댓글
						result += "<strong class='d-block text-gray-dark'>@"+value.writer;
	                	
	                	if(value.writer == loginId ){ // 댓글 작성자라면 수정, 삭제가 보임
	                		result += "&nbsp; [<a href='javascript:updateComments("+value.num+","+pageNumber2+","+value.idx+")'>수정</a>/";
	                		result += "<a href='javascript:deleteComments("+value.num+","+pageNumber2+","+value.idx+")'>삭제</a>]";
	                	}
	                	result += "</strong>";
	                	
	                	//1.댓글 작성자 본인일때 2. 해당 게시글의 작성자일때 3. 관리자일때 => 댓글 비밀설정해도 볼 수 있음
	                	if(value.writer == loginId || "${cbb.writer}" == loginId || "admin" == loginId){
	                		result += "<span id='ccmt_update" + value.num + "'><img src='../../../resources/images/icon/comments_lock.png' width='15' height='15'>" + value.content + "<br>";

	                	}else{ //위 3가지 경우에 해당되지 않는다면, 내용 대신 "비밀 댓글입니다."가 보임
	                		result += "<span id='ccmt_update" + value.num + "'><img src='../../../resources/images/icon/comments_lock.png' width='15' height='15'> 비밀 댓글입니다.<br>";
	                	}      			                	
	                	result += "<font color='gray' size='1px'>("+value.regdate+")</font><br>";
	                	result += "<input type='button' class='btn btn-light' value='답글' ";
	                	result += "onclick='replyccmt("+value.num+","+value.idx+","+value.ref+","+value.restep+","+value.relevel+","+value.pageNumber+")'>";
	                	result += "<span id='replyccmt_area"+value.num+"'></span>";
	                	result += "</span>";
	                	result += "</p>";
					}
	               
	               	else{
	                	result += "<strong class='d-block text-gray-dark'>@"+value.writer;
	                	
	                	if(value.writer == loginId ){ // 댓글 작성자라면 수정, 삭제 보임
	                		result += "&nbsp; [<a href='javascript:updateComments("+value.num+","+pageNumber2+","+value.idx+")'>수정</a>/";
	                		result += "<a href='javascript:deleteComments("+value.num+","+pageNumber2+","+value.idx+")'>삭제</a>]";
	                	}
	                	result += "</strong>";
	                	
	                	result += "<span id='ccmt_update"+value.num+"'>"+value.content+"<br>";
	                	result += "<font color='gray' size='1px'>("+value.regdate+")</font><br>";
	                	result += "<input type='button' class='btn btn-light' value='답글' ";
	                	result += "onclick='replyccmt("+value.num+","+value.idx+","+value.ref+","+value.restep+","+value.relevel+","+value.pageNumber+")'>";
	                	result += "<span id='replyccmt_area"+value.num+"'></span>";
	                	result += "</span>";
	                	result += "</p>";
	               	}
	                result += "</div>";
                })//each
                $('#comments_area').html(result);
			},
			error : function(request, error) {
				alert("error");
				//error 발생이유
				alert("code : "+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		}); //ajax
	}
	
	/* 댓글 유효성 검사 */
	function comments_check(f){
		if(f.content.value == ""){
			alert('내용을 입력하세요');
			return false;
		}
	}
	
	/* 댓글 답글달기 버튼 클릭 */
	function replyccmt(num, idx, ref, re_step, re_level, pageNumber){
		//1. 댓글 입력창 보여지기
		var replyccmt_area = "<form class='form-control' id='reply_form' action='/crewcomments/user/reply.ccmt' method='post'>";
		replyccmt_area += "<input type='hidden' name='idx' value='"+idx+"'>";
		replyccmt_area += "<input type='hidden' name='ref' value='"+ref+"'>";
		replyccmt_area += "<input type='hidden' name='restep' value='"+re_step+"'>";
		replyccmt_area += "<input type='hidden' name='relevel' value='"+re_level+"'>";
		replyccmt_area += "<input type='hidden' name='pageNumber' value='"+pageNumber+"'>";
		replyccmt_area += "<input type='hidden' id='isSecret2' name='isSecret' value='N'>"; // 비밀 댓글
		replyccmt_area += "<input type='text' name='content'>";
		replyccmt_area += "<input type='submit' class='btn btn-light' value='등록' onclick='javascript:return comments_check(reply_form)'>";
		//비밀 댓글 설정
		replyccmt_area += "<div>";
		replyccmt_area += "<input type='checkbox' id='reply_secret2' name='reply_secret2' style='margin-bottom: 10px; margin-top: 10px; margin-right: 5px;' ";
		replyccmt_area += "onchange='javascript:reply_secret()'/>";
		replyccmt_area += "<label for='reply_secret2' style='cusor:pointer;'>비밀댓글로 작성</label></div>";
		
		$('#replyccmt_area'+num).html(replyccmt_area);
	}
	
	/* 댓글 답글달기 비밀글 설정 클릭 */
	function reply_secret(){
		//alert('1');
		if($('#reply_secret2').prop("checked")){
			$('#isSecret2').attr('value','Y');
		}else{
			$('#isSecret2').attr('value', 'N');
		} 
	}
	
	/* 신청하기 버튼 클릭 */
	function signUp(crewname, state, pageNumber, loginId, crewboard_num){
		if(state == '1' ){//모집완료 일때
			alert('이미 모집완료된 크루입니다');
		}else{ // 모집중 일때
			var joincrew_list = new Array();
			
			<c:forEach items="${join_crew}" var="item">
			joincrew_list.push("${item.crewname}");
			</c:forEach>
			
			var result = false;
			for(i=0; i<joincrew_list.length; i++){
				if(joincrew_list[i] == crewname){ // 가입한 크루 목록에 신청하기 누른 크루이름이 있다면
					result = true;
				}
			}
			
			if(result == true) { // 멤버에 loginId가 있음
				alert('이미 가입한 크루입니다');
				return false;
			}else{
				var choose = confirm(crewname+"에 가입하시겠습니까?");
				if(choose == true){ // 확인 눌렀을때
					location.href = "/crew/user/update.cr?crewname="+crewname+"&pageNumber="+pageNumber+"&loginId="+loginId+"&num="+crewboard_num;
				}
			}
		}
	}
	
	
	/* 게시글 삭제 버튼 클릭 */
	function deleteCrewboard(cb_num, pageNumber){
		var result = confirm('정말 삭제하시겠습니까?');
		if(result == true){ // 삭제 요청
			location.href = '/crewboard/user/delete.bdcr?num='+cb_num+'&pageNumber='+pageNumber;
		}
	}
	
	/* 댓글 삭제 버튼 클릭 */
	function deleteComments(ccmt_num, pageNumber, idx){
		//alert(ccmt_num);
		//alert(pageNumber);
		var cmt_result = confirm('정말 삭제하시겠습니까?');
		if(cmt_result == true){
			location.href = '/crewcomments/user/delete.ccmt?num='+ccmt_num+'&pageNumber='+pageNumber+'&idx='+idx;
		}
	}
	
	/* 댓글 수정 버튼 클릭 */
	function updateComments(ccmt_num, pageNumber, idx){
		alert(ccmt_num);
		var cmt_updateform = "<form class='form-control' action='/crewcomments/user/update.ccmt' method='post'>";
		cmt_updateform += "<input type='text' name='content'>";
		cmt_updateform += "<input type='hidden' name='num' value='"+ccmt_num+"'>";
		cmt_updateform += "<input type='hidden' name='idx' value='"+idx+"'>";
		cmt_updateform += "<input type='hidden' name='pageNumber' value='"+pageNumber+"'>";
		cmt_updateform += "<input type='submit' value='확인'>";
		cmt_updateform += "<input type='reset' value='취소' onclick='javascript:getAllComments()'>";
		cmt_updateform += "</form>";
		
		$('#ccmt_update'+ccmt_num).html(cmt_updateform);
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
	}
	
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
	}

</script>

<!-- Projects Start -->
    <div class="container-xxl py-5">
        <div class="container">
            <div class="text-center mx-auto wow fadeInUp" data-wow-delay="0.1s" style="max-width: 500px;">
                <h2 class="display-5 mb-5">${cbb.crewname}</h2>
            </div>
            
           	<!-- 게시글 상세보기 -->
           	<table class="table">
           		<tr>
           			<td>글 제목</td>
           			<td>${cbb.subject}</td>
           		</tr>
           		<tr>
           			<td>작성자</td>
           			<td>${cbb.writer}</td>
           		</tr>
           		<tr>
           			<td>작성일</td>
           			<td>
           				<fmt:formatDate value="${cbb.regdate}" type="date" dateStyle="medium" timeStyle="medium" pattern="yyyy-MM-dd hh:mm:ss"/>
           			</td>
           		</tr>
           		<tr>
           			<td>조회수</td>
           			<td>${cbb.readcount}</td>
           		</tr>
           		<tr>
           			<td>크루명</td>
           			<td>${cbb.crewname}</td>
           		</tr>
           		<tr>
           			<td>현재 가입인원/정원</td>
           			<td>${cbb.crewnow}/${cbb.crewlimit}</td>
           		</tr>
           		<tr align="center">
           			<td colspan="2">글 내용</td>
           		</tr>
           		<tr>
           			<td colspan="2" align="center" height="200">
           				${cbb.contents}
           			</td>
           		</tr>
           		<tr>
           			<td colspan="2" align="right">
           				<input type="button" value="신청하기" class="btn btn-success" onclick="signUp('${cbb.crewname}','${cbb.state}', '${pageNumber}', '${loginId}', '${cbb.crewboardnum}')">
           			</td>
           		</tr>
           		<tr>
           			<td colspan="2" align="center">
	           			<!-- 해당 글 작성자만 수정 삭제 보이게 설정 -->
           				<c:if test="${cbb.writer == loginId}">
           					<input type="button" value="수정" class="btn btn-success" onclick="location.href='/crewboard/user/update.bdcr?num=${cbb.crewboardnum}&pageNumber=${pageNumber}'">
           					<input type="button" value="삭제" class="btn btn-success" onclick="deleteCrewboard(${cbb.crewboardnum}, ${pageNumber})">
           				</c:if>
	           			<!-- //해당 글 작성자만 수정 삭제 보이게 설정 -->
	           			<input type="button" value="목록" class="btn btn-success" onclick="location.href='/crewboard/all/list.bdcr?pageNumber=${pageNumber}'">
           			</td>
           		</tr>
           	</table>	
        </div>
	   
	   	<!-- 좋아요, 북마크 아이콘 -->
	   	<div class="container">
	   		<div align="right">
	   			<img src="<%=request.getContextPath()%>/resources/images/icon/empty_heart.png" id="heart" width="30" height="40" onclick="heart()">
	   			<img src="<%=request.getContextPath()%>/resources/images/icon/empty_bookmark.png" id="bookmark" width="30" height="30" onclick="bookmark()">
	   		</div>
	   		<br>
	   	</div>
	   	<!-- // 좋아요, 북마크 아이콘 -->
	   	
	    <!-- 댓글 입력창 -->
	    <form id="comments_form" action="/crewcomments/user/insert.ccmt" method="post">
	    	<input type="hidden" name="idx" value="${cbb.crewboardnum}"> <!-- 원글 번호 -->
		    <input type="hidden" name="writer" value="${loginId}"> <!-- 댓글 작성자 아이디 -->
		    <input type="hidden" name="pageNumber" value="${pageNumber}"> <!-- 페이지 -->
		    <input type="hidden" name="isSecret" value="N"> <!-- 비밀 댓글 여부 -->
		    
		    <div class="card mb-2">
			<div class="card-header bg-light">
			        <i class="fa fa-comment fa"></i> REPLY
			</div>
			<div class="card-body">
				<ul class="list-group list-group-flush">
				    <li class="list-group-item">
					<div class="form-inline mb-2">
						<!-- <label for="replyId"><i class="fa fa-user-circle-o fa-2x"></i></label>
						<input type="text" class="form-control ml-2" placeholder="Enter yourId" id="replyId">
						<label for="replyPassword" class="ml-4"><i class="fa fa-unlock-alt fa-2x"></i></label>
						<input type="password" class="form-control ml-2" placeholder="Enter password" id="replyPassword"> -->
					</div>
					<textarea class="form-control" name="content" rows="3"></textarea>
					
					<!-- 비밀댓글 -->
					<div>
						<input type="checkbox" id="reply_secret" name="reply_secret" style="margin-bottom: 10px; margin-top: 10px; margin-right: 5px;" />
						<label for="reply_secret" style="cusor:pointer;">비밀댓글로 작성</label>
					</div>
					<!-- //비밀댓글 -->
					
					<input type="submit" class="btn btn-success" value="post reply" onclick="javascript:return comments_check(comments_form)">
				    </li>
				</ul>
			</div>
			</div>
		</form>
		<!-- //댓글 입력창-->
		
	   	<!-- 댓글 목록 -->
		<div class="my-3 p-3 bg-body rounded shadow-sm" id="comments_area">
		
		</div>
	   	<!-- //댓글 목록 -->
	   	
    </div>
    <!-- Projects End -->
    
<%@ include file="../common/common_bottom.jsp" %>