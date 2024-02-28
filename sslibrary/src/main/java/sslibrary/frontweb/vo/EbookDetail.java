package sslibrary.frontweb.vo;

public class EbookDetail {

	private int likes;
	private int thumbs;
	private String info;
	public EbookDetail() {
		// TODO Auto-generated constructor stub
	}
	public EbookDetail(int likes, int thumbs, String info) {
		this.likes = likes;
		this.thumbs = thumbs;
		this.info = info;
	}
	public int getLikes() {
		return likes;
	}
	public void setLikes(int likes) {
		this.likes += likes;
	}
	public int getThumbs() {
		return thumbs;
	}
	public void setThumbs(int thumbs) {
		this.thumbs = thumbs;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	
	
}
