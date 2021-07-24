<%@ tag body-content="scriptless" language="java" pageEncoding="UTF-8"%>
<jsp:useBean id="product" class="jspbook.ch10.Product" />

<%@ attribute name="bgcolor" %>
<%@ attribute name="border" %>

<h2><jsp:doBody /></h2>	<!--커스텀 태그의 태그 바디에 기술된 문자열을 이 자리에 써넣어라  -->

<table border="${border}" bgcolor="${bgcolor}" width="150">
<%
	for( String item : product.getProductList()){
		out.println("<tr><td>"+item+"</td></tr>");
	}
%>
</table>