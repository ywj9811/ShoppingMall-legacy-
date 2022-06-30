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
	</head>
	
	<style>
	
	fieldset {
      display: block;
      margin: 20px 1%;
      margin-bottom: 20px;
     
      padding: 0 auto;
      padding: 15px 0;
      border: 0;
      border-top: 1px solid #DDD;
      width: 98%;
}

	legend {
     display: table; 
     min-width: 0px;
     max-width: 70%;
     position: relative;
     margin: auto;
     padding: 5px 20px;
     
     font-size: 40px;
     text-align: left;
}
	#total{text-align:center;}
	
	table{
		border-collapse : collapse;}
		
	#form_table{margin-left:39%;
				  margin-top: 20px;}
	
	#show_table{margin-left:23%;
				margin-top:30px;
				}
	#n{width:300px;}
	.th1{width:80px; 
		}
	
	
	td{
		padding:3px;
		margin:5px;
		text-align:center;}

	</style>
	<script src="resources/js/httpRequest.js"></script>
	<script>
	
	if("${admin_vo}"==null){
		alert("로그인을 하세요");
		location.href="admin_login.do";
	}

		function search(f){
			f.action="sale_search.do";
			f.submit();
		}
		

	</script>
	<body>
	<jsp:include page="login_header.jsp"></jsp:include>
	
			<fieldset>
	  <legend>BEAN</legend>
	  <div id="total">
	    <h2>총 판매량 : ${map.total_sales}</h2>
	     <h2> 총 판매금액 : ${map.total_amount }</h2>
	  </div>
	  <div id="all_table">
	  <form>
	  <div id="form_table">
	  <table border="1" id="select_table">
	  	<caption><h2>상세검색</h2></caption>
	  	<tr>
	  		<th >대분류 </th>
	  		<th>중분류</th>
	  		
	  	</tr>
	  	
	  	<tr>
	  		<td><input type="radio" name="p_info_lType" value="남성">남성</td>
	  		<td rowspan="2">
	  			<input type="radio" name="p_info_mType" value="상의">상의
	  			<input type="radio" name="p_info_mType" value="하의">하의
	  			<input type="radio" name="p_info_mType" value="아우터">신발
	  			<input type="radio" name="p_info_mType" value="신발">아우터
	  		</td>
	  	</tr>
	  	<tr>
	  		<td><input type="radio" name="p_info_lType" value="여성">여성</td>
	  	</tr>
	  	<tr>
	  		<td><input type="radio" name="p_info_lType" value="잡화">잡화</td>
	  		<td>
	  			<input type="radio" name="p_info_mType" value="잡화">잡화
	  			<input type="radio" name="p_info_mType" value="악세서리">악세서리
	  		</td>
	  	</tr>
	  	
	  </table>
		<input name="p_info_sType">
		<input type="button" value="검색" onclick="search(this.form);">
		<input type="button" value="전체검색" onclick="location.href='p_sell_list.do'">
		</div>
	  </form>
	  
	  <table border="1" id="show_table">
	  	<tr id="name1">
	  		<th id="n">상품 이름</th>
	  		<th class="th1">대분류</th>
	  		<th class="th1">중분류</th>
	  		<th class="th1">소분류</th>
	  		<th class="th1">판매량</th>
	  		<th class="th1">판매 금액</th>
	  	</tr>
	  	
	  	<c:forEach var="list" items="${list }">
	  		<tr>
	  			<td>${list.p_info_name}</td>
	  			<td>${list.p_info_lType}</td>
	  			<td>${list.p_info_mType}</td>
	  			<td>${list.p_info_sType}</td>
	  			<td>${list.view_cell}</td>
	  			<td>${list.view_profit}</td>
	  		</tr>
	  	</c:forEach>
	  </table>
	  </div>
	  
	  <div></div>
</fieldset>
		
		
	
	</body>
</html>