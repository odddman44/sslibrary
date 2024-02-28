package sslibrary.frontweb.vo;
// isbn, title, author_name, publisher, year, customer_id, customer_name, rental_date, return_date 

import java.sql.Date;

public class RentalInfoForAdmin {
	private int isbn;
	private String title;
	private String author_name;
	private String publisher;
	private int year;
	private int cno;
	private String customer_id;
	private String customer_name;
	private Date rental_date;
	private Date return_date;
	private String isreturn;
	public RentalInfoForAdmin() {
		// TODO Auto-generated constructor stub
	}
	
	public String getIsreturn() {
		return isreturn;
	}

	public void setIsreturn(String isreturn) {
		this.isreturn = isreturn;
	}
	
	
	public int getCno() {
		return cno;
	}

	public void setCno(int cno) {
		this.cno = cno;
	}

	public RentalInfoForAdmin(int isbn, String title, String author_name, String publisher, int year, int cno,
			String customer_id, String customer_name, Date rental_date, Date return_date) {
		this.isbn = isbn;
		this.title = title;
		this.author_name = author_name;
		this.publisher = publisher;
		this.year = year;
		this.cno = cno;
		this.customer_id = customer_id;
		this.customer_name = customer_name;
		this.rental_date = rental_date;
		this.return_date = return_date;
	}

	public RentalInfoForAdmin(int isbn, String title, String author_name, String publisher, int year,
			String customer_id, String customer_name, Date rental_date, Date return_date, String isreturn) {
		super();
		this.isbn = isbn;
		this.title = title;
		this.author_name = author_name;
		this.publisher = publisher;
		this.year = year;
		this.customer_id = customer_id;
		this.customer_name = customer_name;
		this.rental_date = rental_date;
		this.return_date = return_date;
		this.isreturn = isreturn;
	}

	public RentalInfoForAdmin(int isbn, String title, String author_name, String publisher, int year,
			String customer_id, String customer_name, Date rental_date, Date return_date) {
		super();
		this.isbn = isbn;
		this.title = title;
		this.author_name = author_name;
		this.publisher = publisher;
		this.year = year;
		this.customer_id = customer_id;
		this.customer_name = customer_name;
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
	public String getAuthor_name() {
		return author_name;
	}
	public void setAuthor_name(String author_name) {
		this.author_name = author_name;
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
	public String getCustomer_id() {
		return customer_id;
	}
	public void setCustomer_id(String customer_id) {
		this.customer_id = customer_id;
	}
	public String getCustomer_name() {
		return customer_name;
	}
	public void setCustomer_name(String customer_name) {
		this.customer_name = customer_name;
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
