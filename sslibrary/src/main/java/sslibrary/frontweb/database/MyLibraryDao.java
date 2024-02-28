package sslibrary.frontweb.database;

import java.util.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import sslibrary.frontweb.vo.*;

public class MyLibraryDao {

	public Object templateRead(String dname) { // read templete
		Object ob = new Object();
		String sql = "select deptno,dname,loc from dept where dname like ?";
		// try(객체처리-연결;대화;결과){} : try resource 구문 파일이나 DB연결 자동 자원해제..
		try (Connection con = DBCon.con(); PreparedStatement pstmt = con.prepareStatement(sql);) {
			// 처리코드1
			pstmt.setString(1, "%" + dname + "%");
			try (ResultSet rs = pstmt.executeQuery();) {
				// 처리코드2
				rs.next();
			}
		} catch (SQLException e) {
			System.out.println("DB 에러:" + e.getMessage());
		} catch (Exception e) {
			System.out.println("일반 에러:" + e.getMessage());
		}
		return ob;
	}

	public int updateCustomer(Customer upt) { // 회원정보수정 dao
		int uptCnt = 0;
		String sql = "UPDATE CUSTOMER SET\r\n" + "	password = ?,\r\n" + "	email = ?,\r\n" + "	PHONE = ? \r\n"
				+ "	WHERE id=?";
		try (Connection con = DBCon.con(); PreparedStatement pstmt = con.prepareStatement(sql);

		) {
			con.setAutoCommit(false);
			// 처리코드1
			pstmt.setString(1, upt.getPassword());
			pstmt.setString(2, upt.getEmail());
			pstmt.setString(3, upt.getPhone());
			pstmt.setString(4, upt.getId());

			uptCnt = pstmt.executeUpdate();
			if (uptCnt == 0) {
				System.out.println("수정 실패");
				con.rollback();
			} else {
				System.out.println("수정 성공");
				con.commit();
			}

		} catch (SQLException e) {
			System.out.println("DB 에러 : " + e.getMessage());
		} catch (Exception e) {
			System.out.println("일반 에러 : " + e.getMessage());
		}

		return uptCnt;
	}

	public int deleteCustomerByCno(int cno) { // 회원탈퇴 dao 메서드
		int delCnt = 0;
		String sql = "DELETE FROM customer WHERE cno = ? ";
		try (Connection con = DBCon.con(); PreparedStatement pstmt = con.prepareStatement(sql);

		) {
			con.setAutoCommit(false);
			// 처리코드1
			pstmt.setInt(1, cno);
			delCnt = pstmt.executeUpdate();

			if (delCnt == 0) {
				System.out.println("삭제 실패");
				con.rollback();
			} else {
				con.commit();
				System.out.println("삭제 성공");
			}

		} catch (SQLException e) {
			System.out.println("DB 에러 : " + e.getMessage());
		} catch (Exception e) {
			System.out.println("일반 에러 : " + e.getMessage());
		}

		return delCnt;
	}

	
	public List<RentalInfoWithBook> getRentalInfoByCno(int cno){
		List<RentalInfoWithBook> rlist = new ArrayList<RentalInfoWithBook>();
		String sql = "SELECT e.ISBN ,e.TITLE, e.PUBLISHER, e.\"YEAR\",  a.NAME, r.RENTAL_DATE, r.RETURN_DATE   \r\n"
				+ "FROM RENTAL r, EBOOK e, AUTHORS a \r\n"
				+ "WHERE cno = ? AND r.isReturn='N' AND r.ISBN = e.ISBN AND e.AUTHOR_ID = a.AUTHOR_ID" ;
		try( 
				Connection con = DBCon.con();
				PreparedStatement pstmt = con.prepareStatement(sql);
			){
			// 처리코드1
			pstmt.setInt(1,cno);
			try( 
				ResultSet rs = pstmt.executeQuery();
				){
				//처리코드2
				while(rs.next()) {
					rlist.add(new RentalInfoWithBook(
								rs.getInt("isbn"),
								rs.getString("title"),
								rs.getString("publisher"),
								rs.getInt("year"),
								rs.getString("name"),
								rs.getDate("rental_date"),
								rs.getDate("return_date")
							));
				}
			}
		}catch(SQLException e) {
			System.out.println("DB 에러:"+e.getMessage());
		}catch(Exception e) {
			System.out.println("일반 에러:"+e.getMessage());
		}
		
		return rlist;
		
	}
	

