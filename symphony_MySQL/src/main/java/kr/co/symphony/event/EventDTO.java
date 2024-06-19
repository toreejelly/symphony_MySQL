package kr.co.symphony.event;

public class EventDTO {

	private int 	wNum;		//글번호
	private String 	id;			//아이디
	private String 	wTitle;		//제목
	private String 	wText;		//내용
	private String 	wPic;		//사진.영상
	private String 	wDate;		//작성일
	private String 	wRdate;		//수정일
	private int 	wLike;		//좋아요
	private int 	wViews;		//조회수
	private String 	wCode;		//게시판 구분코드
	 
	public EventDTO() {}


	public int getwNum() {
		return wNum;
	}

	public void setwNum(int wNum) {
		this.wNum = wNum;
	}

	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	
	public String getwTitle() {
		return wTitle;
	}

	public void setwTitle(String wTitle) {
		this.wTitle = wTitle;
	}

	
	public String getwText() {
		return wText;
	}

	public void setwText(String wText) {
		this.wText = wText;
	}

	
	public String getwPic() {
		return wPic;
	}

	public void setwPic(String wPic) {
		this.wPic = wPic;
	}

	
	public String getwDate() {
		return wDate;
	}

	public void setwDate(String wDate) {
		this.wDate = wDate;
	}

	
	public String getwRdate() {
		return wRdate;
	}

	public void setwRdate(String wRdate) {
		this.wRdate = wRdate;
	}

	
	public int getwLike() {
		return wLike;
	}


	public void setwLike(int wLike) {
		this.wLike = wLike;
	}


	public int getwViews() {
		return wViews;
	}


	public void setwViews(int wViews) {
		this.wViews = wViews;
	}


	public String getwCode() {
		return wCode;
	}

	public void setwCode(String wCode) {
		this.wCode = wCode;
	}
	 
}//class end
