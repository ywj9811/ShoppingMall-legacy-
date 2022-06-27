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
div {
	margin: 10px;
}

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

			<div>
				<label>프로필 사진</label><input type="file" name="user_photo">
			</div>

			<div>
				<label>닉네임</label><input name="user_nick" onchange="change2();">
				<input type="button" value="중복체크" class="btn btn-outline-dark"
					onclick="double_nick_check(this.form);">
			</div>
			<div>
				<label>고객이름</label><input name="user_name">
			</div>
			<label>휴대폰 번호</label>
			<div>
				<select name="news_agency">
					<!-- 통신사 -->
					<option value="skt">SKT</option>
					<option value="KT">KT</option>
					<option value="LG U+">LG U+</option>
					<option value="기타">기타</option>
				</select> <input name="user_tel" placeholder="'-'를 제외하고 입력하세요" maxlength='11'>
			</div>
			<div>
				<label>고객 아이디</label><input name="user_id" onchange="change();">
				<input type="button" name="id_double_check"
					class="btn btn-outline-dark" value="중복체크"
					onclick="id_double_chk(this.form);">
			</div>
			<div>
				<label>비밀번호</label> <input name="user_pw" type="password">
			</div>
			<div>
				<label>비밀번호 확인</label><input name="user_pw2" type="password">
			</div>
			<div class="user_addr_c">
				주소 : <input name="user_addr" class="addr" id="addr"> <input
					type="button" name="addr_search" class="btn btn-outline-dark"
					value="주소찾기" placeholder="주소">
			</div>
			<div>
				<label>상세주소</label><input name="user_daddr" id="user_daddr2"
					placeholder="(선택)">
			</div>
			<div>
				<label>이메일</label> <input type="email" name="user_email"
					placeholder="abc">@<input type="text" name="str_email02"
					id="str_email02" style="width: 100px;" disabled value="naver.com">
				<select style="width: 100px; margin-right: 10px" name="selectEmail"
					id="selectEmail">
					<option value="1">직접입력</option>
					<option value="naver.com" selected>naver.com</option>
					<option value="hanmail.net">hanmail.net</option>
					<option value="hotmail.com">hotmail.com</option>
					<option value="nate.com">nate.com</option>
					<option value="yahoo.co.kr">yahoo.co.kr</option>
					<option value="empas.com">empas.com</option>
					<option value="dreamwiz.com">dreamwiz.com</option>
					<option value="freechal.com">freechal.com</option>
					<option value="lycos.co.kr">lycos.co.kr</option>
					<option value="korea.com">korea.com</option>
					<option value="gmail.com">gmail.com</option>
					<option value="hanmir.com">hanmir.com</option>
					<option value="paran.com">paran.com</option>
				</select>
			</div>
			<div>
				<label>생년월일</label><input name="birth" type="date">
			</div>
			<label>성별</label>
			<div>
				남 : <input type="radio" name="user_gender" value="0"> 여: <input
					type="radio" name="user_gender" value="1">
			</div>
			<input type="button" value="회원가입" class="btn btn-outline-dark"
				onclick="send(this.form);">
		</div>
	</form>

	<script>
	/* KAKAO ADDRESS */
	window.onload = function() {
		$(".user_addr_c").click(function() { //class = user_addr_class 클릭시 동작
			new daum.Postcode({
				oncomplete : function(data) { //선택시 입력값 세팅					
					document.getElementById("addr").value = data.address; // 주소 넣기
					document.querySelector("input[name=user_daddr]").focus(); //상세입력 포커싱
				}
			}).open();
		})

	}
</script>

	<script>
		var check = "no";
	
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
		
		function send(f) {
			var text = f.user_tel.value.trim();
			var regPhone = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;		
			var user_pw = f.user_pw.value.trim();
			var user_pw2 = f.user_pw2.value.trim();
			var user_addr = f.user_addr.value.trim();
			var user_email = f.user_email.value.trim() + "@" + f.str_email02.value.trim();
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
			
			if (check == "no") {
				alert("중복확인을 하세요");
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
					check = "yes";
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
					check = "yes";
					alert("사용가능");
				} else {
					alert("중복된 아이디입니다");
				}
			}
		}

		//nick onchange2()
		function change2() {
			check = "no";
		}

		//onchange()
		function change() {
			check = "no";
		}
	</script>

</body>
</html>