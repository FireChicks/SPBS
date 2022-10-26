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
		<div class="col-lg-4" style="float:left; width:60%; padding-right:20px;">
			<div class="jumbotron" style="padding-top : 18px;">
				<form method="post" action="adminAction/itemAddAction.jsp" enctype="multipart/form-data">
					<h3 style="text-align: center;">아이템 추가</h3>
					<hr>
					<div class="form-group" padding-bottom:20px;>
						아이템 이름 	    <input type="text" class="form-control" placeholder="아이템 이름" name="itemName" maxlength="20">
						아이템 가격 	    <input type="text" class="form-control" placeholder="아이템 가격" name="itemPrice" maxlength="20">
						아이템 재고 	    <input type="text" class="form-control" placeholder="아이템 재고" name="itemStock" maxlength="20">																 
						아이템 단위 	 	 <input type="text" class="form-control" placeholder="아이템 단위" name="itemUnit" maxlength="20">
						아이템 1차 카테고리 	 <input type="text" class="form-control" placeholder="아이템 1차 카테고리" name="itemBigCategory" maxlength="20">
						아이템 2차 카테고리 	 <input type="text" class="form-control" placeholder="아이템 2차 카테고리" name="itemSmallCategory" maxlength="20">
						아이템 내용		    <textarea class="form-control" placeholder="아이템 내용을 입력해주세요." name="itemContent" maxlength="1000" style="height: 70px; resize: none;"></textarea>
						아이템 제철 계절<br> <input type="checkbox" class="btn-check" id="season1" name="season1" value="1" autocomplete="off"><label class="btn btn-light btn-sm" for="season1" >1월&nbsp;</label>
										 <input type="checkbox" class="btn-check" id="season2" name="season2" value="2" autocomplete="off"><label class="btn btn-light btn-sm" for="season2" >2월&nbsp;</label>
										 <input type="checkbox" class="btn-check" id="season3" name="season3" value="3" autocomplete="off"><label class="btn btn-light btn-sm" for="season3" >3월&nbsp;</label>
										 <input type="checkbox" class="btn-check" id="season4" name="season4" value="4" autocomplete="off"><label class="btn btn-light btn-sm" for="season4" >4월&nbsp;</label>
								 		 <input type="checkbox" class="btn-check" id="season5" name="season5" value="5" autocomplete="off"><label class="btn btn-light btn-sm" for="season5" >5월&nbsp;</label>
										 <input type="checkbox" class="btn-check" id="season6" name="season6" value="6" autocomplete="off"><label class="btn btn-light btn-sm" for="season6" >6월&nbsp;</label>
										 <input type="checkbox" class="btn-check" id="season7" name="season7" value="7" autocomplete="off"><label class="btn btn-light btn-sm" for="season7" >7월&nbsp;</label>
										 <input type="checkbox" class="btn-check" id="season8" name="season8" value="8" autocomplete="off"><label class="btn btn-light btn-sm" for="season8" >8월&nbsp;</label>
										 <input type="checkbox" class="btn-check" id="season9" name="season9" value="9" autocomplete="off"><label class="btn btn-light btn-sm" for="season9" >9월&nbsp;</label>
										 <input type="checkbox" class="btn-check" id="season10" name="season10" value="10" autocomplete="off"><label class="btn btn-light btn-sm" for="season10" >10월</label>
										 <input type="checkbox" class="btn-check" id="season11" name="season11" value="11" autocomplete="off"><label class="btn btn-light btn-sm" for="season11" >11월</label>
										 <input type="checkbox" class="btn-check" id="season12" name="season12" value="12" autocomplete="off"><label class="btn btn-light btn-sm" for="season12" >12월</label><br><br>					
					</div>											
			</div>
		</div>		
		<div style="float:left; width:20%;">
			<div class="jumbotron" style="padding-top : 18px;">
					<h3 style="text-align: center;">이미지 추가</h3>
					<hr>
					<div>
						대표 이미지 	    	<input type="file" name="file2" class="form-control" accept="image/*"> <br>
						상품 설명 이미지 	    <input type="file" name="file1" class="form-control" accept="image/*">													
					</div>			
			</div>
		</div>
		<br>
		<input type="submit" class="btn btn-primary form-control" value="제출">	
		</form>			
	</div>				
</main>		
</body>

</html>