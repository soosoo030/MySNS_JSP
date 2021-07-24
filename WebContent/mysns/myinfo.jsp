<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="mysns.member.*"%>
<!DOCTYPE html>
<html>
<head>
<style>
body{text-align:center; background-color:ivory; color:ivory;font-family:THE외계인설명서,DX영화자막,"Typo_Dabanggu B";}
h2,p{color:black;}
form{ display:inline-block; padding:10px; background-color:grey;}
input[type=submit], input[type=button]{background-color:rgb(153, 191, 223); font-size:20px; border-type:none; border-radius:10px; color:ivory;}
</style>
<jsp:useBean id="u" scope="request" class="mysns.member.Member"/>
<meta charset="UTF-8">
<title>내 정보 확인</title>
</head>
<body>
<h2>사용자 정보</h2>
<p>아이디는 변경 할 수 없어요!</p>
<form name="userinfoform" method=post action="user_control.jsp">
<input type=hidden name="action" value="edituser">
<input type=hidden name="uid" value="<%=u.getUid() %>">
<table>
<tr>
	<td>아이디 : </td><td><%=u.getUid() %></td>
</tr>
<tr>
	<td>이름 : </td><td><input type="text" name="name" value="<%=u.getName() %>"/></td>
</tr>
<tr>
	<td>이메일 : </td><td><input type="email" name="email" value="<%=u.getEmail() %>" /></td>
</tr>
<tr>
	<td>가입 일자 : </td><td><%=u.getDate() %></td>
</tr>
<tr>
	<td><input type="submit" value="수정" /></td>
	<td><input type="button" value="탈퇴" onClick="delCheck()"></td>
</tr>
</table>
</form>
<script>
function delCheck(){
	result = confirm("정말로 탈퇴하시겠습니까? 탈퇴를 하면 작성된 게시글은 모두 사라지게 됩니다.");
	if(result){
		document.userinfoform.action.value="deluser";
		document.userinfoform.submit();
	}
	else
		return;
}
</script>
</body>
</html>