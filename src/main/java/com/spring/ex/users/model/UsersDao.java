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
		System.out.println("usersBean.getUserRole() : " + usersBean.getUserRole());
		System.out.println("usersBean.getAddress() : " + usersBean.getAddress());
		System.out.println("usersBean.getAddressSub() : " + usersBean.getAddressSub());
		cnt = sqlSessionTemplate.insert("users.signUp", usersBean);
		
		return cnt;
	}

}//UsersDAO
