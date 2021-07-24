<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
body{text-align:center; background-color:ivory; color:ivory;}
header{display:inline-block; font-size:20px; color:black;}
form{ display:inline-block; padding:10px; background-color:grey;}
input[type=submit]{background-color:rgb(153, 191, 223); font-size:20px; border-type:none; border-radius:10px; color:ivory;}
</style>

<title>회원 가입 화면</title>
</head>
<body>
<header>신규 가입:)</header>
<hr>
<form name="newuserform" action="user_control.jsp" method="post">
<input type=hidden name="action" value="insert">
<table>
<tr><td>이름 : </td><td><input type="text" name="name" required></td></tr>
<tr><td>아이디 : </td><td><input type="text" name="uid" required></td></tr>
<tr><td>이메일 : </td><td><input type="email" name="email"></td></tr>
<tr><td>비밀번호 : </td><td><input type="password" name="user_pw" required></td></tr>
<tr><td colspan="2"><input type="submit" value="회원 등록"></td></tr>
</table>
	
</form>
</body>
</html>