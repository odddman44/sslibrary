package sslibrary.frontweb.vo;
import java.util.*;

public class ReviewDTO {
	private String title;
	private String publisher;
	private String name; // 작가명
	private String content; // 리뷰내용
	private int rating; // 평점
	private Date review_date; // 리뷰 단 날
	public ReviewDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ReviewDTO(String title, String publisher, String name, String content, int rating, Date review_date) {
		super();
		this.title = title;
		this.publisher = publisher;
		this.name = name;
		this.content = content;
		this.rating = rating;
		this.review_date = review_date;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
	}
	public Date getReview_date() {
		return review_date;
	}
	public void setReview_date(Date review_date) {
		this.review_date = review_date;
	}
	

}
