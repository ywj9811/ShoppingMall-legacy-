<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문-처리</title>

<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	crossorigin="anonymous"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<!-- jQuery -->
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<!-- iamport.payment.js -->
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>


<style>
.info_teb {
	display: flex;
	width: 500px;
	margin: 250px auto;
	flex-direction: column;
}

div {
	padding: 7px;
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/incloude/logout_header.jsp"></jsp:include>
	<form>
		<div class="info_teb">
			<input type="hidden" name="count" value="${ count }">
			<div>
				<div>이름</div>
				<div>
					<input id="name" name="name" placeholder="이름을 입력하시오">
				</div>
			</div>
			<!-- 세션에서 받아온 사용자 이름 -->
			<div>
				<div>주소</div>
				<input type="text" id="address" name="address" placeholder="주소">
				<input type="button" class="btn btn-outline-dark"
					onclick="sample6_execDaumPostcode()" value="주소 찾기"> <input
					type="text" id="detailAddress" name="detail" placeholder="상세주소">
			</div>
			<div>
				<div>휴대 전화</div>
				<input type="text" placeholder="'-'제외하고  입력하세요" name="tel"
					maxlength='11'>
			</div>
			<div>
				<div>배송시 요청사항</div>
				<input type="text" name="want" id="want"
					placeholder="배송시 요청사항을 적어주세요"> <select id="want_select">
					<option value="1" selected>직접입력</option>
					<option value="부재시 문앞에 놓고 가주세요">부재시 문앞에 놓고 가주세요</option>
					<option value="부재시 경비실에 두고 가주세요">부재시 경비실에 두고 가주세요</option>
					<option value="배달시 문자를 주세요">배달시 문자를 주세요</option>
				</select>
			</div>
			<div class="info_p">
				<c:forEach var="view_list" items="${ view_list }"
					varStatus="listcount">
					<div>상품 이름 : ${ view_list.p_info_name } (${ view_list.p_detail_color }/${ view_list.p_detail_size })
					</div>
					<div>상품 가격 : ${ view_list.p_info_price }원</div>
				</c:forEach>
			</div>

			<div style="text-align: center;">
				<div>
					<input type="hidden" name="total" value="${ total }"> 수량 :
					${ count }
				</div>
				<div>총 가격 : ${ total }</div>
				<div>
					<input type="button" value="결제하기" class="btn btn-outline-dark"
						onclick="requestPay(this.form);">
				</div>
			</div>
		</div>
	</form>

	<script type="text/javascript">
	   //배송 요청사항
	   $('#want_select').change(function() {
	      $("#want_select option:selected").each(function() {
	
	         if ($(this).val() == '1') { //직접입력일 경우
	            $("#want").val(''); //값 초기화
	            $("#want").attr("readOnly", false); //활성화
	         } else { //직접입력이 아닐경우
	            $("#want").val($(this).text()); //선택값 입력
	            $("#want").attr("readOnly", true); //비활성화
	         }
	      });
	   })
	</script>

	<script>
	//값이 어떻게 담아지는지 확인하는 부분(test2)
		function test2(){
			var f = $('#test');
			var formData = f.serialize();
			alert(formData);
		}
		
		function test(f){
			f.method = "get";
			f.action = "payfin.do";
			f.submit();
		}
		
		function sample6_execDaumPostcode() {
			new daum.Postcode(
					{
						oncomplete : function(data) {
							// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

							// 각 주소의 노출 규칙에 따라 주소를 조합한다.
							// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
							var addr = ''; // 주소 변수
							var extraAddr = ''; // 참고항목 변수

							//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
							if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
								addr = data.roadAddress;
							} else { // 사용자가 지번 주소를 선택했을 경우(J)
								addr = data.jibunAddress;
							}

							// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
							if (data.userSelectedType === 'R') {
								// 법정동명이 있을 경우 추가한다. (법정리는 제외)
								// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
								if (data.bname !== ''
										&& /[동|로|가]$/g.test(data.bname)) {
									extraAddr += data.bname;
								}
								// 건물명이 있고, 공동주택일 경우 추가한다.
								if (data.buildingName !== ''
										&& data.apartment === 'Y') {
									extraAddr += (extraAddr !== '' ? ', '
											+ data.buildingName
											: data.buildingName);
								}
								// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
								if (extraAddr !== '') {
									extraAddr = ' (' + extraAddr + ')';
								}
								// 조합된 참고항목을 해당 필드에 넣는다.
								/*  document.getElementById("sample6_extraAddress").value = extraAddr; */

							} else {
								document.getElementById("sample6_extraAddress").value = '';
							}

							// 우편번호와 주소 정보를 해당 필드에 넣는다.
							/*  document.getElementById('sample6_postcode').value = data.zonecode; */
							document.getElementById("address").value = addr;
							// 커서를 상세주소 필드로 이동한다.
							document.getElementById("detailAddress")
									.focus();
						}
					}).open();
		}
		
		function requestPay( f ) {
			var name = f.name.value;
			var address = f.address.value;
			var detailaddress = f.detail.value;
			var tel = f.tel.value;
			
			if(name == ''){
				alert("이름을 입력하세요.");
				return;
			}
			
			if(address == ''){
				alert("주소를 입력하세요.");
				return;
			}
			
			if(detailaddress == ''){
				alert("상세주소을 입력하세요.");
				return;
			}
			
			if(tel == ''){
				alert("번호을 입력하세요.");
				return;
			}
			
			var IMP = window.IMP;
			IMP.init("imp44549169"); //이 값은 i'mport에서 가져옴
			// IMP.request_pay(param, callback) 결제창 호출
			
			/* 상품코드, 상품이름, 금액, 이메일, 이름, 번호, 주소 필요 */
			if(${count} > 1){
				var mn = "${view_list[0].p_info_name}"+"외"+"${count-1}"+"개";
			}else{
				var mn = "${view_list[0].p_info_name}";
			}
			
			IMP.request_pay({ // param
				pg : "html5_inicis",
				//하나의 아임포트계정으로 여러 PG를 사용할 때 구분자로 사용할 PG사의 코드값을 입력한다.
				pay_method : "card",
				//결제수단 (옵션값 참고)
				merchant_uid : "${view_list[0].p_info_code}" + new Date().getTime(),
				//가맹점에서 생성/관리하는 고유 주문번호
				name : mn,
				//주문명
				amount : "${total}",
				//결제 금액
				buyer_email : "email",
				buyer_name : "name",
				buyer_tel : "tel",
				buyer_addr : "address", //회원 세션에서 받아서 넣자
			//buyer는 모두 구매자의 정보
			}//여기까지 정보 받는 부분
			, function(rsp) { // callback
				console.log(rsp);
				if (rsp.success) {
			         // 가맹점 서버 결제 API 성공시 로직
			        var msg = '결제가 완료되었습니다.';
					alert(msg);
					f.method = "post";
					f.action = "payfin.do"
					f.submit();
				} else {
					var msg = '결제에 실패하였습니다.';
					msg += '에러내용 : ' + rsp.error_msg; //결제 실패
					alert(msg);
				}
				//여기는 callback 부분
				//error_msg, apply_num 등은 제공되는 속성값
			});
			//IMP.request_pay 완료

		}
	</script>
</body>
</html>