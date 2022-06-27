<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bean</title>
<script type="text/javascript"></script>

<style>
.bg {
	width: 1920px;
	margin: auto;
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

	<div class="bg">
		<video muted autoplay loop >
			<source src="resources/main.mp4" type="video/mp4">
		</video>
	</div>
</body>

</html>