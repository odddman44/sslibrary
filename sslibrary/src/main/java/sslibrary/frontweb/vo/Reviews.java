package sslibrary.frontweb.vo;

public class Reviews {

	private int isbn;
	private int cno;
	private int star;
	private String review;
	public Reviews() {
	}
	public Reviews(int isbn, int cno, int star, String review) {
		this.isbn = isbn;
		this.cno = cno;
		this.star = star;
		this.review = review;
	}
	public int getIsbn() {
		return isbn;
	}
	public void setIsbn(int isbn) {
		this.isbn = isbn;
	}
	public int getCno() {
		return cno;
	}
	public void setCno(int cno) {
		this.cno = cno;
	}
	public int getStar() {
		return star;
	}
	public void setStar(int star) {
		this.star = star;
	}
	public String getReview() {
		return review;
	}
	public void setReview(String review) {
		this.review = review;
	}
	
	
	
}
