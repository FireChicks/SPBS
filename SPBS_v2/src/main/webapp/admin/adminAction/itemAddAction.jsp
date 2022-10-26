<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
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
	ItemDAO itemDao = new ItemDAO();
	String userID = null;
	String itemSeason = new String();
	itemSeason = "";
	item.setItemSeason(itemSeason);
	
	ItemDAO itemDAO = new ItemDAO();
	String path = application.getRealPath("/resources/item/"+ itemDAO.getNext()); //폴더 경로
	File Folder = new File(path);
	
	String itemImageContent     = new String();
	String itemImagePath 	    = new String();
	String itemImageRealPath    = new String();
	
// 해당 디렉토리가 없을경우 디렉토리를 생성합니다.
	if (!Folder.exists()) {
		try{
	   	 	Folder.mkdir(); //폴더 생성합니다.
        } 
        catch(Exception e){
	   		 e.getStackTrace();
	    }        
     }
				
		String directory = application.getRealPath("/resources/item/"+itemDAO.getNext()+"/");
		int maxSize = 1024 * 1024 * 100;
		String encoding = "UTF-8";
		
		MultipartRequest multipartRequest
		= new MultipartRequest(request, directory, maxSize, encoding, new DefaultFileRenamePolicy());
		
		int pageNumber = 1;
		if(multipartRequest.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(multipartRequest.getParameter("pageNumber"));
		}
		String searchText = "";
		String search = null;
		boolean searchBbs = false;
		boolean isDesc = true;
		if(multipartRequest.getParameter("search") != null) {
			searchBbs = true;
			search = multipartRequest.getParameter("search");
			searchText = multipartRequest.getParameter("searchText");
		}
		
		boolean isSort = false;
		String sortBy = "";
		if(multipartRequest.getParameter("sortBy") != null) {
			if(multipartRequest.getParameter("sortBy").equals("")) {
				isSort = false;
			} else {
				isSort = true;
				sortBy = multipartRequest.getParameter("sortBy");
			}
		}
		
		if(multipartRequest.getParameter("isDesc") != null) {
			if(multipartRequest.getParameter("isDesc").equals("false")) {
				isDesc = false;
			} else {
				isDesc = true;
			}
		}	
		
		
		if(searchText.equals("")) {
			searchBbs = false;
		}
		
		
		for(int i=1; i <= 12; i++) {
			if(multipartRequest.getParameter("season"+i) != null) {
				itemSeason += multipartRequest.getParameter("season"+i) + "/";
			}
		}
		item.setItemName(multipartRequest.getParameter("itemName"));
		item.setItemContent(multipartRequest.getParameter("itemContent"));
		item.setItemStock(Integer.parseInt(multipartRequest.getParameter("itemStock")));
		item.setItemPrice(Integer.parseInt(multipartRequest.getParameter("itemPrice")));
		item.setItemSeason(itemSeason);
		item.setItemBigCategory(multipartRequest.getParameter("itemBigCategory"));
		item.setItemSmallCategory(multipartRequest.getParameter("itemSmallCategory"));
		item.setItemUnit(multipartRequest.getParameter("itemUnit"));		
												
		int count = 1;		
		
		Enumeration fileNames = multipartRequest.getFileNames();
		while(fileNames.hasMoreElements()) {
			String parameter = (String) fileNames.nextElement();
			String fileName = multipartRequest.getOriginalFileName(parameter);
			String fileRealName = multipartRequest.getFilesystemName(parameter);
				
			if(fileName == null) {
				continue;
			} else {
				
			fileName= "/SPBS/resources/item/"+itemDAO.getNext()+"/"+ fileRealName;
			itemImagePath     +=  fileName     + "#";
			itemImageRealPath +=  fileRealName + "#";
			
			}			
		}
		
		if(itemImagePath != null && !itemImagePath.equals("")) {
			itemImagePath = itemImagePath.substring(0, itemImagePath.length() - 1);
			itemImageRealPath = itemImageRealPath.substring(0, itemImageRealPath.length() - 1);  //맨 끝에 # 제거
			
			item.setItemContentImagePath(itemImagePath);
			item.setItemContentImageRealPath(itemImageRealPath);
			}
	
	if(session.getAttribute("userID") != null && ((String)session.getAttribute("userID")).equals("admin")) {
	userID = (String)session.getAttribute("userID");
	
	if(item.getItemName() != null && item.getItemContent() != null && item.getItemUnit() != null && item.getItemBigCategory() != null && item.getItemSmallCategory() != null) {
			itemDao.write(item);
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('성공적으로 아이템을 추가했습니다.')");
			script.println("location.href = '../itemManage.jsp?searchText=" + searchText + "&search=" + search + "&pageNumber=" +  pageNumber + "&isDesc=" + isDesc + "&sortBy=" + sortBy +"'");
			script.println("</script>");
			
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력되지않은 값이 있습니다.')");
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