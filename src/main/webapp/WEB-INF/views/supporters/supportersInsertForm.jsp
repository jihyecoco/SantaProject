<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common_top.jsp"%>
<style type="text/css">
	.err{
		color:red;
		font-weight: bold;
		font-size: 9px;
	}
</style>

<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	//alert(1);
	
	use = "";
	isCheck = false;
	
	//서포터즈명 중복체크
	$('#supo_check').click(function(){
		//alert('supo_check');
		
		isCheck = true;			
		$.ajax({
			url : "supporters/admin/supportersname_check.su",
			data : ({					
				input_name : $('input[name=supportersname]').val()
			}),
			success : function(data){
				//data 변수에 요청 응답의 결과(Yes 또는 No)가 들어온다.
				//alert('data: '+$.trim(data));
				
				if($('input[name=supportersname]').val() == ''){
					$('#supo_message').html("<font color=green>입력 누락되었습니다</font>");
					use = "missing";
					$('#supo_message').show();
				}
				else if(data == "YES"){
					$('#supo_message').html("<font color=blue>사용가능한 서포터즈명 입니다</font>");
					use = "possible";
					$('#supo_message').show();
				}
				else if(data == "NO"){
					$('#supo_message').html("<font color=red>이미 사용중인 서포터즈명 입니다</font>");
					use = "impossible";
					$('#supo_message').show();
				}					
			}//success		
		});//ajax	
	});//id_click		
	
	//가입하기 버튼을 누를때
	//1. 중복체크 버튼을 눌렀는지 확인
	//2. 입력 누락인지 확인
	//3. 이미 사용중인 아이디인지 확인
	$('#sub').click(function(){
		
		if(isCheck == false){ //!isCheck
			alert('중복체크를 먼저 하세요');
			return false;
		}			
		else if(use == "missing"){
			alert("서포터즈명을 입력하세요");
			$('input[name=supportersname]').focus();
			return false;
		}
		else if(use == "impossible"){
			alert('사용중인 서포터즈명 입니다');
			return false;
		}				
	});//sub_click	
	
	//키보드 눌리면(새로 입력되면)
	$('input[name=supportersname]').keydown(function(){
		
		//1.span 글자 지워지도록 2.use 초기화 3. 중복체크 초기화
		$('#supo_message').css('display','none');
		use = "";
		isCheck = false;
		
	});//keydown		
	
});//document

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
   

<!-- Quote Start -->
<form:form commandName="supporters" action="/supporters/admin/insert.su" method="post">
	<div class="container-fluid py-5">
		<div class="container">
			<div class="text-center mx-auto wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;">
				<p class="fs-5 fw-bold text-primary"></p>
				<h1 class="display-5 mb-5">서포터즈 게시글 작성</h1>
			</div>
			<div class="row justify-content-center">
				<div class="col-lg-9">
					<div class="bg-light rounded p-4 p-sm-5 wow fadeInUp" data-wow-delay="0.1s">
						<div class="row g-3">
							
							<input type="hidden" name="userid" id="userid" value="${userId}">
							<%-- <div class="col-12">                     		
                                <div class="form-floating">
                                	<h5>작성자</h5>
                                	${userId}
                                    <input type="hidden" class="form-control border-0" name="userid" id="userid" value="${userId}">
                                </div>
                            </div> --%>
							
							<div class="col-sm-6">
                        		<h5>서포터즈 명</h5>
                                <div class="form-floating">
                                    <input type="text" class="form-control border-0" name="supportersname" style="width:400px;" value="${supporters.supportersname}"> 
									<%-- <form:errors cssClass="err" path="supportersname" /> --%>
									<input type="button" class="btn btn-secondary btn-sm" value="중복체크" id="supo_check">
									<span id="supo_message">                           	     
	                                </span>
                                </div>
                            </div>                          
                            
                            <div class="col-12">
                        		<h5>모집 기한</h5>
                                <div class="form-floating">
                                    <input type="date" name="deadline" class="form-control border-0" size="20" value="${supporters.deadline}"> 
									<form:errors cssClass="err" path="deadline" />
                                </div>
                            </div>
                            
                            <div class="col-12">
                        		<h5>모집 대상</h5>
                                <div class="form-floating">
                                    <input type="radio" name="target" value="0" <c:if test="${supporters.target eq '0'}">checked</c:if>>전체 회원
									<input type="radio" name="target" value="1" <c:if test="${supporters.target eq '1'}">checked</c:if>>우수 회원
									<form:errors cssClass="err" path="target"/>	
                                </div>
                            </div>
                            
                            <div class="col-sm-6">
                        		<h5>모집 인원</h5>
                                <div class="form-floating">
                                    <input type="number" class="form-control border-0" name="limit" value="${supporters.limit}">
        							<form:errors cssClass="err" path="limit"/>	
                                </div>
                            </div>
                            
                            <div class="col-12">
                        		<h5>활동 시작일</h5>
                                <div class="form-floating">
                                    <input type="date" name="startdate" class="form-control border-0" size="20" value="${supporters.startdate}">
									<form:errors cssClass="err" path="startdate"/>
                                </div>
                            </div>
                            
                            <div class="col-12">
                        		<h5>활동 종료일</h5>
                                <div class="form-floating">
                                    <input type="date" name="enddate" class="form-control border-0" size="20" value="${supporters.enddate}">
									<form:errors cssClass="err" path="enddate"/>
                                </div>
                            </div>
							
							<div class="col-12">
                            	<h5>내용</h5>
                               	<div class="form-floating">
                                    <textarea name="content" class="form-control border-0" style="height:400px" placeholder="">${supporters.content}</textarea>		
									<form:errors cssClass="err" path="content"/>
                                </div>
                            </div>

                            <div class="col-12 text-center">                          	
                            	<input type="submit" value="등록하기" class="btn btn-success" id="sub">
                            	<input type="reset" value="다시작성" class="btn btn-success"> 
                            	<input type="button" value="목록" class="btn btn-success" onclick="location.href='/supporters/all/list.su'">
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