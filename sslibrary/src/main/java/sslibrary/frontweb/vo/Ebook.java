package sslibrary.frontweb.vo;

public class Ebook {
	private int isbn;
	private String title;
	private int author_id;
	private String authorName; // 추가된 필드. 실제 Ebook 테이블엔 존재하지 않음. Join 구문 실행용
	private String publisher;
	private int year;
	private char available;
	private String info;
	public Ebook() {
		// TODO Auto-generated constructor stub
	}
	public Ebook(int isbn, String title, int author_id, String publisher, int year, char available) {
		this.isbn = isbn;
		this.title = title;
		this.author_id = author_id;
		this.publisher = publisher;
		this.year = year;
		this.available = available;
	}
	
	public Ebook(int isbn, String title, String authorName, String publisher, int year) {
		super();
		this.isbn = isbn;
		this.title = title;
		this.authorName = authorName;
		this.publisher = publisher;
		this.year = year;
	}
	public Ebook(int isbn, String title, String authorName, String publisher, int year,String info) {
		super();
		this.isbn = isbn;
		this.title = title;
		this.authorName = authorName;
		this.publisher = publisher;
		this.year = year;
		this.info = info;
	}
	public Ebook(int isbn, String title, int author_id, String authorName, String publisher, int year, char available) {
		this.isbn = isbn;
		this.title = title;
		this.author_id = author_id;
		this.authorName = authorName;
		this.publisher = publisher;
		this.year = year;
		this.available = available;
	}
	
	public String getAuthorName() {
		return authorName;
	}
	public void setAuthorName(String authorName) {
		this.authorName = authorName;
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
	public int getAuthor_id() {
		return author_id;
	}
	public void setAuthor_id(int author_id) {
		this.author_id = author_id;
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
	public char getAvailable() {
		return available;
	}
	public void setAvailable(char available) {
		this.available = available;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	
}
