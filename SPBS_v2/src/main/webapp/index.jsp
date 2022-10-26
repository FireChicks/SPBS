<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>
<%@ page import="item.ItemShowDAO" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
			
		}
		
		ItemShowDAO itemCategory = new ItemShowDAO();
		int bigCategoryNum = itemCategory.bigCategoryCount();
		String[] bigCategorys = itemCategory.bigCategorys().split("#");
	%>
	
	<nav class="navbar navbar-expand-lg bg-light">
  <div class="container-fluid">
    <a class="navbar-brand" href="main.jsp">
    	<img src="images/logo.png" alt="Bootstrap" width="30" height="24">
    놀빛 수산</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link" href="#">알림</a>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            유저 관리
          </a>
          <%if(userID == null) { %>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="join.jsp">회원 가입</a></li>
            <li><a class="dropdown-item" href="login.jsp">로그인</a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item" href="#">고객 센터</a></li>
          </ul>
          <% } else { %>        
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="logoutAction.jsp">로그 아웃</a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item" href="#">고객 센터</a></li>
          </ul>
          <%if(userID.equals("admin")) { %>
          		<li class="nav-item">
          			<a class="nav-link" href="admin/admin.jsp">관리자</a>
       			 </li>
          		<%} %>        		
          <%}%>    
    </div>
  </div>
</nav>

<nav class="navbar navbar-expand-lg bg-light">
  <div class="container-fluid">
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">           
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            상품
          </a>
          <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
          <li><a class="dropdown-item" href="goods.jsp?searchText=&search=itemID&pageNumber=1&itemBigCategory=&itemSmallCategory=&isDesc=true">전체</a></li>
          <li><hr class="dropdown-divider"></li>
          	<%for(int i=0; i < bigCategoryNum; i++) {%>
            <li><a class="dropdown-item" href="goods.jsp?itemBigCategory=<%=bigCategorys[i]%>"><%=bigCategorys[i]%></a></li>
            <%}%>
          </ul>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">신규</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">특집</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">제철</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">후기</a>
        </li>
      </ul>
      <form class="d-flex" action="goods.jsp" role="search">
        <input class="form-control me-2" type="search" placeholder="상품 검색" aria-label="Search" name="searchText">
        <input type="hidden" name="search" value="itemName">
        <button class="btn btn-outline-success" type="submit">검색</button>
      </form>
    </div>
  </div>
</nav>
</html>