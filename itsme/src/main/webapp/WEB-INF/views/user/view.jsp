<%@ page language="java" session="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<html>
<head>
	<%@ include file="../_head.jsp"%>
	<title>View</title>
</head>
<body>
<c:if test="${resultCreated}"><spring:message code="result.created" /></c:if>
<c:if test="${resultUpdated}"><spring:message code="result.updated" /></c:if>
<p>
	id:${user.id}
	<br>
	name:${user.name}
	<br>
	email:${user.email}
	<br>
	password:${user.password}
	<br>
	profile:${user.profile}
	<br>
</p>
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
</body>
</html>
