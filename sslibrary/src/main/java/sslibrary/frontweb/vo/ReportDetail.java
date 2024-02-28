package sslibrary.frontweb.vo;

import java.util.Date;

public class ReportDetail {
	private int rno;
	private String content;
	private Date rdate;
	private String reporter;
	private String reason;
	public ReportDetail() {
		// TODO Auto-generated constructor stub
	}
	public ReportDetail(int rno, String content, Date rdate, String reporter, String reason) {
		this.rno = rno;
		this.content = content;
		this.rdate = rdate;
		this.reporter = reporter;
		this.reason = reason;
	}
	public int getRno() {
		return rno;
	}
	public void setRno(int rno) {
		this.rno = rno;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getRdate() {
		return rdate;
	}
	public void setRdate(Date rdate) {
		this.rdate = rdate;
	}
	public String getReporter() {
		return reporter;
	}
	public void setReporter(String reporter) {
		this.reporter = reporter;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	
	
}
