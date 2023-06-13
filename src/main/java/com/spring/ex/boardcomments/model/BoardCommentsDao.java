package com.spring.ex.boardcomments.model;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.spring.ex.board.model.BoardBean;

@Component
public class BoardCommentsDao {
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	
	public int insertBoardComments(BoardCommentsBean bcmt) {		
		int cnt = -1; 
		cnt = sqlSessionTemplate.insert("InsertBoardComments", bcmt); 
		System.out.println();
		return cnt;
	}

	public List<BoardCommentsBean> getAllBoardComments() {
		List<BoardCommentsBean> lists = new ArrayList<BoardCommentsBean>();
		lists = sqlSessionTemplate.selectList("GetAllBoardComments");
		System.out.println("boardcomments lists.size(): "+lists.size());
		return lists;
	}

	public List<BoardCommentsBean> getBoardCommentsByBnum(int bnum) {
		List<BoardCommentsBean> comments = new ArrayList<BoardCommentsBean>();
		comments = sqlSessionTemplate.selectList("GetBoardCommentsByBnum", bnum);
		return comments;
	}

	public int deleteBoardComments(BoardCommentsBean boardcomments) {
		int cnt = -1;
		cnt = sqlSessionTemplate.update("DeleteBoardComments", boardcomments);
		return cnt;
	}
	
	
	
}
