<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/incloude/logout_header.jsp"></jsp:include>
	
	<h2>주문이 완료되었습니다.</h2>
	<c:forEach var="list" items="${list }">
		${ list.p_info_img1 }
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