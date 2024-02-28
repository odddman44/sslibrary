package sslibrary.frontweb.vo;

public class Report {

	private int rno;
	private int cno;
	private String reason;
	public Report() {
		// TODO Auto-generated constructor stub
	}
	public Report(int rno, int cno, String reason) {
		super();
		this.rno = rno;
		this.cno = cno;
		this.reason = reason;
	}
	public int getRno() {
		return rno;
	}
	public void setRno(int rno) {
		this.rno = rno;
	}
	public int getCno() {
		return cno;
	}
	public void setCno(int cno) {
		this.cno = cno;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	
	
}
