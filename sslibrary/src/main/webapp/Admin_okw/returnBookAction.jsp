<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="sslibrary.frontweb.database.AdminDao"%>
<%
    String action = request.getParameter("action");
    int isbn = Integer.parseInt(request.getParameter("isbn"));
    int cno = Integer.parseInt(request.getParameter("cno"));
    AdminDao dao = new AdminDao();
    boolean success = false;
    String message = "";

    if ("return".equals(action)) {
        // 반납 처리
        int updateCount = dao.returnBook(isbn, cno);
        if (updateCount > 0) {
            success = true;
            message = "도서가 성공적으로 반납되었습니다.";
        } else {
            message = "도서 반납 처리에 실패했습니다.";
        }
    } else if ("extend".equals(action)) {
        // 연장 처리
        int updateCount = dao.extendBook(isbn, cno);
        if (updateCount > 0) {
            success = true;
            message = "도서 기한이 성공적으로 연장되었습니다.";
        } else {
            message = "도서 기한 연장 처리에 실패했습니다.";
        }
    } else {
        message = "잘못된 요청입니다.";
    }

    // 처리 결과에 따른 페이지 리디렉션 또는 메시지 표시
    if (success) {
        out.println("<script>alert('" + message + "'); location.href='adm_index.jsp';</script>");
    } else {
        out.println("<script>alert('" + message + "'); history.back();</script>");
    }
%>