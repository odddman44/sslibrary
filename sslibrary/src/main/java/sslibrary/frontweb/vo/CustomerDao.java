package sslibrary.frontweb.vo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import sslibrary.frontweb.database.DBCon;

public class CustomerDao {

	public int insertCustomer(Customer ins) {
		int insCnt =0;
		String sql = "	INSERT INTO Customer values(cno_seq.nextval,\r\n"
				+ "			?,?,?,?,?)";
		try (Connection con = DBCon.con(); PreparedStatement pstmt = con.prepareStatement(sql);) {
			con.setAutoCommit(false);
			pstmt.setString(1, ins.getId());
			pstmt.setString(2, ins.getPassword());
			pstmt.setString(3, ins.getName());
			pstmt.setString(4, ins.getEmail());
			pstmt.setString(5, ins.getPhone());
			insCnt = pstmt.executeUpdate();
			if (insCnt == 0) {
				System.out.println("등록 실패");
				con.rollback();
			} else {
				con.commit(); 
				System.out.println("등록 성공");
			}
		} catch (SQLException e) {
			System.out.println("DB 에러:" + e.getMessage());
		} catch (Exception e) {
			System.out.println("일반 에러:" + e.getMessage());
		}
		
		return insCnt;
	}
}
