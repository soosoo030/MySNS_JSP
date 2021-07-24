<%@ tag body-content="scriptless" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%@ attribute name="mid" %>
<%@ attribute name="auid" %>
<%@ attribute name="curmsg" %>
<%@ attribute name="puid" %>
<c:if test="${uid != null}">
	<c:if test="${uid == auid}">
	<button type="button"><a href="sns_control.jsp?action=edit&mid=${mid}">수정</a></button>
	<button type="button"><a href="sns_control.jsp?action=delmsg&mid=${mid}&curmsg=${curmsg}&cnt=${cnt}&suid=${suid}">삭제</a></button>
	</c:if>
	<button type="button"><a href="sns_control.jsp?action=addfavmsg&mid=${mid}&puid=${uid}">관심글 등록</a></button>
	<button type="button"><a href="sns_control.jsp?action=fav&mid=${mid}&curmsg=${curmsg}&cnt=${cnt}&suid=${suid}">좋아요</a></button>
</c:if>
