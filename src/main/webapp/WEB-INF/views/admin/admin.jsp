<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:if test="${ empty admin_vo }">
	<script>
		alert("로그인 후 이용해주세요");
		location.href="admin_login.do";
	</script>
</c:if>
</head>
<body>
	<jsp:include page="login_header.jsp"></jsp:include>
	
	<input type="button" value="상품 등록" onclick="location.href='p_insert_form.do'">
	
	<input type="button" value="판매 현황" onclick="location.href='p_sell_list.do'">
</body>
</html>