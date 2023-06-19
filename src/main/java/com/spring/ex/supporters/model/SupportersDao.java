package com.spring.ex.supporters.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.spring.ex.board.model.BoardBean;
import com.spring.ex.utility.Paging;

@Component
public class SupportersDao {
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	
	public int getTotalSupportersCount(Map<String, String> map) {
		int cnt = -1;
		cnt = sqlSessionTemplate.selectOne("GetTotalSupportersCount", map);		
		return cnt;
	}

	public List<SupportersBean> getAllSupporters(Map<String, String> map, Paging pageInfo) {
		List<SupportersBean> lists = new ArrayList<SupportersBean>();
		
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(),pageInfo.getLimit());		
		lists = sqlSessionTemplate.selectList("GetAllSupporters",map,rowBounds);
		System.out.println("supporters lists.size(): "+lists.size());
		
		return lists;
	}

	public int insertSupporters(SupportersBean supporters) {
		int cnt = -1;	
		cnt = sqlSessionTemplate.insert("InsertSupporters", supporters);
		return cnt;
	}

	public int checkSupportersname(String input_name) {
		int cnt = -1;
		cnt = sqlSessionTemplate.selectOne("CheckSupportersname", input_name);
		return cnt;
	}

	public int updateSupoCount(int num) { //조회수 1 중기
		int cnt = -1;
		cnt = sqlSessionTemplate.update("UpdateSupoCount", num);
		return cnt;
	}

	public SupportersBean getSupportersByNum(int num) {
		SupportersBean supporters = null;
		supporters = sqlSessionTemplate.selectOne("GetSupportersByNum", num);		
		return supporters;
	}

	public int deleteSupporters(int num) {
		int cnt = -1;		
		cnt = sqlSessionTemplate.delete("DeleteSupporters",num);
		return cnt;
	}

	public int updateSupporter(SupportersBean supporters) {
		int cnt = -1;
		cnt = sqlSessionTemplate.update("UpdateSupporters", supporters);
		return cnt;
	}
	
	
	
	
}
