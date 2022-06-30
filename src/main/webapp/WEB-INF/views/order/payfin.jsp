<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="resources/js/infochange.js?after"></script>
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

.info_teb {
	width: 1000px;
	margin: auto;
}

.side {
	display: flex;
	justify-content: space-around;
	margin: 50px auto;
	width: 1000px;
}
</style>

</head>
<body>
	<jsp:include page="/WEB-INF/views/incloude/logout_header.jsp"></jsp:include>
	
	<div class="info">
		<div>
			<img src="${vo.user_profile }" width="80">
		</div>
		<div>닉네임 : ${vo.user_nick }</div>
		<div>회원 등급 : ${vo.user_class }</div>
		<div>가입 일자 : ${vo.user_regdate }</div>
	</div>
	
	<h2>주문이 완료되었습니다.</h2>
	<c:forEach var="list" items="${list }">
		${ list.p_info_name }
		(
		${ list.p_detail_size }
		/
		${ list.p_detail_color }
		)
		${ list.p_info_price }
		<br>
	</c:forEach>
</body>
</html>