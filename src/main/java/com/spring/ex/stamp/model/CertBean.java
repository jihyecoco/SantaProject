package com.spring.ex.stamp.model;

public class CertBean {
	private String stampnum;
	private String mountainname;
	private int stampapply;
	private String stampimage;
	private String usersid;
	
	public String getStampnum() {
		return stampnum;
	}
	public void setStampnum(String stampnum) {
		this.stampnum = stampnum;
	}
	public String getUsersid() {
		return usersid;
	}
	public void setUsersid(String usersid) {
		this.usersid = usersid;
	}
	public String getMountainname() {
		return mountainname;
	}
	public void setMountainname(String mountainname) {
		this.mountainname = mountainname;
	}
	
	public int getStampapply() {
		return stampapply;
	}
	public void setStampapply(int stampapply) {
		this.stampapply = stampapply;
	}
	public String getStampimage() {
		return stampimage;
	}
	public void setStampimage(String stampimage) {
		this.stampimage = stampimage;
	}
	
}
