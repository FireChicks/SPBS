<%@page import="java.util.Collections"%>
<%@page import="java.util.ArrayList"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="item.ItemDAO" %>
<%@ page import="item.Item" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	tr {
	width: 800px;
	height: 10px;
	margin-top: 10px;
	padding-top: 10px;
	}
</style>
</head>
<body>
<jsp:include page="index.jsp"></jsp:include>
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
	
	boolean isSeasonAvail = false;
	String[] seasons = null;
	
	ItemDAO itemDAO = new ItemDAO();
	int maxPageNum = itemDAO.maxPageNum();
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
		<div class="col-mg-10">
			<div class="jumbotron" style="padding-top : 18px;">			
				<h3 style="text-align: center;">목록</h3>
				<hr>
				<table class="table table-stirped" style="text-align: center; border: 1px solid #dddddd; font-size: 8pt;">
				<thead>
					<tr>
						<td><a href="itemManage.jsp?searchText=<%=searchText%>&search=<%=search%>&pageNumber=<%=pageNumber%>&sortBy=itemID&isDesc=<%=isDesc%>">아이템<br>ID</a></td>
						<td><a href="itemManage.jsp?searchText=<%=searchText%>&search=<%=search%>&pageNumber=<%=pageNumber%>&sortBy=itemName&isDesc=<%=isDesc%>">아이템<br>이름</a></td>
						<td><a href="itemManage.jsp?searchText=<%=searchText%>&search=<%=search%>&pageNumber=<%=pageNumber%>&sortBy=itemPrice&isDesc=<%=isDesc%>">아이템<br>가격</a></td>
						<td><a href="itemManage.jsp?searchText=<%=searchText%>&search=<%=search%>&pageNumber=<%=pageNumber%>&sortBy=itemStock&isDesc=<%=isDesc%>">아이템<br>재고</a></td>
						<td>아이템<br>단위</td>
						<td>아이템<br>내용</td>
						<td>아이템<br>세일</td>
						<td>아이템<br>제철</td>
						<td>아이템<br>1차 카테고리</td>
						<td>아이템<br>2차 카테고리</td>
						<td>아이템<br>이미지</td>
						<td><a href="itemManage.jsp?searchText=<%=searchText%>&search=<%=search%>&pageNumber=<%=pageNumber%>&sortBy=itemSaleCount&isDesc=<%=isDesc%>">아이템<br>판매량</a></td>
						<td><a href="itemManage.jsp?searchText=<%=searchText%>&search=<%=search%>&pageNumber=<%=pageNumber%>&sortBy=itemAvailable&isDesc=<%=isDesc%>">아이템<br>표시 여부</a></td>
						<td><%if(isDesc) {%>
							<a href="itemManage.jsp?searchText=<%=searchText%>&search=<%=search%>&pageNumber=<%=pageNumber%>&sortBy=<%=sortBy%>" class="btn btn-primary btn-arraw-Right">내림차 순</a>
							<a href="itemManage.jsp?searchText=<%=searchText%>&search=<%=search%>&pageNumber=<%=pageNumber%>&sortBy=<%=sortBy%>&isDesc=false" class="btn btn-light btn-arraw-Right">오름차 순</a>
							<%} else { %>
							<a href="itemManage.jsp?searchText=<%=searchText%>&search=<%=search%>&pageNumber=<%=pageNumber%>&sortBy=<%=sortBy%>" class="btn btn-light btn-arraw-Right">내림차 순</a>
							<a href="itemManage.jsp?searchText=<%=searchText%>&search=<%=search%>&pageNumber=<%=pageNumber%>&sortBy=<%=sortBy%>&isDesc=false" class="btn btn-primary btn-arraw-Right">오름차 순</a>
							<%} %></td>						
					</tr>				
					<%
					ArrayList<Item> items = null;
					if(isSort) {
						if(!searchBbs){
							if(!isDesc) { // 오름차순
								items = itemDAO.getList(pageNumber, sortBy, isDesc); //정렬 카테고리 O / 검색 X
							} else{	//내림차순
								items = itemDAO.getList(pageNumber, sortBy); //정렬 카테고리 O / 검색 X
							}							
							} else {
								if(!isDesc) { // 오름차순
									items = itemDAO.sortByIDList(pageNumber, search, searchText, sortBy, isDesc); //정렬 카테고리 O / 검색 O
								} else{	//내림차순
									items = itemDAO.sortByIDList(pageNumber, search, searchText, sortBy); //정렬 카테고리 O / 검색 O
								}								
						}
					} else {
						if(!searchBbs){
							if(!isDesc) {
								items = itemDAO.getList(pageNumber, isDesc); //정렬 카테고리 X / 검색 X
							} else {
								items = itemDAO.getList(pageNumber); //정렬 카테고리 X / 검색 X
							}
						} else {
							if(!isDesc) {
								items = itemDAO.searchByIDList(pageNumber, search, searchText, isDesc); //정렬 카테고리 X / 검색 O
							} else {
								items = itemDAO.searchByIDList(pageNumber, search, searchText); //정렬 카테고리 X / 검색 O
							}
						}						
					}				
					%>
					
					<% for(int i = 0; i < items.size(); i++) {%>
					<%
					int seasonLen = 0;
					if(!items.get(i).getItemSeason().equals("")) {
						seasons = items.get(i).getItemSeason().split("/");
						seasonLen = seasons.length;
						isSeasonAvail = true;
						}
					%>
					<tr>
						<td><%=items.get(i).getItemID()%></td>
						<td><a href="itemUpdate.jsp?itemID=<%=items.get(i).getItemID()%>"><%=items.get(i).getItemName()%></a></td>
						<td><%=items.get(i).getItemPrice()%></td>
						<td><%=items.get(i).getItemStock()%></td>
						<td><%=items.get(i).getItemUnit()%></td>
						<td><%=items.get(i).getItemContent()%></td>
						<td><%=items.get(i).getItemSale() %></td>
						<td><%if(isSeasonAvail){for(int j = 0; j < seasonLen; j++) {%><%=seasons[j]%>월 <%}}%></td>
						<td><a href="itemManage.jsp?searchText=<%=items.get(i).getItemBigCategory()%>&search=<%="itemBigCategory"%>&sortBy=<%=sortBy%>&isDesc=<%=isDesc%>"><%=items.get(i).getItemBigCategory()%></a></td>
						<td><%=items.get(i).getItemSmallCategory()%></td>
						<td><a href="imageUpdate.jsp?itemID=<%=items.get(i).getItemID()%>">
						    <%if(items.get(i).getItemContentImagePath() != null && !items.get(i).getItemContentImagePath().equals("") ) { %>							
							<%String[] imagePaths = items.get(i).getItemContentImageRealPath().split("#");%>
								<%for(String image : imagePaths) {%>		
									<%=image%><br>
								<%}%>
							<%} else {%>
									<%="없음"%>
							<%}%>
							</a>
						</td>						
						<td><%=items.get(i).getItemSaleCount()%></td>
						<td><%if(items.get(i).getItemAvailable() == 1) {%><%="표시"%><%}else{%><%="비표시"%><%}%></td>
						<td><a href="itemUpdate.jsp?itemID=<%=items.get(i).getItemID()%>" class="btn btn-primary btn-arraw-Left btn-sm">수정</a>
						<a onclick="confirmModal<%=i%>()" class="btn btn-danger btn-arraw-Left btn-sm">삭제</a>
						<a href="adminAction/itemNotHideAction.jsp?itemID=<%=items.get(i).getItemID()%>&searchText=<%=searchText%>&search=<%=search%>&pageNumber=<%= pageNumber%>&isDesc=<%=isDesc%>&sortBy=<%=sortBy%>" class="btn btn-info btn-arraw-Left btn-sm">표시</a>
						<a href="adminAction/itemHideAction.jsp?itemID=<%=items.get(i).getItemID()%>&searchText=<%=searchText%>&search=<%=search%>&pageNumber=<%= pageNumber%>&isDesc=<%=isDesc%>&sortBy=<%=sortBy%>" class="btn btn-secondary btn-arraw-Left btn-sm">비표시</a></td>	
						<script> //삭제 확인 스크립트
      					function confirmModal<%=i%>() {
        					if (window.confirm("정말 삭제하시겠습니까?")) {
         						location.href = "adminAction/itemDeleteAction.jsp?itemID=<%=items.get(i).getItemID()%>&searchText=<%=searchText%>&search=<%=search%>&pageNumber=<%= pageNumber%>&isDesc=<%=isDesc%>&sortBy=<%=sortBy%>";
       						} else {
          					console.log("삭제를 취소하였습니다.");
       						 }
      					}
    					</script>					
					</tr>						
					<%}%>				
				</thead>
				</table>
				<%
				if(pageNumber != 1) {
			%>
				<a href="itemManage.jsp?searchText=<%=searchText%>&search=<%=search%>&pageNumber=<%= pageNumber - 1%>&isDesc=<%=isDesc%>&sortBy=<%=sortBy%>" class="btn btn-light btn-arraw-Left">이전</a>
			<%
				} if(itemDAO.nextPage(pageNumber + 1, search, searchText)) {
			%>
				<a href="itemManage.jsp?searchText=<%=searchText%>&search=<%=search%>&pageNumber=<%= pageNumber + 1%>&isDesc=<%=isDesc%>&sortBy=<%=sortBy%>" class="btn btn-light btn-arraw-Left">다음</a>
			<%
				}
			%>						
			<a href="itemAdd.jsp" class="btn btn-primary float-right btn-sm">추가</a>			
			<form action = "itemManage.jsp?searchText=<%=searchText%>&search=<%=search%>&isDesc=<%=isDesc%>" method="post">
			페이지 이동 : 
			<%if(!searchBbs){ %>
			<input type="number" value="<%=pageNumber%>" name="pageNumber" min="1" max="<%=maxPageNum%>"/>
			<input type="submit" class="btn btn-success btn-sm" value="이동">
			<input type="hidden" name="isDesc" value="<%=isDesc%>">
			<input type="hidden" name="sortBy" value="<%=sortBy%>">
			<%} else {%>
			<input type="number" value="<%=pageNumber%>" name="pageNumber" min="1" max="<%=itemDAO.maxPageNum(pageNumber, search, searchText)%>"/>
			<input type="submit" class="btn btn-success btn-sm" value="이동">
			<input type="hidden" name="isDesc" value="<%=isDesc%>">
			<input type="hidden" name="sortBy" value="<%=sortBy%>">
			<%}%>
			</form> 
			<div style="justify-content: right;" class="btn btn-priamary">
			<form action = "itemManage.jsp" method="post">
			정렬기준 
				<select id="sortBy" name="sortBy" id="searchOption" class="form-select" aria-label="Default select example" onChange={this.onChange.bind(this)}>
					<option value="itemID" <%if(search != null){ if(sortBy.matches("itemID")) {%> <%="selected"%> <%} else {%> <%=""%> <%}}%> >아이템 ID</option>
					<option value="itemName" <%if(search != null){ if(sortBy.matches("itemName")){%><%="selected"%> <%} else{%> <%=""%> <%}}%> >아이템 이름</option>
					<option value="itemPrice" <%if(search != null){ if(sortBy.matches("itemPrice")){%><%="selected"%> <%} else{%> <%=""%> <%}}%> >아이템 가격</option>
					<option value="itemStock" <%if(search != null){ if(sortBy.matches("itemStock")){%><%="selected"%> <%} else{%> <%=""%> <%}}%> >아이템 재고</option>
					<option value="itemSaleCount" <%if(search != null){ if(sortBy.matches("itemSaleCount")){%><%="selected"%> <%} else{%> <%=""%> <%}}%> >아이템 판매량</option>
					<option value="itemAvailable" <%if(search != null){ if(sortBy.matches("itemAvailable")){%><%="selected"%> <%} else{%> <%=""%> <%}}%> >아이템 표시 여부</option>
					
				</select> 				
				<input type="hidden" name="isDesc" value="<%=isDesc%>">
				<script>
				$(document).ready(function(){
   					 $('#sortBy').on('change', function() {
   						alert(this.value);
   						var url = "itemManage.jsp?sortBy="+this.value+"&searchText=<%=searchText%>&search=<%=search%>&pageNumber=<%=pageNumber%>&isDesc=<%=isDesc%>"; 
   						location.replace(url);  
    				});
				});

			</script> 
				
			</form>	
			</div>
						
			<div style="display: flex; justify-content: center;" class="btn btn-priamary">
			<form action = "itemManage.jsp">
				<select name="search" id="searchOption" class="form-select" aria-label="Default select example" onChange={this.onChange.bind(this)}>
					<option value="itemID" <%if(search != null){ if(search.matches("itemID")) {%> <%="selected"%> <%} else {%> <%=""%> <%}}%> >아이템 ID</option>
					<option value="itemName" <%if(search != null){ if(search.matches("itemName")){%><%="selected"%> <%} else{%> <%=""%> <%}}%> >아이템 이름</option>
					<option value="itemBigCategory" <%if(search != null){ if(search.matches("itemBigCategory")){%><%="selected"%> <%} else{%> <%=""%> <%}}%> >아이템 1차 카테고리</option>
					<option value="itemSmallCategory" <%if(search != null){ if(search.matches("itemSmallCategory")){%><%="selected"%> <%} else{%> <%=""%> <%}}%> >아이템 2차 카테고리</option>					
				</select> 				
				<input name="searchText" type="text"  value=<%=searchText%>>
				<input type="hidden" name="isDesc" value="<%=isDesc%>">
				<input type="hidden" name="sortBy" value="<%=sortBy%>">
				<input type="submit" class="btn btn-success btn-sm" value="조회">
			</form>	
			</div>
		</div>
	</div>
</main>		
</body>

</html>