CREATE TABLE testtable1(
	tno NUMBER,
	tname varchar2(50)
);
INSERT INTO TESTTABLE values(1,'테스트용');
SELECT * FROM TESTTABLE ;


/*
 * 권한 확인
 * */
SELECT * FROM USER_SYS_PRIVS;
SELECT * FROM USER_TAB_PRIVS;

/*
 * 테이블 생성 SQL문
 * */
-- 1. 도서정보 테이블 (EBOOK)
CREATE TABLE EBOOK(
    isbn NUMBER(5) PRIMARY KEY, -- 도서 고유 번호
    title VARCHAR2(100),
    author_id NUMBER,  -- 저자 정보 테이블과의 연결을 위한 외래 키
    publisher VARCHAR2(100),
    year NUMBER(4),
    available CHAR(1),  -- 'Y' 또는 'N'으로 대출 가능 여부 표시
    FOREIGN KEY (author_id) REFERENCES AUTHORS(author_id),
    CHECK (isbn BETWEEN 10001 AND 99999)
);

-- 2. 회원정보 테이블 (CUSTOMER)
CREATE TABLE CUSTOMER (
	cno NUMBER PRIMARY KEY,
    id VARCHAR2(20) NOT NULL UNIQUE,
    password VARCHAR2(20) NOT NULL,
    name VARCHAR2(100) NOT NULL,
    email VARCHAR2(100),
    phone VARCHAR2(15)
);

-- 3. 저자정보 테이블(AUTHORS)
CREATE TABLE AUTHORS (
    author_id NUMBER PRIMARY KEY,
    name VARCHAR2(100)
);
-- 3. 저자정보 테이블에 작가소개 컬럼 추가
ALTER TABLE AUTHORS
ADD info CLOB;
SELECT * FROM AUTHORS;

-- 4. 도서 예약 정보 테이블(RESERVE)
CREATE TABLE RESERVE (
    isbn NUMBER(5), -- 도서번호
    cno NUMBER, -- 회원번호
    reserve_date DATE,
    PRIMARY KEY (isbn, cno),
    FOREIGN KEY (isbn) REFERENCES EBOOK(isbn),
    FOREIGN KEY (cno) REFERENCES CUSTOMER(cno)
);

-- 5. 대출 기록 테이블 (PREVIOUSRENTAL)
CREATE TABLE PREVIOUSRENTAL (
    rental_id NUMBER PRIMARY KEY,
    isbn NUMBER(5),
    cno NUMBER,
    rental_date DATE, -- 대출일자
    return_date DATE, -- 반납일자
    FOREIGN KEY (isbn) REFERENCES EBOOK(isbn),
    FOREIGN KEY (cno) REFERENCES CUSTOMER(cno)
);
CREATE TABLE RENTAL (
    isbn NUMBER(5),
    cno NUMBER,
    rental_date DATE, -- 대출일자
    return_date DATE, -- 반납일자
    FOREIGN KEY (isbn) REFERENCES EBOOK(isbn),
    FOREIGN KEY (cno) REFERENCES CUSTOMER(cno)
);
-- 6. 자동 반납 기록 테이블 (AUTO_RERURN_LOG)
CREATE TABLE AUTO_RETURN_LOG (
    log_id NUMBER PRIMARY KEY,
    isbn NUMBER(5),
    return_date DATE,
    FOREIGN KEY (isbn) REFERENCES EBOOK(isbn)
);


/*
 *  시퀀스 
 * */
-- 1. 회원번호
CREATE SEQUENCE cno_seq
    START WITH 1
    INCREMENT BY 1
    NOMAXVALUE;
 
-- 2. 도서번호
CREATE SEQUENCE isbn_seq
START WITH 10001
MAXVALUE 99999
NOCYCLE;

-- 3. 작가번호
CREATE SEQUENCE author_seq
START WITH 1001
MAXVALUE 9999
NOCYCLE;
-- 작가번호 트리거 (메서드로 작가번호 자동 생성시 필요)
CREATE OR REPLACE TRIGGER authors_bir 
BEFORE INSERT ON AUTHORS 
FOR EACH ROW
BEGIN
  SELECT author_seq.NEXTVAL INTO :new.author_id FROM dual;
END;
   
   
/*
 * 관리자 계정 생성, 정보 저장
 * */   
INSERT INTO CUSTOMER VALUES (cno_seq.nextval, 'admin', '1111', '관리자','admin@sslib.com', '010-1111-1111');
SELECT * FROM customer;

/*
 * 기능메서드용 SQL
 * */
-- 1. 로그인확인
SELECT * FROM CUSTOMER WHERE cno = :cno AND password = :password;

-- 2. 도서검색
SELECT e.* FROM EBOOK e
JOIN AUTHORS a ON e.author_id = a.author_id
WHERE e.title LIKE :title OR a.name 
LIKE :author OR e.publisher 
LIKE :publisher OR e.year = :year;

SELECT e.isbn, e.title, e.AUTHOR_ID, a.name as authorName, e.publisher, e.year, e.available
FROM EBOOK e 
JOIN AUTHORS a 
ON e.author_id = a.author_id;

