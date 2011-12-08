<%@ page language="java" session="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="its.me.baby.dto.StreamEntry" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
	<title>Stream</title>
	<%@ include file="../_head_base.jsp"%>
	<script type="text/javascript"  charset="utf-8" src="<%= request.getContextPath() %>/resources/js/jquery.masonry.min.js"></script>
	<style type="text/css">
<!--
.wrap {
	width: 880px;
	margin: 10px;
	padding: 5px 3px;
	background: #E6E6FA;
	overflow: auto;
}
.box {
	width: 260px;
	margin: 5px;
	padding: 10px;
	float: left;
	color: #333;
	background: #F8F8FF;
	display: inline;  /* IE6 fix */
}
.what_time {
	font-style: italic;
	font-size: 80%;
}
.no_stream {
	width: 100%;
	text-align: center;
	font-size: 72px;
	font-weight: bold;
	font-style: italic;
	color: #333333;
}
// -->
	</style>
</head>
<body>

<div>
	<c:choose>
	<c:when test="${fn:length(entryList) > 0}">
		<div class="wrap">
		<c:forEach items="${entryList}" var="entry">
			<div class="box">
				<c:choose>
					<c:when test="${entry.isFacebook}">
						<img src="<%= request.getContextPath() %>/resources/img/icon/facebook16.png" />
					</c:when>
					<c:when test="${entry.isTwitter}">
						<img src="<%= request.getContextPath() %>/resources/img/icon/twitter16.png" />
					</c:when>
				</c:choose>
				<p>
				${entry.message}<br/>
				</p>
				<span class="what_time"><fmt:formatDate value="${entry.createdAt}" type="DATE" pattern="MM-dd-yyyy HH:mm"/></span>
			</div>
		</c:forEach>
		</div>
	</c:when>
	<c:otherwise>
		<div class="no_stream">No Stream</div>
	</c:otherwise>
	</c:choose>
</div>

<script type="text/javascript">
<!--
$(function(){
	$('.wrap').masonry();
});
// -->
</script>
</body>
</html>
