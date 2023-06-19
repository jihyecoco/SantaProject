package com.spring.ex.supporters.model;

import javax.validation.constraints.Min;

import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.Range;

public class SupportersBean {
	
	private int num;
	private String writer;
	
	@NotBlank(message="서포터즈명을 입력하세요")
	private String supportersname;
	private int state;
	
	//오늘보다 이전 날짜를 선택할 수 없음
	private String deadline;
	
	@NotBlank(message="모집대상 선택해야 합니다.")
	private String target;
	
	//@Min(value=5, message="최소 인원은 5명입니다.")
	@Range(min=2, max=20, message="5명 ~ 50명만 가능합니다.")
	private int limit;
	
	private int applicant;
	
	//모집마감일(deadline)보다 이전 날짜를 선택할 수 없음
	private String startdate;
	
	//활동시작일(startdate)보다 이전 날짜를 선택할 수 없음
	private String enddate;
	
	@NotBlank(message="내용을 입력하세요")
	private String content;
	private String regdate;
	private int readcount;
	
	
	
	public int getLimit() {
		return limit;
	}
	public void setLimit(int limit) {
		this.limit = limit;
	}
	public int getApplicant() {
		return applicant;
	}
	public void setApplicant(int applicant) {
		this.applicant = applicant;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getSupportersname() {
		return supportersname;
	}
	public void setSupportersname(String supportersname) {
		this.supportersname = supportersname;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public String getDeadline() {
		return deadline;
	}
	public void setDeadline(String deadline) {
		this.deadline = deadline;
	}
	public String getTarget() {
		return target;
	}
	public void setTarget(String target) {
		this.target = target;
	}
	public String getStartdate() {
		return startdate;
	}
	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}
	public String getEnddate() {
		return enddate;
	}
	public void setEnddate(String enddate) {
		this.enddate = enddate;
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
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	
	
	
	
	
}
