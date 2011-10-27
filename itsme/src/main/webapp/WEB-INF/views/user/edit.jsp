<%@ page language="java" session="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<meta http-equiv="Pragma" content="no-cache" />
	<meta http-equiv="Cache-Control" content="no-cache" />
	<meta http-equiv="Expires" content="-1" />
	<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.6.4.min.js"></script>
	<title>Edit</title>
</head>
<body>
<form:form modelAttribute="user" action="update" method="post">
<p>
	<form:hidden path="id" />

	name:<form:input path="name" size="16" maxlength="32" />
	<spring:hasBindErrors name="user"><form:errors path="name" cssStyle="color:red" /></spring:hasBindErrors>
	<br>
	email:<form:input path="email" size="32" maxlength="128"/>
	<spring:hasBindErrors name="user"><form:errors path="email" cssStyle="color:red" /></spring:hasBindErrors>
	<br>
	password:<form:password path="password" size="10" maxlength="32" />
	<spring:hasBindErrors name="user"><form:errors path="password" cssStyle="color:red" /></spring:hasBindErrors>
	<br>
	profile:<form:textarea path="profile" rows="5" cols="30" />
	<spring:hasBindErrors name="user"><form:errors path="profile" cssStyle="color:red" /></spring:hasBindErrors>
	<br>
	<br>
	<input type="submit">
</p>
</form:form>
<script type="text/javascript">
$(function(){
});
</script>
</body>
</html>
