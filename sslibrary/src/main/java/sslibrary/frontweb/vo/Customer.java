package sslibrary.frontweb.vo;
/*
import ="sslibrary.frontweb.vo.*"
 * */
public class Customer {
	private int cno;
	private String id;
	private String password;
	private String name;
	private String email;
	private String phone;
	public Customer() {
		// TODO Auto-generated constructor stub
	}
	
	public Customer(int cno, String id, String name, String email, String phone) {
		this.cno = cno;
		this.id = id;
		this.name = name;
		this.email = email;
		this.phone = phone;
	}

	public Customer(int cno, String id, String password, String name, String email, String phone) {
		this.cno = cno;
		this.id = id;
		this.password = password;
		this.name = name;
		this.email = email;
		this.phone = phone;
	}
	public int getCno() {
		return cno;
	}
	public void setCno(int cno) {
		this.cno = cno;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	
}