	public int delayReturnDate(int cno, int isbn) { // rental table에서 해당하는 isbn과 cno를 받아서 return_date에 7일 더하기
		int uptCnt = 0;
		String sql = "UPDATE RENTAL SET RETURN_DATE = RETURN_DATE + INTERVAL '7' DAY\r\n"
				+ "WHERE cno= ? AND ISBN = ?";
		try (Connection con = DBCon.con(); PreparedStatement pstmt = con.prepareStatement(sql);
	
		) {
			con.setAutoCommit(false);
			// 처리코드1
			pstmt.setInt(1, cno);						
			pstmt.setInt(2, isbn);
			
			uptCnt = pstmt.executeUpdate();
			if (uptCnt == 0) {
				System.out.println("수정 실패");
				con.rollback();
			}
			else {
				System.out.println("수정 성공");
				con.commit();
			}
	
			
	
		} catch (SQLException e) {
			System.out.println("DB 에러 : " + e.getMessage());
		} catch (Exception e) {
			System.out.println("일반 에러 : " + e.getMessage());
		}
	
		return uptCnt;
	}
	
	public int returnBook(int isbn, int cno) { // 책 반납 DAO
		int uptCnt = 0;
		
		String sql = "UPDATE RENTAL SET \r\n"
				+ "ISRETURN = 'Y', RETURN_DATE = SYSDATE \r\n"
				+ "WHERE ISBN = ? AND cno = ?";
		try (Connection con = DBCon.con(); PreparedStatement pstmt = con.prepareStatement(sql);
				
				) {
					con.setAutoCommit(false);
					// 처리코드1
					pstmt.setInt(1, isbn);						
					pstmt.setInt(2, cno);
					
					uptCnt = pstmt.executeUpdate();
					if (uptCnt == 0) {
						System.out.println("수정 실패");
						con.rollback();
					}
					else {
						System.out.println("수정 성공");
						con.commit();
					}
			
					
			
				} catch (SQLException e) {
					System.out.println("DB 에러 : " + e.getMessage());
				} catch (Exception e) {
					System.out.println("일반 에러 : " + e.getMessage());
				}
			
		return uptCnt;
	}
	


	public List<RentalInfoWithBook> getRentalByCno(int cno) { // 현재 대출 목록
		List<RentalInfoWithBook> rlist = new ArrayList<RentalInfoWithBook>();
		String sql = "SELECT e.TITLE, e.PUBLISHER, e.\"YEAR\", a.NAME, r.CNO , r.RENTAL_DATE , r.RETURN_DATE  \r\n"
				+ "FROM RENTAL r, EBOOK e , AUTHORS a \r\n"
				+ "WHERE r.ISBN = e.ISBN AND r.CNO = ? AND e.AUTHOR_ID = a.AUTHOR_ID ORDER BY RENTAL_DATE";
		try (Connection con = DBCon.con(); PreparedStatement pstmt = con.prepareStatement(sql);) {
			// 처리코드1
			pstmt.setInt(1, cno);
			try (ResultSet rs = pstmt.executeQuery();) {
				// 처리코드2
				while(rs.next()) {
					rlist.add(new RentalInfoWithBook(
						rs.getInt("isbn"),
						rs.getString("title"),
						rs.getString("publisher"),
						rs.getInt("year"),
						rs.getString("name"),
						rs.getDate("rental_date"),
						rs.getDate("return_date")
							
							));
					
				}
			}
		} catch (SQLException e) {
			System.out.println("DB 에러:" + e.getMessage());
		} catch (Exception e) {
			System.out.println("일반 에러:" + e.getMessage());
		}
		System.out.println("검색된 데이터:"+rlist.size());
		
		return rlist;
	}

