package kr.co.symphony.pay;

import java.util.Date;

public class PaymentDTO {

	/*
	 * payment_tb
	 * 
	 * ORDER_ID VARCHAR2(50 BYTE)
	 * ID VARCHAR2(10 BYTE)
	 * PAY_WITH VARCHAR2(10 BYTE)
	 * PAY_TIME DATE 
	 * T_PAY NUMBER
	 * CONFIRM VARCHAR2(10 BYTE)
	 * C_ID NUMBER(38,0)
	 */
	
	private String orderId;
	private String id;
	private String payWith;
	private Date payTime;
	private int tPay;
	private String confirm;
	private int cId;
	
	public String getOrderId() {
		return orderId;
	}
	
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public String getPayWith() {
		return payWith;
	}
	
	public void setPayWith(String payWith) {
		this.payWith = payWith;
	}
	
	public Date getPayTime() {
		return payTime;
	}
	
	public void setPayTime(Date payTime) {
		this.payTime = payTime;
	}
	
	public int gettPay() {
		return tPay;
	}

	public void settPay(int tPay) {
		this.tPay = tPay;
	}
	
	public String getConfirm() {
		return confirm;
	}
	
	public void setConfirm(String confirm) {
		this.confirm = confirm;
	}
	
	public int getC_id() {
		return cId;
	}
	
	public void setC_id(int c_id) {
		this.cId = c_id;
	}

	@Override
	public String toString() {
		return "PaymentDTO [orderId=" + orderId + ", id=" + id + ", payWith=" + payWith + ", payTime=" + payTime
				+ ", tPay=" + tPay + ", confirm=" + confirm + ", cId=" + cId + "]";
	}
	
}
