<%@page import="java.util.Arrays"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="item.ItemDAO" %>
<%@ page import="item.Item" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="index.jsp"></jsp:include>
<%
	int itemID = 1;
	if(request.getParameter("itemID") == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비정상적인 접근입니다!')");
		script.println("location.href = '../../main.jsp'");
		script.println("</script>");
	} else {
		itemID = Integer.parseInt(request.getParameter("itemID"));
		ItemDAO itemDAO = new ItemDAO();
		Item item = itemDAO.getItem(itemID);
		
		boolean isSeasonAvail = false;
		String[] seasons = null;
		if(!item.getItemSeason().equals("")) {
		seasons = item.getItemSeason().split("/");
		int seasonLen = seasons.length;
		isSeasonAvail = true;
		}
		
%>
<main class="d-flex flex-nowrap">
<div class="b-example-divider b-example-vr"></div>

  <div class="d-flex flex-column flex-shrink-0 p-3 bg-light" style="width: 280px;">
    <a href="../admin/admin.jsp" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto link-dark text-decoration-none">
      <svg class="bi pe-none me-2" width="40" height="32"><use xlink:href="#bootstrap"/></svg>
      <span class="fs-4">관리자 메뉴</span>
    </a>
    <hr>
    <ul class="nav nav-pills flex-column mb-auto">
      <li class="nav-item">
        <a href="../admin/itemManage.jsp" class="nav-link active"  aria-current="page">
          <svg class="bi pe-none me-2" width="16" height="16"><use xlink:href="itemMangement.jsp"/></svg>
          상품 관리
        </a>
      </li>
      <li>
        <a href="#" class="nav-link link-dark">
          <svg class="bi pe-none me-2" width="16" height="16"><use xlink:href="#speedometer2"/></svg>
          배송 관리
        </a>
      </li>
      <li>
        <a href="#" class="nav-link link-dark">
          <svg class="bi pe-none me-2" width="16" height="16"><use xlink:href="#table"/></svg>
          특집 글 관리
        </a>
      </li>
      <li>
        <a href="#" class="nav-link link-dark">
          <svg class="bi pe-none me-2" width="16" height="16"><use xlink:href="#grid"/></svg>
          후기 관리
        </a>
      </li>
      <li>
        <a href="#" class="nav-link link-dark">
          <svg class="bi pe-none me-2" width="16" height="16"><use xlink:href="#people-circle"/></svg>
          메인 이미지 관리
        </a>
      </li>
    </ul>      
  </div>
    <div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top : 18px;">
				<form method="post" action="adminAction/imageUpdateAction.jsp?itemID=<%=itemID%>" enctype="multipart/form-data">
					<%if(item.getItemContentImagePath() != null && !item.getItemContentImagePath().equals("") ) { %>	
		<div style="float:left; width:100%;">
			<div class="jumbotron" style="padding-top : 18px;">
					<h3 style="text-align: center;">이미지 추가</h3>
					<hr>
					<%String[] imagePaths = item.getItemContentImagePath().split("#");%>
					<%String[] imageRealPaths = item.getItemContentImageRealPath().split("#");%>
					<div>
						대표 이미지 	    	<input type="file" name="file2" class="form-control" accept="image/*" value="<%=imagePaths[0]%>">
						<img src="<%=imagePaths[0]%>" width="100px" height="100px" alt="이미지 오류"> <%=imageRealPaths[0]%>																								
					</div>	
					<br>	
					<div>
						상품 설명 이미지 	    <input type="file" name="file1" class="form-control" accept="image/*" value="<%=imagePaths[1]%>">
						<img src="<%=imagePaths[1]%>" width="100px" height="100px" alt="이미지 오류"> <%=imageRealPaths[1]%>
					</div>	
					<input type="hidden" name="originalItemPath" value="<%=item.getItemContentImagePath()%>">
					<input type="hidden" name="originalItemRealPath" value="<%=item.getItemContentImageRealPath()%>"> 	
					<a style="color:red;">주의: 이미지 삽입시 원래 이미지는 지워집니다.</a>
				</div>
				</div>
				<%}else{%>
				<div style="float:left; width:100%;">
				<div class="jumbotron" style="padding-top : 18px;">
					<h3 style="text-align: center;">이미지 추가</h3>
					<hr>
						<div>
						대표 이미지 	    	<input type="file" name="file2" class="form-control" accept="image/*"> <br>
						상품 설명 이미지 	    <input type="file" name="file1" class="form-control" accept="image/*">													
						</div>			
					</div>
				</div>
				<%}%>
				<input type="submit" class="btn btn-primary form-control" value="제출">	
				</form>				
			</div>
		</div>
	</div>
</main>		
</body>
<%}%>
</html>