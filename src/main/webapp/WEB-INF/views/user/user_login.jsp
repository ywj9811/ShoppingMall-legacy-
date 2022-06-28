<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>:::Login:::</title>
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

.login_div {
	display: flex;
	flex-direction: column;
	height: 350px;
	justify-content: space-evenly;
}

.join_div {
	display: flex;
	flex-direction: column;
	height: 350px;
	justify-content: space-around;
}
</style>

<script src="resources/js/httpRequest.js"></script>

</head>
<jsp:include page="/WEB-INF/views/incloude/login_header.jsp"></jsp:include>
<body>
	<form>
		<div class="main">
			<input type="hidden" name="${ vo.user_id }">
			<div class="login_div">
				<h3>로그인</h3>
				<div>
					<input class="form-control" name="user_id" placeholder="ID">
				</div>
				<div>
					<input class="form-control" type="password" name="user_pw"
						placeholder="PassWord">
				</div>
				<div>
					<input type="button" class="btn btn-outline-dark" value="로그인"
						onclick="send(this.form);" name="login"
						style="width: -webkit-fill-available;">
				</div>

				<div id="search_idpw">
					<input type="button" class="btn btn-outline-dark" name="search_id"
						value="아이디찾기" onclick="location.href = 'id_search_form.do'">
					<input type="button" name="search_pw" class="btn btn-outline-dark"
						value="비밀번호찾기" onclick="location.href = 'pw_search_form.do'">
				</div>
			</div>
			<div class="join_div">
				<h3>등록</h3>
				<div>
					Bean.com 회원으로 가입하시면 빠르고 편리하게 이용하실 수 있습니다.<br>아직 Bean.com의 회원이
					아니시라면 간편하게 가입하실 수 있습니다.
				</div>
				<div>
					<input type="button" class="btn btn-outline-dark"
						name="member_join" value="회원가입"
						onclick="location.href = 'shop_join.do'">
				</div>
			</div>
		</div>
	</form>

	<script>
		//login.do?id=??&pw=??
		function send(f) {

			var user_id = f.user_id.value.trim();
			var user_pw = f.user_pw.value.trim();

			//유효성 췤
			if (user_id == '') {
				alert("id를 입력하세요");
				return;
			}

			if (user_pw == '') {
				alert("pwd를 입력하세요");
				return;
			}

			//아이디와 비번 서블릿으로 보냄
			var url = "login_action.do";
			var param = "user_id=" + encodeURIComponent(user_id) + "&user_pw="
					+ encodeURIComponent(user_pw);

			sendRequest(url, param, myCheck, "post");

		}

		//callBack method
		function myCheck() {

			if (xhr.readyState == 4 && xhr.status == 200) {

				var data = xhr.responseText;
				//data = "[{'param':'no_id'}]"

				var json = (new Function('return' + data))();

				if (json[0].param == "no_id") {
					alert("id가 존재하지 않습니다");
					return;
				}

				else if (json[0].param == "pwd_false") {
					alert("비밀번호가 틀렸습니다");
					return;
				}
				
				else if (json[0].param == "1") {
					if(!confirm("휴면회원 입니다 활성화 하시겠습니까?")){
						return;	
						/* session해지가 안되고있음 */
					}
					location.href = "activate.do";
				}
				
				else if (json[0].param == "2") {
					if(!confirm("탈퇴 대기 상태입니다 복구 하시겠습니까?")){	
						return;
					}
					location.href = "restore.do";
				}

				else {
					alert("로그인 성공");
					location.href = "main_page.do";
				}
			}

		} //myCheck() 콜백메서드.
	</script>

</body>
</html>