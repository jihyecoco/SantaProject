package com.spring.ex.crewboard.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.spring.ex.utility.Paging;

@Component
public class CrewBoardDao {
	//private final String namespace = "crewboard.CrewBoardBean";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	public List<CrewBoardBean> getAllCrewboard(Map<String, Object> map, Paging pageInfo) {
		List<CrewBoardBean> lists = new ArrayList<CrewBoardBean>();
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		//lists = sqlSessionTemplate.selectList(namespace+".GetAllCrewboard", map, rowBounds);
		lists = sqlSessionTemplate.selectList("GetAllCrewboard", map, rowBounds);
		return lists;
	}

	public int insertCrewboard(CrewBoardBean cbb) {
		int cnt = -1;
		//cnt = sqlSessionTemplate.insert(namespace+".InsertCrewboard", cbb);
		cnt = sqlSessionTemplate.insert("InsertCrewboard", cbb);
		return cnt;
	}

	public CrewBoardBean getCrewboardByNum(int num) {
		//CrewBoardBean cbb = sqlSessionTemplate.selectOne(namespace+".GetCrewboardByNum", num);
		CrewBoardBean cbb = sqlSessionTemplate.selectOne("GetCrewboardByNum", num);
		return cbb;
	}

	public CrewBoardBean getCrewboardByCrewname(String crewname) {
		//CrewBoardBean cbb = sqlSessionTemplate.selectOne(namespace+".GetCrewboardByCrewname", crewname);
		CrewBoardBean cbb = sqlSessionTemplate.selectOne("GetCrewboardByCrewname", crewname);
		return cbb;
	}

	public int updateCrewboardState(String crewname) {
		int cnt = -1;
		//cnt = sqlSessionTemplate.update(namespace+".UpdateCrewboardState", crewname);
		cnt = sqlSessionTemplate.update("UpdateCrewboardState", crewname);
		return cnt;
	}

	public int getTotalCount(Map<String, Object> map) {
		int totalCount = 0;
		//totalCount = sqlSessionTemplate.selectOne(namespace+".GetTotalCount", map);
		//totalCount = sqlSessionTemplate.selectOne("GetTotalCount", map);
		return totalCount;
	}
	
	
}
