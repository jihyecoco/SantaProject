<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common_top.jsp"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.js"></script>
<script type="text/javascript">
	/* 구분선택시 가격창 비활성화 */
	function kind_change(f){
		var sel_ind = f.kind.selectedIndex;
		//alert(sel_ind);
		if(sel_ind == 0){
			$('#price').attr('placeholder','price')
		}else if(sel_ind == 1){ // 판매일때
			$('#price').removeAttr('readonly');
			$('#price').attr('value','');
			$('#price').attr('placeholder','price')
		}else if(sel_ind == 2){ // 나눔일때
			$('#price').attr('readonly','readonly');
			$('#price').attr('value', '0');
		}else if(sel_ind == 3){ // 교환일때
			$('#price').attr('readonly','readonly');
			$('#price').attr('value', '0');
		}
	}
	
	/* 파일 업로드 */
	function filechange() {
		/* 파일 업로드 개수제한 */
		var $fileUpload = $("input[type='file']");
		if (parseInt($fileUpload.get(0).files.length) > 4) {
			alert("이미지는 4개 이하만 올릴 수 있습니다");
			$("input[type='file']").val('');
		}
		
		/* 업로드한 이미지 미리보기*/
		var fileTag = document.querySelector('input[name=upload]');
		var divTag = document.querySelector('#img_preview');
		
		if(fileTag.files.length>0){ // 파일을 올렸을 때
			for(var i=0; i<fileTag.files.length; i++){
				var reader = new FileReader();
				reader.onload = function(data){
					//1. 이미지 태그 만들기
					var imgTag = document.createElement('img');
					
					//2. 이미지 태그에 속성 넣기
					imgTag.setAttribute('src', data.target.result);
					imgTag.setAttribute('width', '250');
					imgTag.setAttribute('height', '150');
					
					//3. 이미지 태그 div에 추가하기
					divTag.appendChild(imgTag);
				}
				reader.readAsDataURL(fileTag.files[i]);
			}//for
		}//if
		else{ //취소버튼을 눌렀을 때
			//div안에 내용 비우기
			divTag.innerHTML = "";
		}
	}
</script>
<style>
	.err{
		font-size : 3px;
		color: red;
		font-weight : bold;
	}
</style>

<!-- Page Header Start -->
    <div class="container-fluid page-header py-5 mb-5 wow fadeIn" data-wow-delay="0.1s">
        <div class="container text-center py-5">
            <h1 class="display-3 text-white mb-4 animated slideInDown">Contact Us</h1>
            <nav aria-label="breadcrumb animated slideInDown">
                <ol class="breadcrumb justify-content-center mb-0">
                    <li class="breadcrumb-item"><a href="#">Home</a></li>
                    <li class="breadcrumb-item"><a href="#">Pages</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Contact</li>
                </ol>
            </nav>
        </div>
    </div>
    <!-- Page Header End -->


    <!-- Contact Start -->
    <form:form name="prdform" commandName="pb" action="update.prd" method="post" enctype="multipart/form-data">
    	<input type="hidden" name="productsnum" value="${pb.productsnum}">
    	<input type="hidden" name="pageNumber" value="${pageNumber}">
	    <div class="container-xxl py-5">
	        <div class="container">
	            <div class="row g-5">
	                <div class="col-lg-6 wow fadeIn" data-wow-delay="0.1s">
	                    <p class="fs-5 fw-bold text-primary"></p>
	                    <h1 class="display-5 mb-5">거래 글 수정하기</h1>
	                    <p class="mb-4"></p>
	                        <div class="row g-3">
	                            <div class="col-md-6">
	                                구분 : 
	                                <form:errors cssClass="err" path="kind"/>
	                            </div>
	                            <div class="col-md-6">
	                                <select name="kind" id="kind" class="form-select" onchange="kind_change(prdform)">
	                                	<option value="">선택</option>
	                                	<option value="a" <c:if test="${pb.kind == 'a'}">selected</c:if>>판매</option>
	                                	<option value="b" <c:if test="${pb.kind == 'b'}">selected</c:if>>나눔</option>
	                                	<option value="c" <c:if test="${pb.kind == 'c'}">selected</c:if>>교환</option>
	                                </select>
	                            </div>
	                            <div class="col-md-6">
	                                상품명 : 
	                                <form:errors cssClass="err" path="name"/>
	                            </div>
	                            <div class="col-md-6">
	                                <input type="text" class="form-control" name="name" id="name" placeholder="name" value="${pb.name}">
	                            </div>
	                            <div class="col-md-6">
	                                가격 : 
	                                <form:errors cssClass="err" path="price"/>
	                            </div>
	                            <div class="col-md-6">
	                                <input type="text" class="form-control" name="price" id="price" placeholder="price" value="${pb.price}">
	                            </div>
	                            <div class="col-12">
	                                <div class="form-floating">
	                                    <textarea class="form-control" placeholder="Leave a message here" name="info" id="info" style="height: 150px">${pb.info}</textarea>
	                                    <label for="info">상품 설명</label>
	                                    <form:errors cssClass="err" path="info"/>
	                                </div>
	                            </div>
	                            <div class="col-12" align="right">
	                                <input type="button" class="btn btn-primary py-3 px-4" value="취소">
	                      			<button class="btn btn-primary py-3 px-4" id="sub" type="submit">등록</button>
	                            </div>
	                        </div>
	                </div>
	                <div class="col-lg-6 wow fadeIn" data-wow-delay="0.5s" style="min-height: 450px;">
	                    <div class="position-relative rounded overflow-hidden h-100">
	                    	<p class="fs-5 fw-bold text-primary">이미지 등록 : </p> 
	                    	<input type="file" multiple="multiple" name="upload" value="${pb.upload}" onchange="filechange()"><br>
	                    	<input type="hidden" name="upload2" value="${pb.image}"/> <!-- 기존 이미지 -->
	                    	<form:errors cssClass="err" path="image"/>
	                    	<div id="img_preview">
	                    	
	                    	</div>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
    </form:form>
    <!-- Contact End -->

<%@ include file="../common/common_bottom.jsp"%>