-- 3. 도서대출
INSERT INTO PREVIOUSRENTAL (isbn, cno, rental_date, return_date) VALUES (:isbn, :cno, SYSDATE, SYSDATE + 10);

-- 4. 도서 반납
UPDATE PREVIOUSRENTAL SET return_date = SYSDATE WHERE isbn = :isbn AND cno = :cno;

-- 5. 도서 예약
INSERT INTO RESERVE (isbn, cno, reserve_date) VALUES (:isbn, :cno, SYSDATE);

--6. 도서 예약 취소 
DELETE FROM RESERVE WHERE isbn = :isbn AND cno = :cno;

-- 7.대출 및 예약 도서 목록 조회(일반회원용)
SELECT * FROM PREVIOUSRENTAL WHERE cno = :cno;
SELECT * FROM RESERVE WHERE cno = :cno;

-- 8. 대출/반납 기록 조회 (관리자용)
SELECT
  e.isbn,
  e.title,
  a.name AS author_name,
  e.publisher,
  e.year,
  c.id AS customer_id,
  c.name AS customer_name,
  r.rental_date,
  r.return_date
FROM
  Rental r
JOIN
  Ebook e ON r.isbn = e.isbn
JOIN
  Authors a ON e.author_id = a.author_id
JOIN
  Customer c ON r.cno = c.cno
WHERE r.ISRETURN ='N' AND 
  c.name LIKE '%검색어%' OR
  c.id LIKE '%검색어%' OR
  e.title LIKE '%검색어%' OR
  e.PUBLISHER  LIKE '%검색어%' OR
  a.name LIKE '%검색어%';
 
SELECT * FROM rental;

--9. 대출 통계 조회(관리자용)
SELECT cno, COUNT(*) AS total_rentals FROM PREVIOUSRENTAL GROUP BY cno;
SELECT isbn, COUNT(*) AS total_rentals FROM PREVIOUSRENTAL GROUP BY isbn;

-- 10. 자동 반납 처리(Batch Service)
INSERT INTO AUTO_RETURN_LOG (isbn, return_date) SELECT isbn, SYSDATE FROM PREVIOUSRENTAL WHERE return_date < SYSDATE;

-- 11. 회원 정보 조회
SELECT * FROM CUSTOMER 
WHERE id LIKE 'admin' OR name LIKE '관리자';

-- 12. 책 정보 조회
SELECT e.isbn, e.title, e.AUTHOR_ID, a.name as authorName, e.publisher, e.year, e.available
FROM EBOOK e 
JOIN AUTHORS a 
ON e.author_id = a.author_id;

/* 
 ***** 책정보 / 회원정보 추가..
 */
-- 1. 회원정보 추가
INSERT INTO CUSTOMER VALUES (cno_seq.nextval, 'okw9344', '9344', '오근우','okw9344@gmail.com', '010-9027-7345');
-- 2. 책 정보 추가
INSERT INTO ebook VALUES (isbn_seq.NEXTVAL,'이것이 자바다','1',)
-- 2-2. 책 정보 수정
UPDATE EBOOK 
SET title = '갈매기의 꿈'
WHERE author_id = 1003;
UPDATE AUTHORS
SET name = '리처드 바크'
WHERE author_id = 1003;

UPDATE Ebook_detail
SET info ='내용'
WHERE isbn = 10000;

-- 2-3. 책 정보 삭제
DELETE FROM ebook
WHERE isbn = 10002;

DELETE FROM AUTHORS
WHERE AUTHOR_ID = 1004;

SELECT * FROM ebook;
SELECT * FROM AUTHORS;
SELECT * FROM CUSTOMER;
SELECT * FROM rental;
SELECT * FROM RESERVE;
SELECT * FROM  EBOOK e
JOIN EBOOK_DETAIL ed ON ed.isbn = e.isbn;

SELECT* FROM REPORTS;

SELECT r.rno, rv.review_content AS content, rv.review_date AS rdate, 
       c.id AS reporter, r.reason
FROM Reports r
JOIN Reviews rv ON r.rno = rv.rno
JOIN Customer c ON rv.cno = c.cno;
/*************************
 **** 기타 sql 조정문 ****
 ************************/

-- 테이블 초기화 하는법 
-- 테이블 삭제시 순서 
DROP TABLE AUTO_RETURN_LOG;
DROP TABLE PREVIOUSRENTAL;
DROP TABLE RESERVE;
DROP TABLE EBOOK;
DROP TABLE CUSTOMER;
DROP TABLE AUTHORS;

-- 회원번호 시퀀스 삭제
DROP SEQUENCE cno_seq;
DROP SEQUENCE isbn_seq;
DROP SEQUENCE author_seq;
-- 작가번호 트리거 삭제
DROP TRIGGER authors_bir;

-- 도서 데이터 삭제
DELETE FROM EBOOK WHERE isbn = 10026;
-- 연결된 작가정보 삭제
DELETE FROM AUTHORS WHERE author_id NOT IN (SELECT DISTINCT author_id FROM EBOOK);

SELECT*FROM AUTHORS;
SELECT * FROM ebook;
