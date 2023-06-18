package com.spring.ex.pay.model;

public class PayBean {
	private int paynum;
	private int prdnum;
	private String buyer;
	private int price;
	private String regdate;
	private String payment;
	
	public int getPaynum() {
		return paynum;
	}
	public void setPaynum(int paynum) {
		this.paynum = paynum;
	}
	public int getPrdnum() {
		return prdnum;
	}
	public void setPrdnum(int prdnum) {
		this.prdnum = prdnum;
	}
	public String getBuyer() {
		return buyer;
	}
	public void setBuyer(String buyer) {
		this.buyer = buyer;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public String getPayment() {
		return payment;
	}
	public void setPayment(String payment) {
		this.payment = payment;
	}
	
	
}
