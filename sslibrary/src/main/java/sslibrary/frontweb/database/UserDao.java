package sslibrary.frontweb.database;

import sslibrary.frontweb.vo.Ebook;
import sslibrary.frontweb.vo.EbookDetail;
import sslibrary.frontweb.vo.Report;
import sslibrary.frontweb.vo.ReviewList;
import sslibrary.frontweb.vo.Reviews;
import sslibrary.frontweb.database.DBCon;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class UserDao {

	public List<Ebook> showAllBooks() {
	    List<Ebook> books = new ArrayList<>();
	    String sql = "SELECT e.isbn, e.title, e.AUTHOR_ID, a.name as authorName, e.publisher, e.year, e.available\r\n"
	    		+ "FROM EBOOK e \r\n"
	    		+ "JOIN AUTHORS a \r\n"
	    		+ "ON e.author_id = a.author_id";

	    try (
	        Connection con = DBCon.con();
	        PreparedStatement pstmt = con.prepareStatement(sql);
	        ResultSet rs = pstmt.executeQuery();
	    ) {
	        while (rs.next()) {
	            Ebook book = new Ebook(
	            		rs.getInt("isbn"),
	                    rs.getString("title"),
	                    rs.getInt("author_id"),
	                    rs.getString("authorName"),
	                    rs.getString("publisher"),
	                    rs.getInt("year"),
	                    rs.getString("available").charAt(0)
	            );
	            books.add(book);
	        }
	        System.out.println("조회된 데이터 수:"+books.size());
	    } catch (SQLException e) {
	        System.out.println("DB 에러: " + e.getMessage());
	    } catch (Exception e) {
	        System.out.println("일반 에러: " + e.getMessage());
	    }
	    return books;
	}
	
	/*
	 	SELECT e.isbn, e.title, e.AUTHOR_ID, a.name as authorName, e.publisher, e.year, e.available
		FROM EBOOK e 
		JOIN AUTHORS a 
		ON e.author_id = a.author_id
		WHERE e.TITLE LIKE'%전%'; 
	 */
	public List<Ebook> searchBooks(String keyword) {
	    List<Ebook> books = new ArrayList<>();
	    String sql = "SELECT e.isbn, e.title, e.AUTHOR_ID, a.name as authorName, e.publisher, e.year, e.available\r\n"
	    		+ "		FROM EBOOK e \r\n"
	    		+ "		JOIN AUTHORS a \r\n"
	    		+ "		ON e.author_id = a.author_id\r\n"
	    		+ "		WHERE e.TITLE LIKE ?";

	    try(Connection con = DBCon.con(); PreparedStatement pstmt = con.prepareStatement(sql);){
			// 처리코드1
			pstmt.setString(1, "%"+keyword+"%");
			try(ResultSet rs = pstmt.executeQuery();){
				//처리코드2
				while (rs.next()) {
		            Ebook book = new Ebook(
		            		rs.getInt("isbn"),
		                    rs.getString("title"),
		                    rs.getInt("author_id"),
		                    rs.getString("authorName"),
		                    rs.getString("publisher"),
		                    rs.getInt("year"),
		                    rs.getString("available").charAt(0)
		            );
		            books.add(book);
				}
			}
		}catch (SQLException e) {
	        System.out.println("DB 에러: " + e.getMessage());
	    } catch (Exception e) {
	        System.out.println("일반 에러: " + e.getMessage());
	    }
	    return books;
	}
	
	
	
	public Ebook getBookInfo(int isbn) {
		Ebook book = null;
		String sql="SELECT e.isbn, e.title, a.name as authorName, e.publisher, e.year, a.info\r\n"
				+ "FROM EBOOK e \r\n"
				+ "JOIN AUTHORS a ON e.author_id = a.author_id "
	            + "WHERE e.isbn = ?";
		// try(객체처리-연결;대화;결과){} : try resource 구문 파일이나 DB연결 자동 자원해제..
		try(Connection con = DBCon.con(); PreparedStatement pstmt = con.prepareStatement(sql);){
			// 처리코드1
			pstmt.setInt(1, isbn);
			try(ResultSet rs = pstmt.executeQuery();){
				//처리코드2
				if(rs.next()) {
					//int isbn, String title, String authorName, String publisher, int year
					book = new Ebook(
							rs.getInt("isbn"),
							rs.getString("title"),
							rs.getString("authorName"),
							rs.getString("publisher"),
							rs.getInt("year"),
							rs.getString("info")
							);
				}
			}
		}catch(SQLException e) {
			System.out.println("DB 에러:"+e.getMessage());
		}catch(Exception e) {
			System.out.println("일반 에러:"+e.getMessage());
		}
		return book; 
	}
	/*
	    SELECT a.LIKES ,a.THUMBS ,a.INFO 
		FROM EBOOK e
		JOIN EBOOK_DETAIL a ON e.ISBN =a.ISBN 
		WHERE e.isbn = 10006;
	 */
	public EbookDetail getBookDetail(int isbn) {
		EbookDetail bookd = null;
		String sql="SELECT a.LIKES ,a.THUMBS ,a.INFO \r\n"
				+ "		FROM EBOOK e\r\n"
				+ "		JOIN EBOOK_DETAIL a ON e.ISBN =a.ISBN \r\n"
				+ "		WHERE e.isbn = ?";
		// try(객체처리-연결;대화;결과){} : try resource 구문 파일이나 DB연결 자동 자원해제..
		try(Connection con = DBCon.con(); PreparedStatement pstmt = con.prepareStatement(sql);){
			// 처리코드1
			pstmt.setInt(1, isbn);
			try(ResultSet rs = pstmt.executeQuery();){
				//처리코드2
				if(rs.next()) {
					//int isbn, String title, String authorName, String publisher, int year
					bookd = new EbookDetail(
							rs.getInt("likes"),
							rs.getInt("thumbs"),
							rs.getString("info")
							);
				}
			}
		}catch(SQLException e) {
			System.out.println("DB 에러:"+e.getMessage());
		}catch(Exception e) {
			System.out.println("일반 에러:"+e.getMessage());
		}
		return bookd; 
	}
	
/*	UPDATE EBOOK_DETAIL 
  	SET LIKES  = LIKES  + 1
	WHERE ISBN = '10006';*/
	
	public int updateLikes(int isbn){
		int uptCnt = 0;
	      String sql = "UPDATE EBOOK_DETAIL \r\n"
	      		+ "  SET LIKES  = LIKES  + 1\r\n"
	      		+ "	WHERE ISBN = ?";
	      try( 
	            Connection con = DBCon.con();
	            PreparedStatement pstmt = con.prepareStatement(sql);){
	            	
	            	con.setAutoCommit(false);
	         // 처리코드1
	            	pstmt.setInt(1, isbn);
	    	  uptCnt=pstmt.executeUpdate();
	    	  if(uptCnt==0) {
	    		  System.out.println("좋아요실패");
	    		  con.rollback();
	    	  }else {
		        	con.commit(); // Commit the transaction
		        	System.out.println("좋아요+1");
		        }
	      }catch(SQLException e) {
	         System.out.println("DB 에러:"+e.getMessage());
	      }catch(Exception e) {
	         System.out.println("일반 에러:"+e.getMessage());
	      }
	      return uptCnt;
	   }
	public int updateThumbs(int isbn){
		int uptCnt = 0;
		String sql = "UPDATE EBOOK_DETAIL \r\n"
				+ "  SET thumbs  = thumbs  + 1\r\n"
				+ "	WHERE ISBN = ?";
		try( 
				Connection con = DBCon.con();
				PreparedStatement pstmt = con.prepareStatement(sql);){
			
			con.setAutoCommit(false);
			// 처리코드1
			pstmt.setInt(1, isbn);
			uptCnt=pstmt.executeUpdate();
			if(uptCnt==0) {
				System.out.println("추천실패");
				con.rollback();
			}else {
				con.commit(); // Commit the transaction
				System.out.println("추천+1");
			}
		}catch(SQLException e) {
			System.out.println("DB 에러:"+e.getMessage());
		}catch(Exception e) {
			System.out.println("일반 에러:"+e.getMessage());
		}
		return uptCnt;
	}
	
	/*
	 INSERT INTO rental 
	VALUES (?, ?, SYSDATE, SYSDATE + 7); 
	VALUES (10006, 3, SYSDATE, SYSDATE + 7); 
	 */
	
	public int insertRental(int isbn, int cno) {
		int insCnt = 0;
		String sql = "INSERT INTO rental (ISBN,CNO,RENTAL_DATE,RETURN_DATE)\r\n"
				+ "	VALUES (?, ?, SYSDATE, SYSDATE + 7)";
		try (Connection con = DBCon.con(); PreparedStatement pstmt = con.prepareStatement(sql);) {
			con.setAutoCommit(false);
			// 처리코드1
			pstmt.setInt(1, isbn);
			pstmt.setInt(2, cno);
			insCnt = pstmt.executeUpdate();
			con.commit();
		} catch (SQLException e) {
			System.out.println("DB 에러:" + e.getMessage());
//			con.rollback();
			
		} catch (Exception e) {
			System.out.println("일반 에러:" + e.getMessage());
		}		
		return insCnt;
	}
	
	/*
	 INSERT INTO REVIEWS (ISBN,CNO,STAR_RATING,REVIEW_CONTENT,REVIEW_DATE)
	VALUES (10009, 5, 4, TO_CLOB('내용이 너무 유익했어요~'), SYSDATE);
	 */
	public int insertReviews(Reviews rew) {
		int insCnt = 0;
		String sql = "INSERT INTO REVIEWS (RNO,ISBN,CNO,STAR_RATING,REVIEW_CONTENT,REVIEW_DATE)\r\n"
				+ "	VALUES (rno_seq.nextval, ?, ?, ?, TO_CLOB(?), SYSDATE)";
		try (Connection con = DBCon.con(); PreparedStatement pstmt = con.prepareStatement(sql);) {
			con.setAutoCommit(false);
			// 처리코드1
			pstmt.setInt(1, rew.getIsbn());
			pstmt.setInt(2, rew.getCno());
			pstmt.setInt(3, rew.getStar());
			pstmt.setString(4, rew.getReview());
			insCnt = pstmt.executeUpdate();
			con.commit();
		} catch (SQLException e) {
			System.out.println("DB 에러:" + e.getMessage());
//			con.rollback();
			
		} catch (Exception e) {
			System.out.println("일반 에러:" + e.getMessage());
		}		
		return insCnt;
	}
	/*
	    SELECT c.ID , r.REVIEW_CONTENT AS review , r.STAR_RATING AS star
		FROM CUSTOMER c JOIN REVIEWS r 
		ON c.CNO = r.CNO 
		WHERE r.ISBN =10004;
	  
	 */
	public List<ReviewList> showReviews(int isbn){
		List<ReviewList> reL = new ArrayList<ReviewList>();
		String sql="SELECT r.rno, c.ID , r.REVIEW_CONTENT AS review , r.STAR_RATING AS star\r\n"
				+ "FROM CUSTOMER c JOIN REVIEWS r \r\n"
				+ "ON c.CNO = r.CNO \r\n"
				+ "WHERE r.ISBN =?";
	// try(객체처리-연결;대화;결과){} : try resource 구문 파일이나 DB연결 자동 자원해제..
	try(
			Connection con=DBCon.con();
			PreparedStatement pstmt= con.prepareStatement(sql);
			
		){
		pstmt.setInt(1, isbn);
		try(
			ResultSet rs=pstmt.executeQuery();
			){
			while (rs.next()) {
	        	ReviewList re = new ReviewList(
	        			rs.getInt("rno"),
	        			rs.getString("id"),
	        			rs.getString("review"),
	            		rs.getInt("star")
	            );
	            reL.add(re);
	        }
			System.out.println("리뷰데이터건수 :"+reL.size());
		}
		
	}catch (SQLException e) {
		System.out.println("DB 예외:"+e.getMessage());
	} catch (Exception e) {
		System.out.println("일반 예외:"+e.getMessage());
	}
	return reL;
	}
	/*
	 INSERT INTO Reports (rno,cno,reason)
	VALUES (1, 2,'개인정보노출');
	 */
	public int deleteThumbs(int isbn){
		int uptCnt = 0;
		String sql = "UPDATE EBOOK_DETAIL \r\n"
				+ "  SET thumbs  = thumbs  + 1\r\n"
				+ "	WHERE ISBN = ?";
		try( 
				Connection con = DBCon.con();
				PreparedStatement pstmt = con.prepareStatement(sql);){
			
			con.setAutoCommit(false);
			// 처리코드1
			pstmt.setInt(1, isbn);
			uptCnt=pstmt.executeUpdate();
			if(uptCnt==0) {
				System.out.println("추천실패");
				con.rollback();
			}else {
				con.commit(); // Commit the transaction
				System.out.println("추천+1");
			}
		}catch(SQLException e) {
			System.out.println("DB 에러:"+e.getMessage());
		}catch(Exception e) {
			System.out.println("일반 에러:"+e.getMessage());
		}
		return uptCnt;
	}
	/*
	 DELETE FROM REVIEWS
	 WHERE rno=1;
	 */
	public int deleteReview(int rno){
		int uptCnt = 0;
		String sql = "DELETE FROM REVIEWS\r\n"
				+ "	 WHERE rno=?";
		try( 
				Connection con = DBCon.con();
				PreparedStatement pstmt = con.prepareStatement(sql);){
			
			con.setAutoCommit(false);
			// 처리코드1
			pstmt.setInt(1, rno);
			uptCnt=pstmt.executeUpdate();
			if(uptCnt==0) {
				System.out.println("삭제실패");
				con.rollback();
			}else {
				con.commit(); // Commit the transaction
				System.out.println("삭제성공");
			}
		}catch(SQLException e) {
			System.out.println("DB 에러:"+e.getMessage());
		}catch(Exception e) {
			System.out.println("일반 에러:"+e.getMessage());
		}
		return uptCnt;
	}
	/*
	 INSERT INTO Reports (rno,cno,reason)
	VALUES (1, 2,'개인정보노출');
	 */
	public int insertReport(Report rep) {
		int insCnt = 0;
		String sql = "INSERT INTO Reports (rno,cno,reason)\r\n"
				+ "	VALUES (?, ?, ?)";
		try (Connection con = DBCon.con(); PreparedStatement pstmt = con.prepareStatement(sql);) {
			con.setAutoCommit(false);
			// 처리코드1
			pstmt.setInt(1, rep.getRno());
			pstmt.setInt(2, rep.getCno());
			pstmt.setString(3, rep.getReason());
			insCnt = pstmt.executeUpdate();
			con.commit();
		} catch (SQLException e) {
			System.out.println("DB 에러:" + e.getMessage());
//			con.rollback();
			
		} catch (Exception e) {
			System.out.println("일반 에러:" + e.getMessage());
		}		
		return insCnt;
	}
}
	
