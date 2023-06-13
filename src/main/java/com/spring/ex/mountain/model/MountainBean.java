package com.spring.ex.mountain.model;

import org.hibernate.validator.constraints.NotBlank;
import org.springframework.web.multipart.MultipartFile;

public class MountainBean {
	
	//mountain 식별번호
	private int mountainnum;
	
	//mountain 이름
	@NotBlank(message = "산 이름은 비워둘 수 없습니다.")
	private String mountainname;
	
	//mountain 높이(단위 m)
	private int mountainheight;
	
	//mountain 지역(목록에서는 동까지 표시)
	@NotBlank(message = "산 지역은 비워둘 수 없습니다.")
	private String mountainlocal;
	
	//mountain 상세설명
	private String mountaincontent;
	
	//mountain 사진
	private String mountainimage;
	
	//mountain 국립공원 여부, 0 : 국립공원 아님, 1 : 국립공원
	@NotBlank(message = "국립공원 여부는 비워둘 수 없습니다.")
	private int mountainnational;
	
	//mountain 난이도, 초급자, 중급자, 상급자
	private String mountaindifficulty;
	
	//mountain 소요시간(00시간 00분으로 표기)
	private String mountaintime;

	
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
	public int getMountainnum() {
		return mountainnum;
	}

	public void setMountainnum(int mountainnum) {
		this.mountainnum = mountainnum;
	}

	public String getMountainname() {
		return mountainname;
	}

	public void setMountainname(String mountainname) {
		this.mountainname = mountainname;
	}

	public int getMountainheight() {
		return mountainheight;
	}

	public void setMountainheight(int mountainheight) {
		this.mountainheight = mountainheight;
	}

	public String getMountainlocal() {
		return mountainlocal;
	}

	public void setMountainlocal(String mountainlocal) {
		this.mountainlocal = mountainlocal;
	}

	public String getMountaincontent() {
		return mountaincontent;
	}

	public void setMountaincontent(String mountaincontent) {
		this.mountaincontent = mountaincontent;
	}

	public String getMountainimage() {
		return mountainimage;
	}

	public void setMountainimage(String mountainimage) {
		this.mountainimage = mountainimage;
	}

	public int getMountainnational() {
		return mountainnational;
	}

	public void setMountainnational(int mountainnational) {
		this.mountainnational = mountainnational;
	}

	public String getMountaindifficulty() {
		return mountaindifficulty;
	}

	public void setMountaindifficulty(String mountaindifficulty) {
		this.mountaindifficulty = mountaindifficulty;
	}

	public String getMountaintime() {
		return mountaintime;
	}

	public void setMountaintime(String mountaintime) {
		this.mountaintime = mountaintime;
	}
	
	
	
}
