<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="index.jsp"></jsp:include>
<div class="container" style="float: none; margin:100 auto;">
		<div class="col-lg-4" style="width:100%;">
		<div class="col-lg-4" style="width:300px; margin: auto;">
			<div class="jumbotron">
				<form method="post" action="joinAction2.jsp">
					<h3 style="text-align: center;">회원가입 화면</h3>
					<div class="form-group">
						<input type="text" id="input" class="form-control" placeholder="아이디" name="userID" maxlength="20">
						<span id="result" style="color : Red"></span>
						<br>
						<script>
  						input.oninput = function() {
  											var con1 = /[^a-z|0-9|\-|_]|[\s]/g; // 특수문자, 공백 검색 정규식 (-,_)제외
											var temp = document.getElementById('input').value;
											var pos1 = temp.match(con1);
											const btn = document.getElementById('btn');
											if(pos1){
												result.innerHTML = "최대 20자의 영문 소문자, 숫자와 특수기호(-),(_)만을 사용 가능합니다.";
												btn.disabled = true;
											}else{
												result.innerHTML = "";
												btn.disabled = false;
							}
								
 						 };
						</script>
					</div>					
					<div class="form-group">
						<input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20">
					</div>
					<br>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="이름" name="userName" maxlength="20">
					</div>
					<br>
					<div class="form-group">
						<b>주소</b>
						<div style="float:right;">
						<input type="text" id="sample4_postcode" name="postcode" placeholder="우편번호">
						<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기">
						</div>
						<input type="text"  class="form-control" id="sample4_roadAddress" name="roadAddress" placeholder="도로명주소">
						<input type="hidden" class="form-control" id="sample4_jibunAddress" name="jibunAddress" placeholder="지번주소">
						<span id="guide" style="color:#999;display:none"></span>
						<input type="text" class="form-control"  id="sample4_detailAddress" name="detailAddress" placeholder="상세주소">
						<input type="hidden" id="sample4_extraAddress" name="extraAddress" placeholder="참고항목">

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
	</script>
					</div>
					<br>
					<div style="text-align:center;">
					<select id="txtMobile1" name="txtMobile1">
						<option selected>전화번호</option>
						<option value="010">010</option>    
						<option value="011">011</option>
					    <option value="016">016</option>
					    <option value="017">017</option>
    					<option value="019">019</option>
					</select>
					<script>
						function inputMobile() {
						var con1 = /[^0-9]/g; // 특수문자, 공백 검색 정규식 (-,_)제외
						var temp = document.getElementById('txtMobile2').value;
						var temp2 = document.getElementById('txtMobile3').value;
						var pos2 = temp2.match(con1);
						var pos1 = temp.match(con1);
						const btn = document.getElementById('btn');
						if(pos1 || pos2){
							mobileCon.innerHTML = "숫자만 4자까지 입력 가능합니다.";
							btn.disabled = true;
						}else{
							mobileCon.innerHTML = "";
							btn.disabled = false;
						} 
					};
					</script>				
					<input type="text" id="txtMobile2" name="txtMobile2" size="6" maxlength="4" oninput="inputMobile()"/>
					<input type="text" id="txtMobile3" name="txtMobile3" size="6" maxlength="4" oninput="inputMobile()"/>
					</div> 
					<span id="mobileCon" style="color : Red"></span>
					
					<!-- <div class="form-group" style="text-align: center;">
						<div class="btn-group" data-toggle="buttons">
							<label class="btn btn-primary active">
								<input type="radio" name="userGender" autocomplete="off" value="남자" checked>남자 
							</label>
							<label class="btn btn-primary active">
								<input type="radio" name="userGender" autocomplete="off" value="여자" checked>여자 
							</label>
						</div>
					</div> -->				
					<!-- div class="form-group">
						<input type="email" class="form-control" placeholder="이메일" name="userEmail" maxlength="50">
					</div> -->
					<input type="submit" id ="btn" disabled = 'disabled' class="btn btn-primary form-control" value="회원 가입">
				</form>
				</div>				
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	
	
</body>
</body>
</html>