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
		if(userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}
		
		int bbsID = 0;
		if (request.getParameter("bbsID") != null) {
				bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		
		if(bbsID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		if(!userID.equals(bbs.getUserID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
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
				<%		
					}
				%>				
		</div>
	</nav>
	<div class="container">
		<div class="row">
		<script>
		function check() {

  			if(document.getElementById("bbsTitle").value == "") {
    				return false;
 			 }

  			else if(document.getElementById("bbsContent").value == "") {
   					 return false;

  			} 
  
			
  			else return true;

		}
		</script>
		 <form name="write" method="post" action="updateAction.jsp?bbsID=<%=bbsID%>" onsubmit="return check()">		 
			<table class="table table-stirped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="2" style="background-color: #eeeeee; text-align: center;">게시판 글쓰기 양식</th>
						
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type="text" class="form-control" placeholder="글 제목" name="bbsTitle" id="bbsTitle" maxlength="20" value="<%= bbs.getBbsTitle() %>"></td>
					</tr>
					<tr>
						<td><textarea class="form-control" placeholder="글 내용을 입력해주세요." name="bbsContent" id="bbsContent" maxlength="4096" style="height: 500px;"> <%= bbs.getBbsContent()%> </textarea></td>
					</tr>
					<tr>
					 <%
						String[] tagArray = bbs.getBbsTag().split("#");	
					 %>					 				
						<td>													
						   <a href="javacsript:void(0);" onclick="deleteTag;" name="bbsTag" id="tag_1" style="color : Blue"></a> 
						   <a href="javacsript:void(0);" onclick="deleteTag;" name="bbsTag" id="tag_2" style="color : Blue"></a> 
						   <a href="javacsript:void(0);" onclick="deleteTag;" name="bbsTag" id="tag_3" style="color : Blue"></a> 
						   <a href="javacsript:void(0);" onclick="deleteTag;" name="bbsTag" id="tag_4" style="color : Blue"></a> 
						   <a href="javacsript:void(0);" onclick="deleteTag;" name="bbsTag" id="tag_5" style="color : Blue"></a>
						   <a href="javacsript:void(0);" onclick="deleteTag;" id="tag_6" style="color : Blue"></a>    
						 						
						
						 <script>
						 document.getElementById("tag_1").addEventListener('click', deleteTag);
						 document.getElementById("tag_2").addEventListener('click', deleteTag);
						 document.getElementById("tag_3").addEventListener('click', deleteTag);
						 document.getElementById("tag_4").addEventListener('click', deleteTag);
						 document.getElementById("tag_5").addEventListener('click', deleteTag); 
						
						   	function deleteTag() {
						   		confirm(this.innerHTML + " 를 지우시겠습니까?");
						   		if(this.innerHTML == tag_1.innerHTML){
						   			document.getElementById('bbsTag1').value = "";
						   		} else if (this.innerHTML == tag_2.innerHTML){
						   			document.getElementById('bbsTag2').value = "";
						   		} else if (this.innerHTML == tag_3.innerHTML){
						   			document.getElementById('bbsTag3').value = "";
						   		} else if (this.innerHTML == tag_4.innerHTML){
						   			document.getElementById('bbsTag4').value = "";
						   		} else if (this.innerHTML == tag_5.innerHTML){
						   			document.getElementById('bbsTag5').value = "";
						   		} else {
						   			alert('오류발생');
						   		}						   		
						   		this.innerHTML = "";	
						   	}
						   </script>						   
						 </td>
					</tr>					
					<tr>						
						<td><input type="text" onkeyup="if(window.event.keyCode==32){test()}" class="form-control" placeholder="태그를 입력해주세요. 전부 입력후 스페이스바를 입력해주세요(최대 10자)" id="tag" maxlength="10">
							<input type="hidden">
							</td>
							<script>
					 	var tagIndex = 0;
					 </script>
					 <script>					 					 	
					 		tag_1.innerHTML = "<%try { %> <%="#" + tagArray[1]%><%} catch (Exception e) {%><%=""%><%}%>";						 	
					 </script>						 
				 			 
					 <script>					 					 	
					 		tag_2.innerHTML = "<%try { %> <%="#" + tagArray[2]%><%} catch (Exception e) {%><%=""%><%}%>";						 								
					 </script>
					 								 
					 <script>					 					 	
					 		tag_3.innerHTML = "<%try { %> <%="#" + tagArray[3]%><%} catch (Exception e) {%><%=""%><%}%>";					 								
					 </script>
					 				 	
					 <script>					 					 	
					 		tag_4.innerHTML = "<%try { %> <%="#" + tagArray[4]%><%} catch (Exception e) {%><%=""%><%}%>";					 								
					 </script>					 
					 
					 <script>					 					 	
					 		tag_5.innerHTML = "<%try { %> <%="#" + tagArray[5]%><%} catch (Exception e) {%><%=""%><%}%>";					 								
					 </script>
					 
					 <script>					 					 	
					 		tag_6.innerHTML = "<%try { %> <%="#" + tagArray[6]%><%} catch (Exception e) {%><%=""%><%}%>";					 								
					 </script>					
																				 
						<script>						
						 	function test() {						 		
						 		if(document.getElementById('tag').value.trim() == ""){
						 			alert("태그를 입력해주세요")
						 			document.getElementById('tag').value = "";
						 			return;
						 		}
						 		var str1 = document.getElementById('tag_1').innerHTML;
						 		var str2 = document.getElementById('tag_2').innerHTML;
						 		var str3 = document.getElementById('tag_3').innerHTML;
						 		var str4 = document.getElementById('tag_4').innerHTML;
						 		var str5 = document.getElementById('tag_5').innerHTML;						 		
						 		
						 		if(document.getElementById('tag_1').innerHTML == document.getElementById('tag_6').innerHTML || document.getElementById('tag_1').innerHTML == "") {
						    		tagIndex = 1;
						    	}else if (document.getElementById('tag_2').innerHTML == document.getElementById('tag_6').innerHTML || document.getElementById('tag_2').innerHTML == "") {
						    		tagIndex = 2;
						    	}else if (document.getElementById('tag_3').innerHTML == document.getElementById('tag_6').innerHTML || document.getElementById('tag_3').innerHTML == "") {
						    		tagIndex = 3;
						    	}else if (document.getElementById('tag_4').innerHTML == document.getElementById('tag_6').innerHTML || document.getElementById('tag_4').innerHTML == "") {
						    		tagIndex = 4;
						    	}else if (document.getElementById('tag_5').innerHTML == document.getElementById('tag_6').innerHTML || document.getElementById('tag_5').innerHTML == "") {
						    		tagIndex = 5;
						    	} else {
						    		tagIndex = 6;
						    	}
						 		
						 			if(tagIndex > 5) {
						 				alert(tagIndex);
						 				alert("태그는 5개가 최대입니다.");
						 				return;
						 			}
						 		document.getElementById('tag').value = document.getElementById('tag').value.trim();
						 		alert(tagIndex + "번째 태그를 입력합니다.");
						 		switch(tagIndex) {
						 		case 1:
						 			tag_1.innerHTML = "#" + document.getElementById('tag').value;
						 			document.getElementById('bbsTag1').value = tag_1.innerHTML;						 			
						 			break;
						 		case 2:
						 			tag_2.innerHTML = "#" + document.getElementById('tag').value;
						 			document.getElementById('bbsTag2').value = tag_2.innerHTML;
							 		break;
						 		case 3:
						 			tag_3.innerHTML = "#" + document.getElementById('tag').value;
						 			document.getElementById('bbsTag3').value = tag_3.innerHTML;
							 		break;
						 		case 4:
						 			tag_4.innerHTML = "#" + document.getElementById('tag').value;
						 			document.getElementById('bbsTag4').value = tag_4.innerHTML;
							 		break;
						 		case 5:
						 			tag_5.innerHTML = "#" + document.getElementById('tag').value;
						 			document.getElementById('bbsTag5').value = tag_5.innerHTML;
							 		break;							 														 							 			
						 	}
						 			document.getElementById('tag').value = "";
						    };
						    						 
						</script>								
					</tr>														
				</tbody>				
			</table>			
			<INPUT TYPE="hidden" NAME="bbsTag1" id="bbsTag1" SIZE=10 value=''>
			<INPUT TYPE="hidden" NAME="bbsTag2" id="bbsTag2" SIZE=10 value=''>
			<INPUT TYPE="hidden" NAME="bbsTag3" id="bbsTag3" SIZE=10 value=''>
			<INPUT TYPE="hidden" NAME="bbsTag4" id="bbsTag4" SIZE=10 value=''>
			<INPUT TYPE="hidden" NAME="bbsTag5" id="bbsTag5" SIZE=10 value=''>
			<script>
			document.getElementById('bbsTag1').value = tag_1.innerHTML;
			document.getElementById('bbsTag2').value = tag_2.innerHTML;
			document.getElementById('bbsTag3').value = tag_3.innerHTML;
			document.getElementById('bbsTag4').value = tag_4.innerHTML;
			document.getElementById('bbsTag5').value = tag_5.innerHTML;
			</script>
					
			<input type="submit" onmouseout="check = false;"class="btn btn-primary pull-right" value="글쓰기"/>				
		 </form>
		</div>
	</div>	
	<script>
					 	var reg = /\s/g;
						function
					 	if(tag_1.innerHTML.match("")){
				    		tagIndex = 1;
				    	}else if (tag_2.innerHTML.match("")) {
				    		tagIndex = 2;
				    	}else if (tag_3.innerHTML.match("")) {
				    		tagIndex = 3;
				    	}else if (tag_4.innerHTML.match("")) {
				    		tagIndex = 4;
				    	}else if (tag_5.innerHTML == tag_5.innerHTML) {
				    		tagIndex = 5;
				    	} else {
				    		tagIndex = 6;
				    	}
	</script>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	
	
</body>
</html>