package com.spring.ex.users.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("UsersDao")
public class UsersDao {
	
private static final Logger logger = LoggerFactory.getLogger(UsersDao.class);
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	//getInfo : 로그인한 사용자의 정보가져오기
	public UsersBean getInfo(String userId) {
		UsersBean loginInfo = new UsersBean();
		loginInfo.setUserId(userId);
		loginInfo = sqlSessionTemplate.selectOne("login.getInfo", loginInfo);
		return loginInfo;
		
	}//getInfo

	//signUp : 회원가입
	public int signUp(UsersBean usersBean) {
		int cnt = -1;
		cnt = sqlSessionTemplate.insert("users.signUp", usersBean);
		return cnt;
		
	}//signUp
	
	//UserIdCheck : 회원가입페이지에서 아이디중복여부 체크
	public int userIdCheck(String input_UserId) {
		int cnt = -1;
		cnt = sqlSessionTemplate.selectOne("users.userIdCheck", input_UserId);
		//userId가 있으면 1, 없으면 0
		return cnt;
		
	}//UserIdCheck

	//findUserId : 아이디 찾기페이지에서 submit 클릭하여, 사용자가 입력한 정보가 users에 있는지 확인
	public String findUserId(UsersBean param_usersBean) {
	    UsersBean usersBean = null;
	    usersBean = sqlSessionTemplate.selectOne("users.findUserId", param_usersBean);
	    String result = "NO"; 
	    if (usersBean != null && usersBean.getUserId() != null) {
	    	result = usersBean.getUserId();
	    } 
	    System.out.println("findUserId result : " + result);
	    return result;
	    
	}//findUserId

	//findPassword : 비밀번호 찾기페이지에서 submit 클릭하여, 사용자가 입력한 정보가 users에 있는지 확인
	public String findPassword(UsersBean param_usersBean) {
	    UsersBean usersBean = null;
	    usersBean = sqlSessionTemplate.selectOne("users.findPassword", param_usersBean);
	    String result = "NO"; 
	    if (usersBean != null && usersBean.getPassword() != null) {
	    	result =  usersBean.getPassword();
	    } 
	    System.out.println("findPassword result : " + result);
	    return result;
	    
	}//findPassword

	//getUsersByUserId : 마이페이지에 사용자 정보 띄우기
	public UsersBean getUsersByUserId(String getUserId) {
		UsersBean usersBean = null;
	    usersBean = sqlSessionTemplate.selectOne("users.getUsersByUserId", getUserId);
		return usersBean;
	}//getUsersByUserId

	//getUsersByPassword : 마이페이지에서 수정 클릭 시 사용자의 비밀번호를 다시 확인
	public int getUsersByPassword(UsersBean usersBean) {
		int cnt = -1;
		cnt = sqlSessionTemplate.selectOne("users.getUsersByPassword", usersBean);
		//입력한 비밀번호와 DB의 비밀번호가 동일하면 1, 동일하지않으면 0 return
		System.out.println("getUsersByPassword cnt : "+cnt);
		return cnt;
	}//getUsersByPassword

	//usersUpdate : 사용자 비밀번호를 확인 후 마이페이지수정페이지에서 사용자가 수정요청한 값 update
	public int usersUpdate(UsersBean usersBean) {
		int cnt = -1;
		cnt = sqlSessionTemplate.update("users.usersUpdate", usersBean);
		System.out.println("usersUpdate cnt : "+cnt);
		return cnt;
	}//usersUpdate

	//usersUpdatePassword : 사용자 기존 비밀번호 확인 후 새로운 비밀번호로 update
	public int usersUpdatePassword(UsersBean usersBean) {
		int cnt = -1;
		System.out.println(usersBean.getUserId());
		System.out.println(usersBean.getPassword());
		System.out.println(usersBean.getPasswordNew());
		cnt = sqlSessionTemplate.update("users.usersUpdatePassword", usersBean);
		System.out.println("usersUpdatePassword cnt : "+cnt);
		return cnt;
	}//usersUpdatePassword

	//usersWithdrawal : 사용자 탈퇴(status Y -> N) update
	public int usersWithdrawal(String getUserId) {
		int cnt = -1;
		cnt = sqlSessionTemplate.update("users.usersWithdrawal", getUserId);
		System.out.println("usersWithdrawal cnt : "+cnt);
		return cnt;
	}//usersWithdrawal


}//UsersDAO
