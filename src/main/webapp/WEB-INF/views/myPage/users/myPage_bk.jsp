<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>마이페이지</title>
<!-- nav에서 마이페이지 클릭 -> 마이페이지 홈(myPage.jsp) -->
<%@ include file="../../common/common_top.jsp"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.js"></script>
<script type="text/javascript">
	
	//마이페이지 수정하기 클릭 시 비밀번호 확인
	function usersInfoUpdate(){
		alert("마이페이지 수정하기 클릭함");
		//location.href = "usersInfoUpdate.us";
	}
	
	//등급안내 클릭
	function userRole_info(){
		window.open('userRole_info.us','등급안내','width=550,height=500');       
	}
	
</script>
<%
	String[] genderArr = {"남자", "여자"};
%>
	<!-- myPage Start -->
    <div class="container-fluid py-5">
        <div class="container">
            <div class="text-center mx-auto wow fadeInUp" data-wow-delay="0.1s" style="max-width: 500px;">
                <h1 class="display-5 mb-5">마이페이지</h1> 	
            </div>
            <div class="row justify-content-center">
                <div class="col-lg-9 mx-auto">
                    <div class="bg-light rounded p-4 p-sm-5 wow fadeInUp" data-wow-delay="0.1s">
                        <div class="row g-3 mx-auto">
                        
                        	<!-- 이미지 -->
                        	<div class="col-9">
	                        	<div class="col-4" style="float: left;">
	                        	 	<c:if test="${usersBean.image eq null || usersBean.image == null}">
	                                	<img width="100" height="100" src ="<%=request.getContextPath()%>/resources/images/users/user_basic_box.png"><br>
	                                </c:if>
	                                <c:if test="${! usersBean.image eq null || usersBean.image != null}">
	                                	<img alt="${usersBean.image}" src="${usersBean.image}">
	                                </c:if>
                                </div> 
                            </div>	
                            <!-- //이미지 -->
                            
                            <!-- 아이디 -->
							<div class="col-9">
                                <div class="form-floating">
                                    <input type="text" class="form-control border-0" id="userId" name="userId" value="${usersBean.userId}">
                                    <label for="name">아이디</label>
                                </div>
                            </div>
                            <!-- //아이디 -->
                            
                             <!-- 비밀번호 -->
							<div class="col-9">
                                <div class="form-floating">
                                    <input type="password" class="form-control border-0" id="password" name="password" value="${usersBean.password}">
                                    <label for="password">비밀번호</label>
                                </div>
                            </div>
                            <!-- //비밀번호 -->
                            
                            <!-- 이름 -->
							<div class="col-9">
                                <div class="form-floating">
                                    <input type="text" class="form-control border-0" id="name" name="name" value="${usersBean.name}">
                                    <label for="name">이름</label>
                                </div>
                            </div>
                            <!-- //이름 -->
                            
                            <!-- 등급 -->
                            <div class="col-12" >
								<div class="col-9" style="float: left"> 
									<div class="form-floating">
									    <input type="text" class="form-control border-0" id="userRole" name="userRole"
									     value=
									    	<c:if test="${usersBean.userRole == 'r01'}">
												"일반회원"
											</c:if>
											<c:if test="${usersBean.userRole == 'r02'}">
												"우수회원"
											</c:if>
										>
								       <label for="userRole">등급</label>
								   </div>
								</div>
								<div style="float: left; display:inline-block; margin-left:10px;" >
									<button target="_blank" class="btn btn-primary btn" onclick ="userRole_info();">
										등급 안내
									</button>
								</div>
                            </div>
                            <!-- //등급 -->
                            
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
							</div>
                            <!-- //성별 -->
                            
                            <!-- 이메일 -->
                            <div class="col-9">
                                <div class="form-floating">
                                    <input type="text" class="form-control border-0" id="email" name="email" value="${usersBean.email}">
                                    <label for="email">이메일</label>
                                </div>
                            </div>
                            <!-- //이메일 -->
                             
                            <!-- 연락처 -->
                            <div class="col-9">
                                <div class="form-floating">
                                    <input type="text" class="form-control border-0" id="phone" name="phone" value="${usersBean.phone}">
                                    <label for="phone">연락처</label>
                                </div>
                            </div>
                            <!-- //연락처 -->
                            
                            <!-- 주소 -->
							<div class="col-12">
								<div class="form-floating">
									<input type="text" class="form-control border-0" name="addressAll" id="addressAll" value="${usersBean.address}, ${usersBean.addressSub}"><br>
									<label for="addressAll">주소</label>
								</div>
                            </div>
                            <!-- //주소 -->
                            
                            <!-- 마이페이지 수정 링크 -->
                            <div style="float: left; display:inline-block;" >
                            	<input type="button" class="btn btn-primary py-3 px-4" value="마이페이지 수정하기" onclick="usersInfoUpdate()">
                            </div>
                            <!-- //마이페이지 수정 링크 -->
                         </div><!--//row g-3  -->
                    	</div><!-- //bg-light -->
                    </div><!-- //col-lg-9  -->
                </div><!-- //row justify-content-center -->
            </div><!-- //container -->
        </div><!-- //container-fluid -->
    <!-- //myPage End -->
    

<%@ include file="../../common/common_bottom.jsp"%>
</html>