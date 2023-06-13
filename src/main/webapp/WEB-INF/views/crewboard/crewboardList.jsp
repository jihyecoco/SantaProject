<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file ="../common/common_top.jsp"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.js"></script>
<script type="text/javascript">
	/* 신청하기 버튼 클릭 */
	function signUp(crewname, state){
		if(state == '1' ){//모집완료 일때
			alert('이미 모집완료된 크루입니다');
		}else{ // 모집중 일때
			var choose = confirm(crewname+"에 가입하시겠습니까?");
			if(choose == true){ // 확인 눌렀을때
				location.href = "/crew/user/update.cr?crewname="+crewname;
			}
		}
	}
</script>
<!-- Page Header Start -->
    <div class="container-fluid page-header py-5 mb-5 wow fadeIn" data-wow-delay="0.1s">
        <div class="container text-center py-5">
            <h1 class="display-3 text-white mb-4 animated slideInDown">크루 모집 게시판</h1>
            <nav aria-label="breadcrumb animated slideInDown">
                <ol class="breadcrumb justify-content-center mb-0">
                    <li class="breadcrumb-item"><a href="#">Home</a></li>
                    <li class="breadcrumb-item"><a href="#">Pages</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Features</li>
                </ol>
            </nav>
        </div>
    </div>
    <!-- Page Header End -->

 	<!-- Facts Start -->
    <div class="container-fluid facts my-5 py-5" data-parallax="scroll" data-image-src="<%=request.getContextPath()%>/resources/bootstrap/user/img/carousel-1.jpg">
        <div class="container py-5">
            <div class="row g-5">
                <div class="col-sm-6 col-lg-3 text-center wow fadeIn" data-wow-delay="0.1s">
                    <h1 class="display-4 text-white" data-toggle="counter-up">1234</h1>
                    <span class="fs-5 fw-semi-bold text-light">총 산타 크루</span>
                </div>
                <div class="col-sm-6 col-lg-3 text-center wow fadeIn" data-wow-delay="0.3s">
                    <h1 class="display-4 text-white" data-toggle="counter-up">1234</h1>
                    <span class="fs-5 fw-semi-bold text-light">모집중인 등산크루</span>
                </div>
                <div class="col-sm-6 col-lg-3 text-center wow fadeIn" data-wow-delay="0.5s">
                    <h1 class="display-4 text-white" data-toggle="counter-up">1234</h1>
                    <span class="fs-5 fw-semi-bold text-light">모집중인 플로깅크루</span>
                </div>
                <div class="col-sm-6 col-lg-3 text-center wow fadeIn" data-wow-delay="0.7s">
                    <h1 class="display-4 text-white" data-toggle="counter-up">1234</h1>
                    <span class="fs-5 fw-semi-bold text-light">모집완료 크루</span>
                </div>
            </div>
        </div>
    </div>
    <!-- Facts End -->

    <!-- Feature Start -->
    
    <!-- 검색창 -->
    <div class="container-fluid py-5">
        <div class="container" style="display:table">
        	<div align="right">
		    	<input type="button" class="btn btn-success" value="글쓰기" onclick="location.href='/crewboard/user/insert.bdcr'">
        	</div>
        	<br>
            <nav class="navbar navbar-light bg-light">
  				<div class="container" style="display:table-cell; vertical-align:middle;">
   				 	<form class="d-flex" action="list.bdcr" method="post">
   				 		<div class="col-sm-2">
	   				 		<select name="whatColumn" class="form-select">
	   				 			<option value="all">전체</option>
	   				 			<option value="crewname">크루명</option>
	   				 			<option value="M">등산크루</option>
	   				 			<option value="P">플로깅크루</option>
	   				 		</select>
   				 		</div>
   				 		<div class="col-sm-8">
     						<input class="form-control me-2" type="text" name="keyword">
      					</div>
      					<div class="col-sm-2" align="center">
      						<button class="btn btn-outline-success" type="submit">Search</button>
      					</div>
    				</form>
 			 	</div>
			</nav>
        </div>
    </div>
    <!-- //검색창 -->
    
    <!-- 크루 게시판 목록  -->
    <div class="container">
    	<div align="right">
    		<a href="">최신순</a> / <a href="">인기순</a>
    		<br>
    	</div>
	    <table border="1" class="table table-hover">
	    	<tr align="center">
	    		<th>모집상태</th>
	    		<th>구분1/구분2</th>
	    		<th>제목</th>
	    		<th>작성자</th>
	    		<th>크루명</th>
	    		<th>현재인원/전체인원</th>
	    		<th>신청하기</th>
			</tr>
	    	<c:if test="${crewboard_list.size() == 0 }">
	    		<tr>
	    			<td colspan="7" align="center">등록된 게시물이 없습니다.</td>
	    		</tr>
	    	</c:if>
	    	
	    	<c:if test="${crewboard_list.size() != 0 }">
	    		<c:forEach var="lists" items="${crewboard_list}">
	    			<tr align="center">
	    				<td>
	    					<c:if test="${lists.state == 0}"><font color="blue">[모집중]</font></c:if>
	    					<c:if test="${lists.state == 1}"><font color="red">[모집완료]</font></c:if>
	    				</td>
	    				<td>
	    					<c:if test="${lists.large == 1}">1일 /</c:if>
	    					<c:if test="${lists.large == 2}">정기 /</c:if>
	    					<c:if test="${lists.small == 'M'}">등산</c:if>
	    					<c:if test="${lists.small == 'P'}">플로깅</c:if>
	    				</td>
	    				<td width="50%">
	    					<a href="/crewboard/user/detail.bdcr?num=${lists.crewboardnum}">${lists.subject} (${lists.comments})</a>
	    				</td>
	    				<td>
	    					${lists.writer}
	    				</td>
	    				<td>
	    					${lists.crewname}
	    				</td>
	    				<td>
	    					${lists.crewnow}/${lists.crewlimit}
	    				</td>
	    				<td>
	    					<input type="button" value="신청하기" onclick="signUp('${lists.crewname}','${lists.state}')">
	    				</td>
	    			</tr>
	    		</c:forEach>
	    	</c:if>
	    </table>
	    <!-- 페이지 표시 -->
	    <div align="center">
	    	${pageInfo.pagingHtml}
	    </div>
	    <!-- //페이지 표시 -->
    </div>
    <!-- //크루 게시판 목록  -->
    
    <!-- 내 크루 보기, 크루 만들기 -->
    <div class="container">
    	<div align="right">
    		<input type="button" value="내 크루 보기" class="btn btn-success" onclick="">
    		<input type="button" value="크루 만들기" class="btn btn-success" onclick="location.href='/crew/user/insert.cr'">
    	</div>
    </div>
    <!-- //내 크루 보기, 크루 만들기 -->
    
    
    <div class="container-fluid py-5">
        <div class="container">
            <div class="row gx-0">
                <div class="col-lg-4 wow fadeIn" data-wow-delay="0.1s">
                    <div class="bg-white shadow d-flex align-items-center h-100 px-5" style="min-height: 160px;">
                        <div class="d-flex">
                            <div class="flex-shrink-0 btn-lg-square rounded-circle bg-light">
                                <i class="fa fa-times text-primary"></i>
                            </div>
                            <div class="ps-3">
                                <h4>No Hidden Cost</h4>
                                <span>Clita erat ipsum lorem sit sed stet duo justo</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 wow fadeIn" data-wow-delay="0.3s">
                    <div class="bg-white shadow d-flex align-items-center h-100 px-5" style="min-height: 160px;">
                        <div class="d-flex">
                            <div class="flex-shrink-0 btn-lg-square rounded-circle bg-light">
                                <i class="fa fa-users text-primary"></i>
                            </div>
                            <div class="ps-3">
                                <h4>Dedicated Team</h4>
                                <span>Clita erat ipsum lorem sit sed stet duo justo</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 wow fadeIn" data-wow-delay="0.5s">
                    <div class="bg-white shadow d-flex align-items-center h-100 px-5" style="min-height: 160px;">
                        <div class="d-flex">
                            <div class="flex-shrink-0 btn-lg-square rounded-circle bg-light">
                                <i class="fa fa-phone text-primary"></i>
                            </div>
                            <div class="ps-3">
                                <h4>24/7 Available</h4>
                                <span>Clita erat ipsum lorem sit sed stet duo justo</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Feature End -->


    <!-- Features Start -->
    <div class="container-xxl py-5">
        <div class="container">
            <div class="row g-5 align-items-center">
                <div class="col-lg-6 wow fadeInUp" data-wow-delay="0.1s">
                    <p class="fs-5 fw-bold text-primary">Why Choosing Us!</p>
                    <h1 class="display-5 mb-4">Few Reasons Why People Choosing Us!</h1>
                    <p class="mb-4">Tempor erat elitr rebum at clita. Diam dolor diam ipsum sit. Aliqu diam amet diam et eos. Clita erat ipsum et lorem et sit, sed stet lorem sit clita duo justo magna dolore erat amet</p>
                    <a class="btn btn-primary py-3 px-4" href="">Explore More</a>
                </div>
                <div class="col-lg-6">
                    <div class="row g-4 align-items-center">
                        <div class="col-md-6">
                            <div class="row g-4">
                                <div class="col-12 wow fadeIn" data-wow-delay="0.3s">
                                    <div class="text-center rounded py-5 px-4" style="box-shadow: 0 0 45px rgba(0,0,0,.08);">
                                        <div class="btn-square bg-light rounded-circle mx-auto mb-4" style="width: 90px; height: 90px;">
                                            <i class="fa fa-check fa-3x text-primary"></i>
                                        </div>
                                        <h4 class="mb-0">100% Satisfaction</h4>
                                    </div>
                                </div>
                                <div class="col-12 wow fadeIn" data-wow-delay="0.5s">
                                    <div class="text-center rounded py-5 px-4" style="box-shadow: 0 0 45px rgba(0,0,0,.08);">
                                        <div class="btn-square bg-light rounded-circle mx-auto mb-4" style="width: 90px; height: 90px;">
                                            <i class="fa fa-users fa-3x text-primary"></i>
                                        </div>
                                        <h4 class="mb-0">Dedicated Team</h4>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 wow fadeIn" data-wow-delay="0.7s">
                            <div class="text-center rounded py-5 px-4" style="box-shadow: 0 0 45px rgba(0,0,0,.08);">
                                <div class="btn-square bg-light rounded-circle mx-auto mb-4" style="width: 90px; height: 90px;">
                                    <i class="fa fa-tools fa-3x text-primary"></i>
                                </div>
                                <h4 class="mb-0">Modern Equipment</h4>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Features End -->
<%@ include file ="../common/common_bottom.jsp"%>