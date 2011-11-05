<%@ page language="java" session="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<html>
<head>
	<%@ include file="_head.jsp"%>
	<title>Login</title>
</head>
<body>
<div id="login">
<form:form modelAttribute="userGetter" action="login" method="post">
<ul>
	<li>
		email:<form:input path="email" size="32" maxlength="32" />
		<spring:hasBindErrors name="userGetter"><form:errors path="email" cssStyle="color:red" /></spring:hasBindErrors>
	</li>
	<li>
		password:<form:input path="password" size="16" maxlength="32" />
		<spring:hasBindErrors name="userGetter"><form:errors path="password" cssStyle="color:red" /></spring:hasBindErrors>
	</li>
	<li>
		<input type="submit" value="signin"/>
	</li>
</ul>
</form:form>
</div>

<div id="regiter">
	<a href="create">register</a>
</div>
</body>
</html>
