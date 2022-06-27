<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>탈퇴 취소</title>
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
.main {
	display: flex;
	height: 500px;
	margin: 100px;
	justify-content: space-evenly;
	align-items: center;
}
}
</style>

<script src="resources/js/httpRequest.js"></script>
<!-- jQuery -->
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
</head>
<jsp:include page="/WEB-INF/views/incloude/login_header.jsp"></jsp:include>
<body>
	<form id="form_data">
		<div class="main">
			<div class="login_div">
				<h3>복구</h3>
				<div>
					<input type="text" name="user_id" placeholder="id:">
				</div>
				<div>
					<input type="password" name="user_pw" placeholder="pwd:">
				</div>
				<div>
					<input type="button" class="btn btn-outline-dark" value="복구하기"
						id="login">
				</div>

			</div>
			<div class="join_div">Bean.com의 회원으로 돌아오신것을 환영합니다.</div>
		</div>
	</form>

	<script>
		$("#login").click(function(){
			var user_id = $('input[name=user_id]').val();
			var user_pw = $('input[name=user_pw]').val();
			
			if (user_id == '') {
				alert("id를 입력하세요");
				return;
			}

			if (user_pw == '') {
				alert("pwd를 입력하세요");
				return;
			}
			
			$.ajax({
				type : "post",
				url : "restorefin.do",
				data : $('#form_data').serialize(),
				
				success: function(data){
					if(data == "no_id"){
						alert("id가 틀렸습니다");
						return;
					}
					
					if(data == "pwd_false"){
						alert("비밀번호가 틀렸습니다");
						return;
					}
					
					alert("복구되었습니다 다시 로그인 해주세요");
					$(location).attr('href',"login.do");
				},
				
				error: function (request, status, error) {
                    console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
		});
	</script>
</body>
</html>