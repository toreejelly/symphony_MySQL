package kr.co.symphony.pay;

public class PayDTO {

	private int cart_id;
	private String id;
	private int c_id;
	private String c_title;
	private int price;
	private String c_time;
	private String c_date;
	private int t_time;
	private String name;
	
	public PayDTO() {}

	public int getCart_id() {
		return cart_id;
	}

	public void setCart_id(int cart_id) {
		this.cart_id = cart_id;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getC_id() {
		return c_id;
	}

	public void setC_id(int c_id) {
		this.c_id = c_id;
	}

	public String getC_title() {
		return c_title;
	}

	public void setC_title(String c_title) {
		this.c_title = c_title;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getC_time() {
		return c_time;
	}

	public void setC_time(String c_time) {
		this.c_time = c_time;
	}

	public String getC_date() {
		return c_date;
	}

	public void setC_date(String c_date) {
		this.c_date = c_date;
	}

	public int getT_time() {
		return t_time;
	}

	public void setT_time(int t_time) {
		this.t_time = t_time;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Override
	public String toString() {
		return "PayDTO [cart_id=" + cart_id + ", id=" + id + ", c_id=" + c_id + ", c_title=" + c_title + ", price="
				+ price + ", c_time=" + c_time + ", c_date=" + c_date + ", t_time=" + t_time + ",name="+name+"]";
	}
	
}
