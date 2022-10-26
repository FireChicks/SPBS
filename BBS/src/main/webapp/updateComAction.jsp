<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="comment.CommentDAO" %>
<%@ page import="bbs.BbsDAO" %>
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
		int bbsID = 0;
		String search = request.getParameter("search");
		String searchText = request.getParameter("searchText");
		int pageNumber = 1;
		int comID = 0;
		if (request.getParameter("comID") != null) {
			comID = Integer.parseInt(request.getParameter("comID"));
		}
		
		int comContent = 0;
		if (request.getParameter("comID") != null) {
			comID = Integer.parseInt(request.getParameter("comID"));
		}
		
		int comPage = 1;
		if(request.getParameter("comPage") != null) {
			comPage = Integer.parseInt(request.getParameter("comPage"));
		}
		
		if(request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
		if(request.getParameter("bbsID") != null){
			bbsID = Integer.parseInt(request.getParameter("bbsID"));	
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글번호입니다.')");
			script.println("history.back()");
			script.println("</script>");
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
		} else {		
		if(request.getParameter("comContent") == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			CommentDAO comDAO = new CommentDAO();
			int result = comDAO.update(comID, request.getParameter("comContent"));			
			if(result == - 1) {	
				PrintWriter script = response.getWriter(); 
				script.println("<script>");
				script.println("alert('댓글수정에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else {						
				PrintWriter script = response.getWriter(); 
				script.println("<script>");
				script.println("location.href = 'view.jsp?bbsID="+ bbsID +"&search="+ search + "&searchText="+ searchText + "&pageNumber="+ pageNumber + "&comPage=" + comPage + "'");
				script.println("</script>");			
			} 		
		
		}
	}
	%>
	
	
</body>
</html>