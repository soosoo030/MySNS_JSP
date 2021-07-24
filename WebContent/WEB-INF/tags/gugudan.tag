<%@ tag body-content="scriptless" language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="b" %>
<%@ attribute name="e" %>

<table>
<c:if test="${empty(b)}">
	<c:set value="2" var="b" />
</c:if>
<c:if test="${empty(e)}">
	<c:set value="9" var="e" />
</c:if>
<h2><jsp:doBody />(${b}~${e}단)</h2>	<!-- 커스텀 태그의 태그 바디에 기술된 문자열 이 자리에 출력 -->
<c:forEach var="i" begin="${b}" end="${e}">
	<tr>
	<c:forEach var="j" begin="1" end="9">
		<td>${i} * ${j} = ${i*j}&nbsp;</td>
	</c:forEach>
	</tr>
</c:forEach>

</table>