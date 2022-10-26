<%@page import="comment.CommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="comment.Comment" %>
<%@ page import="comment.Comment" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
		<%
		String userID = null;
		String search = request.getParameter("search");
		String searchText = request.getParameter("searchText");
		int pageNumber = 1;
		if(request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
		int comPage = 1;
		if(request.getParameter("comPage") != null) {
			comPage = Integer.parseInt(request.getParameter("comPage"));
		}
		
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		} int bbsID = 0;
		if (request.getParameter("bbsID") != null) {
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		
		int comID = 0;
		if (request.getParameter("comID") != null) {
			comID = Integer.parseInt(request.getParameter("comID"));
		}
	
	if(comID == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 댓글입니다.')");
		script.println("location.href = 'view.jsp?bbsID="+bbsID+ "'");
		script.println("</script>");
		}
	
			   	
			CommentDAO comDAO = new CommentDAO();
			int result = comDAO.delete(comID);
			if(result == - 1) {	
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('댓글삭제에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else {						
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'view.jsp?bbsID="+ bbsID +"&search="+ search + "&searchText="+ searchText + "&pageNumber="+ pageNumber + "&comPage=" + comPage + "'");
				script.println("</script>");			
			} 
		
		
	%>
	
	
</body>
</html>