<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- stampCertInsertForm.jsp -->
<%@ include file="../common/common_top.jsp" %>
<style type="text/css">
	.err {
		font-weight: bold;
		color: red;
		font-size:7px;
	}
</style>
    <!-- Page Header Start -->
    <div class="container-fluid page-header py-5 mb-5 wow fadeIn" data-wow-delay="0.1s">
        <div class="container text-center py-5">
            <h1 class="display-3 text-white mb-4 animated slideInDown">스탬프 신청</h1>
        </div>
    </div>
    <!-- Page Header End -->


    <!-- stampCert Insert Form Start -->
    <div class="container-fluid py-5">
        <div class="container">
        	<!-- 타이틀 -->
            <div class="text-center mx-auto">
                <h1 class="display-5 mb-5">스탬프 신청</h1>
            </div>
            <!-- //타이틀 -->
            
            <!-- 폼 -->
            <form:form commandName="stampBean" action="/stamp/user/insert.stp" method="post" enctype="multipart/form-data">
            <div class="row justify-content-center">
                <div class="col-lg-7">
                    <div class="bg-light rounded p-4 p-sm-5">
                        <div class="row g-3" style="margin-bottom:-10px;">
                        	
                        	<!-- 제목 입력 -->
                            <div class="col-6" style="float: left; ">
	                                <div class="form-floating">
	                                    <input type="text" class="form-control border-0" id="mountainname" name="mountainname" value="${mountainname}">
	                                    <label for="mountainname">*산 이름</label>
	                                </div>
	                                <form:errors cssClass="err" path="mountainname"/>
	                        </div>
	                        <!-- //제목 입력 -->
                        	
                            <!-- 사진 첨부 -->
                            <div class="mb-1">
                                <div class="mb-2 mx-1"><b>*완등 사진 : </b></div>
  								<input class="form-control" type="file" name="upload">
							</div>
							<form:errors cssClass="err" path="stampimage"/>
                            <!-- //사진 첨부 -->
                            
                            <!-- 등록하기 버튼 -->
                            <div class="col-12 text-center">
                                <button class="btn btn-success" type="submit">등록하기</button>
                                <button class="btn btn-success" type="reset">다시작성</button>
                                <button class="btn btn-success" onClick="location.href='/stamp/user/list.stp'">목록</button>
                            </div>
                            <!-- //등록하기 버튼 -->
                        </div>
                    </div>
                </div>
            </div>
            </form:form>
            <!-- //폼 end -->
        </div>
    </div>
    <!-- stampCert Insert Form End -->
<%@ include file="../common/common_bottom.jsp" %>