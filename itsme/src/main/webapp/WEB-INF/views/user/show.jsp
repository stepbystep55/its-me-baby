<%@ page language="java" session="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<html>
<head>
	<%@ include file="../_head.jsp"%>
	<title>View</title>
</head>
<body>
<%@ include file="../_body_header.jsp"%>

<div id="content">
	<div class="container_12">
		<div class="grid_1">&nbsp;</div>
		<div class="grid_11">
			<div id="title">${user.name}</div>
		</div>

		<div class="clear"></div>
		<div class="grid_1">&nbsp;</div>
		<div class="grid_6">
			<div id="profile">${user.profile}</div>
		</div>
		<div class="grid_5">&nbsp;</div>

	</div>
</div>

<div>
	<c:if test="${feedList != null}">
	Facebook
	<ul>
	<c:forEach items="${feedList}" var="post">
		<li>${post.updatedTime}: ${post.type}: ${post.message}</li>
	</c:forEach>
	</ul>
	</c:if>
	
	<c:if test="${tweets != null}">
	Twitter
	<ul>
	<c:forEach items="${tweets}" var="tweet">
		<li>${tweet.createdAt}: ${tweet.text}</li>
	</c:forEach>
	</ul>
	</c:if>
</div>
<div>
	<c:if test="${fn:length(entryList) > 0}">
	<c:forEach items="${entryList}" var="entry">
		<li>${entry.createdAt}: ${entry.message}</li>
	</c:forEach>
	</c:if>
</div>
</body>
</html>
