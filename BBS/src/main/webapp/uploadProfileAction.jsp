<%@page import="javax.swing.plaf.multi.MultiMenuItemUI"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="file.FileDAO" %>
<%@ page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
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
	<%
	String path = application.getRealPath("/resources/profile/"+userID); //폴더 경로
	File Folder = new File(path);

	// 해당 디렉토리가 없을경우 디렉토리를 생성합니다.
	if (!Folder.exists()) {
		try{
		    Folder.mkdir(); //폴더 생성합니다.
	        } 
	        catch(Exception e){
		    e.getStackTrace();
		    }        
         }
				
		String directory = application.getRealPath("/resources/profile/"+userID+"/");
		int maxSize = 1024 * 1024 * 100;
		String encoding = "UTF-8";
		
		MultipartRequest multipartRequest
		= new MultipartRequest(request, directory, maxSize, encoding, new DefaultFileRenamePolicy());
		
		String fileName = multipartRequest.getOriginalFileName("file");
		String fileRealName = multipartRequest.getFilesystemName("file");
		
		
		
		fileName= "/BBS/resources/profile/"+userID+"/"+ fileRealName;
		new FileDAO().upload(fileName, fileRealName, userID);
		out.write("성공적으로 파일이 업로드 되었습니다.");
	%>
	<img src="/BBS/resources/profile/<%=userID%>/<%=fileRealName%>">
	</div>
	
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	
	
</body>
</html>