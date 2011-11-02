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
<br>
<form action="<c:url value="/signin/facebook" />" method="POST">
	<input type="image" src="<%= request.getContextPath() %>/resources/img/connect_facebook.gif" />
	<input type="hidden" name="scope" value="email,read_stream,offline_access" />
</form>
<form action="<c:url value="/signin/twitter" />" method="POST">
	<input type="image" src="<%= request.getContextPath() %>/resources/img/t_logo.png" />
	<input type="hidden" name="scope" value="email,read_stream,offline_access" />
</form>
<script type="text/javascript">
$(function(){
});
</script>
</body>
</html>
