package sslibrary.frontweb.vo;

public class ReviewList {

	private int rno;
	private String id;
	private String review;
	private int star;
	public ReviewList() {
	}
	public ReviewList(int rno, String id, String review, int star) {
		super();
		this.rno = rno;
		this.id = id;
		this.review = review;
		this.star = star;
	}
	public int getRno() {
		return rno;
	}
	public void setRno(int rno) {
		this.rno = rno;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getReview() {
		return review;
	}
	public void setReview(String review) {
		this.review = review;
	}
	public int getStar() {
		return star;
	}
	public void setStar(int star) {
		this.star = star;
	}
	
}
	