<%@ page language="java" session="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<html>
<head>
	<%@ include file="../_head.jsp"%>
	<title>Show</title>
	<script type="text/javascript">
<!--
$(function(){
});
// -->
	</script>
</head>
<body>

<div>
	<c:if test="${fn:length(entryList) > 0}">
	<ul>
	<c:forEach items="${entryList}" var="entry">
		<li>${entry.createdAt}: ${entry.message}</li>
	</c:forEach>
	</ul>
	</c:if>
</div>
</body>
</html>
