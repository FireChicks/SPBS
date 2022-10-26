<%@page import="item.ItemDAO"%>
<%@page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:useBean id="item" class="item.Item" scope="request"></jsp:useBean>
<jsp:setProperty property="*" name="item"/>
<%
	int pageNumber = 1;
	if(request.getParameter("pageNumber") != null) {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
	String searchText = "";
	String search = null;
	boolean searchBbs = false;
	boolean isDesc = true;
	if(request.getParameter("search") != null) {
		searchBbs = true;
		search = request.getParameter("search");
		searchText = request.getParameter("searchText");
	}
	
	boolean isSort = false;
	String sortBy = "";
	if(request.getParameter("sortBy") != null) {
		if(request.getParameter("sortBy").equals("")) {
			isSort = false;
		} else {
			isSort = true;
			sortBy = request.getParameter("sortBy");
		}
	}
	
	if(request.getParameter("isDesc") != null) {
		if(request.getParameter("isDesc").equals("false")) {
			isDesc = false;
		} else {
			isDesc = true;
		}
	}
	
	
	if(searchText.equals("")) {
		searchBbs = false;
	}
	ItemDAO itemDao = new ItemDAO();
	String userID = null; 
	int itemID = 0;
	
	if(request.getParameter("itemID") != null) {
		itemID = Integer.parseInt(request.getParameter("itemID"));
	}
	
	if(session.getAttribute("userID") != null && ((String)session.getAttribute("userID")).equals("admin")) {
	userID = (String)session.getAttribute("userID");
	
			if(itemDao.notHideItem(itemID) == 1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('성공적으로 아이템을 표시 처리했습니다.')");
				script.println("location.href = '../itemManage.jsp?searchText=" + searchText + "&search=" + search + "&pageNumber=" +  pageNumber + "&isDesc=" + isDesc + "&sortBy=" + sortBy +"'");
				script.println("</script>");
			} else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('아이템을 표시 처리하는데 실패했습니다.')");
				script.println("location.href = '../itemManage.jsp?searchText=" + searchText + "&search=" + search + "&pageNumber=" +  pageNumber + "&isDesc=" + isDesc + "&sortBy=" + sortBy +"'");
				script.println("</script>");
			}	
	} else {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('허가되지 않은 접근입니다!')");
	script.println("location.href = '../../main.jsp'");
	script.println("</script>");
	}	
%>
</body>
</html>