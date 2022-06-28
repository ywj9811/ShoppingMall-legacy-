<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="resources/js/httpRequest.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="resources/js/infochange.js?after"></script>
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

.info_teb {
	width: 1000px;
	margin: auto;
}

.side {
	display: flex;
	justify-content: space-around;
	margin: 50px auto;
	width: 1000px;
}
</style>

</head>
<body>
	<jsp:include page="/WEB-INF/views/incloude/logout_header.jsp"></jsp:include>
	<div class="info">
		<div>
			<img src="resources/upload/${vo.user_profile }" width="80">
		</div>
		<div>닉네임 : ${vo.user_nick }</div>
		<div>회원 등급 : ${vo.user_class }</div>
		<div>가입 일자 : ${vo.user_regdate }</div>
	</div>
	<div class="side">
		<div>
			<input type="button" value="구매후기" class="btn btn-outline-dark"
				onclick="location.href='userreply.do'">
		</div>
		<div>
			<input type="button" value="회원정보 변경" class="btn btn-outline-dark"
				onclick="location.href='infochange.do'">
		</div>
		<div>
			<input type="button" value="주문내역" class="btn btn-outline-dark"
				onclick="location.href='orderlist.do'">
		</div>
	</div>
	<div class=info_teb>
		<div class="accordion" id="accordionPanelsStayOpenExample">
			<div class="accordion-item">
				<h2 class="accordion-header" id="panelsStayOpen-headingOne">
					<button class="accordion-button" type="button"
						class="btn btn-outline-dark" data-bs-toggle="collapse"
						data-bs-target="#panelsStayOpen-collapseOne" aria-expanded="true"
						aria-controls="panelsStayOpen-collapseOne">프로필 사진 변경</button>
				</h2>
				<div id="panelsStayOpen-collapseOne"
					class="accordion-collapse collapse show"
					aria-labelledby="panelsStayOpen-headingOne">
					<div class="accordion-body">
						<form id="test" enctype="multipart/form-data" method="post">
							<div>
								현재 프로필 사진 : <img src="resources/upload/${vo.user_profile }"
									width="80">
							</div>
							<input type="file" class="form-control" name="user_photo">
							<input type="button" class="btn btn-outline-dark"
								value="프로필 사진 변경" onclick="c_profile(this.form);">
						</form>
					</div>
				</div>
			</div>
			<div class="accordion-item">
				<h2 class="accordion-header" id="panelsStayOpen-headingTwo">
					<button class="accordion-button collapsed" type="button"
						data-bs-toggle="collapse"
						data-bs-target="#panelsStayOpen-collapseTwo" aria-expanded="false"
						aria-controls="panelsStayOpen-collapseTwo">닉네임 변경</button>
				</h2>
				<div id="panelsStayOpen-collapseTwo"
					class="accordion-collapse collapse"
					aria-labelledby="panelsStayOpen-headingTwo">
					<div class="accordion-body">
						<div>아이디 : ${vo.user_id }</div>
						<form>
							<div>닉네임 : ${vo.user_nick }</div>
							<input name="nick" onchange="nick_change();"> <input
								type="button" value="중복체크" class="btn btn-outline-dark"
								onclick="double_nick_check(this.form);">
							<div>
								<input type="button" value="닉네임 변경" class="btn btn-outline-dark"
									onclick="c_nick(this.form);">
							</div>
						</form>
					</div>
				</div>
			</div>
			<div class="accordion-item">
				<h2 class="accordion-header" id="panelsStayOpen-headingThree">
					<button class="accordion-button collapsed" type="button"
						data-bs-toggle="collapse"
						data-bs-target="#panelsStayOpen-collapseThree"
						aria-expanded="false" aria-controls="panelsStayOpen-collapseThree">비밀번호
						변경</button>
				</h2>
				<div id="panelsStayOpen-collapseThree"
					class="accordion-collapse collapse"
					aria-labelledby="panelsStayOpen-headingThree">
					<div class="accordion-body">
						<form>
							<div>
								<input name="p1" type="password" placeholder="기존 비밀번호 입력">
							</div>
							<div>
								<input name="p2" type="password" placeholder="새 비밀번호 입력">
							</div>
							<div>
								<input name="p3" type="password" placeholder="새 비밀번호 재 입력">
							</div>
							<input type="button" value="비밀번호 변경" class="btn btn-outline-dark"
								onclick="c_pw(this.form);">
						</form>
					</div>
				</div>
			</div>
			<div class="accordion-item">
				<h2 class="accordion-header" id="panelsStayOpen-headingFour">
					<button class="accordion-button collapsed" type="button"
						data-bs-toggle="collapse"
						data-bs-target="#panelsStayOpen-collapseFour"
						aria-expanded="false" aria-controls="panelsStayOpen-collapseFour">휴대전화
						변경</button>
				</h2>
				<div id="panelsStayOpen-collapseFour"
					class="accordion-collapse collapse"
					aria-labelledby="panelsStayOpen-headingFour">
					<div class="accordion-body">
						<input type="text" value="${vo.user_tel }">
						<form>
							<div>
								<input name="tel" placeholder="'-'를 제외하고 입력하세요" maxlength='11'>
							</div>
							<input type="button" value="휴대폰번호 변경"
								class="btn btn-outline-dark" onclick="c_tel(this.form);">
						</form>

					</div>
				</div>
			</div>
			<div class="accordion-item">
				<h2 class="accordion-header" id="panelsStayOpen-headingFive">
					<button class="accordion-button collapsed" type="button"
						data-bs-toggle="collapse"
						data-bs-target="#panelsStayOpen-collapseFive"
						aria-expanded="false" aria-controls="panelsStayOpen-collapseFive">주소
						변경</button>
				</h2>
				<div id="panelsStayOpen-collapseFive"
					class="accordion-collapse collapse"
					aria-labelledby="panelsStayOpen-headingFive">
					<div class="accordion-body">
						<form>
							<div>현재 주소 : ${vo.user_addr }</div>
							<div>현재 상세 : ${vo.user_daddr }</div>
							<div class="user_addr_c">
								주소 :<input id="addr" name="user_addr">
							</div>
							<div>
								상세 주소 : <input name="user_daddr">
							</div>
							<input type="button" value="주소 변경" class="btn btn-outline-dark"
								onclick="c_addr(this.form);">
						</form>
					</div>
				</div>
			</div>
			<div class="accordion-item">
				<h2 class="accordion-header" id="panelsStayOpen-headingSix">
					<button class="accordion-button collapsed" type="button"
						data-bs-toggle="collapse"
						data-bs-target="#panelsStayOpen-collapseSix" aria-expanded="false"
						aria-controls="panelsStayOpen-collapseSix">이메일 변경</button>
				</h2>
				<div id="panelsStayOpen-collapseSix"
					class="accordion-collapse collapse"
					aria-labelledby="panelsStayOpen-headingSix">
					<div class="accordion-body">
						<div>현재 이메일 : ${vo.user_email }</div>
						<form>
							<input name="user_email1" id="user_email1"><a>@</a> <input
								name="user_email2" id="user_email2" disabled value="선택해주세요">
							<select name="selectEmail" id="selectEmail">
								<option value="self">직접입력</option>
								<option value="naver.com" selected>naver.com</option>
								<option value="hanmail.net">hanmail.net</option>
								<option value="google.com">gmail.com</option>
								<option value="nate.com">nate.com</option>
								<option value="yahoo.co.kr">yahoo.co.kr</option>
							</select> <input style="width: 100px;" type="button" value="중복체크"
								class="btn btn-outline-dark" onclick="e_double(this.form);">
							<input style="width: 140px;" type="button" value="인증번호 발송"
								class="btn btn-outline-dark" onclick="certifyEmail(this.form);">
							<input style="width: 250px;" class="form-control" name="e_check"
								placeholder="인증번호를 입력하세요" maxlength='6'> <input
								style="width: 100px;" type="button" value="인증확인"
								class="btn btn-outline-dark" onclick="e_check_fin(this.form);">
							<input type="button" value="이메일 변경" class="btn btn-outline-dark"
								onclick="c_email(this.form);">
						</form>
					</div>
				</div>
			</div>
			<div class="accordion-item">
				<h2 class="accordion-header" id="panelsStayOpen-headingSeven">
					<button class="accordion-button collapsed" type="button"
						data-bs-toggle="collapse"
						data-bs-target="#panelsStayOpen-collapseSeven"
						aria-expanded="false" aria-controls="panelsStayOpen-collapseSeven">회원
						탈퇴</button>
				</h2>
				<div id="panelsStayOpen-collapseSeven"
					class="accordion-collapse collapse"
					aria-labelledby="panelsStayOpen-headingSeven">
					<div class="accordion-body">
						<div>
							회원 탈퇴 시 1주일 동안 탈퇴 예정 상태가 됩니다.<br> 탈퇴 예정 상태에서는 언제든지 탈퇴 취소를 할
							수 있습니다.<br> 회원 가입시 탈퇴했던 아이디는 재사용이 불가합니다.
						</div>
						<form>
							<div>아이디 : ${vo.user_id }</div>
							<div>
								비밀번호 : <input name="user_pw1" type="password">
							</div>
							<div>
								비밀번호 재 입력 : <input name="user_pw2" type="password"> <input
									type="button" value="회원 탈퇴" placeholder="비밀 번호를 입력하세요"
									class="btn btn-outline-dark" onclick="del(this.form)">
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		//이메일 입력방식 선택
		$('#selectEmail').change(function() {
			$("#selectEmail option:selected").each(function() {
				if ($(this).val() == 'self') { //직접입력일 경우
					$("#user_email2").val(''); //값 초기화
					$("#user_email2").attr("disabled", false); //활성화
				} else { //직접입력이 아닐경우
					$("#user_email2").val($(this).text()); //선택값 입력
					$("#user_email2").attr("disabled", true); //비활성화
				}
			});
		});

		var e_check = "no";
		var e_check2 = "no";
		var e_check_num;

		//이메일 중복체크
		function e_double(f) {
			var user_email = "user_email=" + f.user_email1.value.trim() + "@"
					+ f.user_email2.value.trim();

			$.ajax({
				type : "post",
				url : "e_check.do",
				data : user_email,

				success : function(data) {
					if (data == "yes") {
						alert("사용가능");
						e_check = "yes";
					}
					if (data == "no") {
						alert("중복된 이메일 입니다");
					}
				},
				error : function(request, status, error) {
					console.log("code:" + request.status + "\n" + "message:"
							+ request.responseText + "\n" + "error:" + error);
				}
			})
		}

		//이메일 인증
		function certifyEmail(f) {

			var user_email = "user_email=" + f.user_email.value.trim() + "@"
					+ f.str_email02.value.trim();

			$.ajax({
				type : "post",
				url : "certifyEmail.do",
				data : user_email,

				success : function(data) {
					alert("인증번호가 발송되었습니다");
					e_check_num = data;
				},
				error : function(request, status, error) {
					console.log("code:" + request.status + "\n" + "message:"
							+ request.responseText + "\n" + "error:" + error);
				}
			});
		}

		function e_check_fin(f) {
			var e_fin = f.e_check.value;
			if (e_check_num == e_fin) {
				alert("인증 되었습니다");
				e_check2 = "yes";
			} else {
				alert("인증번호가 일치하지 않습니다.");
				return;
			}
		}
		
		function c_email(f) { // 이메일 변경 버튼
			
			var user_email1 = f.user_email1.value;
			var user_email2 = f.user_email2.value;
			
			if (user_email1 == '') {
				alert('변경할 이메일을 입력해주세요');
				return;
			}
			
			if(e_check == "no"){
				alert("중복체크를 해주세요");
				return;
			}
			if(e_check2 == "no"){
				alert("email인증을 해주세요");
				return;
			}
			
			var url = "c_email.do?user_email1=" + user_email1 + "&user_email2=" + user_email2;
			/*var param = "user_email1=" + user_email1 + "&user_email2=" + user_email2;
		*/
			sendRequest(url, null, c_emailFn, "post");
		}
		function c_emailFn() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				var data = xhr.responseText;
				var json = (new Function('return' + data))();
				if (json[0].param == 'yes') {
					alert('변경 성공');
					location.href = "infochange.do";
				} else {
					alert('변경 실패');
				}

			}
		}
		
		function del(f) {
			var user_pw1 = f.user_pw1.value.trim();
			var user_pw2 = f.user_pw2.value.trim();

			if (!confirm("회원탈퇴하시겠습니까?")) {
				alert("탈퇴안함");
				return;
			}

			if (user_pw1 == "") {
				alert("비밀번호를 입력해주세요");
				return;
			}
			if (user_pw2 == "") {
				alert("비밀번호를 재입력해주세요");
				return;
			}
			var url = "c_user_out.do";
			var param = "user_pw1=" + user_pw1 + "&user_pw2=" + user_pw2;
			sendRequest(url, param, delFn, "post");
		}

		function delFn() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				var data = xhr.responseText;
				var json = (new Function('return' + data))();

				if (json[0].param == 'yes') { //탈퇴 성공 (탈퇴 예정 상태로 변경)
					alert('See You Again Bro 1주일의 탈퇴 예정 상태가 됩니다.');
					location.href = "main.do";
				}
				if (json[0].param == 'pw_db_not_eq') { // 기존 비밀번호와 불일치
					alert("기존의 비밀번호와 일치하지 않습니다.");
					return;
				}
				if (json[0].param == 'pw_not_eq') { // 중복확인 비밀번호와 불일치
					alert("중복 비밀번호가 일치하지 않습니다.");
					return;
				}
			}
		}
	</script>
</body>
</html>