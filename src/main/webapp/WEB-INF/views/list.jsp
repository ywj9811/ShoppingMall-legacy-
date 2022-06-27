<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품</title>
<style>
.search {
	display: flex;
	flex-direction: row;
	width: 1000px;
	justify-content: space-around;
	margin: 100px auto;
}

.search_main {
	display: flex;
	padding: 30px;
	width: 1920px;
	margin: auto;
	flex-wrap: wrap;
	justify-content: space-between
}

}
.data {
	background: blue;
}

.photo {
	background: #C7803E;
	height: 300px;
	width: 300px;
}

.content {
	background: green;
	margin-bottom: 20px;
	display: flex;
	justify-content: space-around;
}
</style>

<script>
	function send(f) {

		var p_info_code = f.p_info_code.value;

		f.action = "p_info.do";
		f.method = "get";
		f.submit();
	}
</script>
</head>
<body>
	<c:if test="${ sessionScope.vo ne null }">
		<jsp:include page="/WEB-INF/views/incloude/logout_header.jsp"></jsp:include>
	</c:if>
	<c:if test="${ sessionScope.vo eq null }">
		<jsp:include page="/WEB-INF/views/incloude/login_header.jsp"></jsp:include>
	</c:if>

	<div class="search_main">
		<c:forEach var="vo" items="${list }">
			<form>
				<input name="p_info_code" type="hidden" value="${vo.p_info_code }">
				<button type="button" onclick="send(this.form);" style="cursor: pointer;">
					<div class="data">
						<div class="photo">
							사진 이미지 <img src="">
						</div>
						<div class="content">
							<div class="price">가격 :${vo.p_info_price }원</div>
							<div class="name">이름 :${vo.p_info_name }</div>
						</div>
					</div>
				</button>
			</form>
		</c:forEach>
	</div>
</body>
</html>