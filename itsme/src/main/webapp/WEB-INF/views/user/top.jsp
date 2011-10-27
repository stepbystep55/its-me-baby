<%@ page language="java" session="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<title>Top</title>
</head>
<body>
<form:form modelAttribute="user" action="create" method="post">
	<input type="submit" value="create">
</form:form>

<form:form modelAttribute="userGetter" action="login" method="post">
<p>
	email:<form:input path="email" size="16" maxlength="32" />
	<spring:hasBindErrors name="userGetter"><form:errors path="email" cssStyle="color:red" /></spring:hasBindErrors>
	<br>
	password:<form:input path="password" size="10" maxlength="32" />
	<spring:hasBindErrors name="userGetter"><form:errors path="password" cssStyle="color:red" /></spring:hasBindErrors>
	<br>
	<input type="submit">
</p>
</form:form>
</body>
</html>
