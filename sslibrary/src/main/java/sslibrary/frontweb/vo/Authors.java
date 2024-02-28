package sslibrary.frontweb.vo;
/*
 * CREATE TABLE AUTHORS (
    author_id NUMBER PRIMARY KEY,
    name VARCHAR2(100)
);
 * */
public class Authors {
	private int author_id;
	private String name;
	public Authors() {
		// TODO Auto-generated constructor stub
	}
	public Authors(int author_id, String name) {
		this.author_id = author_id;
		this.name = name;
	}
	public int getAuthor_id() {
		return author_id;
	}
	public void setAuthor_id(int author_id) {
		this.author_id = author_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	
}
