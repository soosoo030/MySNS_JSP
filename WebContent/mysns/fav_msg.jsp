<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="sns"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:forEach var="m" items="${datas}">
			<div id="posting${m.mid}">
				<a href="#posting${m.mid}"><p id="head">[${m.uid}] ${m.msgtitle}</p></a>
				<h3 class="post">
				<p><span id="span1">작성자 : ${m.uid}</span><span id="span2">${m.date}</span></p>
				<p>${m.msg}<br>[좋아요${m.favcount} | 댓글 ${m.replycount}]</p>
				</h3>
			</div>
</c:forEach>
</body>
</html>