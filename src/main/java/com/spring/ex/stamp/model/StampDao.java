package com.spring.ex.stamp.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class StampDao {

	//Stamp namespace
	private String namespace = "mountain.StampBean";
			
	//Sqlsessiontemplate 객체 생성
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
			
	//StampDao 생성자 start
	public StampDao() {
		System.out.println("StampDao() 생성자");
	}//StampDao 생성자 end
	
}
