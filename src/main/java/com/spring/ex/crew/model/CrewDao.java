package com.spring.ex.crew.model;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("CrewDao")
public class CrewDao {
	//private final String namespace = "crew.CrewBean";
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public int checkCrewname(String input_name) {
		int cnt = -1;
		//cnt = sqlSessionTemplate.selectOne(namespace+".CheckCrewname", input_name);
		cnt = sqlSessionTemplate.selectOne("CheckCrewname", input_name);
		return cnt;
	}

	public int insertCrew(CrewBean cb) {
		int cnt = -1;
		//cnt = sqlSessionTemplate.insert(namespace+".InsertCrew", cb);
		cnt = sqlSessionTemplate.insert("InsertCrew", cb);
		return cnt;
	}

	public List<CrewBean> getCrewById(String loginid) {
		List<CrewBean> cb = new ArrayList<CrewBean>();
		//cb = sqlSessionTemplate.selectList(namespace+".GetCrewById", loginid);
		System.out.println("crewdao 아이디 : "+loginid);
		cb = sqlSessionTemplate.selectList("GetCrewById", loginid);
//		for(int i=0; i<cb.size(); i++) {
//			System.out.println("crewdao 크루이름 : "+cb.get(i).getCrewname());
//			System.out.println("crewdao 설명 : "+cb.get(i).getCrewcontents());
//			System.out.println("crewdao 크루멤버 : "+cb.get(i).getCrewmember());
//			System.out.println("crewdao large : "+cb.get(i).getLarge());
//			System.out.println("crewdao small : "+cb.get(i).getSmall());
//			System.out.println("crewdao num : "+cb.get(i).getCrewnum());
//			System.out.println("crewdao limit : "+cb.get(i).getCrewlimit());
//			System.out.println("crewdao now : "+cb.get(i).getCrewnow());
//		}
		return cb;
	}

	public int updateCrew(CrewBean cb) {
		int cnt = -1;
		//cnt = sqlSessionTemplate.update(namespace+".UpdateCrew", cb);
		cnt = sqlSessionTemplate.update("UpdateCrew", cb);
		return cnt;
	}
	
	
}
