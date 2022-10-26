<%@page import="java.awt.Graphics"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.awt.Image"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%-- <jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userGender" />
<jsp:setProperty name="user" property="userEmail" />
<jsp:setProperty name="user" property="userProfile" /> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

		<%		
		String userID = null;				
		String filePath = request.getParameter("userProfile");
		String filePath2 = request.getParameter("userProf");
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");			
		}
		User user = new User();
		user.setUserID(userID);
		user.setUserEmail(request.getParameter("userEmail"));
		user.setUserName(request.getParameter("userName"));
		user.setUserProfile(filePath);
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		} else {		
		if(user.getUserName() == null || user.getUserEmail() == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}  else {
		}
			UserDAO userDAO = new UserDAO();	

					
			int result = userDAO.update(userID, user.getUserName(), user.getUserEmail());
			if(result == - 1) {	
				PrintWriter script = response.getWriter(); 
				script.println("<script>");
				script.println("alert('프로필 정보 수정에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else {						
				PrintWriter script = response.getWriter(); 
				script.println("<script>");
				script.println("location.href = 'main.jsp'");
				script.println("alert('프로필 정보 수정에 성공했습니다.')");
				script.println("</script>");			
			} 		
		
		 }
		
	%>
	
	
</body>
</html>