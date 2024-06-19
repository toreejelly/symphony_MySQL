package kr.co.symphony.lessonreg;

import org.springframework.web.multipart.MultipartFile;

public class RegDTO {
	private int c_id;
	private String id;
	private String c_title;
	private String prof_photo;
	private String c_content;
	private String q01ans;
	private String q03ans;
	private String q04ans;
	private String c_time;
	private String c_date;
	private int price;
	private String ddate;
	private String gender;
	private int w_views;

	public RegDTO() {}
	
	// 1) 스프링 파일 객체 멤버변수 선언
	// <input type='file' name='posterMF' size='50'>
	private MultipartFile prof_photoMF;

	// 2) getter와 setter함수 작성
	public MultipartFile getProf_photoMF() {
		return prof_photoMF;
	}

	public void setProf_photoMF(MultipartFile prof_photoMF) {
		this.prof_photoMF = prof_photoMF;
	}

	public int getC_id() {
		return c_id;
	}

	public void setC_id(int c_id) {
		this.c_id = c_id;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getC_title() {
		return c_title;
	}

	public void setC_title(String c_title) {
		this.c_title = c_title;
	}
	
	public String getProf_photo() {
		return prof_photo;
	}

	public void setProf_photo(String prof_photo) {
		this.prof_photo = prof_photo;
	}

	public String getC_content() {
		return c_content;
	}

	public void setC_content(String c_content) {
		this.c_content = c_content;
	}

	public String getQ01ans() {
		return q01ans;
	}

	public void setQ01ans(String q01ans) {
		this.q01ans = q01ans;
	}

	public String getQ03ans() {
		return q03ans;
	}

	public void setQ03ans(String q03ans) {
		this.q03ans = q03ans;
	}

	public String getQ04ans() {
		return q04ans;
	}

	public void setQ04ans(String q04ans) {
		this.q04ans = q04ans;
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


	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}
	
	public String getDdate() {
		return ddate;
	}

	public void setDdate(String ddate) {
		this.ddate = ddate;
	}
	
	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}
	
	public int getW_views() {
		return w_views;
	}

	public void setW_views(int w_views) {
		this.w_views = w_views;
	}



	
	


}
