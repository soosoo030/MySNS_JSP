<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="sns"%>

<!DOCTYPE html>
<html>
<head>

<style> 
@import "stylesheet.css";
</style>
<script>
	function newuser() {
		window.open(
						"new_user.jsp",
						"newuser",
						"titlebar=no,location=no,scrollbars=no,resizeable=no,menubar=no,toolbar=no,width=600,height=240");
	}
</script>
		
<meta charset="UTF-8">
<title>메인 화면</title>
</head>
<body>
	<header id=banner>TWITTAGRAM</header>
	<nav id=bar>
		<ul>
			<li><a href="sns_control.jsp?action=getall">HOME</a></li>
			<li><a href="sns_control.jsp?action=getall">전체글보기</a>
			<li><button type="button"><a href="javascript:newuser()">회원 가입</a></button></li>
			<li><sns:login /></li>					
		</ul>
		<form name="searchform" method="get" action="user_control.jsp">
			ID 검색 >> <input type="hidden" name="action" value="search">
			<input type="text" name="key"> <input type="submit" value="검색"/>
		</form>
	</nav>
	<section id="section">
		<form id="mform" method="post" action="sns_control.jsp?action=newmsg">
			<input type="hidden" name="uid" value="${uid}">
			<h2 style="text-align : left">게시글을 작성해주세요:D</h2>
			<sns:write type="msgtitle" />
			<sns:write type="msg"/>
			<input id="postButton" type="submit" value="POST">
		</form>
		<div id=output><!-- 게시글 출력 위치 -->
		<c:forEach varStatus="mcnt" var="msgs" items="${datas}">
			<c:set var="m" value="${msgs.message}"/>
			<div id="posting${m.mid}">
				<a href="#posting${m.mid}"><p id="head">[${m.uid}] ${m.msgtitle}</p></a>
				<h3 class="post">
				<p><span id="span1">작성자 : ${m.uid}</span><span id="span2">${m.date}</span></p>
				<p>${m.msg}<br>[좋아요${m.favcount} | 댓글 ${m.replycount}]</p>
				<p style="text-align : right"><sns:smenu mid="${m.mid}" auid="${m.uid}" puid="${uid}" curmsg="${mcnt.index}"/></p></h3>
				<br>
				<ul class="reply">
				<c:forEach var="r" items="${msgs.rlist}">
				<c:choose>
					<c:when test="${r.secret == false }">
						<li>${r.uid } :: ${r.rmsg} - ${r.date} <sns:rmenu curmsg="${mcnt.index}" rid="${r.rid}" ruid="${r.uid}" rmid="${r.mid}"/></li>
					</c:when>
					<c:otherwise>
						<li>${r.uid } :: <sns:secret ruid="${r.uid}" muid="${m.uid}" puid="${uid}" msg="${r.rmsg}"/> - ${r.date}<sns:rmenu curmsg="${mcnt.index}" rid="${r.rid}" ruid="${r.uid}" rmid="${r.mid}"/></li>
					</c:otherwise>
				</c:choose>
				</c:forEach>
				</ul>
				<br>
				<form name="replyform" action="sns_control.jsp?action=newreply&cnt=${cnt}" method="post">
							<input type="hidden" name="mid" value="${m.mid}">
							<input type="hidden" name="uid" value="${uid}">
							<input type="hidden" name="suid" value="${suid}">
							<input type="hidden" name="curmsg" value="${mcnt.index}">				
							<sns:write type="rmsg"/>
						
				</form>
			</div>
			</c:forEach>
		
		</div>
			<div align="center"><a href="sns_control.jsp?action=getall&cnt=${cnt+5}&suid=${suid}">더보기&gt;&gt;</a></div>
	</section>
	<aside id=aside>
		<h3><a href="user_control.jsp?action=userinfo&uid=${uid}">내 정보</a></h3>
		<h3><a href="sns_control.jsp?action=getfavmsg&fuid=${uid}">나의 관심글</a></h3>
		<h3>새로운 가입자!</h3>
		<ul>
		<c:forEach items="${nusers}" var="n">
			<li><a href="sns_control.jsp?action=getall&suid=${n}">${n}</a></li>
		</c:forEach>
		</ul>
	</aside>
	<footer id=footer>
		덕성여자대학교 컴퓨터공학과 20190991 김수정  &nbsp;[START : 2020-6-29 ~ END : 2020-7-3]
	</footer>
</body>
</html>