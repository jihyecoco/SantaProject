package com.spring.ex.bookmark.crewboard.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.spring.ex.users.model.UsersBean;
import com.spring.ex.users.model.UsersDao;

@Component("CrewBoardBookmarkDao")
public class CrewBoardBookmarkDao {
		
	private static final Logger logger = LoggerFactory.getLogger(CrewBoardBookmarkDao.class);
		
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	//crewBoardCheckBookmark :	크루게시판의 상세보기클릭하면 해당 게시글의 북마크 상태 확인
	public int crewBoardCheckBookmark(CrewBoardBookmarkBean cbhBean) {
		int cnt = -1;
		try {
			cnt = sqlSessionTemplate.selectOne("crewboardBookmark.checkBookmark", cbhBean);
			System.out.println("Dao - crewBoardCheckBookmark  cnt : " + cnt);
			if(cnt == 1) {
				System.out.println("북마크 누름");
			} else {
				System.out.println("북마크 안누름");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}//crewBoardCheckBookmark

		
	//crewBoardInsertBookmark : 크루게시판의 상세보기에서 북마크를 클릭하면 북마크 insert
	public int crewBoardInsertBookmark(CrewBoardBookmarkBean cbhBean) {
		int cnt = -1;
		try {
			cnt = sqlSessionTemplate.insert("crewboardBookmark.insertBookmark", cbhBean);
			System.out.println("Dao - crewBoardInsertBookmark cnt : " + cnt);
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return cnt;
	}//crewBoardInsertBookmark
	
	//crewBoardDeleteBookmark : 크루게시판의 상세보기에서 북마크를 클릭하면 북마크 delete(북마크 취소)
	public int crewBoardDeleteBookmark(CrewBoardBookmarkBean cbhBean) {
		int cnt = -1;
		cnt = sqlSessionTemplate.delete("crewboardBookmark.deleteBookmark", cbhBean);
		System.out.println("Dao - crewBoardDeleteBookmark cnt : " + cnt);
		return cnt;
		
	}//crewBoardDeleteBookmark

	//getcrewBoardBookmarkTotal : 게시글의 북마크 수 count
	public int getcrewBoardBookmarkTotal(CrewBoardBookmarkBean cbhBean) {
		int cnt = -1;
		cnt = sqlSessionTemplate.selectOne("crewboardBookmark.getcrewBoardBookmarkTotal", cbhBean);
		System.out.println("Dao - getcrewBoardBookmarkTotal cnt : " + cnt);
		return cnt;
		
	}//getcrewBoardBookmarkTotal

}//CrewBoardBookmarkDao
