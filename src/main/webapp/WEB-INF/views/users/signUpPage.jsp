<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common_top.jsp"%>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
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
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
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
    <form:form name="signUp" commandName="usersBean" action="/login/all/signUp.lg" method="post">
    	
    <div class="container-fluid py-5">
        <div class="container">
            <div class="text-center mx-auto wow fadeInUp" data-wow-delay="0.1s" style="max-width: 500px;">
                <h1 class="display-5 mb-5">회원가입</h1>
            </div>
            <div class="row justify-content-center">
                <div class="col-lg-7">
                    <div class="bg-light rounded p-4 p-sm-5 wow fadeInUp" data-wow-delay="0.1s">
                        <div class="row g-3">
                        	<!-- 아이디 -->
                            <div class="col-9" style="float: left; width: 60%;">
                                <div class="form-floating">
                                    <input type="text" class="form-control border-0" id="userId" name="userId" value="${usersBean.userId}">
                                    <label for="userId">아이디</label>
                                </div>
                                <form:errors cssClass="err" path="userId"/>
                            </div>
                            <!-- //아이디 -->
                            
                            <!-- 아이디 중복체크 -->
                            <div class="col-3" style="float: left; width: 20%; display:inline-block; background-color: red; text-align: center;"  >
	                            <input type="button" class="btn btn-secondary btn-sm" value="아이디 중복체크" id="userId_check">
                           		<span id="userId_check_result">
                           	     userId_check_result
                                </span>
                            	
                            </div>
                            <!-- //아이디 중복체크 -->
                           
                            <!-- 비밀번호 -->
                            <div class="col-9">
                                <div class="form-floating">
                                    <input type="password" class="form-control border-0" id="password" name="password" value="${usersBean.password}">
                                    <label for="password">비밀번호</label>
                                </div>
                                <form:errors cssClass="err" path="password"/>
                            </div>
                             <!-- //비밀번호 -->
                             
                            <!-- 이름 -->
                        	<div class="col-9">
                                <div class="form-floating">
                                    <input type="text" class="form-control border-0" id="name" name="name" value="${usersBean.name}">
                                    <label for="name">이름</label>
                                </div>
                                <form:errors cssClass="err" path="name"/>
                            </div>
                            <!-- //이름 -->
                            
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
                            <div class="col-12">
                            <input type="text" id="sample6_postcode" placeholder="우편번호"  >
							<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
							<input type="text" name="address" id="sample6_address" placeholder="주소" value="${usersBean.address}"><br>
							<input type="text" name="addressSub"  id="sample6_detailAddress" placeholder="상세주소" value="${usersBean.addressSub}">
							<input type="text" id="sample6_extraAddress" placeholder="참고항목">
                           		<!-- <div class="col-9" style="float: left; width: 60%; display:inline-block; background-color: blue; text-align: center;"  >
		                            <input type="text" class="form-control border-0"  id="sample6_postcode" placeholder="우편번호">
									<input type="button" class="btn btn-secondary btn-sm" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
								</div>	
								<div class="form-floating">
									<input type="text" class="form-control border-0"  id="sample6_address" >
									<label for="address">주소</label>
								</div>	
								<div class="form-floating">	
									<input type="text" class="form-control border-0"  id="sample6_detailAddress" >
									<label for="addressSub">상세주소</label>
									<input type="text" class="form-control border-0"  id="sample6_extraAddress" placeholder="참고항목"> 
								</div>
							 </div> -->
							 <!-- //주소 -->
                            </div><!--//row g-3  -->
                            <!-- reset & submit -->
                            <div class="col-12 text-center">
                                <input type="reset" value="취소" class="btn btn-primary py-3 px-4">
                                <input type="submit" name="submit" value="등록" class="btn btn-primary py-3 px-4">
                            </div>
                            <!-- //reset & submit -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </form:form>
    <!-- SignUp End -->

<%@ include file="../common/common_bottom.jsp"%>