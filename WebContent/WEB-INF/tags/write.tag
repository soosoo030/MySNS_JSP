<%@ tag body-content="scriptless" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%@ attribute name="type" %>

<c:if test="${uid != null}">
<c:choose> 
	<c:when test="${type == 'msgtitle'}">제목 : <input  type="text" name="msgtitle" maxlength="15" size="100"><br></c:when>
	<c:when test="${type == 'msg'}">내용 : <input  type="text" name="msg" maxlength="100" size="100"></c:when>
	<c:when test="${type == 'rmsg'}">[${uid}] <input type="text" name="rmsg" maxlength="50" size="60"> [비밀댓글<input type="checkbox" name="secret" value="true">]
	<input type="submit" value="등록"/>
	</c:when>
</c:choose>
</c:if>

<c:if test="${uid == null}">
<c:choose> 
	<c:when test="${type == 'msgtitle'}">제목 : <input  type="text" name="msgtitle" maxlength="15" size="100" disabled="disabled"  value="작성하려면 로그인 하세요!!"><br></c:when>
	<c:when test="${type == 'msg'}">내용 : <input type="text" name="msg" maxlength="100" size="100" disabled="disabled"  value="작성하려면 로그인 하세요!!"></c:when>
	<c:when test="${type == 'rmsg'}">X <input type="text" name="rmsg" maxlength="50" size="60" disabled="disabled" value="작성하려면 로그인 하세요!!"></c:when>
</c:choose>
</c:if>