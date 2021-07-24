<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%@ attribute name="ruid" %>
<%@ attribute name="muid" %>
<%@ attribute name="puid" %>
<%@ attribute name="msg" %>
<c:choose>
<c:when test="${(puid == muid)||(puid == ruid) }">
	[비밀 댓글] ${msg}
</c:when>
<c:otherwise>
	비밀 댓글입니다.
</c:otherwise>
</c:choose>