<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>회원가입</title>
<!-- 로그인페이지(loginPage.jsp) -> 회원가입 클릭(signUp.jsp)  -->
<%@ include file="../../common/common_top.jsp"%>
<%@ include file="../../common/common_nav_admin.jsp"%>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.js"></script>
<script type="text/javascript">
	
	/* 아이디 중복체크 */
	$(document).ready(function(){
		//alert(123);
		var isCheck = false;
		var use = "";
		$('#userId_check').click(function(){ // 중복체크 버튼 눌렀을 때
			//alert(1);
			isCheck = true;
			$.ajax({
				url : '/login/all/userId_check.us', //users로 경로잡으면 권한이 없기때문에 접근할 수 X
				data : ({
					input_UserId : $('input[name=userId]').val()
				}),
				success : function(data){ //가능하면 yes 불가능하면 no
					if($('input[name=userId]').val()==""){
						$('#userId_check_result').html("<font color='red' size='2px' font-weight='bold'>아이디를 입력하세요.</font>");
						$('input[name=userId]').focus();
					}else if(data == 'NO'){
						$('#userId_check_result').html("<font color='red' size='2px' font-weight='bold'>이미 등록된 아이디입니다.</font>");
						$('#userId_check_result').show();
						use = "impossible";
					}else if(data == 'YES'){
						$('#userId_check_result').html("<font color='blue' size='2px' font-weight='bold'>사용가능한 아이디입니다.</font>");
						$('#userId_check_result').show();
						use = "possible";
					}
				}
			});//ajax
		});
		
		$('#userId').keydown(function(){
			$('#userId_check_result').css('display', 'none');
		});//keydown
		
		//회원가입(submit) 클릭 
		$('#submit').click(function(){
			if(!isCheck){
				alert('아이디 중복여부를 확인해주세요.');
				return false;
			}else if(use == 'impossible'){
				alert('사용중인 아이디입니다');
				$('input[name=userId]').select();
				return false;
			}else if($('input[name=userId]').val() == ""){
				alert('아이디를 입력하세요');
				return false;
			}else if( $('input[name=password]').val() !=  
					  $('input[name=passwordCheck]').val()){
				alert('비밀번호가 일치하지 않습니다');
				return false;
			}
		});//click
	})//ready
	/* 아이디 중복체크 */

	/* 카카오 주소 API */
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("address_extra").value = extraAddr;
                
                } else {
                    document.getElementById("address_extra").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("addressSub").focus();
            }
        }).open();
    }
	/* 카카오 주소 API */
</script>
<style>
	.err{
		font-size : 7px;
		color : red;
		font-weight : bold;
	}
</style>
<%
	String[] genderArr = {"남자", "여자"};
