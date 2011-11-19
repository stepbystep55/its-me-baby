<%@ page language="java" session="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<html>
<head>
	<title>Stream</title>
	<%@ include file="../_head_base.jsp"%>
	<script type="text/javascript"  charset="utf-8" src="<%= request.getContextPath() %>/resources/js/jquery.masonry.min.js"></script>
	<script type="text/javascript">
<!--
$(function(){
	$('.wrap').masonry();
});
// -->
	</script>
	<style type="text/css">
<!--
.wrap {
	width: 880px;
	padding: 10px;
	background: #EEE;
	overflow: auto;
}
.box {
	width: 230px;
	margin: 5px;
	padding: 10px;
	float: left;
	background: #424242;
	color: #FFF;
	display: inline;  /* IE6 fix */
}
// -->
	</style>
</head>
<body>

<div>
	<c:if test="${fn:length(entryList) > 0}">
	<div class="wrap">
	<c:forEach items="${entryList}" var="entry">
		<div class="box">
		<fmt:formatDate value="${entry.createdAt}" type="DATE" pattern="MM-dd-yyyy"/><br/>
		${entry.message}
		</div>
	</c:forEach>
	</div>
	</c:if>
</div>
</body>
</html>
