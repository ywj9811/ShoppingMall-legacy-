///* KAKAO ADDRESS */
//window.onload = function() {
//	$(".user_addr_c").click(function() { //class = user_addr_class 클릭시 동작
//		new daum.Postcode({
//			oncomplete: function(data) { //선택시 입력값 세팅					
//				document.getElementById("addr").value = data.address; // 주소 넣기
//				document.querySelector("input[name=user_daddr]").focus(); //상세입력 포커싱
//			}
//		}).open();
//	})
//
//}
//
//function c_profile(f) { // 프로필 사진 변경 버튼
//	var c_profile = f.user_photo.value;
//	if (c_profile == '') {
//		alert("변경할 프로필 사진을 넣어주세요");
//		return;
//	}
//	alert(c_profile);
//
//	f.action = "c_profile.do";
//	f.method = "post";
//	f.submit();
//}
//
////닉네임의 경우는 중복체크를 진행해야 한다.
//var nick_check = "yes";
//
//function nick_change() {
//	nick_check = "no";
//}
//function double_nick_check(f) {
//	var user_nick = f.nick.value;
//
//	if (user_nick == '') {
//		alert("닉네임을 입력하세요");
//		return;
//	}
//
//	var url = "double_nick_check.do";
//	var param = "user_nick=" + user_nick;
//
//	sendRequest(url, param, nickCheck, "post");
//}
//
//function nickCheck() {
//	if (xhr.readyState == 4 && xhr.status == 200) {
//		var data = xhr.responseText;
//
//		if (data == "yes") {
//			nick_check = "yes";
//			alert("사용가능");
//		} else {
//			alert("중복된 닉네임입니다");
//		}
//	}
//}
//
//function c_nick(f) { // 닉네임 변경 버튼
//	var c_nick = f.nick.value;
//
//	if (nick_check == "no") {
//		alert("중복확인을 하세요");
//		return;
//	}
//	if (c_nick == '') {
//		alert("변경할 닉네임을 입력해주세요");
//		return;
//	}
//	var url = "c_nick.do";
//	var param = "nick=" + c_nick;
//	sendRequest(url, param, c_nickFn, 'get');
//}
//function c_nickFn() { // 닉네임 변경 버튼 ajax
//	if (xhr.readyState == 4 && xhr.status == 200) {
//		var data = xhr.responseText;
//		var json = (new Function('return' + data))();
//
//		if (json[0].param == 'yes') {
//			alert('변경 성공');
//			location.href = "infochange.do";
//		} else {
//			alert('변경 실패');
//		}
//
//	}
//}
//
//function c_tel(f) { // 전화번호 변경 버튼
//	var c_tel = f.tel.value;
//	var regPhone = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
//	if (regPhone.test(c_tel) == false) {
//		alert('올바른 핸드폰 번호를 입력하세요');
//		return;
//	}
//	if (c_tel == "") {
//		alert("변경할 휴대전화를 입력해주세요");
//		return;
//	}
//	var url = "c_tel.do";
//	var param = "tel=" + c_tel;
//	sendRequest(url, param, c_telFn, 'get');
//}
//function c_telFn() {
//	if (xhr.readyState == 4 && xhr.status == 200) {
//		var data = xhr.responseText;
//		var json = (new Function('return' + data))();
//		if (json[0].param == 'yes') {
//			alert('변경 성공');
//			location.href = "infochange.do";
//		} else {
//			alert('변경 실패');
//		}
//
//	}
//}
//
//function c_addr(f) { // 주소 변경 버튼
//	var c_addr = f.user_addr.value;
//	var c_daddr = f.user_daddr.value;
//
//	if (c_addr == "") {
//		alert("변경 주소를 입력해주세요");
//		return;
//	}
//	var url = "c_addr.do"
//	var param = "user_addr=" + c_addr + "&user_daddr=" + c_daddr;
//	sendRequest(url, param, c_addrFn, "get")
//}
//
//function c_addrFn() {
//	if (xhr.readyState == 4 && xhr.status == 200) {
//		var data = xhr.responseText;
//		var json = (new Function('return' + data))();
//		if (json[0].param == 'yes') {
//			alert('변경 성공');
//			location.href = "infochange.do";
//		} else {
//			alert('변경 실패');
//		}
//
//	}
//}
//
