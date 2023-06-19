<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
    
<nav class="navbar navbar-expand-lg navbar-light bg-light rounded">
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExample10" aria-controls="navbarsExample10" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse justify-content-md-center" id="navbarsExample10">
      <ul class="navbar-nav">
      	<!-- users -->
      	<li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="dropdown10" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">회원정보관리</a>
          <div class="dropdown-menu" aria-labelledby="dropdown10">
            <a class="dropdown-item" href="/users/user/usersInfoCheck.us">회원정보수정</a>
            <a class="dropdown-item" href="/users/user/usersPasswordUpdate.us">비밀번호변경</a>
            <a class="dropdown-item" href="/users/user/usersWithdrawalCheck.us">회원탈퇴</a>
          </div>
        </li>
        <!-- //users -->
        
        <!-- crew -->
      	<li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="dropdown10" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">크루</a>
          <div class="dropdown-menu" aria-labelledby="dropdown10">
            <a class="dropdown-item" href="/crew/user/myPage1.cr">일일크루</a>
            <a class="dropdown-item" href="/crew/user/myPage2.cr">정기크루</a>
          </div>
        </li>
        <!-- //crew -->
        
        <!-- stamp -->
      	<li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="dropdown10" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">완등 내역</a>
          <div class="dropdown-menu" aria-labelledby="dropdown10">
            <a class="dropdown-item" href="#">스탬프 신청</a>
            <a class="dropdown-item" href="#">완등 내역</a>
          </div>
        </li>
        <!-- //stamp -->
        
        <!-- 게시글 관련 -->
      	<li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="dropdown10" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">작성 게시글 목록</a>
          <div class="dropdown-menu" aria-labelledby="dropdown10">
            <a class="dropdown-item" href="#">작성한 게시글</a>
            <a class="dropdown-item" href="#">좋아요한 게시글</a>
            <a class="dropdown-item" href="#">저장(북마크)한 게시글</a>
          </div>
        </li>
        <!-- //게시글 관련 -->
        
         <!-- 게시글 관련 -->
      	<li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="dropdown10" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">거래 내역</a>
          <div class="dropdown-menu" aria-labelledby="dropdown10">
            <a class="dropdown-item" href="">거래내역</a>
          </div>
        </li>
        <!-- //게시글 관련 -->
        
        <!-- 서포터즈 -->
      	<li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="dropdown10" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">내 서포터즈</a>
          <div class="dropdown-menu" aria-labelledby="dropdown10">
            <a class="dropdown-item" href="#">전체</a>
            <a class="dropdown-item" href="#">활동중</a>
            <a class="dropdown-item" href="#">활동 종료</a>
          </div>
        </li>
        <!-- //서포터즈 -->
        
        
      </ul>
    </div>
  </nav>