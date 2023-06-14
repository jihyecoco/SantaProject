<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file ="../common/common_top.jsp" %>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		//alert('1');
		getAllComments();
	})
	
	/* 댓글 목록 가져오기 */
	function getAllComments(){
		//alert('getAllComments');
		var loginId = $('input[name=writer]').val(); // 현재 로그인 아이디
		var pageNumber2 = $('input[name=pageNumber]').val(); // 현재 페이지
		
		$.ajax({
			url : '/productscomments/user/list.pcmt',
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
	               
	                if(value.deleteyn == 'Y'){
	                	result += "삭제된 댓글입니다";
	                	result += "</p>";
	               	}else{
	                	result += "<strong class='d-block text-gray-dark'>@"+value.writer;
	                	
	                	if(value.writer == loginId ){ // 댓글 작성자라면 수정, 삭제 보임
	                		result += "&nbsp; [<a href='javascript:updateComments("+value.num+","+pageNumber2+","+value.idx+")'>수정</a>/";
	                		result += "<a href='javascript:deleteComments("+value.num+","+pageNumber2+","+value.idx+")'>삭제</a>]";
	                	}
	                	result += "</strong>";
	                	
	                	result += "<span id='pcmt_update"+value.num+"'>"+value.content+"<br>";
	                	result += "<font color='gray' size='1px'>("+value.regdate+")</font><br>";
	                	result += "<input type='button' class='btn btn-light' value='답글' ";
	                	result += "onclick='replypcmt("+value.num+","+value.idx+","+value.ref+","+value.restep+","+value.relevel+","+value.pageNumber+")'>";
	                	result += "<span id='replypcmt_area"+value.num+"'></span>";
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
	
	/* 댓글 답글달기 버튼 클릭 */
	function replypcmt(num, idx, ref, re_step, re_level, pageNumber){
		//1. 댓글 입력창 보여지기
		var replypcmt_area = "<form class='form-control' action='/productscomments/user/reply.pcmt' method='post'>";
		replypcmt_area += "<input type='hidden' name='idx' value='"+idx+"'>";
		replypcmt_area += "<input type='hidden' name='ref' value='"+ref+"'>";
		replypcmt_area += "<input type='hidden' name='restep' value='"+re_step+"'>";
		replypcmt_area += "<input type='hidden' name='relevel' value='"+re_level+"'>";
		replypcmt_area += "<input type='hidden' name='pageNumber' value='"+pageNumber+"'>";
		replypcmt_area += "<input type='text' name='content'>";
		replypcmt_area += "<input type='submit' value='등록'>";
		
		$('#replypcmt_area'+num).html(replypcmt_area);
	}
	
	/* 판매완료 버튼 클릭 */
	function changeState(prd_num, pageNumber){
		//alert(prd_num);
		var result = confirm('판매 완료로 바꾸시겠습니까?');
		if(result == true){ // 판매완료된 상품
			location.href = '/products/user/update.prd?num='+prd_num+'&state=change&pageNumber='+pageNumber;
		}
	}
	
	/* 게시글 삭제 버튼 클릭 */
	function deleteProducts(prd_num, pageNumber){
		var result = confirm('정말 삭제하시겠습니까?');
		if(result == true){ // 삭제 요청
			location.href = '/products/user/delete.prd?num='+prd_num+'&pageNumber='+pageNumber;
		}
	}
	
	/* 댓글 삭제 버튼 클릭 */
	function deleteComments(pcmt_num, pageNumber, idx){
		//alert(ccmt_num);
		//alert(pageNumber);
		var pcmt_result = confirm('정말 삭제하시겠습니까?');
		if(pcmt_result == true){
			location.href = '/productscomments/user/delete.pcmt?num='+pcmt_num+'&pageNumber='+pageNumber+'&idx='+idx;
		}
	}
	
	/* 댓글 수정 버튼 클릭 */
	function updateComments(pcmt_num, pageNumber, idx){
		alert(pcmt_num);
		var pcmt_updateform = "<form class='form-control' action='/productscomments/user/update.pcmt' method='post'>";
		pcmt_updateform += "<input type='text' name='content'>";
		pcmt_updateform += "<input type='hidden' name='num' value='"+pcmt_num+"'>";
		pcmt_updateform += "<input type='hidden' name='idx' value='"+idx+"'>";
		pcmt_updateform += "<input type='hidden' name='pageNumber' value='"+pageNumber+"'>";
		pcmt_updateform += "<input type='submit' value='확인'>";
		pcmt_updateform += "<input type='reset' value='취소' onclick='javascript:getAllComments()'>";
		pcmt_updateform += "</form>";
		
		$('#pcmt_update'+pcmt_num).html(pcmt_updateform);
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
                <p class="fs-5 fw-bold text-primary">상품 상세보기</p>
                <h3 class="display-5 mb-5">${pb.name}</h3>
            </div>
            
           	<!-- 거래 게시글 상세보기 -->
           	<table class="table">
           		<tr align="right">
           			<td colspan="4">
           				<!-- 해당 글 작성자만 보이게 설정 -->
           				<c:if test="${pb.seller == loginId}">
           					<c:if test="${pb.state == 0}"> <input type="button" value="판매완료" onclick="changeState(${pb.productsnum},${pageNumber})"> </c:if>
           					<input type="button" value="수정" onclick="location.href='/products/user/update.prd?num=${pb.productsnum}&pageNumber=${pageNumber}'">
           					<input type="button" value="삭제" onclick="deleteProducts(${pb.productsnum}, ${pageNumber})">
           				</c:if>
           				<!-- //해당 글 작성자만 보이게 설정 -->
           			</td>
           		</tr>
           		<tr align="center">
           			<th colspan="4">상품명</th>
           		</tr>
           		<tr align="center">
           			<td colspan="4">${pb.name}</td>
           		</tr>
           		<tr>
           			<td colspan="4" align="center">
           			<%-- <c:set var="thumbnail" value="${fn:split(plist.image, ',')}"/> --%>
           			<c:forEach var="prd_img" items="${fn:split(pb.image, ',')}">
           				<img src ="<%=request.getContextPath()%>/resources/images/products/${prd_img}"><br>
           			</c:forEach> 
           			</td>
           		</tr>
           		<tr align="right">
           			<td colspan="3">
           				판매자 : ${pb.seller}<br>
           				작성일 : ${pb.inputdate}
           			</td>
           			<td>
           				조회수 : ${pb.readcount}
           			</td>
           		</tr>
           		<tr>
           			<th>가격</th>
           			<td>${pb.price}</td>
           			<th></th>
           			<td></td>
           		</tr>
           		<tr align="center">
           			<th colspan="4">글 내용</th>
           		</tr>
           		<tr>
           			<td colspan="4" align="center" height="200">
           				${pb.info}
           			</td>
           		</tr>
           		<tr>
           			<td colspan="4" align="right">
           				<input type="button" value="구매하기">
           				<input type="button" value="목록보기" onclick="location.href='/products/all/list.prd?pageNumber=${pageNumber}'">
           			</td>
           		</tr>
           	</table>	
           	<!-- //게시글 상세보기 -->
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
	    <form action="/productscomments/user/insert.pcmt" method="post">
	    	<input type="hidden" name="idx" value="${pb.productsnum}"> <!-- 원글 번호 -->
		    <input type="hidden" name="writer" value="${loginId}"> <!-- 작성자 아이디 -->
		    <input type="hidden" name="pageNumber" value="${pageNumber}"> <!-- 페이지 -->
		    
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
		<div class="my-3 p-3 bg-body rounded shadow-sm" id="comments_area">
			
		</div>
	   	<!-- //댓글 목록 -->
	   	
    </div>
    <!-- Projects End -->

<%@ include file ="../common/common_bottom.jsp" %>