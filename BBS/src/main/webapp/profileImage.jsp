<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		} 
		
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}
		
		User user = new UserDAO().getUserInfoList(userID);
		
		
		int pageNumber = 1;
		if(request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
				
		String searchText = "";
		String search = null;
		boolean searchBbs = false;
		if(request.getParameter("search") != null) {
			searchBbs = true;
			search = request.getParameter("search");
			searchText = request.getParameter("searchText");
		}
	%>
	
	<nav class="navbar navbar-default">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
						data-toggle="collapse" data-target="#bs-exapmle-navbar-collapse-1"
						aria-expanded="false">
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>
		</div>
			<div class="collapse navbar-collapse" id="bs-exapmle-navbar-collapse-1">
				<ul class="nav navbar-nav">
					<li ><a href="main.jsp">메인</a></li>
					<li><a href="bbs.jsp">게시판</a></li>
				</ul>
				<% 
					if(userID == null) {											
				%>
				
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown">
						<a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">접속하기<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li> <a href="login.jsp">로그인</a></li>
							<li><a href="join.jsp">회원가입</a></li>
						</ul>
					</li>
				</ul>
				
				<%
					} else {
				%>
				<ul class="nav navbar-nav navbar-right">
				<li>
					<img src="<%=user.getUserProfilePath()%>" width="50px" height="50px" alt="프로필" title="프로필" >
				</li>
				</ul>
						<ul class="nav navbar-nav navbar-right">
					<li class="dropdown">
						<a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">회원관리<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li> <a href="profile.jsp">프로필 수정</a> </li>
							<li> <a href="profileImage.jsp">이미지 수정</a> </li>
							<li> <a href="logoutAction.jsp">로그아웃</a></li>							
						</ul>
					</li>
				</ul>
				<%		
					}
				%>				
		</div>
	</nav>	
<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top : 20px;">
				<form action="uploadProfileAction.jsp" method="post" enctype="multipart/form-data" >
					<h3 style="text-align: center;">프로필 이미지 변경</h3>
					<div class="form-group">
						 <input type="file" name="file" accept="image/*"><br>
					</div>
					<input type="hidden" value="<%=userID%>" name="userID">
					<input type="submit" class="btn btn-primary form-control" value="수정">				
				</form>				
			</div>
		</div>
	</div>
	
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	
	
</body>
</html>