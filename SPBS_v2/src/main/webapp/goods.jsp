<%@page import="parameter.ItemPageParameter"%>
<%@page import="item.Item"%>
<%@page import="java.util.ArrayList"%>
<%@page import="item.ItemShowDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.outer-div {
  width : 100%;
  height : 300px;
  background-color : blue;
}

.inner-div {
  width : 500px;
  height : 100px;
  background-color: red;
  margin: auto;
}
td{
	width:100px;
	border:1px;	
}
</style>
</head>
<body>
<% 
	int pageNumber = 1;
	if(request.getParameter("pageNumber") != null) {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
	String searchText = "";
	String search = "itemID";
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
	
	
	if(searchText == null || searchText.equals("")) {
		searchBbs = false;
	}
	
	String itemBigCategory = ""; //1차 카테고리 받기
	String itemSmallCategory = "";
	boolean isBigSort = false;
	boolean isSmallSort = false;
	if(request.getParameter("itemBigCategory") != null) {
		itemBigCategory = request.getParameter("itemBigCategory");
		isBigSort = true;
	}
	
	
	
	boolean isSeasonAvail = false;
	String[] seasons = null;
	ItemShowDAO itemDAO = new ItemShowDAO();
	int maxPageNum = itemDAO.maxPageNum();
	
	int bigCategoryNum = itemDAO.bigCategoryCount();
	String[] bigCategorys = itemDAO.bigCategorys().split("#"); //1차 카테고리 가져오기
	
	int smallCategoryNum = 0;
	String[] smallCategorys = null;
	
	if(isBigSort) {
		if(request.getParameter("itemSmallCategory") != null) {
			itemSmallCategory = request.getParameter("itemSmallCategory");
			isSmallSort = true;			
		}
		if(itemBigCategory != null && !itemBigCategory.equals("")) {
		smallCategoryNum = itemDAO.smallCategoryCount(itemBigCategory.trim());
		smallCategorys = itemDAO.smallCategorys(itemBigCategory.trim()).split("#"); //2차 카테고리 가져오기
		}
	}
%>

<%
					ItemPageParameter itemPara = new ItemPageParameter();
					itemPara.setDesc(isDesc);
					itemPara.setSearch(searchBbs);
					itemPara.setSortBy(isSort);
					itemPara.setBigSort(isBigSort);
					itemPara.setSmallSort(isSmallSort);
					itemPara.setItemBigCategory(itemBigCategory);
					itemPara.setItemSmallCategory(itemSmallCategory);
					itemPara.setPageNumber(pageNumber);
					itemPara.setSearch(search);
					itemPara.setSearchText(searchText);
					itemPara.setSortBy(sortBy);
					ArrayList<Item> items;
					if((!isSort || sortBy.equals(""))&& (!searchBbs || search.equals("")) && (!isBigSort || itemBigCategory.equals(""))) {
						if(isDesc) {
						items = itemDAO.getList(pageNumber);	
						} else {
						items = itemDAO.getList(pageNumber, isDesc);	
						}
					}else{
					 	items = itemDAO.getList(itemPara);		
					}
%>

<jsp:include page="index.jsp"></jsp:include>
<div class='outer-div'>
  <div class='inner-div'>
  <div style=" margin:0 auto;">
  	<table>
  		<tr>
	  		<td>아이템 카테고리 <form action = "goods.jsp">
			아이템 1차 카테고리 : 
				<select id="itemBigCategory" name="itemBigCategory" class="form-select" aria-label="Default select example" onChange={this.onChange.bind(this)}>
					<option value="%">전체</option>
					<%for(int i=0; i < bigCategoryNum; i++) {%>
					<option value="<%=bigCategorys[i]%>" <%if(isBigSort){ if(itemBigCategory.equals(bigCategorys[i])) {%> <%="selected"%> <%} else {%> <%=""%> <%}}%> ><%=bigCategorys[i]%></option>	
					<%} %>		
				</select> 				
				<input type="hidden" name="isDesc" value="<%=isDesc%>">
				
				<script>
				$(document).ready(function(){
   					 $('#itemBigCategory').on('change', function() {
   						alert(this.value);
   						var url = "goods.jsp?itemBigCategory="+this.value+"&searchText=<%=searchText%>&search=<%=search%>&pageNumber=<%=pageNumber%>&sortBy=<%=sortBy%>&isDesc=<%=isDesc%>"; 
   						location.replace(url);  
    				});
				});
			</script> 				
			</form></td>
	  		
	  		<td> <%if(isBigSort && !itemBigCategory.equals("전체")){%>
	  		<form action = "goods.jsp">
			아이템 2차 카테고리 : 
				<select id="itemSmallCategory" name="itemSmallCategory" class="form-select" aria-label="Default select example" onChange={this.onChange.bind(this)}>
					<option value="%">선택 안함</option>	
					<%for(int i=0; i < smallCategoryNum; i++) {%>
					<option value="<%=smallCategorys[i]%>" <%if(isSmallSort){ if(itemSmallCategory.equals(smallCategorys[i].trim())) {%> <%="selected"%> <%} else {%> <%=""%> <%}}%> ><%=smallCategorys[i]%></option>	
					<%} %>		
				</select> 				
				<input type="hidden" name="isDesc" value="<%=isDesc%>">
				
				<script>
				$(document).ready(function(){
   					 $('#itemSmallCategory').on('change', function() {
   						alert(this.value);
   						var url = "goods.jsp?itemSmallCategory="+this.value+"&searchText=<%=searchText%>&search=<%=search%>&pageNumber=<%=pageNumber%>&itemBigCategory=<%=itemBigCategory%>&sortBy=<%=sortBy%>&isDesc=<%=isDesc%>"; 
   						location.replace(url);  
    				});
				});
			</script> 				
			</form>
			<%}%>
			</td>
	  		
	  		<td><form action = "goods.jsp">
			정렬기준 
				<select id="sortBy" name="sortBy" id="searchOption" class="form-select" aria-label="Default select example" onChange={this.onChange.bind(this)}>
					<option value="itemID" <%if(search != null){ if(sortBy.matches("itemID")) {%> <%="selected"%> <%} else {%> <%=""%> <%}}%> >아이템 ID</option>
					<option value="itemName" <%if(search != null){ if(sortBy.matches("itemName")){%><%="selected"%> <%} else{%> <%=""%> <%}}%> >아이템 이름</option>
					<option value="itemPrice" <%if(search != null){ if(sortBy.matches("itemPrice")){%><%="selected"%> <%} else{%> <%=""%> <%}}%> >아이템 가격</option>
					<option value="itemStock" <%if(search != null){ if(sortBy.matches("itemStock")){%><%="selected"%> <%} else{%> <%=""%> <%}}%> >아이템 재고</option>
					<option value="itemSaleCount" <%if(search != null){ if(sortBy.matches("itemSaleCount")){%><%="selected"%> <%} else{%> <%=""%> <%}}%> >아이템 판매량</option>					
					
				</select> 				
				<input type="hidden" name="isDesc" value="<%=isDesc%>">	
				<script>
				$(document).ready(function(){
   					 $('#sortBy').on('change', function() {
   						alert(this.value);
   						var url = "goods.jsp?sortBy="+this.value+"&searchText=<%=searchText%>&search=<%=search%>&pageNumber=<%=pageNumber%><%if(isBigSort){%>&itemBigCategory=<%=itemBigCategory%><%}%><%if(isSmallSort){%>&itemSmallCategory=<%=itemSmallCategory%><%}%>&sortBy=<%=sortBy%>&isDesc=<%=isDesc%>"; 
   						location.replace(url);  
    				});
				});				

			</script></form> </td>
	  		
	  		<td><%if(isDesc) {%>
								<a href="goods.jsp?searchText=<%=searchText%>&search=<%=search%>&pageNumber=<%=pageNumber%><%if(isBigSort){%>&itemBigCategory=<%=itemBigCategory%><%}%><%if(isSmallSort){%>&itemSmallCategory=<%=itemSmallCategory%><%}%>&sortBy=<%=sortBy%>&isDesc=true" class="btn btn-primary btn-arraw-Right">내림차 순</a>
								<a href="goods.jsp?searchText=<%=searchText%>&search=<%=search%>&pageNumber=<%=pageNumber%><%if(isBigSort){%>&itemBigCategory=<%=itemBigCategory%><%}%><%if(isSmallSort){%>&itemSmallCategory=<%=itemSmallCategory%><%}%>&sortBy=<%=sortBy%>&isDesc=false" class="btn btn-light btn-arraw-Right">오름차 순</a>
								<%} else { %>
								<a href="goods.jsp?searchText=<%=searchText%>&search=<%=search%>&pageNumber=<%=pageNumber%><%if(isBigSort){%>&itemBigCategory=<%=itemBigCategory%><%}%><%if(isSmallSort){%>&itemSmallCategory=<%=itemSmallCategory%><%}%>&sortBy=<%=sortBy%>&isDesc=true" class="btn btn-light btn-arraw-Right">내림차 순</a>
								<a href="goods.jsp?searchText=<%=searchText%>&search=<%=search%>&pageNumber=<%=pageNumber%><%if(isBigSort){%>&itemBigCategory=<%=itemBigCategory%><%}%><%if(isSmallSort){%>&itemSmallCategory=<%=itemSmallCategory%><%}%>&sortBy=<%=sortBy%>&isDesc=false" class="btn btn-primary btn-arraw-Right">오름차 순</a>
								<%} %>
			</td>
  		</tr>
  </table>
  <%for(int i=0; i<items.size(); i++){%>
  	<%=items.get(i).getItemID()%>
  <%}%>
  총 갯수: <%=items.size()%>
  </div>
  </div>
</div>	
</body>
</html>