<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="resources/js/httpRequest.js"></script>
<!-- jQuery -->
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
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
</head>
<body>
	<jsp:include page="/WEB-INF/views/incloude/logout_header.jsp"></jsp:include>
	<div class="info">
		<div>
			<img src="resources/upload/${vo.user_profile }"
				width="80">
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
	
	<div class="center">
		<div class="nav_data">
			<c:forEach var="list" items="${ list }">
				<form id="reply_form">
					<input name="payment_code" type="hidden"
						value="${ list.payment_code }"> <input name="p_info_dcode"
						type="hidden" value="${list.p_info_dcode }">
					<div>
						<div>
							<img src="resources/upload/${ list.p_info_img1 }">
						</div>
						<a> ${ list.p_info_name } ${ list.p_info_price } (${ list.p_detail_size }
							/ ${ list.p_detail_color })</a>

						<div id="preply">
							<c:if test="${ list.reply_ok eq 0 }">
								<textarea class="form-control" name="content" rows="3" placeholder="구매후기" style="resize:none;"></textarea>
								<input type="button" value="작성" class="btn btn-outline-dark"
									onclick="reply(this.form);">
							</c:if>
							<c:if test="${ list.reply_ok eq 1 }">
								구매후기를 작성하였습니다
							</c:if>
						</div>
					</div>
				</form>
			</c:forEach>
		</div>
	</div>
	
	<script>
		function reply(f){
			var form_data = "payment_code=" + f.payment_code.value + "&p_info_dcode=" + f.p_info_dcode.value + "&content="+f.content.value;
			
			console.log("상세코드"+form_data);

			$.ajax({
				type: "post",
				url: 'p_reply.do',
				data: form_data,
				
				success: function(data){
					alert("작성되었습니다");
					
					$(location).attr('href','orderlist.do');
				},
				
				error: function (request, status, error) {
                    console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
		}
	
		function send(f) {

			var p_info_code = f.p_info_code.value;

			f.action = "p_info.do";
			f.method = "get";
			f.submit();
		}
	</script>
</body>
</html>