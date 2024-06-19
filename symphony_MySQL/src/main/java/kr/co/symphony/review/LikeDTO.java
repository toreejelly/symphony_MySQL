package kr.co.symphony.review;

public class LikeDTO {

	private int		likeNum;			//좋아요번호
	private int 	wNum;				//글번호
	private String 	wCode = "r";				//분류
	private String 	id;				    //아이디
	private String 	likedYn;			//좋아요 여부
	
	public LikeDTO() {}

	public int getLikeNum() {
		return likeNum;
	}

	public void setLikeNum(int likeNum) {
		this.likeNum = likeNum;
	}

	public int getwNum() {
		return wNum;
	}

	public void setwNum(int wNum) {
		this.wNum = wNum;
	}

	public String getwCode() {
		return wCode;
	}

	public void setwCode(String wCode) {
		this.wCode = wCode;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getLikedYn() {
		return likedYn;
	}

	public void setLikedYn(String likedYn) {
		this.likedYn = likedYn;
	}

}//class end

