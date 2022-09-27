<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Enumeration"%>
<%@page import="javax.swing.plaf.multi.MultiMenuItemUI"%>
<%@ page import="file.FileDAO" %>
<%@ page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>   
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
		int imgCount = 0;
		if (request.getParameter("imgCount") != null) {
			imgCount = Integer.parseInt(request.getParameter("imgCount"));
		}
		if(bbsID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		} else {
												
		BbsDAO bbsDAO = new BbsDAO();
		String path = application.getRealPath("/resources/bbs/"+ bbsID); //폴더 경로
		File Folder = new File(path);
		
		String bbsImageContent   = new String();
		String bbsImagePath 	= new String();
		String bbsImageRealPath = new String();
		
		
	// 해당 디렉토리가 없을경우 디렉토리를 생성합니다.
		if (!Folder.exists()) {
			try{
		   	 	Folder.mkdir(); //폴더 생성합니다.
	        } 
	        catch(Exception e){
		   		 e.getStackTrace();
		    }        
         }
					
			String directory = application.getRealPath("/resources/bbs/"+bbsID+"/");
			int maxSize = 1024 * 1024 * 100;
			String encoding = "UTF-8";
			
			MultipartRequest multipartRequest
			= new MultipartRequest(request, directory, maxSize, encoding, new DefaultFileRenamePolicy());
			
			String bbsTitle = multipartRequest.getParameter("bbsTitle");
			String bbsContent = multipartRequest.getParameter("bbsContent");
			String youtubeLink = multipartRequest.getParameter("youtubeLink").replace("https://www.youtube.com/watch?v=", "").replace("https://youtube.com/", "").trim();
			
			String tempImagePath = new String();
			String tempRealImagePath = new String();
			String tempImageContent = new String();
			int count = 1;
			
			for(int i= imgCount; i >= 1; i--) {
			if(multipartRequest.getParameter("file"+i) != null) {
				tempImagePath += "#" + multipartRequest.getParameter("file"+i); 
				tempRealImagePath += "#" + multipartRequest.getParameter("file0"+i); 				
				count++;
				}
			}
			
			for(int i = 1; i < count; i++) {
				if(multipartRequest.getParameter("comContent"+i) == null || multipartRequest.getParameter("comContent"+i).trim().isEmpty()) {
					tempImageContent += "#.";  
				} else {
					tempImageContent += "#" + multipartRequest.getParameter("comContent"+ i);
				}
			}
			
			bbsImageContent = tempImageContent; 
			
			if(bbsTitle.trim().isEmpty() || bbsContent.trim().isEmpty()) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else {
			String tags = new String();
			for(int i=1; i<=5; i++ ) {
			tags += multipartRequest.getParameter("bbsTag" + i);
			}
				
				
			Enumeration fileNames = multipartRequest.getFileNames();
			int nonCount = 0;
			while(fileNames.hasMoreElements()) {
				String parameter = (String) fileNames.nextElement();
				String fileName = multipartRequest.getOriginalFileName(parameter);
				String fileRealName = multipartRequest.getFilesystemName(parameter);
	
				if(fileName == null) {
					count++;
					nonCount++;
					continue;
				} else {
					
				fileName= "/BBS/resources/bbs/"+bbsID+"/"+ fileRealName;
				bbsImagePath     += "#" + fileName;
				bbsImageRealPath += "#" + fileRealName ;
				if(multipartRequest.getParameter("comContent" + count).trim().isEmpty()) {
					if(multipartRequest.getParameter("comContent" + (count + 1)).trim().isEmpty()) {
						bbsImageContent     += "#" + ".";
					} else {
						
					}
				} else {
				bbsImageContent     += "#" + multipartRequest.getParameter("comContent" + count);
				} 
				count++;
				}
							
			}
			
			for(int i = count-1; i < ((count-1) + nonCount); i++) {
				if(multipartRequest.getParameter("comContent"+i) == null) {  
				} else {
					bbsImageContent += "#" + multipartRequest.getParameter("comContent"+ i);
				}
			}
			
			bbsImagePath     += tempImagePath;
			bbsImageRealPath += tempRealImagePath;
																											
			int result = bbsDAO.update(bbsID, bbsTitle, bbsContent, tags, bbsImagePath, bbsImageRealPath, bbsImageContent, youtubeLink);
			if(result == - 1) {	
				PrintWriter script = response.getWriter(); 
				script.println("<script>");
				script.println("alert('글쓰기에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else {						
				PrintWriter script = response.getWriter(); 
				script.println("<script>");
				script.println("alert('성공적으로 수정을 완료했습니다.')");
				script.println("location.href = 'bbs.jsp'");
				script.println("</script>");			
			}
		}
			}
		
	}
	%>
	
</body>
</html>