package com.spring.ex.mountain.model;

import java.util.List;
import java.util.Map;

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

	public List<MountainBean> getAllMountainFirst() {
		List<MountainBean> mountainLists = sqlSessionTemplate.selectList("GetAllMountainFirst");
		return mountainLists;
	}

	public int insertMountainFirst(Map<String, Object> map) {
		int cnt = sqlSessionTemplate.insert("InsertMountainFirst",map);
		return cnt;
	}
	
}
