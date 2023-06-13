package com.spring.ex.users.model;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotBlank;

public class UsersBean {
	private final String input_message = " 필수입력 사항입니다.";
	private final String choice_message = " 필수선택 사항입니다.";
	
	private int userNum;
	
	@Pattern(regexp = "^[a-z0-9]+$", message = "아이디는 영어와 숫자룰 사용하여 6글자 이상으로 가능합니다.")
	private String userId;
	
	@Pattern(regexp = "^[a-z0-9]+$", message = "비밀번호는 영어와 숫자룰 사용하여 6글자 이상으로 가능합니다.")
	private String password;

	@NotBlank(message = "이름은" + input_message)
	private String name;
	
	@NotBlank(message = "성별은" + choice_message)
	private String gender;
	
	@NotBlank(message = "이메일은" + input_message)
	@Email(message = "올바른 이메일 형식이 아닙니다.") //@Email Null허용
	private String email;
	
	//@Pattern(regexp = "^01(?:0|1|[6-9])-(?:d{3}|d{4})-d{4}$", message = "올바른 연락처의 형태가 아닙니다.")
	private String phone;
	
	private String status;
	private String userRole;
	private String udate;
	
	@NotBlank(message = "주소는" + input_message)
	private String address;
	@NotBlank(message = "상세주소는" + input_message)
	private String addressSub;
	private String image;
	
	//getter & setter
	public int getUserNum() {
		return userNum;
	}
	public void setUserNum(int userNum) {
		this.userNum = userNum;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getUserRole() {
		return userRole;
	}
	public void setUserRole(String userRole) {
		this.userRole = userRole;
	}
	public String getUdate() {
		return udate;
	}
	public void setUdate(String udate) {
		this.udate = udate;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getAddressSub() {
		return addressSub;
	}
	public void setAddressSub(String addressSub) {
		this.addressSub = addressSub;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	

}
