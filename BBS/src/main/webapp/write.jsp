<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
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
		} else {							
				
		int bbsID = 0;
		if (request.getParameter("bbsID") != null) {
				bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
	//	if(bbsID == 0) {
	//		PrintWriter script = response.getWriter();
	//		script.println("<script>");
	//		script.println("alert('유효하지 않은 글입니다.')");
	//		script.println("location.href = 'bbs.jsp'");
	//		script.println("</script>");
	//	}
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
		boolean check = false;
		</script>
		<script>
		function check() {

  			if(document.getElementById("bbsTitle").value == "") {
    				return false;
 			 }

  			else if(document.getElementById("bbsContent").value == "") {
   					 return false;

  			}
  			else{
  				if(check){
  					return true;
  				} else {
  					return false;
  				}
  			}

		}
		</script>		
		 <form name="write" id="write" method="post" action="writeAction.jsp" id="form0" enctype="multipart/form-data" onsubmit="return check()">		 
			<table class="table table-stirped" id="writeForm" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="2" style="background-color: #eeeeee; text-align: center;">게시판 글쓰기 양식</th>
						
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type="text" class="form-control" placeholder="글 제목" name="bbsTitle" id="bbsTitle" maxlength="20"> </td>
					</tr>
					<tr>					
						<td><textarea class="form-control" placeholder="글 내용을 입력해주세요." name="bbsContent" id="bbsContent" maxlength="4096" style="height: 500px;"></textarea></td>
						
					</tr>
					<tr>
						<td>													
						   <a href="javacsript:void(0);" onclick="deleteTag" name="bbsTag" id="tag_1" style="color : Blue"></a> 
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
						   		}						   		
						   		this.innerHTML = "";	
						   	}
						   </script>						   
						 </td>
					</tr>					
					<tr>						
						<td><input type="text" onkeyup="if(window.event.keyCode==32){test()}" class="form-control" placeholder="태그를 입력해주세요. 전부 입력후 스페이스바를 입력해주세요(최대 10자)" id="inputTag" maxlength="10">
							<input type="hidden">
							</td>	
						<script>
						var tagIndex = 0;
						 	function test() {						 		
						 		if(document.getElementById('inputTag').value.trim() == ""){
						 			alert("태그를 입력해주세요")
						 			document.getElementById('inputTag').value = "";
						 			return;
						 		}
						 		var str1 = document.getElementById('tag_1').innerHTML;
						 		var str2 = document.getElementById('tag_2').innerHTML;
						 		var str3 = document.getElementById('tag_3').innerHTML;
						 		var str4 = document.getElementById('tag_4').innerHTML;
						 		var str5 = document.getElementById('tag_5').innerHTML;
						 		var reg = /\s/g;
						 								 		
						 		if(document.getElementById('tag_1').innerHTML == document.getElementById('tag_6').innerHTML){
						    		tagIndex = 1;
						    	}else if (document.getElementById('tag_2').innerHTML == document.getElementById('tag_6').innerHTML) {
						    		tagIndex = 2;
						    	}else if (document.getElementById('tag_3').innerHTML == document.getElementById('tag_6').innerHTML) {
						    		tagIndex = 3;
						    	}else if (document.getElementById('tag_4').innerHTML == document.getElementById('tag_6').innerHTML) {
						    		tagIndex = 4;
						    	}else if (document.getElementById('tag_5').innerHTML == document.getElementById('tag_6').innerHTML) {
						    		tagIndex = 5;
						    	} else {
						    		tagIndex = 6;
						    	}
						 		
						 			if(tagIndex > 5) {
						 				alert("태그는 5개가 최대입니다.")
						 				return;
						 			}
						 			
						 		alert(tagIndex + "번째 태그를 입력합니다.");
						 		switch(tagIndex) {
						 		case 1:
						 			tag_1.innerHTML = "#" + document.getElementById('inputTag').value;
						 			document.getElementById('bbsTag1').value = tag_1.innerHTML.trim();						 			
						 			break;
						 		case 2:
						 			tag_2.innerHTML = "#" + document.getElementById('inputTag').value;
						 			document.getElementById('bbsTag2').value = tag_2.innerHTML.trim();
							 		break;
						 		case 3:
						 			tag_3.innerHTML = "#" + document.getElementById('inputTag').value;
						 			document.getElementById('bbsTag3').value = tag_3.innerHTML.trim();
							 		break;
						 		case 4:
						 			tag_4.innerHTML = "#" + document.getElementById('inputTag').value;
						 			document.getElementById('bbsTag4').value = tag_4.innerHTML.trim();
							 		break;
						 		case 5:
						 			tag_5.innerHTML = "#" + document.getElementById('inputTag').value;
						 			document.getElementById('bbsTag5').value = tag_5.innerHTML.trim();
							 		break;							 														 							 			
						 	}
						 			document.getElementById('inputTag').value = "";
						    };
						    						 
						</script>									
					</tr>
					<tr>						
						<td><input type="text" class="form-control" placeholder="유튜브 링크를 입력해주세요" name="youtubeLink" id="youtubeLink" maxlength="200">
							</td>
					</tr>
					<script>
					var count = 1;
				     function addRow(){
				    	 if(count != 0) {
				    	 var id = "file" + count;
				    	 var fileCheck = document.getElementById(id).value;
					    if(!fileCheck){
					    	alert("먼저 이미지를 추가해주세요");
					    	return;
					    	}
				    	}
					    if(count >= 10) {
					    	alert("최대 이미지개수는 10개입니다.");
					    	return;
					    } else {
					     var tableData = document.getElementById('writeForm');
					     var row = tableData.insertRow(tableData.rows.length );
					     
					     var cell1 = row.insertCell(0);
					     
					     cell1.innerHTML = "<td><div style='text-align: left;'>"+ ++count +"번 이미지 첨부</div>"
					     					+ "<input type='file' onChange='changeFile()'  id='file"+ count + "' name='file"+ count + "' accept='image/*'> <br>"
					     					+ "<div style='text-align:left;'><span style='color : Red;'>주의: 이미지를 첨부하지 않으면 글의 내용도 저장되지 않습니다.</span></div> <br>"
					     					+ "<textarea class='form-control' placeholder='" + count  +"번째 이미지에 대한 설명을 입력해주세요. (최대 500자)' name='comContent"+ count + "' id='comContent"+ count + "' maxlength='500'  style='resize: none;'></textarea>"
					     					+"</td>";
					     					
					    }
					    				
					} 					
					</script>
					<script>			    
					    function delRow(){
						    if(count <= 0) {
						    	alert("최소 이미지 개수는 0개 입니다.");
						    	return;
						    } else {
						     var tableData = document.getElementById('writeForm');
						     tableData.deleteRow(tableData.rows.length-1); 
						     count--;
						     					
						    }						    
					  } 					
					</script>
					
				<!-- 	<script>
					function changeFile(){
						for(int i=1; i<=count; i++) {
							var id = "file" + count;
							var fileCheck = document.getElementById(id).value;
							if(!fileCheck) {
								tableData.deleteRow(i - (tableData.rows.length + 1));
							} 
						}
						return;
					}
					</script>  -->
					<tr>
						<td>
					<div style="text-align: left;"><input id="delROW" type="button" value="이미지 개수 제거" class="btn btn-primary pull-left" onclick="delRow();" />						 
						 						     <input id="addROW" type="button" value="이미지 개수 추가" class="btn btn-primary pull-left" onclick="addRow();" /> </div>
						</td>
					</tr>
					<tr>
						<td>						
							<div style="text-align: left;">1번 이미지 첨부</div>
						 	<input type="file" id="file1" name="file1" accept="image/*" onChange="changeFile()"> <br>
						 	<div style="text-align:left;"><span style="color : Red;">주의: 이미지를 첨부하지 않으면 글의 내용도 저장되지 않습니다.</span></div> <br>
						 	<textarea class="form-control" placeholder="1번째 이미지에 대한 설명을 입력해주세요. (최대 500자)" name="comContent1" id="comContent1" maxlength="500"  style="resize: none;"></textarea>					 	
						</td>						
					</tr>																
				</tbody>				
			</table>			
			<INPUT TYPE="hidden" NAME="bbsTag1" id="bbsTag1" SIZE=10 value=''>
			<INPUT TYPE="hidden" NAME="bbsTag2" id="bbsTag2" SIZE=10 value=''>
			<INPUT TYPE="hidden" NAME="bbsTag3" id="bbsTag3" SIZE=10 value=''>
			<INPUT TYPE="hidden" NAME="bbsTag4" id="bbsTag4" SIZE=10 value=''>
			<INPUT TYPE="hidden" NAME="bbsTag5" id="bbsTag5" SIZE=10 value=''>
					
			<input  type="submit" onmouseout="check = false;"class="btn btn-primary pull-right" value="글쓰기"/>				
		 </form>
		</div>
	</div>	
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	
<%} %>	
</body>
</html>