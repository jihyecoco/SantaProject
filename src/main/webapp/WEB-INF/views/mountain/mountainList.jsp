<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- mountainList.jsp -->
<%@ include file="../common/common_top.jsp" %>
<style>
	th, td {
	  text-align: center;
	}
	#btn-insert {
		  margin-bottom: 10px;
		  background-color: #348e38;
		  border: none;
		  color: #fff;
		  cursor: pointer;
		  padding: 10px 25px;
		  float: right;
		}
		#btn-insert:hover {
		  background-color: yellow;
		  color: #000;
		  transition: all 0.35s;
		}
</style>
    <!-- Page Header Start -->
    <div class="container-fluid page-header py-5 mb-5 wow fadeIn" data-wow-delay="0.1s">
        <div class="container text-center py-5">
            <h1 class="display-3 text-white mb-4 animated slideInDown">산별정보</h1>
            <nav aria-label="breadcrumb animated slideInDown">
                <ol class="breadcrumb justify-content-center mb-0">
                    <li class="breadcrumb-item"><a href="/users/all/main.lg">Home</a></li>
                    <li class="breadcrumb-item active" aria-current="page">산별정보</li>
                </ol>
            </nav>
        </div>
    </div>
    <!-- Page Header End -->

    <!-- navbar -->
    <%@ include file="../common/common_nav_mountain.jsp" %>
    
    <!-- 산 목록 Start -->
    <div class="container-fluid py-5">
        <div class="container">
            <div class="text-center mx-auto wow fadeInUp" data-wow-delay="0.1s" style="max-width: 500px;">
                <p class="fs-5 fw-bold text-primary">산별정보</p>
                <h1 class="display-5 mb-5">산 목록</h1>
            </div>
            
            <div class="row justify-content-center">
                <div class="col-lg-10">
                
                <!-- mountain 검색 Start -->
			    <div class="container wow fadeInUp">
			    	<form action="list.mnt" method="get">
			    		<!-- 검색할 카테고리 -->
			    		<select name="whatColumn" class="form-select btn-primary py-2 position-relative top-0 start-0 mt-2 me-2 mb-3" style="width:8%;margin-left:-20px;display:inline-block;">
				    		<option value="">전체</option>
				    		<option value="이름">이름</option>
				    		<option value="내용">내용</option>
				    		<option value="지역">지역</option>
			    		</select>
			    		<!-- //검색할 카테고리 -->
			    		<!-- 검색할 키워드 -->
			    		<div class="position-relative w-25" style="display:inline-block;">
			                <input name="keyword" type="text" class="form-control bg-light border-light w-100 py-2 ps-4 pe-5">
			                <input value="검색" type="submit" class="btn btn-primary py-1 position-absolute top-0 end-0 mt-1 me-2">
			                <!-- <button type="button" class="btn btn-primary py-2 position-absolute top-0 end-0 mt-2 me-2">검색</button> -->
			            </div>
			    		<!-- //검색할 키워드 -->
			    	</form>
			    </div>
			    <!-- //mountain 검색 End -->
			    
                    <div class="bg-light rounded p-4 p-sm-5 wow fadeInUp" id="reloadpart" data-wow-delay="0.1s">
                        <div class="row g-3">
							
                            <!-- 산 목록 Start -->
							<table class="table table-hover table-borded align-middle">
							  <thead class="table-light">
							    <tr>
			                      <c:if test="${principal.getName() == 'admin'}">
			                      <th><input type="checkbox" class="form-check-input" id="success-outlined" name="selected_all"></th>
			                      </c:if>
							      <th scope="col">번호</th>
							      <th scope="col" class="w-25">이름</th>
							      <th scope="col" class="w-25">지역</th>
							      <th scope="col">높이</th>
							      <th scope="col">난이도</th>
							      <th scope="col">국립공원</th>
							      <th scope="col">상세보기</th>
							    </tr>
							  </thead>
							  <tbody>
							  	<c:choose>
							  	<c:when test="${principal.getName() == 'admin' and mountainLists == null}">
							  		<td colspan="8">등록된 데이터가 없습니다.</td>
							  	</c:when>
							  	<c:when test="${mountainLists == null}">
							  		<td colspan="7">등록된 데이터가 없습니다.</td>
							  	</c:when>
							  	</c:choose>
							  	<c:forEach var="ml" items="${mountainLists}">
							    <tr>
							  	  <c:if test="${principal.getName() == 'admin'}">
			                      <td><input type="checkbox" class="form-check-input" name="selected_one" value="${ml.mountainnum}"></td>
			                      </c:if>
							      <th scope="row">${ml.mountainnum}</th>
							      <td><a href="<c:url value='/mountain/all/detail.mnt?mountainnum=${ml.mountainnum}'/>">${ml.mountainname}</a></td>
							      <td>${ml.mountainlocal}</td>
							      <td>${ml.mountainheight}</td>
							      <td>
							      <c:choose>
							      	<c:when test="${ml.mountainheight <= avg*1}">
							      		초급
							      	</c:when>
							      	<c:when test="${ml.mountainheight > avg*1 and ml.mountainheight <= avg*2}">
							      		중급
							      	</c:when>
							      	<c:when test="${ml.mountainheight < avg*2 and ml.mountainheight <= avg*3}">
							      		상급
							      	</c:when>
							      </c:choose>
							      </td>
							      <td>
								      <c:if test="${fn:contains(ml.mountaincontent, '국립공원')}">
								      	O
								      </c:if>
								      <c:if test="${not fn:contains(ml.mountaincontent, '국립공원')}">
								      	X
								      </c:if>
							      </td>
							      <td>
							      <a href="<c:url value='/mountain/all/detail.mnt?mountainnum=${ml.mountainnum}'/>"><img alt="돋보기" src="<%=request.getContextPath()%>/resources/images/icon/detailview.png"></a>
							      </td>
							    </tr>
							  	</c:forEach>
							  </tbody>
							</table>
                            <!-- //산 목록 End -->
                            ${pageinfo.pageHtml}
                        </div>
                    <!-- 체크박스의 값을 넘기는 hidden input -->
                    <input type="hidden" name="hiddenValue" id="hiddenValue" value=""/>
                    
                    <!-- 정보 등록 버튼(관리자만 볼 수 있음) -->
                    <c:if test="${principal.getName() == 'admin'}">
                    	<button id="btn-insert" onClick="location.href='/mountain/admin/insert.mnt'" style="margin-right:-45px;margin-top:67px;">산 정보 등록</button>
                    	<button id="btn-insert" onclick="fnGetdata()" style="margin-right:15px;margin-top:67px;">선택 정보 삭제</button>
                    </c:if>
                    <!-- //정보 등록 버튼 end -->
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- //산 목록 End -->
<script src="../../../resources/js/jquery.js"></script>
<script  type="text/javascript">
	//전체 선택 및 해제
	$('input[name=selected_all]').change(function(){
		$('input[name=selected_one]').prop('checked', this.checked);
	});
	
	//선택된 값 넘기기
	function fnGetdata(){
        var obj = $("[name=selected_one]");
        var chkArray = new Array(); // 배열 선언
 
        $('input:checkbox[name=selected_one]:checked').each(function() { // 체크된 체크박스의 value 값을 가지고 온다.
            chkArray.push(this.value);
        });
        $('#hiddenValue').val(chkArray);
        
        alert($('#hiddenValue').val()); // 아래 체크박스가 모두 체크되어 있다면 1,2,3,4 가 출력 된다.
        
        //배열을 넘기는 ajax
        $.ajax({
        	  type : 'post',
        	  url : '/mountain/admin/delete.mnt',
        	  data : {chkArray : chkArray},
        	  dataType : 'json',
        	  traditional: true,
        	  error: function(xhr, status, error){
        		// 실패했을 때 처리
        	  },
        	  success : function(data){
        		// 성공했을 때 처리
        	  }
        	});
        window.location.replace("/mountain/all/list.mnt");
    }
</script>
<%@ include file="../common/common_bottom.jsp" %>