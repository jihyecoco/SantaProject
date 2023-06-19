package com.spring.ex.board.model;

import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.web.multipart.MultipartFile;

public class BoardBean {
	
	private int num;
	private String userid;
	
	@NotBlank(message="카테고리를 선택하세요")
	private String category;
	
	@NotBlank(message="글제목을 입력하세요")
	private String subject;
	
	@NotBlank(message="내용을 입력하세요")
	private String content;
	private String regdate;
	private String readcount;
	
	//@NotEmpty(message="파일을 선택하세요.")
	private String image;
	
	private int boardcommentscount; //댓글수 출력하기위한 칼럼
	
	//////////	
	private MultipartFile upload;
	
	private String upload2; //수정할때 기존 이미지를 담는 변수(수정할때 웹서버폴더에서 기존이미지를 지워야 하므로)
		
	public String getUpload2() {
		return upload2;
	}

	public void setUpload2(String upload2) {
		this.upload2 = upload2;
	}

	public MultipartFile getUpload() {
		return upload;
	}

	public void setUpload(MultipartFile upload) {
		System.out.println("setUpload");
		this.upload = upload;
		String fileName = upload.getOriginalFilename();
		this.image = fileName;
	}
	
	//////////

	
	public int getNum() {
		return num;
	}

	public int getBoardcommentscount() {
		return boardcommentscount;
	}

	public void setBoardcommentscount(int boardcommentscount) {
		this.boardcommentscount = boardcommentscount;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public String getReadcount() {
		return readcount;
	}

	public void setReadcount(String readcount) {
		this.readcount = readcount;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}
	
	
	
	
}
