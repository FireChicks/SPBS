<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>JSP 게시판 웹 사이트</title>
<style type="text/css">
	a, a:hover {
	color: #000000;
	text-decoration: none;
	}
</style>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
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
		
		if(searchText.equals("")) {
			searchBbs = false;
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
					<li><a href="main.jsp">메인</a></li>
					<li class="active"><a href="bbs.jsp">게시판</a></li>
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
					<li class="dropdown">
						<a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">회원관리<span class="caret"></span></a>
						<ul class="dropdown-menu">
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
		<div class="row">
			<table class="table table-stirped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">번호</th>
						<th style="background-color: #eeeeee; text-align: center;">제목</th>
						<th style="background-color: #eeeeee; text-align: center;">작성자</th>
						<th style="background-color: #eeeeee; text-align: center;">작성일</th>
					</tr>
				</thead>
				<tbody>
				
					<%
					BbsDAO bbsDAO = new BbsDAO();
					ArrayList<Bbs> bbsList = null;
					
					if(!searchBbs){
						bbsList = bbsDAO.getList(pageNumber);
					} else {
						bbsList = bbsDAO.searchList(pageNumber, search, searchText);					
						}
						for(int i = 0; i < bbsList.size(); i++) {
					%>
					<tr>
						<td><%= bbsList.get(i).getBbsID()%></td>
						<td><a href="view.jsp?searchText=<%=searchText%>&search=<%=search%>&pageNumber=<%= pageNumber%>&bbsID=<%=bbsList.get(i).getBbsID() %>"><%= bbsList.get(i).getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;".replaceAll("\n", "<br>")) %></a></td>
						<td><a href="bbs.jsp?searchText=<%=bbsList.get(i).getUserID()%>&search=userID"><%= bbsList.get(i).getUserID() %></a></td>
						<td><%= bbsList.get(i).getBbsDate().substring(0,11) + bbsList.get(i).getBbsDate().substring(11, 13) + "시" + bbsList.get(i).getBbsDate().substring(14, 16) + "분"   %> </td>
					</tr>
					
					<%
						} 				
					%>									
				</tbody>
			</table>
			<%
				if(pageNumber != 1) {
			%>
				<a href="bbs.jsp?searchText=<%=searchText%>&search=<%=search%>&pageNumber=<%= pageNumber - 1%>" class="btn btn-success btn-arraw-Left">이전</a>
			<%
				} if(bbsDAO.nextPage(pageNumber + 1,search,searchText)) {
			%>
				<a href="bbs.jsp?searchText=<%=searchText%>&search=<%=search%>&pageNumber=<%= pageNumber + 1%>" class="btn btn-success btn-arraw-Left">다음</a>
			<%
				}
			%>						
			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a> 			
			<div style="display: flex; justify-content: center;" class="btn btn-priamary">
			<form action = "bbs.jsp">
				<select name="search" id="searchOption" class="form-select" aria-label="Default select example">
					<option value="bbsTitle">글 제목</option>
					<option value="bbsContent">글 내용</option>
					<option value="bbsID">글 번호</option>
					<option value="userID">작성자 검색</option>
					<option value="bbsTag">태그 검색</option>
				</select> 				
				<input name="searchText" type="text"  value=<%=searchText%>>
				<input type="submit" class="btn btn-primary" value="검색">
			</form>				
			</div>	
		</div>
	</div>

		
	
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	
	
</body>
</html>