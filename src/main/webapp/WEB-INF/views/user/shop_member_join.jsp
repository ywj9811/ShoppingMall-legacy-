<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>:::회원가입 페이지:::</title>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	crossorigin="anonymous"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<script src="resources/js/httpRequest.js"></script>

<!-- 제이쿼리 -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<!-- 카카오 주소 API -->
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js">
	
</script>

<style>
.join {
	display: flex;
	justify-content: space-around;
	margin: 150px auto;
}
</style>

</head>
<jsp:include page="/WEB-INF/views/incloude/login_header.jsp"></jsp:include>
<body>
	<form method="POST" enctype="multipart/form-data" class="join">
		<div class="join_form">
			<!-- 3개다 num임 -->
			<input type="hidden" name="user_total" value="0"> <input
				type="hidden" name="user_class" value="0"> <input
				type="hidden" name="user_status" value="1">
			<h3>회원가입</h3>

			<div class="mb-3">
				<label class="form-label">프로필 사진</label> <input class="form-control"
					type="file" name="user_photo">
			</div>
			<div>
				<label class="form-label">고객 아이디</label> <input class="form-control"
					name="user_id" onchange="change();"> <input type="button"
					name="id_double_check" class="btn btn-outline-dark" value="중복체크"
					onclick="id_double_chk(this.form);">
			</div>
			<div>
				<label class="form-label">비밀번호</label> <input class="form-control"
					name="user_pw" type="password">
			</div>
			<div>
				<label class="form-label">비밀번호 확인</label><input class="form-control"
					name="user_pw2" type="password">
			</div>
			<div>
				<label class="form-label">고객이름</label><input class="form-control"
					name="user_name">
			</div>
			<div>
				<label class="form-label">닉네임</label> <input class="form-control"
					name="user_nick" onchange="change2();"> <input
					type="button" value="중복체크" class="btn btn-outline-dark"
					onclick="double_nick_check(this.form);">
			</div>
			<label class="form-label">휴대폰 번호</label>
			<div>
				<input class="form-control" name="user_tel"
					placeholder="'-'를 제외하고 입력하세요" maxlength='11'>
			</div>

			<div class="user_addr_c">
				<label class="form-label">주소</label><input name="user_addr"
					class="form-control" id="addr"> <input type="button"
					name="addr_search" class="btn btn-outline-dark" value="주소찾기"
					placeholder="주소">
			</div>
			<div>
				<label class="form-label">상세주소</label><input class="form-control"
					name="user_daddr" id="user_daddr2" placeholder="(선택)">
			</div>
			<div>
				<div>
					<label class="form-label">이메일</label>
				</div>
				<input class="form-control" type="email" name="user_email"
					style="width: 150px; display: inline-block;" onchange="change3();"> <a>@</a> <input
					class="form-control" name="str_email02" id="str_email02"
					style="width: 150px; display: inline-block;" disabled
					value="naver.com" onchange="change3();"> <select class="form-select"
					style="width: 150px; display: inline-block;" name="selectEmail"
					id="selectEmail">
					<option value="1">직접입력</option>
					<option value="naver.com" selected>naver.com</option>
					<option value="hanmail.net">hanmail.net</option>
					<option value="google.com">gmail.com</option>
					<option value="nate.com">nate.com</option>
					<option value="yahoo.co.kr">yahoo.co.kr</option>
				</select> 
				<input style="width: 100px;" type="button" value="중복체크"
					class="btn btn-outline-dark" onclick="e_double(this.form);">
				<input style="width: 140px;" type="button" value="인증번호 발송"
					class="btn btn-outline-dark" onclick="certifyEmail(this.form);">
				<input style="width: 250px;" class="form-control" name="e_check"
					placeholder="인증번호를 입력하세요" maxlength='6'>
				<input style="width: 100px;" type="button" value="인증확인"
					class="btn btn-outline-dark" onclick="e_check_fin(this.form);">
			</div>
			<div>
				<label class="form-label">생년월일</label> <input class="form-control"
					name="birth" type="date">
			</div>
			<div style="display: flex; justify-content: space-evenly;">
				<label class="form-label">성별</label>
				<div>
					남 : <input class="form-check-input" type="radio" name="user_gender"
						value="0"> 여: <input class="form-check-input" type="radio"
						name="user_gender" value="1">
				</div>
			</div>
			<div style="margin: auto; width: 100px;">
				<input style="width: 100px;" type="button" value="회원가입"
					class="btn btn-outline-dark" onclick="send(this.form);">
			</div>
		</div>
	</form>

	<script>
		/* KAKAO ADDRESS */
		window.onload = function() {
			$(".user_addr_c")
					.click(
							function() { //class = user_addr_class 클릭시 동작
								new daum.Postcode(
										{
											oncomplete : function(data) { //선택시 입력값 세팅					
												document.getElementById("addr").value = data.address; // 주소 넣기
												document
														.querySelector(
																"input[name=user_daddr]")
														.focus(); //상세입력 포커싱
											}
										}).open();
							})

		}
		
		var i_check = "no";
		var e_check = "no";
		var e_check2 = "no";
		var n_check = "no";
		
		var e_check_num;
		
		//이메일 중복체크
		function e_double(f){
			if(f.user_email.value == ''){
				alert("이메일을 입력해 주세요");
				return;
			}
			
			if(f.str_email02.value == ''){
				alert("이메일을 입력해 주세요");
				return;
			}
			
			var user_email = "user_email=" + f.user_email.value.trim() + "@" + f.str_email02.value.trim();
			
			$.ajax({
				type : "post",
				url : "e_check.do",
				data : user_email,
				
				success: function(data){
					if(data == "yes"){
						alert("사용가능");
						e_check = "yes";
					}
					if(data == "no"){
						alert("중복된 이메일 입니다");
					}
				},
				error: function (request, status, error) {
                    console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			})
		}
		
		//이메일 인증
		function certifyEmail(f) {
			e_check2 = "no";
			
			if(f.user_email.value == ''){
				alert("이메일을 입력해 주세요");
				return;
			}
			
			if(f.str_email02.value == ''){
				alert("이메일을 입력해 주세요");
				return;
			}
			
			var user_email = "user_email=" + f.user_email.value.trim() + "@"
					+ f.str_email02.value.trim();
			
			$.ajax({
				type : "post",
				url : "certifyEmail.do",
				data : user_email,

				success : function(data) {
					alert("인증번호가 발송되었습니다");
					e_check_num = data;
					alert(e_check_num);
					//임시로 사용하는 alert
				},
				error: function (request, status, error) {
                    console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
		}
	
		function e_check_fin(f){
			var e_fin = f.e_check.value;
			if(e_check_num == e_fin){
				alert("인증 되었습니다");
				e_check2 = "yes";
			}
			else{
				alert("인증번호가 일치하지 않습니다.");
				return;
			}
		}
		
		function send(f) {
			var text = f.user_tel.value.trim();
			var regPhone = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
			var user_pw = f.user_pw.value.trim();
			var user_pw2 = f.user_pw2.value.trim();
			var user_addr = f.user_addr.value.trim();
			var user_email = f.user_email.value.trim() + "@"
					+ f.str_email02.value.trim();
			var regEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
			var user_gender = f.user_gender.value.trim();
			var birth = f.birth.value;

			if (user_addr == '') {
				alert("주소를 입력해 주세요");
				return;
			}

			if (regEmail.test(user_email) == false) {
				alert('올바른 이메일을 입력해 주세요');
				return;
			}

			if (user_gender == '') {
				alert("성별을 입력해 주세요");
				return;
			}

			if (user_addr == '') {
				alert("주소를 입력해 주세요");
				return;
			}

			if (user_pw != user_pw2) {
				alert("비밀번호가 일치하지 않습니다");
				return;
			}

			if (regPhone.test(text) == false) {
				alert('올바른 핸드폰 번호를 입력하세요');
				return;
			}

			if (birth == '') {
				alert("생년월일를 입력해 주세요");
				return;
			}

			if (i_check == "no") {
				alert("중복확인을 하세요");
				return;
			}
			
			if (i_check == "no" || n_check == "no" || e_check == "no" ) {
				alert("중복확인을 하세요");
				return;
			}
			if(e_check2 == "no"){
				alert("email인증을 해주세요");
				return;
			}

			f.action = "upload.do";
			f.method = "post";
			f.submit();
		}

		function double_nick_check(f) {
			var user_nick = f.user_nick.value.trim();

			if (user_nick == '') {
				alert("닉네임을 입력하세요");
				return;
			}

			var url = "double_nick_check.do";
			var param = "user_nick=" + user_nick;

			sendRequest(url, param, nickCheck, "post");
		}

		function nickCheck() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				var data = xhr.responseText;

				if (data == "yes") {
					n_check = "yes";
					alert("사용가능");
				} else {
					alert("중복된 닉네임입니다");
				}
			}
		}

		//id 중복체크
		function id_double_chk(f) {
			var user_id = f.user_id.value.trim();

			if (user_id == "") {
				alert("아이디를 입력하세요");
				return;
			}
			var url = "check_id.do";
			var param = "user_id=" + user_id;
			sendRequest(url, param, resultFn, "post");

		}
		//call back method
		function resultFn() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				var data = xhr.responseText;

				if (data == "yes") {
					i_check = "yes";
					alert("사용가능");
				} else {
					alert("중복된 아이디입니다");
				}
			}
		}

		//nick onchange2()
		function change2() {
			n_check = "no";
		}
		
		//email
		function change3() {
			e_check = "no";
			e_check2 = "no";
		}


		//onchange()
		function change() {
			i_check = "no";
		}
	</script>
	<script type="text/javascript">
		//이메일 입력방식 선택
		$('#selectEmail').change(function() {
			$("#selectEmail option:selected").each(function() {

				if ($(this).val() == '1') { //직접입력일 경우
					$("#str_email02").val(''); //값 초기화
					$("#str_email02").attr("disabled", false); //활성화
				} else { //직접입력이 아닐경우
					$("#str_email02").val($(this).text()); //선택값 입력
					$("#str_email02").attr("disabled", true); //비활성화
				}
			});
		});
	</script>

</body>
</html>