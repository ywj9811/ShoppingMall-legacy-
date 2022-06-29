<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
.info {
	display: flex;
	flex-direction: row;
	width: 1000px;
	height: 100px;
	justify-content: space-around;
	align-items: center;
	margin: 100px auto;
}

.side {
	display: flex;
	justify-content: space-around;
	margin: 50px auto;
	width: 1000px;
}

.center {
	margin: auto;
	width: 400px;
	display: flex;
	flex-direction: column;
}
</style>
<body>
	<jsp:include page="/WEB-INF/views/incloude/logout_header.jsp"></jsp:include>
	<div class="info">
		<div>
			<img src="resources/upload/${vo.user_profile }" width="80">
		</div>
		<div>닉네임 : ${vo.user_nick }</div>
		<div>회원 등급 : ${vo.user_class }</div>
		<div>가입 일자 : ${vo.user_regdate }</div>
	</div>
	<div class="side">
		<div class="button">
			<input type="button" value="구매후기" class="btn btn-outline-dark"
				onclick="location.href='userreply.do'">
		</div>
		<div class="button">
			<input type="button" value="회원정보 변경" class="btn btn-outline-dark"
				onclick="location.href='infochange.do'">
		</div>
		<div class="button">
			<input type="button" value="주문내역" class="btn btn-outline-dark"
				onclick="location.href='orderlist.do'">
		</div>
	</div>

	<c:forEach var="list" items="${list }">
		<div class="center">
			<div class="nav_data">
				<div>상품 이름 : ${list.p_info_name }</div>
				<div>구매상품 색상 :${list.p_detail_color } / 사이즈
					:${list.p_detail_size }</div>
				<div>
					<textarea class="form-control" name="content" rows="3" style="resize:none;" readonly><c:out
							value="${ list.reply_content }" /></textarea>
				</div>
				<div>작성일 : ${list.reply_regdate }</div>
				<br>
			</div>
		</div>
	</c:forEach>

</body>
</body>
</html>
