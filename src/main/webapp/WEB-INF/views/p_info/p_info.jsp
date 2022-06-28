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
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	crossorigin="anonymous"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">

<style>
.content {
	display: flex;
	justify-content: space-evenly;
	margin-top: 150px;
}

.reply_main {
	width: 1000px;
	margin: 50px auto;
}
</style>
</head>
<body>
	<c:if test="${ sessionScope.vo ne null }">
		<jsp:include page="/WEB-INF/views/incloude/logout_header.jsp"></jsp:include>
	</c:if>
	<c:if test="${ sessionScope.vo eq null }">
		<jsp:include page="/WEB-INF/views/incloude/login_header.jsp"></jsp:include>
	</c:if>
	<form id="p_info">
		<div class="content">
			<input name="p_info_code" type="hidden" value="${vo.p_info_code }">
			<div class="img_part">
				<div>
					<img src="resources/upload/${vo.p_info_img1 }">
				</div>
				<%-- <div>
					<img src="resources/upload/${vo.p_info_img2 }">
				</div>
				<div>
					<img src="resources/upload/${vo.p_info_img3 }">
				</div> --%>
			</div>
			<div class="p_info_part">
				<div>상품 대분류 : ${vo.p_info_lType }</div>
				<div>상품 중분류 : ${vo.p_info_mType }</div>
				<div>상품 소분류 : ${vo.p_info_sType }</div>
				<div>상품 이름 : ${vo.p_info_name }</div>
				<div>상품 가격 : ${vo.p_info_price }원</div>

				<select name="sizebox" class="form-select">
					<option>사이즈</option>
					<c:forEach var="size" items="${size }">
						<option value="${size}">${size}</option>
					</c:forEach>
				</select> <select name="colorbox" class="form-select">
					<option>색상</option>
					<c:forEach var="color" items="${color }">
						<option value="${color }">${color }</option>
					</c:forEach>
				</select>

				<c:if test="${ sessionScope.vo ne null }">
					<div>
						<input type="button" class="btn btn-outline-dark" value="장바구니"
							id="addcart">
					</div>
					<div id="hide" style="display: none;">
						<input type="button" class="btn btn-outline-dark" value="바로구매"
							onclick="buynow();">
					</div>
				</c:if>
				<c:if test="${ sessionScope.vo eq null }">
					<div>
						<input type="button" class="btn btn-outline-dark" value="장바구니"
							onclick="no();">
					</div>
				</c:if>
			</div>
		</div>
	</form>

	<div>
		<hr>
	</div>
	<div class="reply_main">
		<div class="header">
			<h1>상품 후기</h1>
		</div>
		<div class="reply">
			<c:forEach var="list" items="${list }">
				<form style="margin-top: 30px;">
					<div>닉네임 : ${list.user_nick }</div>
					<div>색상 :${list.p_detail_color } / 사이즈 :${list.p_detail_size }</div>
					<div>
						<textarea class="form-control" name="content" rows="3"
							style="resize: none;" readonly><c:out
								value="${ list.reply_content }" /></textarea>
					</div>
				</form>
				<hr>
			</c:forEach>
		</div>
	</div>

	<script>
		function no() {
			alert("로그인 후 이용해주세요");
		}

		$("#addcart").click(
				function() {
					var form_data = $('#p_info').serialize();
					$.ajax({
						type : "post",
						url : "addcart.do",
						data : form_data,

						success : function(data) {
							alert("상품이 담겼습니다");
							payon();
						},

						error : function(request, status, error) {
							console.log("code:" + request.status + "\n"
									+ "message:" + request.responseText + "\n"
									+ "error:" + error);
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