<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<script src="resources/js/httpRequest.js"></script>
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
table, td, tr {
	text-align: center;
}

.center {
	display: flex;
	flex-direction: column;
	align-items: center;
	margin: 150px auto;
	width: 600px;
	height: 1000px;
}

.del {
	text-align: center;
}

.form_table {
	width: 350px;
	height: 150px;
}

.info {
	display: flex;
	text-align: center;
}

.img {
	width: 100px;
	height: 100px;
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/incloude/logout_header.jsp"></jsp:include>
	<!-- 각 상품의 수량, 전체 수량 각각 필요 -->
	<div class="center">
		<div class="center_top">
			<c:if test="${ total ne 0 }">
				<c:forEach var="view_list" items="${ view_list }"
					varStatus="listcount">
					<form name="check" id="check">
						<input type="hidden" name="info"
							value="${ view_list.p_info_dcode }">
						<div class="info">
							<div>
								<div class="img">
									<img src="resources/upload/${ view_list.p_info_img1 }">
								</div>
							</div>
							<div>
								<div>상품명(색상/사이즈) : ${ view_list.p_info_name }(${ view_list.p_detail_color }/${ view_list.p_detail_size })</div>
								<div>상품 가격 : ${ view_list.p_info_price }원</div>
								<div>
									<input type="button" class="btn btn-outline-dark" value="-"
										onclick="minus(this.form);"> <input readonly
										name="cnt" value=${ need[listcount.index].cart_cnt}
										style="text-align: center; width: 100px;"> <input
										type="button" class="btn btn-outline-dark" value="+"
										onclick="plus(this.form);"> <img
										src="resources/image/biggarbagebin_121980.png"
										onclick="delOne()">
								</div>
							</div>
						</div>
					</form>
				</c:forEach>
			</c:if>

			<c:if test="${ total eq 0 }">
					아직 아무것도 담지 않았습니다.
				</c:if>


		</div>
		<div id="totaldel" class="del">
			전체 삭제 <img src="resources/image/biggarbagebin_121980.png"
				onclick="delAll()">
		</div>
		<div class="center_bottom">
			<form id="totalpay">
				<input type="hidden" id="paytotal" name="total" value="">
				<table class="form_table">
					<tr>
						<td>상품 금액</td>
						<td>할인 합계</td>
						<td>최종 결제 금액</td>
					</tr>

					<tr>
						<td><div id="total">${total}원</div></td>
						<td><div id="sail">${sail}원</div></td>
						<td><div id="sailtotal">${ sailtotal }</div></td>
					</tr>
					<tr>
						<td colspan="3"><input type="button"
							class="btn btn-outline-dark" value="결제하기"
							onclick="pay(this.form)"> <input type="button"
							class="btn btn-outline-dark" value="취소하기"
							onclick="javascript:history.back();"></td>
					</tr>

				</table>
			</form>
		</div>
	</div>
	<script>
		function minus(f) {
			if (f.cnt.value > 1) {
				var cnt = f.cnt.value;
				var info = f.info.value;
				f.cnt.value = cnt - 1;

				var url = "minus.do";
				var param = "cnt=" + cnt + "&info=" + info;
				sendRequest(url, param, minusres, "get");
			}
		}

		function plus(f) {
			var cnt = f.cnt.value;
			var info = f.info.value;
			f.cnt.value = parseInt(cnt) + 1;

			var url = "plus.do";
			var param = "cnt=" + cnt + "&info=" + info;
			sendRequest(url, param, plusres, "get");
		}

		function plusres() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				var data = xhr.responseText;
				var json = (new Function('return' + data))();

				document.getElementById('total').innerHTML = json[0].param;
				document.getElementById('sail').innerHTML = json[1].param;
				document.getElementById('sailtotal').innerHTML = json[2].param;
			}
		}

		function minusres() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				var data = xhr.responseText;
				var json = (new Function('return' + data))();

				document.getElementById('total').innerHTML = json[0].param;
				document.getElementById('sail').innerHTML = json[1].param;
				document.getElementById('sailtotal').innerHTML = json[2].param;
			}
		}
		//////////////////////////////////////////////////////////////
		function delOne() {
			if (!confirm("삭제하시겠습니까?")) {
				return;
			}

			var f = document.getElementById("check");
			f.action = "delOne.do";
			f.method = "post";
			f.submit();

		}

		function delAll() {
			if (!confirm("전체 삭제하시겠습니끼?")) {
				return;
			}

			location.href = "delAll.do";
		}

		/////////////////////////////////////////////////////////////
		function pay(f) {
			const element = document.getElementById("sailtotal");
			document.getElementById('paytotal').value = element.innerText;
			f.method = "post";
			f.action = "c_order.do";
			f.submit();
		}
	</script>
</body>
</html>