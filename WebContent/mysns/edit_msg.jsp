<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="mysns.sns.*"%>
<!DOCTYPE html>
<html>
<style>
body{text-align:center; background-color:ivory; color:ivory;font-family:THE외계인설명서,DX영화자막,"Typo_Dabanggu B";}
h2,p{color:black;}
form{ display:inline-block; padding:10px; background-color:grey; text-align:left;}
input[type=submit]{background-color:rgb(153, 191, 223); font-size:20px; border-type:none; border-radius:10px; color:ivory;}

</style>
<head>
<meta charset="UTF-8">
<jsp:useBean id="m" scope="request" class="mysns.sns.Message"/>
<title>게시글 수정</title>
</head>
<body>
<h2>게시글 수정</h2>
<form name="msgeditform" method=post action="sns_control.jsp?action=editmsg">
<input type=hidden name="mid" value="<%=m.getMid() %>">
제목 : <input type="text" name="msgtitle" size="50" maxlength="15" value="<%=m.getMsgtitle() %>" /><br>

내용 : <input type="text" name="msg" size="50" maxlength="100" value="<%=m.getMsg()%>" />
<input type="submit" value="수정"/>
</form>
</body>
</html>