	public List<RentalInfoWithBook> getPreRentalInfoByCno(int cno, String start_date, String end_date){ // 이전 대출 내역 조회
		List<RentalInfoWithBook> rlist = new ArrayList<RentalInfoWithBook>();
		String sql = "SELECT e.ISBN ,e.TITLE, e.PUBLISHER, e.\"YEAR\",  a.NAME, r.RENTAL_DATE, r.RETURN_DATE   \r\n"
				+ "FROM RENTAL r, EBOOK e, AUTHORS a \r\n"
				+ "WHERE cno = ? AND r.isReturn='Y' AND r.ISBN = e.ISBN AND e.AUTHOR_ID = a.AUTHOR_ID" ;
		if(start_date!=null && end_date!=null) {
			sql+= " AND r.RENTAL_DATE BETWEEN to_date(?, 'YYYY-MM-DD') AND to_date(?, 'YYYY-MM-DD') ";
		}
		
		try( 
				Connection con = DBCon.con();
				PreparedStatement pstmt = con.prepareStatement(sql);
			){
			// 처리코드1
			pstmt.setInt(1,cno);
			if((start_date!=null && end_date!=null && !start_date.isEmpty() && !end_date.isEmpty())) {
				 pstmt.setString(2, start_date);
				 pstmt.setString(3, end_date);
			}
			try( 
				ResultSet rs = pstmt.executeQuery();
				){
				//처리코드2
				while(rs.next()) {
					rlist.add(new RentalInfoWithBook(
								rs.getInt("isbn"),
								rs.getString("title"),
								rs.getString("publisher"),
								rs.getInt("year"),
								rs.getString("name"),
								rs.getDate("rental_date"),
								rs.getDate("return_date")
							));
				}
			}
		}catch(SQLException e) {
			System.out.println("DB 에러:"+e.getMessage());
		}catch(Exception e) {
			System.out.println("일반 에러:"+e.getMessage());
		}
		System.out.println("검색된 데이터 개수"+rlist.size());
		
		return rlist;
		
	}
	public List<ReviewDTO> getReviewByCno(int cno){ // 회원이 작성한 리뷰 불러오기
		 List<ReviewDTO> rlist = new  ArrayList<ReviewDTO>();
		 String sql = "SELECT e.TITLE, e.PUBLISHER, a.NAME, r.REVIEW_CONTENT, r.STAR_RATING, r.REVIEW_DATE  \r\n"
		 		+ "FROM EBOOK e, AUTHORS a,  REVIEWS r\r\n"
		 		+ "WHERE r.CNO = ? AND r.ISBN = e.ISBN AND e.AUTHOR_ID =a.AUTHOR_ID";
		 try (Connection con = DBCon.con(); PreparedStatement pstmt = con.prepareStatement(sql);) {
				// 처리코드1
				pstmt.setInt(1, cno);
				try (ResultSet rs = pstmt.executeQuery();) {
					// 처리코드2
					while(rs.next()) {
						rlist.add(new ReviewDTO(
							rs.getString("title"),
							rs.getString("publisher"),
							rs.getString("name"),
							rs.getString("review_content"),
							rs.getInt("star_rating"),
							rs.getDate("review_date")
								
								));
						
					}
				}
			} catch (SQLException e) {
				System.out.println("DB 에러:" + e.getMessage());
			} catch (Exception e) {
				System.out.println("일반 에러:" + e.getMessage());
			}
			System.out.println("검색된 데이터:"+rlist.size());
		 return rlist;
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		MyLibraryDao dao = new MyLibraryDao();

		List<RentalInfoWithBook> rlist = dao.getRentalByCno(3);
		for(RentalInfoWithBook r:rlist) {
			System.out.println("책 제목"+r.getTitle());
			System.out.println("출판사"+r.getPublisher());
			System.out.println("출판년도"+r.getYear());
			System.out.println("작가명"+r.getName());
			System.out.println("대출일자"+r.getRental_date());
			System.out.println("책 제목"+r.getReturn_date());
		}

		dao.getPreRentalInfoByCno(3, "2023-12-01", "2023-12-06");


	}
}