%>
    <!-- SignUp Start -->
    <form:form name="adminInsertForm" commandName="usersBean" action="/admin/admin/adminInsertForm.us" method="post">
    	
    <div class="container-fluid py-5">
        <div class="container">
            <div class="text-center mx-auto wow fadeInUp" data-wow-delay="0.1s" style="max-width: 500px;">
                <h1 class="display-5 mb-5">관리자 등록</h1>
            </div>
            <div class="row justify-content-center">
                <div class="col-lg-7">
                    <div class="bg-light rounded p-4 p-sm-5 wow fadeInUp" data-wow-delay="0.1s">
                        <div class="row g-3">
                        	<!-- hidden -->
                        	<input type="hidden" id="userRole" name="userRole" value="r99">
                        	<!-- //hidden -->
                        	<!-- 아이디 & 아이디 중복체크 -->
                        	<div class="col-12" >
	                        	<!-- 아이디 -->
	                            <div class="col-9" style="float: left; ">
	                                <div class="form-floating">
	                                    <input type="text" class="form-control border-0" id="userId" name="userId" value="${usersBean.userId}">
	                                    <label for="userId">아이디</label>
	                                </div>
	                                <form:errors cssClass="err" path="userId"/>
	                            </div>
	                            <!-- //아이디 -->
	                            
	                            <!-- 아이디 중복체크 -->
	                            <div style="float: left; margin-left:10px; display:inline-block;"  >
		                            <input type="button" class="btn btn-secondary btn-sm" value="중복체크" id="userId_check"><br>
	                            	
	                            </div>
	                            <div style="float: left; display:inline-block;"  >
	                           		<span id="userId_check_result" style="text-align: left;">
	                           	    	
	                                </span>
	                            </div>
	                            <!-- //아이디 중복체크 -->
                            </div>
                            <!-- 아이디 & 아이디 중복체크 -->
                            
                            <!-- 비밀번호 -->
                            <div class="col-9">
                                <div class="form-floating">
                                    <input type="password" class="form-control border-0" id="password" name="password" value="${usersBean.password}">
                                    <label for="password">비밀번호</label>
                                </div>
                                <form:errors cssClass="err" path="password"/>
                            </div>
                            <!-- //비밀번호 -->
                             
                             <!-- 비밀번호 확인 -->
                            <div class="col-9">
                                <div class="form-floating">
                                    <input type="password" class="form-control border-0" id="passwordCheck" name="passwordCheck">
                                    <label for="password">비밀번호 확인</label>
                                </div>
                            </div>
                             <!-- //비밀번호 확인-->
                            <!-- 이름 -->
                        	<div class="col-9">
                                <div class="form-floating">
                                    <input type="text" class="form-control border-0" id="name" name="name" value="${usersBean.name}">
                                    <label for="name">이름</label>
                                </div>
                                <form:errors cssClass="err" path="name"/>
                            </div>
                            <!-- //이름 -->
                            
                            <!-- 생년월일 -->
							<div class="col-9">
							 	<div class="form-floating">
									<input type="date" class="form-control border-0" id="birth" name="birth" value="${usersBean.birth}">
                                    <label for="birth">생년월일</label>
								 </div>
							    <form:errors cssClass="err" path="birth"/>
							</div>
                            <!-- //생년월일 -->
                            
                            
                            <!-- 성별 -->
							<div class="col-9">
							 	<div class="form-floating">
									<c:set var="gender" value="<%= genderArr %>"/>
									<c:forEach var="gender" items="${gender}">
											<input type="radio" class=" form-check-input border-0" name="gender" id="gender" value="${gender}"
											<c:if test="${usersBean.gender eq gender}">checked</c:if>
											>${gender} &nbsp;&nbsp;&nbsp;
									</c:forEach>
								  </div>
							    <form:errors cssClass="err" path="gender"/>
							</div>
                            <!-- //성별 -->
                            
                            <!-- 이메일 -->
                            <div class="col-9">
                                <div class="form-floating">
                                    <input type="text" class="form-control border-0" id="email" name="email" value="${usersBean.email}">
                                    <label for="email">이메일</label>
                                </div>
                                <form:errors cssClass="err" path="email"/>
                            </div>
                            <!-- //이메일 -->
                             
                            <!-- 연락처 -->
                            <div class="col-9">
                                <div class="form-floating">
                                    <input type="text" class="form-control border-0" id="phone" name="phone" value="${usersBean.phone}">
                                    <label for="phone">연락처</label>
                                </div>
                                <form:errors cssClass="err" path="phone"/>
                            </div>
                            <!-- //연락처 -->
                            
                            <!-- 주소 -->
                            <input type="hidden" class="form-control border-0" id="postcode" name="postcode" style="width: 50%" >
                           
							<div class="col-12" style="margin-bottom: 0;" >
								<div class="col-9" style="float: left;">
									<div class="form-floating" style="margin-bottom: 0;">
										<input type="text" class="form-control border-0" name="address" id="address" value="${usersBean.address}"><br>
										<label for="address">주소</label>
									</div>	
									
								</div>
								<div style="float: left; margin-left:10px; display:inline-block;" >
                                	<input type="button" class="btn btn-secondary btn-sm" onclick="execDaumPostcode()" value="주소 등록">
                            	</div>
                            	
                            </div>		
                            <div style="float: left; margin-top: -25px; margin-bottom: 10px;" >
                           		<form:errors cssClass="err" path="address"/>
                           	</div>
                            	
                            <div class="col-9" style="margin-top: 0" ><!-- style="line-height: 10px" -->	
									<div class="form-floating">
										<input type="text" class="form-control border-0" name="addressSub"  id="addressSub" value="${usersBean.addressSub}">
										<label for="addressSub">상세주소</label>
										<input type="hidden" class="form-control border-0" id="address_extra" placeholder="참고항목">
	                           		</div>
	                           		<form:errors cssClass="err" path="addressSub"/>
							</div>	
                            <!-- //주소 -->
                            
                            <!-- reset & submit -->
                            <div class="col-12 text-center">
                            	<input type="submit" id="submit" value="회원가입하기"  class="btn btn-success">
                                <input type="reset" value="다시작성"  class="btn btn-success">
                            </div>
                            <!-- //reset & submit -->
                        </div><!--//row  -->
                    </div><!-- //bg-light -->
                </div><!-- //col-lg-7 -->
            </div><!-- //row justify-content-center -->
        </div><!-- //container -->
    </div><!-- //container-fluid -->
    </form:form>
    <!-- SignUp End -->

<%@ include file="../../common/common_bottom.jsp"%>
</html>