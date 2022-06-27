<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="resources/js/httpRequest.js"></script>

<!-- jQuery -->
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.4.min.js"></script>


</head>
<body>
	<c:if test="${ sessionScope.vo ne null }">
		<jsp:include page="/WEB-INF/views/incloude/logout_header.jsp"></jsp:include>
	</c:if>
	<c:if test="${ sessionScope.vo eq null }">
		<jsp:include page="/WEB-INF/views/incloude/login_header.jsp"></jsp:include>
	</c:if>

	<form id="p_info">
		<input name="p_info_code" type="hidden" value="${vo.p_info_code }">
		<div>상품 코드 : ${vo.p_info_code }</div>
		<div>상품 대분류 : ${vo.p_info_lType }</div>
		<div>상품 중분류 : ${vo.p_info_mType }</div>
		<div>상품 소분류 : ${vo.p_info_sType }</div>
		<div>상품 이름 : ${vo.p_info_name }</div>
		<div>상품 가격 : ${vo.p_info_price }</div>
		<div>이미지1 : ${vo.p_info_img1 }</div>
		<div>이미지2 : ${vo.p_info_img2 }</div>
		<div>이미지3 : ${vo.p_info_img3 }</div>
		<div>상품 상세설명 : ${vo.p_info_detail }</div>
		<div>상품 : 등록일 ${vo.p_info_regdate }</div>
		<div>상품 조회수 : ${vo.p_info_hit }</div>
		<div>상품 수정일 : ${vo.p_info_mdate }</div>

		<select name="sizebox">
			<option>사이즈</option>
			<c:forEach var="size" items="${size }">
				<option value="${size}">${size}</option>
			</c:forEach>
		</select> <select name="colorbox">
			<option>색상</option>
			<c:forEach var="color" items="${color }">
				<option value="${color }">${color }</option>
			</c:forEach>
		</select>

		<c:if test="${ sessionScope.vo ne null }">
			<div>
				<input type="button" value="장바구니" id="addcart">
				<!--  onclick="addcart(this.form);" -->
			</div>
		</c:if>
		<c:if test="${ sessionScope.vo eq null }">
			<div>
				<input type="button" value="장바구니" onclick="no();">
			</div>
		</c:if>
		<div id="hide" style="display: none;">
			<input type="button" value="바로구매" onclick="buynow();">
		</div>
	</form>

	<div>
		<hr>
	</div>
	<h1>리뷰</h1>
	<c:forEach var="list" items="${list }">
		<form>
			<div>고객 닉네임 : ${list.user_nick }</div>
			<div>구매상품 색상 :${list.p_detail_color } / 사이즈 :
				${list.p_detail_size }</div>
			<div>내용 : ${list.reply_content }</div>
			<div>작성일 : ${list.reply_regdate }</div>
		</form>
	</c:forEach>
	
	<script>
		function no(){
			alert("로그인 후 이용해주세요");
		}

		$("#addcart").click(function(){
			var form_data = $('#p_info').serialize();
			$.ajax({
				type : "post",
				url : "addcart.do",
				data : form_data,
				
				success: function(data){
					alert("상품이 담겼습니다");
					payon();
				},
				
				error: function (request, status, error) {
                    console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
		});

		function buynow() {
			location.href = "cart.do";
		}

		function payon() {
			$('#hide').show();
		}
	</script>
</body>
</html>