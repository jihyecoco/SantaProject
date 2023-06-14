<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- mountainList.jsp -->
<%@ include file="../common/common_top.jsp" %>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>얻어온 Open API 정보</h3>

<p>${openInfo }</p>

<a href="/goods/goodsSearch"><button type="button">API화면</button></a>
</body>
</html>