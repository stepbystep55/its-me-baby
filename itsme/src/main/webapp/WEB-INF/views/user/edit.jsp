<%@ page language="java" session="true" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<html>
<head>
	<%@ include file="../_head.jsp"%>
	<title>Edit</title>
</head>
<body>
<c:if test="${resultCreated}"><spring:message code="result.created" /></c:if>
<c:if test="${resultUpdated}"><spring:message code="result.updated" /></c:if>

<div id="show">
	<a href="show">view your page</a>
</div>

<div id="update">
<form:form modelAttribute="user" action="update" method="post">
<form:hidden path="id" />
<ul>
	<li>
		name:<form:input path="name" size="16" maxlength="32" />
		<spring:hasBindErrors name="user"><form:errors path="name" cssStyle="color:red" /></spring:hasBindErrors>
	</li>
	<li>
		email:<form:input path="email" size="32" maxlength="128"/>
		<spring:hasBindErrors name="user"><form:errors path="email" cssStyle="color:red" /></spring:hasBindErrors>
	</li>
	<li>
		password:<form:password path="password" size="16" maxlength="32" />
		<spring:hasBindErrors name="user"><form:errors path="password" cssStyle="color:red" /></spring:hasBindErrors>
	</li>
	<li>
		profile:<form:textarea path="profile" rows="5" cols="30" />
		<spring:hasBindErrors name="user"><form:errors path="profile" cssStyle="color:red" /></spring:hasBindErrors>
	</li>
	<li>
		<input type="submit" value="update"/>
	</li>
</ul>
</form:form>
</div>

<div id="social">
Facebook
<c:choose>
<c:when test="${facebookConnected}">
<form action="disconnect" method="POST">
	<input type="submit" value="disconnect" />
	<input type="hidden" name="provider" value="facebook" />
</form>
</c:when>
<c:otherwise>
<form action="<c:url value="/signin/facebook" />" method="POST">
	<input type="submit" value="connect" />
	<input type="hidden" name="scope" value="email,read_stream,offline_access" />
</form>
</c:otherwise>
</c:choose>

Twitter
<c:choose>
<c:when test="${twitterConnected}">
<form action="disconnect" method="POST">
	<input type="submit" value="disconnect" />
	<input type="hidden" name="provider" value="twitter" />
</form>
</c:when>
<c:otherwise>
<form action="<c:url value="/signin/twitter" />" method="POST">
	<input type="submit" value="connect" />
</form>
</c:otherwise>
</c:choose>
</div>

<script type="text/javascript">
$(function(){
});
</script>
</body>
</html>
