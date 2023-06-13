package com.spring.ex.stamp.model;

import org.hibernate.validator.constraints.NotBlank;
import org.springframework.web.multipart.MultipartFile;

public class StampBean {
	
	//stamp 인증 신청 식별번호
	private int stampnum;
	
	//users table 외래키
	private String usersid;
	
	//stamp 갯수
	private int stampcount;
	
	//stamp 인증 신청 이미지
	@NotBlank(message = "인증 이미지는 비워둘 수 없습니다.")
	private String stampimage;
	
	//stamp 인증 상태, default 0, 0 : 인증 대기, 1 : 인증 완료, 2 : 인증 실패
	private int stampapply;
	
	//이미지 업로드를 위한 객체, 변수 생성
	private MultipartFile upload;
	private String upload2;
	
	
	
	//setter, getter 메서드
	public MultipartFile getUpload() {
		return upload;
	}
	
	public void setUpload(MultipartFile upload) {
		this.upload = upload;
	}
	
	public String getUpload2() {
		return upload2;
	}
	
	public void setUpload2(String upload2) {
		this.upload2 = upload2;
	}
	public int getStampnum() {
		return stampnum;
	}

	public void setStampnum(int stampnum) {
		this.stampnum = stampnum;
	}

	public String getUsersid() {
		return usersid;
	}

	public void setUsersid(String usersid) {
		this.usersid = usersid;
	}

	public int getStampcount() {
		return stampcount;
	}

	public void setStampcount(int stampcount) {
		this.stampcount = stampcount;
	}

	public String getStampimage() {
		return stampimage;
	}

	public void setStampimage(String stampimage) {
		this.stampimage = stampimage;
	}

	public int getStampapply() {
		return stampapply;
	}

	public void setStampapply(int stampapply) {
		this.stampapply = stampapply;
	}
	
	
}
