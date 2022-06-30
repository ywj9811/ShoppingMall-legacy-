<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${ empty admin_vo }">
	<script>
		alert("로그인 후 이용해주세요");
		location.href="admin_login.do";
	</script>
</c:if>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script src="resources/js/httpRequest.js"></script>
		<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
		<STYLE>
			th{width:100px;
				padding:0;}
			input[type=button] {
		        background-color: gray;
		        border: red;
		        color: yellow;
		        padding: 5px 10px;
		        text-decoration: none;
		        margin: 4px 2px;
		        cursor: pointer;
      }
			table{	border-collapse : collapse;
					align:center;
				    margin-left:34%;
				    padding:10px;
					width:400px;
					height:50px;}
			legend {
				     display: table; 
				     min-width: 0px;
				     max-width: 70%;
				     position: relative;
				     margin: auto;
				     padding: 5px 20px;
				     
				     font-size: 20px;
				     text-align: left;
				}
		</STYLE>
	</head>
	<body>
	<jsp:include page="/WEB-INF/views/incloude/login_header.jsp"></jsp:include>
				<fieldset>
	  <legend>Bean</legend>
		<form>
			<table border="1">
				<tr>
					<th>상품 대분류</th>
					<td>
					<select id="selectbox" name="p_info_lType">
						<option value="남성">남성</option>
						<option value="여성">여성</option>
						<option value="잡화">잡화</option>
					</select>
					
					</td>
				</tr>
				<tr>
					<th>상품 중분류</th>
					<td>
						<select name="p_info_mType">
							<option value="상의">상의</option>
							<option value="하의">하의</option>
							<option value="신발">신발</option>
							<option value="아우터">아우터</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>상품 소분류</th>
					<td>
						<select name="p_info_sType">
							<optgroup label="상의">
								<option value="반팔">반팔</option>
								<option value="긴팔">긴팔</option>
								<option value="맨투맨">맨투맨</option>
							</optgroup>
							<optgroup label="하의">
								<option value="청바지">청바지</option>
								<option value="슬렉스">슬렉스</option>
							</optgroup>
							
							<optgroup label="아우터">
								<option value="코트">코트</option>
								<option value="자켓">자켓</option>
								<option value="가디건">가디건</option>
							</optgroup>
							
							<optgroup label="신발">
								<option value="신발">신발</option>
							</optgroup>
						</select>
					</td>
				</tr>
				<tr>
					<th>상품 이름</th>
					<td><input name="p_info_name"></td>
				</tr>
				
				<tr>
					<th>가격</th>
					<td><input name="p_info_price"></td>
				</tr>
				
				<tr>
					<th>대표 이미지</th>
					<td><input name="p_info_img1" onchange="check();"></td>
				</tr>
				<tr>
					<th>추가 이미지1</th>
					<td><input name="p_info_img2"></td>
				</tr>
				<tr>
					<th>추가이미지2</th>
					<td><input name="p_info_img3"></td>
				</tr>
				
				<tr>
					<th>상세설명</th>
					<td><input name="p_info_detail"></td>
				</tr>
				
				<tr>
					<th>의류 사이즈</th>
					<td>
						S<input type="checkbox" name="p_detail_size" value="s">
						M<input type="checkbox" name="p_detail_size" value="m">
						L<input type="checkbox" name="p_detail_size" value="l">
					</td>
				</tr>
				<tr>
					<th>신발 사이즈</th>
					<td>
						250<input type="checkbox" name="p_detail_size" value="250">
						260<input type="checkbox" name="p_detail_size" value="260">
						270<input type="checkbox" name="p_detail_size" value="270">
						280<input type="checkbox" name="p_detail_size" value="280">
						290<input type="checkbox" name="p_detail_size" value="290">
					</td>
				</tr>
				
				<tr>
					<th>컬러</th>
					<td>
					블랙<input type="checkbox" name="p_detail_color" value="블랙">
					화이트<input type="checkbox" name="p_detail_color" value="화이트">
					베이지<input type="checkbox" name="p_detail_color" value="베이지">
					소라<input type="checkbox" name="p_detail_color" value="소라">
					카키<input type="checkbox" name="p_detail_color" value="카키">
					네이비<input type="checkbox" name="p_detail_color" value="네이비">
					오트밀<input type="checkbox" name="p_detail_color" value="오트밀">
					그레이<input type="checkbox" name="p_detail_color" value="그레이">
					레드<input type="checkbox" name="p_detail_color" value="레드">
					차콜<input type="checkbox" name="p_detail_color" value="차콜">
					연청<input type="checkbox" name="p_detail_color" value="연청">
					진청<input type="checkbox" name="p_detail_color" value="진청">
					</td>
				</tr>
				
				
				<tr>
					<td colspan="2">
					<input type="button" value="등록" onclick="insert_detail(this.form);">
					<input type="button" value="중복확인" onclick="p_check(this.form);">				
					</td>
				</Tr>
				
			</table>

		</form>
		</fieldset>
		<script>
			var c="no";
			function check(){
				c="no";
			}
			
			function insert_detail(f){
				if(c=="yes"){
				f.action="p_insert.do";
				f.submit();
				}
				else{
					alert("중복검사하세요");
				}
			}
			
			
			function p_check(f){
				var img =f.p_info_img1.value.trim();
				if(img==""){
					alert("이미지를 넣어주세염><");
					return;
				}
				var url="p_info_check.do";
				var param="p_info_img1="+img;
				sendRequest(url,param,resultFn,"post");

			}
			function resultFn(){
				if(xhr.readyState==4 && xhr.status==200){
					var check=xhr.responseText;
					if(check=="no"){
						c="yes";
						alert("중복확인 완료");
					}
					else{
						alert("중복 게시물");
					}
				}
				
			}
			
			
		</script>
	</body>
</html>