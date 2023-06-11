<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common_top.jsp" %>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		//alert('1');
		getAllComments();
	})
	
	function getAllComments(){
		//alert('getAllComments');
		$.ajax({
			url : '/crewcomments/user/list.ccmt',
			type : 'post',
			data : ({
				idx : $('input[name=idx]').val()
			}),
			success : function(data){
				//alert('성공');
				var result = "<table class='table table-hover'>";
				$.each(data,function(index, value) { // 값이 여러개 일 때는 반복문 사용
                	result += "<tr><td>";
                	if(value.relevel>0){
                		var wid = value.relevel*20;
                		result += "<img src='../../../resources/images/crewcomments/level.gif' width='"+wid+"' height='15'>";
                		result += "<img src='../../../resources/images/crewcomments/re.gif' width='20' height='15'>";
                	}
                	result += "작성자 : "+value.writer+"<br>";
                	result += value.content+" ";
                	result += "<input type='button' value='답글달기' ";
                	result += "onclick='replyccmt("+value.num+","+value.idx+","+value.ref+","+value.restep+","+value.relevel+")'><br>"+value.regdate+"<br>";
                	result += "<span id='replyccmt_area"+value.num+"'></span></td></tr>";
                })
                result += "</table>";
                $('#comments_area').html(result);
			},
			error : function(request, error) {
				alert("error");
				//error 발생이유
				alert("code : "+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		}); //ajax
	}
	
	/* 댓글 답글달기 버튼 클릭 */
	function replyccmt(num, idx, ref, re_step, re_level){
		//1. 댓글 입력창 보여지기
		var replyccmt_area = "<form action='/crewcomments/user/reply.ccmt' method='post'>";
		replyccmt_area += "<input type='hidden' name='idx' value='"+idx+"'>";
		replyccmt_area += "<input type='hidden' name='ref' value='"+ref+"'>";
		replyccmt_area += "<input type='hidden' name='restep' value='"+re_step+"'>";
		replyccmt_area += "<input type='hidden' name='relevel' value='"+re_level+"'>";
		replyccmt_area += "<input type='text' name='content'>";
		replyccmt_area += "<input type='submit' value='등록'>";
		
		$('#replyccmt_area'+num).html(replyccmt_area);
	}
	
	/* 신청하기 버튼 클릭 */
	function signUp(crewname, state){
		if(state == '1' ){//모집완료 일때
			alert('이미 모집완료된 크루입니다');
		}else{ // 모집중 일때
			var choose = confirm(crewname+"에 가입하시겠습니까?");
			if(choose == true){ // 확인 눌렀을때
				location.href = "/crew/user/update.cr?crewname="+crewname;
			}
		}
	}

</script>

<!-- Projects Start -->
    <div class="container-xxl py-5">
        <div class="container">
            <div class="text-center mx-auto wow fadeInUp" data-wow-delay="0.1s" style="max-width: 500px;">
                <p class="fs-5 fw-bold text-primary">글 상세보기</p>
                <h3 class="display-5 mb-5">${cbb.crewname}</h3>
            </div>
            
           	<!-- 게시글 상세보기 -->
           	<table class="table">
           		<tr align="right">
           			<td colspan="4">
           				<input type="button" value="목록보기" onclick="location.href='/crewboard/all/list.bdcr'">
           			</td>
           		</tr>
           		<tr align="center">
           			<th colspan="4">글 제목</th>
           		</tr>
           		<tr align="center">
           			<td colspan="4">${cbb.subject}</td>
           		</tr>
           		<tr align="right">
           			<td colspan="3">
           				작성자 : ${cbb.writer}<br>
           				작성일 : ${cbb.regdate}
           			</td>
           			<td>
           				조회수 : ${cbb.readcount}
           			</td>
           		</tr>
           		<tr>
           			<th>크루명</th>
           			<td>${cbb.crewname}</td>
           			<th>현재 가입인원/정원</th>
           			<td>${cbb.crewnow}/${cbb.crewlimit}</td>
           		</tr>
           		<tr align="center">
           			<th colspan="4">글 내용</th>
           		</tr>
           		<tr>
           			<td colspan="4" align="center" height="200">
           				${cbb.contents}
           			</td>
           		</tr>
           		<tr>
           			<td colspan="4" align="right">
           				<input type="button" value="신청하기" onclick="signUp('${cbb.crewname}','${cbb.state}')">
           			</td>
           		</tr>
           	</table>	
           	<!-- //게시글 상세보기 -->
        </div>
	   
	    <!-- 댓글 입력창 -->
	    <form action="/crewcomments/user/insert.ccmt" method="post">
	    	<input type="hidden" name="idx" value="${cbb.crewboardnum}"> <!-- 원글 번호 -->
		    <input type="hidden" name="writer" value="${loginId}"> <!-- 댓글 작성자 아이디 -->
		    
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
					<input type="submit" class="btn btn-dark mt-3" value="post reply">
				    </li>
				</ul>
			</div>
			</div>
		</form>
		<!-- //댓글 입력창-->
		
	   	<!-- 댓글 목록 -->
	   	<div class="container">
	   		<span id="comments_area">
	   		
	   		</span>
	   	</div>
	   	<!-- //댓글 목록 -->
	   	
    </div>
    <!-- Projects End -->
    
<%@ include file="../common/common_bottom.jsp" %>