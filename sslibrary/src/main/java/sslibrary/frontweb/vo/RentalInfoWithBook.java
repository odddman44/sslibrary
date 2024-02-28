package sslibrary.frontweb.vo;

import java.util.Date;
//title, publisher, year, name, cno, reserve_date, return_date
public class RentalInfoWithBook {
	private int isbn;
	private String title; // 책 제목
	private String publisher; // 출판사
	private int year; // 출판년도
	private String name; // 작가명
	private Date rental_date; // 대출일자
	private Date return_date; // 반납일자
	public RentalInfoWithBook() {
		super();
		// TODO Auto-generated constructor stub
	}
	public RentalInfoWithBook(int isbn, String title, String publisher, int year, String name, Date rental_date,
			Date return_date) {
		this.isbn = isbn;
		this.title = title;
		this.publisher = publisher;
		this.year = year;
		this.name = name;
		this.rental_date = rental_date;
		this.return_date = return_date;
	}
	public int getIsbn() {
		return isbn;
	}
	public void setIsbn(int isbn) {
		this.isbn = isbn;
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
	public int getYear() {
		return year;
	}
	public void setYear(int year) {
		this.year = year;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Date getRental_date() {
		return rental_date;
	}
	public void setRental_date(Date rental_date) {
		this.rental_date = rental_date;
	}
	public Date getReturn_date() {
		return return_date;
	}
	public void setReturn_date(Date return_date) {
		this.return_date = return_date;
	}
	
	
	
	
}
