package sslibrary.frontweb.database;

// import="sslibrary.frontweb.database.AdminDao"

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import sslibrary.frontweb.database.DBCon;
import sslibrary.frontweb.vo.Customer;
import sslibrary.frontweb.vo.Ebook;
import sslibrary.frontweb.vo.RentalInfoForAdmin;
import sslibrary.frontweb.vo.ReportDetail;

public class AdminDao {

	/**
	 ** 사용할 템플릿 ** 
	 * */
	public Object templateRead(String dname){
		Object ob = new Object();
		String sql = "select deptno,dname,loc from dept where dname like ?";
		// try(객체처리-연결;대화;결과){} : try resource 구문 파일이나 DB연결 자동 자원해제..
		try( 
				Connection con = DBCon.con();
				PreparedStatement pstmt = con.prepareStatement(sql);
			){
			// 처리코드1
			pstmt.setString(1,"%"+dname+"%");
			try( 
				ResultSet rs = pstmt.executeQuery();
				){
				//처리코드2
				rs.next();
			}
		}catch(SQLException e) {
			System.out.println("DB 에러:"+e.getMessage());
		}catch(Exception e) {
			System.out.println("일반 에러:"+e.getMessage());
		}
		return ob;
	}
	
	public int templateCUD(String ename){
	    int cudCnt = 0;
	    String sql = "INSERT INTO emp01(ename) values(?)";
	    try (Connection con = DBCon.con(); PreparedStatement pstmt = con.prepareStatement(sql);) {
	        con.setAutoCommit(false);
	        // 처리코드1
	        pstmt.setString(1, ename);
	        

	        cudCnt = pstmt.executeUpdate();
	        if(cudCnt == 0) {
	        	System.out.println("CUD 실패");
	        	con.rollback();
	        }else {
	        	con.commit(); // Commit the transaction
	        	System.out.println("CUD 성공");
	        }
	    } catch (SQLException e) {
	        System.out.println("DB 에러:" + e.getMessage());
	    } catch (Exception e) {
	        System.out.println("일반 에러:" + e.getMessage());
	    }
		return cudCnt;
	}
	
	/* 회원정보조회 메서드 */
	public List<Customer> schCustomer(String id, String name){
		List<Customer> memList = new ArrayList<Customer>();
		String sql = "SELECT * FROM CUSTOMER \r\n"
				+ "WHERE id LIKE ? OR name LIKE ?"
				+ "ORDER BY cno";
		// try(객체처리-연결;대화;결과){} : try resource 구문 파일이나 DB연결 자동 자원해제..
		try( 
				Connection con = DBCon.con();
				PreparedStatement pstmt = con.prepareStatement(sql);
			){
			// 처리코드1
			pstmt.setString(1,"%"+id+"%");
			pstmt.setString(2,"%"+name+"%");
			try(ResultSet rs = pstmt.executeQuery();){
				//처리코드2
				while(rs.next()) {
					memList.add(new Customer(
							rs.getInt("cno"),
							rs.getString("id"),
							rs.getString("password"),
							rs.getString("name"),
							rs.getString("email"),
							rs.getString("phone")
							));
				}
				System.out.println("조회된 데이터 수:"+memList.size());
			}
		}catch(SQLException e) {
			System.out.println("DB 에러:"+e.getMessage());
		}catch(Exception e) {
			System.out.println("일반 에러:"+e.getMessage());
		}
		return memList;
	}
	
