<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="resources/js/httpRequest.js"></script>
<script>
	function send(f){
		
		var admin_id=f.admin_id.value.trim();
		var admin_pw=f.admin_pw.value.trim();
		if(admin_id=="" || admin_pw==""){
			alert("이이디나 비밀번호를 입력하세요");
			return;
		}
		var url="admin_check.do";
		var param="admin_id="+admin_id+"&admin_pw="+admin_pw;
		
		sendRequest(url,param,resultFn,"post");
	}
	function resultFn(){
		if(xhr.readyState==4 && xhr.status==200){
			let check=xhr.responseText;
			if(check=="yes"){
				location.href="admin.do";
			}
			else{
				alert("틀림 풉 ㅋ");
			}
		}
		
	}
</script>
</head>
<body>
	<form>
			<table border="1" align="center">
				<caption>::: 로그인 :::</caption>
				<tr>
					<th>아이디</th>
					<td><input name="admin_id"></td>
				</tr>
				
				<tr>
					<th>비밀번호</th>
					<td><input type="password" name='admin_pw'></td>
				</tr>
				
				<tr>
					<td colspan="2" align="center">
						<input type="button" value="로그인" onclick="send(this.form);">
					</td>
				</tr>
			</table>
		</form>
</body>
</html>