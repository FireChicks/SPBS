<%@page import="java.util.ArrayList"%>
<%@page import="comment.CommentDAO"%>
<%@page import="comment.Comment"%>
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
		boolean updateComment = false;
		
		int bbsID = 0;
		if (request.getParameter("bbsID") != null) {
				bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		
		int comID = 0;
		if (request.getParameter("comID") != null) {
				comID = Integer.parseInt(request.getParameter("comID"));
				updateComment = true;
		}
		
		if(bbsID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}
		int comPage = 1;
		if (request.getParameter("comPage") != null) {
			comPage = Integer.parseInt(request.getParameter("comPage"));
	}
		
		int pageNumber = 1;
		if(request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
		int imgCount = 0;
		
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		User bbsuser = new UserDAO().getUserInfoList(bbs.getUserID());
		String searchText = "";
		String search = null;
		boolean searchBbs = false;
		if(request.getParameter("search") != null) {
			searchBbs = true;
			search = request.getParameter("search");
			searchText = request.getParameter("searchText");
		}		
		boolean youTubeExist = false;
		if(bbs.getYoutubeLink() != null && !(bbs.getYoutubeLink().trim().isEmpty())) {
			youTubeExist = true;
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
						
					User user = new UserDAO().getUserInfoList(userID);
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
			<%} %>				
		</div>
	</nav>
	<div class="container">
		<div class="row">
			<table class="table table-stirped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="6" style="background-color: #eeeeee; text-align: center;">게시판 글보기</th>
						
					</tr>
				</thead>
				<tbody>
				<%
						String[] array = bbs.getBbsTag().split("#");				
				%>
					<tr>
						<td style="width:20%;">글 제목</td>
						<td colspan="5"><%= bbs.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;".replaceAll("\n", "<br>;'"))%></td>
					</tr>
					<tr>
						<td style="vertical-align : middle;" >작성자</td>
						<td colspan="2" style="text-align : left;"><img src="<%=bbsuser.getUserProfilePath()%>" width="50px" height="50px" alt="프로필" title="프로필" ></td>
						<td colspan="4"  style="vertical-align : middle;"><%= bbs.getUserID() %></td>
					</tr>
					<tr>
						<td>작성일자</td>
						<td colspan="5"><%= bbs.getBbsDate().substring(0,11) + bbs.getBbsDate().substring(11, 13) + "시" + bbs.getBbsDate().substring(14, 16) + "분" %></td>
					</tr>
					<tr>
						<td>내용</td>
						<td colspan="5" style="min-height: 200px; text-align: Left"><%if(youTubeExist) { %><iframe width="560" height="315" src="https://www.youtube.com/embed/<%=bbs.getYoutubeLink()%>" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe><br> <%} %>
																					
																					
																					<%=bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%> <br>
																					<%	try{
																						String[] imageContentArray =bbs.getBbsImageContent().split("#");						
																						String[] ImagePathArray = bbs.getBbsImagePath().split("#");
																						imgCount = ImagePathArray.length;
																						for(int i=1; i<ImagePathArray.length; i++) {%> <img src="<%=ImagePathArray[ImagePathArray.length - i]%>" width="90%" height="90%" alt="프로필" title="프로필" > <br> <%= imageContentArray[i].replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %> <br>
																					<%} } catch(Exception e) {}%>																	
						</td>
					</tr>
					<tr>
						<td>태그</td>
						<td colspan="5"><%for(int i=1;i<array.length;i++) { %> <a href="bbs.jsp?searchText=<%=array[i].trim()%>&search=bbsTag"><%=" #" + array[i]%></a><%}%></td>
					</tr>
					<%if(!updateComment) { %>
					<form  method="post" action="commentAction.jsp?bbsID=<%=bbsID%>&searchText=<%=searchText%>&search=<%=search%>&pageNumber=<%= pageNumber%>">
					<tr>					
						<td colspan="6"><textarea class="form-control" placeholder="댓글을 입력해주세요." name="comContent" id="comContent" maxlength="500"  style="resize: none; width:100%;"></textarea><input type="submit" class="btn btn-primary pull-right" value="댓글 작성"/></td>					
					</tr>					
					</form>
					<% } else { 
					CommentDAO upComDAO = new CommentDAO();
					String upCom = upComDAO.getContent(comID);%>
					<form  method="post" action="updateComAction.jsp?comPage=<%=comPage%>&comID=<%=comID%>&bbsID=<%=bbsID%>&searchText=<%=searchText%>&search=<%=search%>&pageNumber=<%= pageNumber%>">
					<tr>					
						<td colspan="6"><textarea class="form-control" placeholder="댓글을 입력해주세요." name="comContent" id="comContent" maxlength="500"  style="resize: none; width:100%;"><%=upCom%></textarea><input type="submit" class="btn btn-primary pull-right" value="댓글 작성"/></td>					
					</tr>					
					</form>
					<%} %>
					<% 						
						CommentDAO comDAO = new CommentDAO();
						ArrayList<Comment> comList = comDAO.getList(comPage, bbsID);
						for(int i=0; i < comList.size(); i++) {
							User comUser = new UserDAO().getUserInfoList(comList.get(i).getUserID());
					%>
				    <tr>
						<td rowspan="2" style="vertical-align : middle;"  >댓글 <%if(userID != null && userID.equals(comUser.getUserID())) {%> <br><a href="view.jsp?bbsID=<%=bbsID%>&comID=<%=comList.get(i).getComID()%>&searchText=<%=searchText%>&search=<%=search%>&pageNumber=<%= pageNumber%>&comPage=<%=comPage%>" >수정</a> 
																																				  <a href="deleteComAction.jsp?bbsID=<%=bbsID%>&comID=<%=comList.get(i).getComID()%>&searchText=<%=searchText%>&search=<%=search%>&pageNumber=<%= pageNumber%>&comPage=<%=comPage%>">삭제</a> <%} %></td>
						<td colspan="1" style="text-align : left;"><img src="<%=comUser.getUserProfilePath()%>" width="50px" height="50px" alt="프로필" title="프로필"></td>
						<td colspan="3" style="vertical-align : middle;"> 작성자 : <%=comList.get(i).getUserID()%> </td>
						<td style="vertical-align : middle;"> <%=comList.get(i).getComDate()%></td>
					</tr>
					<tr>
						<td colspan="2" style="vertical-align : middle; text=align:center"  >댓글 내용</td>					
						<td colspan="4"> <%=comList.get(i).getComContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></td>
					</tr> 
					<%}%>
				<tr>
					<td colspan="6" style="text-align: left;">
					<%
					if(comPage != 1) {
					%>
					<a href="view.jsp?bbsID=<%=bbsID%>&searchText=<%=searchText%>&search=<%=search%>&pageNumber=<%= pageNumber%>&comPage=<%=comPage - 1 %>" class="btn btn-success btn-arraw-Left">이전</a>
					<%
					} if(comDAO.nextPage(comPage, bbsID)) {
					%>
					<a href="view.jsp?bbsID=<%=bbsID%>&searchText=<%=searchText%>&search=<%=search%>&pageNumber=<%= pageNumber%>&comPage=<%=comPage + 1 %>" class="btn btn-success btn-arraw-Left">다음</a>
					<%
					}
					%>	
					</td>
				</tr>								
				</tbody>				
			</table>
			<a href="bbs.jsp?searchText=<%=searchText%>&search=<%=search%>&pageNumber=<%= pageNumber%>" class="btn btn-primary">목록</a>
			<%
				if(userID != null && userID.equals(bbs.getUserID())) {
			%>
				<a href="update.jsp?bbsID=<%=bbsID%>&imgCount=<%=imgCount%>" class="btn btn-primary">수정</a>
				<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">삭제</a>
			<% 		
				}
			%>
			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a> 
		 </form>
		</div>
	</div>
	
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	
	
</body>
</html>