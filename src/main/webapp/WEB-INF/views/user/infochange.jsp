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
						data-bs-toggle="collapse"
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
							<input type="file" name="user_photo"> <input
								type="button" class="btn btn-outline-dark" value="프로필 사진 변경"
								onclick="c_profile(this.form);">
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
							</select> <input type="button" value="이메일 변경" class="btn btn-outline-dark"
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
					<div>회원 탈퇴 시 1주일 동안 탈퇴 예정 상태가 됩니다.<br>
					탈퇴 예정 상태에서는 언제든지 탈퇴 취소를 할 수 있습니다.<br>
					회원 가입시 탈퇴했던 아이디는 재사용이 불가합니다.</div>
						<form>
							<div>아이디 : ${vo.user_id }</div>
							<div>비밀번호 : <input name="user_pw1" type="password"></div>
							<div>비밀번호 재 입력 : <input name="user_pw2" type="password">
								<input type="button" value="회원 탈퇴" placeholder="비밀 번호를 입력하세요" onclick="del(this.form)">
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
	</script>
</body>
</html>