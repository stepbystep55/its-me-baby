<%@ page language="java" session="true" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<html>
<head>
	<%@ include file="../_head.jsp"%>
	<title>Create</title>
</head>
<body>
<form:form modelAttribute="user" action="save" method="post">
<p>
	name:<form:input path="name" size="16" maxlength="32" />
	<spring:hasBindErrors name="user"><form:errors path="name" cssStyle="color:red" /></spring:hasBindErrors>
	<br>
	email:<form:input path="email" size="32" maxlength="128"/>
	<spring:hasBindErrors name="user"><form:errors path="email" cssStyle="color:red" /></spring:hasBindErrors>
	<br>
	password:<form:input path="password" size="10" maxlength="32" />
	<spring:hasBindErrors name="user"><form:errors path="password" cssStyle="color:red" /></spring:hasBindErrors>
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
