<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Enumeration"%>
<%@page import="javax.swing.plaf.multi.MultiMenuItemUI"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="file.FileDAO" %>
<%@ page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>    
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
							
		BbsDAO bbsDAO = new BbsDAO();
		String path = application.getRealPath("/resources/bbs/"+ bbsDAO.getNext()); //폴더 경로
		File Folder = new File(path);
		
		String bbsImageContent     = new String();
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
					
			String directory = application.getRealPath("/resources/bbs/"+bbsDAO.getNext()+"/");
			int maxSize = 1024 * 1024 * 100;
			String encoding = "UTF-8";
			
			MultipartRequest multipartRequest
			= new MultipartRequest(request, directory, maxSize, encoding, new DefaultFileRenamePolicy());
			
			String bbsTitle = multipartRequest.getParameter("bbsTitle");
			String bbsContent = multipartRequest.getParameter("bbsContent");
			String youtubeLink = multipartRequest.getParameter("youtubeLink").replace("https://www.youtube.com/watch?v=", "").replace("https://youtube.com/", "").trim();
			
			
			
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
				
			int count = 1;		
			Enumeration fileNames = multipartRequest.getFileNames();
			while(fileNames.hasMoreElements()) {
				String parameter = (String) fileNames.nextElement();
				String fileName = multipartRequest.getOriginalFileName(parameter);
				String fileRealName = multipartRequest.getFilesystemName(parameter);
					
				if(fileName == null) {
					count++;
					continue;
				} else {
					
				fileName= "/BBS/resources/bbs/"+bbsDAO.getNext()+"/"+ fileRealName;
				bbsImagePath     += "#" + fileName;
				bbsImageRealPath += "#" + fileRealName ;
				if(multipartRequest.getParameter("comContent" + count).trim().isEmpty()) {
					bbsImageContent  += "#"+".";
				} else {
				bbsImageContent     += "#" + multipartRequest.getParameter("comContent" + count);
				}
				count++;
				out.write("성공적으로 파일이 업로드 되었습니다.");
				}
			}
				
																															
			int result = bbsDAO.write(bbsTitle, userID, bbsContent, tags, bbsImagePath, bbsImageRealPath, bbsImageContent, youtubeLink);
			if(result == - 1) {	
				PrintWriter script = response.getWriter(); 
				script.println("<script>");
				script.println("alert('글쓰기에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else {						
				PrintWriter script = response.getWriter(); 
				script.println("<script>");
				script.println("location.href = 'bbs.jsp'");
				script.println("</script>");			
			}
		}
	}
	%>
	
	
</body>
</html>