	/*새 도서정보 추가 메서드*/
	public int addNewBook(String title, String authorName, String publisher, int year) {
		int cudCnt = 0;
		Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    try {
	        con = DBCon.con();
	        con.setAutoCommit(false);

	        // 1. 작가명 조회
	        int authorId = 0;
	        String sqlSelectAuthor = "SELECT author_id FROM AUTHORS WHERE name = ?";
	        pstmt = con.prepareStatement(sqlSelectAuthor);
	        pstmt.setString(1, authorName);
	        rs = pstmt.executeQuery();
	        
	        if (rs.next()) {
	            // 작가가 존재하는 경우, author_id 사용
	            authorId = rs.getInt("author_id");
	        } else {
	            // 작가가 존재하지 않는 경우, 새로운 작가 추가
	            String sqlInsertAuthor = "INSERT INTO AUTHORS (name) VALUES (?)";
	            pstmt = con.prepareStatement(sqlInsertAuthor, new String[] {"author_id"});
	            pstmt.setString(1, authorName);
	            pstmt.executeUpdate();
	            rs = pstmt.getGeneratedKeys();
	            if (rs.next()) {
	                authorId = rs.getInt(1);
	            }
	        }

	        // 2. 도서 정보 추가
	        String sqlInsertBook = "INSERT INTO EBOOK (isbn, title, author_id, publisher, year, available) VALUES (isbn_seq.NEXTVAL, ?, ?, ?, ?, 'Y')";
	        pstmt = con.prepareStatement(sqlInsertBook);
	        pstmt.setString(1, title);
	        pstmt.setInt(2, authorId);
	        pstmt.setString(3, publisher);
	        pstmt.setInt(4, year);
	        cudCnt = pstmt.executeUpdate();

	        if (cudCnt > 0) {
	            con.commit();
	            System.out.println("도서 추가 성공");
	        } else {
	            con.rollback();
	            System.out.println("도서 추가 실패");
	        }
	    } catch (SQLException e) {
	        System.out.println("DB 에러: " + e.getMessage());
	        if (con != null) {
	            try {
	                con.rollback();
	            } catch (SQLException ex) {
	                System.out.println("Rollback 에러:" + ex.getMessage());
	            }
	        }
	    } catch (Exception e) {
	        System.out.println("일반 에러: " + e.getMessage());
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (pstmt != null) pstmt.close();
	            if (con != null) con.close();
	        } catch (SQLException e) {
	            System.out.println("자원 해제 에러:" + e.getMessage());
	        }
	    }
	    return cudCnt;
	}
	
	/* 새 도서정보 추가 메서드2 */
	public int addNewBook2(String title, String authorName, String publisher, int year, String authorInfo, String ebookDetailInfo) {
	    int cudCnt = 0;
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    try {
	        con = DBCon.con();
	        con.setAutoCommit(false);

	        // 1. 작가명 조회 및 추가
	        int authorId = 0;
	        String sqlSelectAuthor = "SELECT author_id FROM AUTHORS WHERE name = ?";
	        pstmt = con.prepareStatement(sqlSelectAuthor);
	        pstmt.setString(1, authorName);
	        rs = pstmt.executeQuery();
	        
	        if (rs.next()) {
	            // 작가가 존재하는 경우, author_id 사용
	            authorId = rs.getInt("author_id");
	        } else {
	            // 작가가 존재하지 않는 경우, 새로운 작가 추가
	            String sqlInsertAuthor = "INSERT INTO AUTHORS (name, info) VALUES (?, ?)";
	            pstmt = con.prepareStatement(sqlInsertAuthor, new String[] {"author_id"});
	            pstmt.setString(1, authorName);
	            pstmt.setString(2, authorInfo); // 작가 소개 추가
	            pstmt.executeUpdate();
	            rs = pstmt.getGeneratedKeys();
	            if (rs.next()) {
	                authorId = rs.getInt(1);
	            }
	        }

	        // 2. 도서 정보 추가
	        String sqlInsertBook = "INSERT INTO EBOOK (isbn, title, author_id, publisher, year, available) VALUES (isbn_seq.NEXTVAL, ?, ?, ?, ?, 'Y')";
	        pstmt = con.prepareStatement(sqlInsertBook, new String[] {"isbn"});
	        pstmt.setString(1, title);
	        pstmt.setInt(2, authorId);
	        pstmt.setString(3, publisher);
	        pstmt.setInt(4, year);
	        cudCnt = pstmt.executeUpdate();
	        rs = pstmt.getGeneratedKeys();
	        int isbn = 0;
	        if (rs.next()) {
	            isbn = rs.getInt(1);
	        }

	        // 3. 도서 상세 정보 추가
	        if (isbn != 0) {
	            String sqlInsertEbookDetail = "INSERT INTO EBOOK_DETAIL (isbn, info) VALUES (?, ?)";
	            pstmt = con.prepareStatement(sqlInsertEbookDetail);
	            pstmt.setInt(1, isbn);
	            pstmt.setString(2, ebookDetailInfo); // 도서 상세 정보 추가
	            cudCnt += pstmt.executeUpdate();
	        }

	        if (cudCnt == 2) {
	            con.commit();
	            System.out.println("도서 추가 성공");
	        } else {
	            con.rollback();
	            System.out.println("도서 추가 실패");
	        }
	    } catch (SQLException e) {
	        System.out.println("DB 에러: " + e.getMessage());
	        try {
	            if (con != null) {
	                con.rollback();
	            }
	        } catch (SQLException ex) {
	            System.out.println("Rollback 에러: " + ex.getMessage());
	        }
	    } catch (Exception e) {
	        System.out.println("일반 에러: " + e.getMessage());
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (pstmt != null) pstmt.close();
	            if (con != null) con.close();
	        } catch (SQLException e) {
	            System.out.println("자원 해제 에러: " + e.getMessage());
	        }
	    }
	    return cudCnt;
	}
	
	/* 추가할 도서 중복 여부 확인!! */
	public boolean isBookExists(String title, String authorName, String publisher, int year) {
	    boolean exists = false;
	    String sql = "SELECT COUNT(*) FROM EBOOK WHERE title = ? AND author_id IN (SELECT author_id FROM AUTHORS WHERE name = ?) AND publisher = ? AND year = ?";
	    
	    try (
	        Connection con = DBCon.con();
	        PreparedStatement pstmt = con.prepareStatement(sql);
	    ) {
	        pstmt.setString(1, title);
	        pstmt.setString(2, authorName);
	        pstmt.setString(3, publisher);
	        pstmt.setInt(4, year);

	        try (ResultSet rs = pstmt.executeQuery()) {
	            if (rs.next() && rs.getInt(1) > 0) {
	                exists = true;
	            }
	        }
	    } catch (SQLException e) {
	        System.out.println("DB 에러: " + e.getMessage());
	    } catch (Exception e) {
	        System.out.println("일반 에러: " + e.getMessage());
	    }
	    return exists;
	}

	/*전체 도서 목록 조회 메서드*/
	//int isbn, String title, int author_id, String authorName, String publisher, int year, char available
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
	
	/* 책 상세정보 조회*/
	public Ebook getBookInfo(int isbn) {
		Ebook book = null;
		String sql="SELECT e.isbn, e.title, a.name as authorName, e.publisher, e.year\r\n"
				+ "FROM EBOOK e \r\n"
				+ "JOIN AUTHORS a ON e.author_id = a.author_id "
	            + "WHERE e.isbn = ?";
		// try(객체처리-연결;대화;결과){} : try resource 구문 파일이나 DB연결 자동 자원해제..
		try(Connection con = DBCon.con(); PreparedStatement pstmt = con.prepareStatement(sql);){
			con.setAutoCommit(false);
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
							rs.getInt("year")
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
	/* 책 정보 업데이트 
	 *  UPDATE EBOOK
		SET title = ?, publisher = ?, year = ?
		WHERE isbn = ?;
		
		UPDATE AUTHORS
		SET name = ?
		WHERE author_id = (SELECT author_id FROM EBOOK WHERE isbn = ?);
	 * */
	public int updateBook(Ebook upt) {
	    int uptCnt = 0;
	    Connection con = null;
	    PreparedStatement pstmt = null;

	    try {
	        con = DBCon.con();
	        con.setAutoCommit(false);

	        // EBOOK 테이블 업데이트
	        String sqlEbook = "UPDATE EBOOK SET title = ?, publisher = ?, year = ? WHERE isbn = ?";
	        pstmt = con.prepareStatement(sqlEbook);
	        pstmt.setString(1, upt.getTitle());
	        pstmt.setString(2, upt.getPublisher());
	        pstmt.setInt(3, upt.getYear());
	        pstmt.setInt(4, upt.getIsbn());
	        uptCnt = pstmt.executeUpdate();

	        // AUTHORS 테이블 업데이트
	        String sqlAuthor = "UPDATE AUTHORS SET name = ? WHERE author_id = (SELECT author_id FROM EBOOK WHERE isbn = ?)";
	        pstmt = con.prepareStatement(sqlAuthor);
	        pstmt.setString(1, upt.getAuthorName());
	        pstmt.setInt(2, upt.getIsbn());
	        uptCnt += pstmt.executeUpdate();

	        // 트랜잭션 커밋 또는 롤백
	        if (uptCnt == 2) { // 두 개의 업데이트 모두 성공했는지 확인
	            con.commit();
	            System.out.println("수정 성공");
	        } else {
	            con.rollback();
	            System.out.println("수정 실패");
	        }
	    } catch (SQLException e) {
	        System.out.println("DB 에러: " + e.getMessage());
	        try {
	            if (con != null) {
	                con.rollback();
	            }
	        } catch (SQLException ex) {
	            System.out.println("롤백 에러: " + ex.getMessage());
	        }
	    } catch (Exception e) {
	        System.out.println("일반 에러: " + e.getMessage());
	    } finally {
	        try {
	            if (pstmt != null) pstmt.close();
	            if (con != null) con.close();
	        } catch (SQLException e) {
	            System.out.println("자원 해제 에러: " + e.getMessage());
	        }
	    }

	    return uptCnt;
	}
	
	/* 책 삭제 처리 메서드*/
	public int deleteBook(int isbn) {
	    int delCnt = 0;
	    Connection con = null;
	    PreparedStatement pstmt = null;

	    try {
	        con = DBCon.con();
	        con.setAutoCommit(false); // 트랜잭션 시작
	        // 도서와 관련된 자식 레코드 삭제
	        // 1. Ebook_detail 테이블에서 도서 관련 레코드 삭제
	        String sqlDelEbookDetail = "DELETE FROM EBOOK_DETAIL WHERE isbn = ?";
	        pstmt = con.prepareStatement(sqlDelEbookDetail);
	        pstmt.setInt(1, isbn);
	        delCnt += pstmt.executeUpdate();

	        // 2. Reviews 테이블에서 도서 관련 리뷰 삭제
	        String sqlDelReviews = "DELETE FROM REVIEWS WHERE isbn = ?";
	        pstmt = con.prepareStatement(sqlDelReviews);
	        pstmt.setInt(1, isbn);
	        delCnt += pstmt.executeUpdate();

	        // 3. Rental 테이블에서 도서 관련 대출 기록 삭제
	        String sqlDelRental = "DELETE FROM RENTAL WHERE isbn = ?";
	        pstmt = con.prepareStatement(sqlDelRental);
	        pstmt.setInt(1, isbn);
	        delCnt += pstmt.executeUpdate();
	        
	        // EBOOK 테이블에서 특정 ISBN의 도서 삭제
	        String sqlDelBook = "DELETE FROM EBOOK WHERE isbn = ?";
	        pstmt = con.prepareStatement(sqlDelBook);
	        pstmt.setInt(1, isbn);
	        delCnt = pstmt.executeUpdate();

	        // AUTHORS 테이블에서 연결된 도서가 없는 작가 삭제
	        String sqlDelAuthor = "DELETE FROM AUTHORS WHERE author_id NOT IN (SELECT DISTINCT author_id FROM EBOOK)";
	        pstmt = con.prepareStatement(sqlDelAuthor);
	        delCnt += pstmt.executeUpdate();

	        // 트랜잭션 커밋
	        con.commit();
	        System.out.println("도서 및 작가 정보 삭제 성공");
	    } catch (SQLException e) {
	        System.out.println("DB 에러: " + e.getMessage());
	        // 롤백 처리
	        if (con != null) {
	            try {
	                con.rollback();
	            } catch (SQLException ex) {
	                System.out.println("롤백 에러: " + ex.getMessage());
	            }
	        }
	    } catch (Exception e) {
	        System.out.println("일반 에러: " + e.getMessage());
	    } finally {
	        // 자원 해제
	        try {
	            if (pstmt != null) pstmt.close();
	            if (con != null) con.close();
	        } catch (SQLException e) {
	            System.out.println("자원 해제 에러: " + e.getMessage());
	        }
	    }

	    return delCnt;
	}
	
	/* 로그인 처리 메서드 1 : boolean 방식..*/
	public boolean login01(String id, String password) {
	    boolean isLoggedIn = false;
	    String sql = "SELECT COUNT(*) FROM customer WHERE id = ? AND password = ?";
	    
	    try (Connection con = DBCon.con();
	         PreparedStatement pstmt = con.prepareStatement(sql)) {
	        
	        pstmt.setString(1, id);
	        pstmt.setString(2, password);
	        
	        try (ResultSet rs = pstmt.executeQuery()) {
	            if (rs.next() && rs.getInt(1) > 0) {
	                isLoggedIn = true;
	            }
	        }
	    } catch (SQLException e) {
	        System.out.println("DB 에러:" + e.getMessage());
	    } catch (Exception e) {
	        System.out.println("일반 에러:" + e.getMessage());
	    }
	    
	    return isLoggedIn;
	}
	
	/* 로그인 처리 메서드2 : Customer 직접 사용 방식*/
	public Customer login(String id, String password) {
        Customer customer = null;
        String sql = "SELECT * FROM Customer WHERE id = ? AND password = ?";

        // try-with-resources 구문 사용
        try (
            Connection con = DBCon.con();
            PreparedStatement pstmt = con.prepareStatement(sql);
        ) {
            pstmt.setString(1, id);
            pstmt.setString(2, password);

            try (ResultSet rs = pstmt.executeQuery();) {
                if (rs.next()) {
                    customer = new Customer(
                    		rs.getInt("cno"),
                    		rs.getString("id"),
                            rs.getString("password"),
                            rs.getString("name"),
                            rs.getString("email"),
                            rs.getString("phone")
                    		);
                }
            }
        } catch (SQLException e) {
            System.out.println("DB 에러: " + e.getMessage());
        } catch (Exception e) {
            System.out.println("일반 에러: " + e.getMessage());
        }

        return customer;
    }
	
	/*관리자용 회원대출조회현황 메서드*/
    public List<RentalInfoForAdmin> searchRentalRecords(String searchKeyword) {
        List<RentalInfoForAdmin> rentalRecords = new ArrayList<>();
        String sql = "SELECT " +
                "e.isbn, e.title, a.name AS author_name, e.publisher, e.year, " +
                "c.cno, c.id AS customer_id, c.name AS customer_name, " +
                "r.rental_date, r.return_date " +
                "FROM Rental r " +
                "JOIN Ebook e ON r.isbn = e.isbn " +
                "JOIN Authors a ON e.author_id = a.author_id " +
                "JOIN Customer c ON r.cno = c.cno " +
                "WHERE r.ISRETURN = 'N' AND (" +
                "c.name LIKE ? OR " +
                "c.id LIKE ? OR " +
                "e.title LIKE ? OR " +
                "e.publisher LIKE ? OR " +
                "a.name LIKE ?)";

        try (Connection con = DBCon.con();
             PreparedStatement pstmt = con.prepareStatement(sql)
            ) {
            String searchQuery = "%" + searchKeyword + "%";
            pstmt.setString(1, searchQuery);
            pstmt.setString(2, searchQuery);
            pstmt.setString(3, searchQuery);
            pstmt.setString(4, searchQuery);
            pstmt.setString(5, searchQuery);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    RentalInfoForAdmin info = new RentalInfoForAdmin(
                    			rs.getInt("isbn"),
			                    rs.getString("title"),
			                    rs.getString("author_name"),
			                    rs.getString("publisher"),
			                    rs.getInt("year"),
			                    rs.getInt("cno"),
			                    rs.getString("customer_id"),
			                    rs.getString("customer_name"),
			                    rs.getDate("rental_date"),
			                    rs.getDate("return_date")
                    			);
                    // TODO: Handle '연장횟수', '반납버튼', '연장버튼' later
                    rentalRecords.add(info);
                }
            }
        } catch (SQLException e) {
            System.out.println("DB 에러:" + e.getMessage());
            // Handle exception
        }catch (Exception e) {
            System.out.println("일반 에러: " + e.getMessage());
        }
        return rentalRecords;
    }
    /* 모든 회원 대출 기록 조회 메서드 */
    public List<RentalInfoForAdmin> searchRentalHistory(String searchKeyword) {
        List<RentalInfoForAdmin> rentalRecords = new ArrayList<>();
        String sql = "SELECT " +
                     "e.isbn, e.title, a.name AS author_name, e.publisher, e.year, " +
                     "c.id AS customer_id, c.name AS customer_name, " +
                     "r.rental_date, r.return_date, r.isReturn " +
                     "FROM Rental r " +
                     "JOIN Ebook e ON r.isbn = e.isbn " +
                     "JOIN Authors a ON e.author_id = a.author_id " +
                     "JOIN Customer c ON r.cno = c.cno " +
                     "WHERE c.name LIKE ? OR " +
                     "c.id LIKE ? OR " +
                     "e.title LIKE ? OR " +
                     "e.publisher LIKE ? OR " +
                     "a.name LIKE ?";

        try (Connection con = DBCon.con();
             PreparedStatement pstmt = con.prepareStatement(sql)
            ) {
            String searchQuery = "%" + searchKeyword + "%";
            pstmt.setString(1, searchQuery);
            pstmt.setString(2, searchQuery);
            pstmt.setString(3, searchQuery);
            pstmt.setString(4, searchQuery);
            pstmt.setString(5, searchQuery);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    RentalInfoForAdmin info = new RentalInfoForAdmin(
                        rs.getInt("isbn"),
                        rs.getString("title"),
                        rs.getString("author_name"),
                        rs.getString("publisher"),
                        rs.getInt("year"),
                        rs.getString("customer_id"),
                        rs.getString("customer_name"),
                        rs.getDate("rental_date"),
                        rs.getDate("return_date"),
                        rs.getString("isreturn") // 반납 여부 추가
                    );
                    rentalRecords.add(info);
                }
            }
        } catch (SQLException e) {
            System.out.println("DB 에러:" + e.getMessage());
            // Handle exception
        } catch (Exception e) {
            System.out.println("일반 에러: " + e.getMessage());
        }
        return rentalRecords;
    }
    
    /* 관리자 권한 반납처리 */
    public int returnBook(int isbn, int cno) {
        int updateCount = 0;
        String sql = "UPDATE RENTAL SET return_date = SYSDATE, "
        		+"isReturn = 'Y' WHERE isbn = ? "
        		+"AND cno = ? AND isReturn = 'N'";
        try (Connection con = DBCon.con();
             PreparedStatement pstmt = con.prepareStatement(sql)) {
            pstmt.setInt(1, isbn);
            pstmt.setInt(2, cno);
            updateCount = pstmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println("DB 에러: " + e.getMessage());
        } catch (Exception e) {
            System.out.println("일반 에러: " + e.getMessage());
        }
        return updateCount;
    }
    
    /* 관리자 권한으로 대출 기한 연장 */
    public int extendBook(int isbn, int cno) {
        int updateCount = 0;
        String sql = "UPDATE RENTAL SET return_date = return_date + 7 "
                   + "WHERE isbn = ? AND cno = ? AND isReturn = 'N'";
        try (Connection con = DBCon.con();
             PreparedStatement pstmt = con.prepareStatement(sql)) {
            pstmt.setInt(1, isbn);
            pstmt.setInt(2, cno);
            updateCount = pstmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println("DB 에러: " + e.getMessage());
        } catch (Exception e) {
            System.out.println("일반 에러: " + e.getMessage());
        }
        return updateCount;
    }
    
    /* 리뷰 신고 조회 테이블*/
    // int rno, String content, Date rdate, String reporter, String reason
    public List<ReportDetail> reportInfo() {
        List<ReportDetail> reports = new ArrayList<>();
        String sql = "SELECT r.rno, rv.review_content AS content, rv.review_date AS rdate, \r\n"
        		+ "       c.id AS reporter, r.reason\r\n"
        		+ "FROM Reports r\r\n"
        		+ "JOIN Reviews rv ON r.rno = rv.rno\r\n"
        		+ "JOIN Customer c ON rv.cno = c.cno";

        try (
    	        Connection con = DBCon.con();
    	        PreparedStatement pstmt = con.prepareStatement(sql);
    	        ResultSet rs = pstmt.executeQuery();
    	    ) {
                while (rs.next()) {
                    ReportDetail report = new ReportDetail(
                    		rs.getInt("rno"),
                    		rs.getString("content"),
                    		rs.getDate("rdate"),
                    		rs.getString("reporter"),
                    		rs.getString("reason")
                    		);
                    reports.add(report);
                }
            
        } catch (SQLException e) {
            System.out.println("DB 에러:" + e.getMessage());
            // Handle exception
        } catch (Exception e) {
            System.out.println("일반 에러: " + e.getMessage());
        }
        return reports;
    }
    
    /* 신고된 리뷰 삭제 메서드 */
    public int deleteReportedReview(int rno) {
        int deleteCount = 0;
        String sql = "DELETE FROM REVIEWS WHERE rno = ?";
        try (Connection con = DBCon.con(); 
             PreparedStatement pstmt = con.prepareStatement(sql)) {
            pstmt.setInt(1, rno);
            deleteCount = pstmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println("DB 에러: " + e.getMessage());
            // 추가적인 에러 처리 필요시 여기에 작성
	    } catch (Exception e) {
	        System.out.println("일반 에러:" + e.getMessage());
	    }
        return deleteCount;
    }
    
	public static void main(String[] args) {
		AdminDao dao = new AdminDao();

	}
}
