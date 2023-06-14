package com.spring.ex.mountain.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class MountainDao {

	//Mountain namespace
	//private String namespace = "mountain.MountainBean";
		
	//Sqlsessiontemplate 객체 생성
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
		
	//MountainDao 생성자 start
	public MountainDao() {
		System.out.println("MountainDao() 생성자");
	}//MountainDao 생성자 end

	public List<MountainBean> getAllQna() {
		// TODO Auto-generated method stub
		return null;
	}
	
}
