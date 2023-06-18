<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common_top.jsp" %>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	/* 카카오페이 구매하기 버튼 클릭 */
	$('#kakao_apibtn').click(function(){
		$.ajax({
			url : '/pay/user/kakaopay.pay',
			data : ({
				num : $('input[name=idx]').val()
			}),
			dataType : 'json' ,
			success : function(data){
				//alert(data.tid);
				var url = data.next_redirect_pc_url;
				window.open(url);
									
			},
			error : function(error){
				alert(error);
			}
		}); //ajax
	});//click
	
	/* 신용카드 구매하기 버튼 클릭 */
	$('#credit_apibtn').click(function(){
		$.ajax({
			url : '/pay/user/credit.pay',
			data : ({
				num : $('input[name=idx]').val()
			}),
			dataType : 'json' ,
			success : function(data){
				//alert(data.tid);
				var url = data.next_redirect_pc_url;
				window.open(url);
									
			},
			error : function(error){
				alert(error);
			}
		}); //ajax
	});//click
	
});//ready

</script>

<input type="button" id="kakao_apibtn" value="카카오페이">
<input type="button" id="credit_apibtn" value="신용카드">
<input type="text" value="1234" name="idx">

<%@ include file="../common/common_bottom.jsp" %>