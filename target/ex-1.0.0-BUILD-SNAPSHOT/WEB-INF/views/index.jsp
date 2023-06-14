<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>로그인</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="keywords">
<meta content="" name="description">


<%@ include file="common/common_top.jsp"%>
	
	<h1>HOME!</h1>
	<p> The time on the server is ${serverTime} </p>
	<h3>계정 ${userInfo.userId} / 이름 ${userInfo.name} / 권한 ${userInfo.userRole}  님 반값습니다.</h3>
	
	<form:form action="${pageContext.request.contextPath}/logout" method="POST"> 
		<input type="submit" value="로그아웃" /> 
	</form:form>



	<%@ include file="common/common_bottom.jsp"%>

</html>