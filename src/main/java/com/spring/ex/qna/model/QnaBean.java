package com.spring.ex.qna.model;

import java.util.Date;

import org.hibernate.validator.constraints.NotBlank;
import org.springframework.web.multipart.MultipartFile;


public class QnaBean {
	
	//qna 식별번호
	private int qnanum;
	
	//users table 외래키
	private String usersid;
	
	//qna 카테고리
	@NotBlank(message = "카테고리는 비워둘 수 없습니다.")
	private String qnacategory;
	
	//qna 작성일자, default sysdate
	private Date qnadate;
	
	//qna 제목
	@NotBlank(message = "제목은 비워둘 수 없습니다.")
	private String qnasubject;

	//qna 질문
	@NotBlank(message = "질문 내용은 비워둘 수 없습니다.")
	private String qnaquestion;

	private String qnaanswer;

	//qna 이미지
	private String qnaimage;
	
	//qna 비밀글, 0 : 일반, 1 : 비밀
	@NotBlank(message = "글의 공개범위를 선택해주세요.")
	private String qnasecret;
	
	//이미지 업로드를 위한 객체, 변수 생성
	private MultipartFile upload;
	private String upload2;
	
	//setter, getter 메서드
	public int getQnanum() {
		return qnanum;
	}
	public void setQnanum(int qnanum) {
		this.qnanum = qnanum;
	}
	public String getUsersid() {
		return usersid;
	}
	public void setUsersid(String usersid) {
		this.usersid = usersid;
	}
	public String getQnacategory() {
		return qnacategory;
	}
	public void setQnacategory(String qnacategory) {
		this.qnacategory = qnacategory;
	}
	public Date getQnadate() {
		return qnadate;
	}
	public void setQnadate(Date qnadate) {
		this.qnadate = qnadate;
	}
	public String getQnasubject() {
		return qnasubject;
	}
	public void setQnasubject(String qnasubject) {
		this.qnasubject = qnasubject;
	}
	public String getQnaquestion() {
		return qnaquestion;
	}
	public void setQnaquestion(String qnaquestion) {
		this.qnaquestion = qnaquestion;
	}
	public String getQnaanswer() {
		return qnaanswer;
	}
	public void setQnaanswer(String qnaanswer) {
		this.qnaanswer = qnaanswer;
	}
	public String getQnaimage() {
		return qnaimage;
	}
	public void setQnaimage(String qnaimage) {
		this.qnaimage = qnaimage;
	}
	public String getQnasecret() {
		return qnasecret;
	}
	public void setQnasecret(String qnasecret) {
		this.qnasecret = qnasecret;
	}
	public MultipartFile getUpload() {
		return upload;
	}
	public void setUpload(MultipartFile upload) {
		System.out.println("setUpload()");
		this.upload = upload;
		
		String fileName = upload.getOriginalFilename();
		System.out.println("filename : "+fileName);
		
		this.qnaimage = fileName;
	}
	public String getUpload2() {
		return upload2;
	}
	public void setUpload2(String upload2) {
		this.upload2 = upload2;
	}

}
