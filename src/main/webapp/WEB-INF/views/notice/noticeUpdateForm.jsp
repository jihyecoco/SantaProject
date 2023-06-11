<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common_top.jsp" %> 
<style type="text/css">
	.err{
		color:red;
		font-weight: bold;
		font-size: 9px;
	}
</style>

   <!--  noticeUpdateForm.jsp<br> -->
    

<center>
<h3>공지사항 수정하기</h3>
<form:form commandName="notice" action="/notice/admin/update.no" method="post">
	<input type="hidden" name="num" value="${notice.num }">
	<input type="hidden" name="pageNumber" value="${pageNumber }">
<table border="1">
	<tr>
		<td>이름</td>
		<td>
			<%-- ${notice.user_id} --%>
			<input type="text" name="userid" size="60" value="${notice.userid}">
			<form:errors cssClass="err" path="userid"/>
		</td>
	</tr>
	<tr>
		<td>제목</td>
		<td>
			<input type="text" name="subject" size="70" value="${notice.subject}">
			<form:errors cssClass="err" path="subject"/>
		</td>
	</tr>
	<tr>
		<td>내용</td>
		<td>
			<textarea name="content" rows="20" cols="70">${notice.content}</textarea>		
			<form:errors cssClass="err" path="content"/>
		</td>	
	</tr>
	<tr height="30">
		<td colspan="2" align="center">
			<input type="submit" value="수정하기">
			<input type="reset" value="다시작성">
			<input type="button" value="목록" onclick="location.href='list.no?pageNumber=${pageNumber}'">
		</td>
	</tr>
</table>
</form:form>        
</center>   

<%@ include file="../common/common_bottom.jsp"%>