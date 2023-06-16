<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- mountainUpdateForm.jsp -->
<%@ include file="../common/common_top.jsp" %>
<style type="text/css">
	.err {
		font-weight: bold;
		color: red;
	}
</style>
    <!-- Page Header Start -->
    <div class="container-fluid page-header py-5 mb-5 wow fadeIn" data-wow-delay="0.1s">
        <div class="container text-center py-5">
            <h1 class="display-3 text-white mb-4 animated slideInDown">산 정보 수정</h1>
            <nav aria-label="breadcrumb animated slideInDown">
                <ol class="breadcrumb justify-content-center mb-0">
                    <li class="breadcrumb-item"><a href="/users/all/main.lg">Home</a></li>
                    <li class="breadcrumb-item"><a href="/mountain/all/list.mnt">산 상세 정보</a></li>
                    <li class="breadcrumb-item" aria-current="page">산 정보 수정</li>
                </ol>
            </nav>
        </div>
    </div>
    <!-- Page Header End -->


    <!-- mountain Insert Form Start -->
    <div class="container-fluid py-5">
        <div class="container">
        	<!-- 타이틀 -->
            <div class="text-center mx-auto wow fadeInUp" data-wow-delay="0.1s" style="max-width: 500px;">
                <p class="fs-5 fw-bold text-primary">산 상세 정보</p>
                <h1 class="display-5 mb-5">산 정보 수정</h1>
            </div>
            <!-- //타이틀 -->
            
            <!-- 폼 -->
            <form:form commandName="mountainBean" action="/mountain/admin/update.mnt" method="post" enctype="multipart/form-data">
            <div class="row justify-content-center">
                <div class="col-lg-7">
                    <div class="bg-light rounded p-4 p-sm-5 wow fadeInUp" data-wow-delay="0.1s">
                        <div class="row g-3" style="margin-bottom:-10px;">
                        	<!-- hidden으로 num 넘겨주기 -->
                            <input type="hidden" value="${mountainBean.mountainnum}" class="form-control border-0" name="mountainnum"><br>
                        	<!-- 제목 입력 -->
                            <div class="col-sm-9" style="margin-bottom:-10px;">
                                <div class="mb-2 mx-1"><b>*산 이름 : </b></div>
                                    <input type="text" value="${mountainBean.mountainname}" class="form-control border-0" name="mountainname"><br>
                            </div>
                        	<span class="col-12" style="margin-top:-3px;margin-bottom:-3px;"><form:errors cssClass="err" path="mountainname"/></span>
                        	<!-- //제목 입력 -->
                        	
                            <!-- 사진 첨부 -->
                            <div class="mb-1">
                                <div class="mb-2 mx-1"><b>참고 사진 : </b></div>
  								<input class="form-control" type="file" name="upload">
							</div>
                            <!-- //사진 첨부 -->
                            
                            <!-- 높이 입력 -->
                            <div class="col-sm-5" style="margin-bottom:-10px;">
                                <div class="mb-2 mx-1"><b>산 높이 : </b></div>
                                    <input type="text" value="${mountainBean.mountainheight}" class="form-control border-0" name="mountainheight"><br>
                            </div>
                            
                        	<span class="col-12" style="margin-top:-3px;margin-bottom:-3px;"><form:errors cssClass="err" path="mountainheight"/></span>
                        	<!-- //높이 입력 -->

                            <!-- 지역 입력 -->
                            <div class="col-12" style="margin-bottom:-10px;">
                                <div class="mb-2 mx-1"><b>*산 지역 : </b></div>
                                    <input type="text" value="${mountainBean.mountainlocal}" class="form-control border-0" name="mountainlocal"><br>
                            </div>
                            
                        	<span class="col-12" style="margin-top:-3px;margin-bottom:-3px;"><form:errors cssClass="err" path="mountainlocal"/></span>
                        	<!-- //지역 입력 -->
                        	
                        	<!-- 상세 정보 입력 -->
                            <div class="col-12">
                            	<div class="mb-2 mx-1"><b>*상세 정보 : </b></div>
                            	<textarea name="mountaincontent" class="form-control border-0" placeholder="산 상세 정보" id="message" style="height: 200px">${mountainBean.mountaincontent}</textarea>
                            </div>
                        	
                            <span class="col-12"><form:errors cssClass="err" path="mountaincontent"/></span>
                        	<!-- //상세 정보 입력 -->

                        	<!-- 100대 명산 입력 -->
                            <div class="col-12">
                            	<div class="mb-2 mx-1"><b>특이사항 : </b></div>
                            	
                            	<div class="form-check form-check-inline mb-3">
								  <input name="mountaincheck" value="0" class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault1" <c:if test="${mountainBean.mountaingreat == null}">checked</c:if>>
								  <label class="form-check-label" for="flexRadioDefault1">
								    없음
								  </label>
								</div>
								<div class="form-check form-check-inline">
								  <input name="mountaincheck" value="1" class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault2" <c:if test="${mountainBean.mountaingreat != null}">checked</c:if>>
								  <label class="form-check-label" for="flexRadioDefault2">
								    100대 명산
								  </label>
								</div>
								<textarea name="mountaingreat" id="mountaingreat" class="form-control border-0" placeholder="100대 명산 선정 이유를 입력해주세요." style="height: 100px" disabled>${mountainBean.mountaingreat}</textarea>
                            	<span id="mountaingreatdanger" style="font-size:10px; color: gray;">※선정 이유를 입력해주셔야 100대명산으로 등록됩니다.</span>
                            </div>
                        	<!-- //100대 명산 입력 -->
                            
                            <!-- 수정하기 버튼 -->
                            <div class="col-12 text-center">
                                <button class="btn btn-primary py-2 px-4" type="submit">수정하기</button>
                            </div>
                            <!-- //수정하기 버튼 -->
                        </div>
                    </div>
                </div>
            </div>
            </form:form>
            <!-- //폼 end -->
        </div>
    </div>
    <!-- mountain Insert Form End -->
<script src="../../../resources/js/jquery.js"></script>
<script>
	$('input[name="mountaincheck"]').change(function(){
	    var value = $(this).val();
	    var checked = $(this).prop('checked');
	    if(value=='1'){
	            document.getElementById('mountaingreat').disabled=false;
	            document.getElementById('mountaingreatdanger').disabled=false;
	    }else{
	            document.getElementById('mountaingreat').disabled=true;
	            document.getElementById('mountaingreatdanger').disabled=true;
	    }
       	document.getElementById('mountaingreat').value='';
	});
</script>
<%@ include file="../common/common_bottom.jsp" %>