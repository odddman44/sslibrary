package sslibrary.frontweb.vo;
import java.util.*;

public class Rental {
	private int isbn; // 책번호
	private int cno; // 회원번호
	private Date rental_date; // 대출일
	private Date return_date; // 반납예정일
	public Rental() {
		
	}
	public Rental(int isbn, int cno, Date rental_date, Date return_date) {
		this.isbn = isbn;
		this.cno = cno;
		this.rental_date = rental_date;
		this.return_date = return_date;
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
