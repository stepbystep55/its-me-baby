<%@ page language="java" session="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<html>
<head>
	<%@ include file="_head.jsp"%>
	<title>Login</title>
	<style TYPE="text/css">
<!--
#title {
	margin: 0;
	padding-top: 30px;
	padding-bottom: 20px;
	color: #DC143C;
	font-weight: bold;
	font-size: 42px;
}
-->
	</style>
</head>
<body>
<form:form modelAttribute="userGetter" action="login" method="post">
<div id="header">
	<div class="container_12">
		<div class="grid_1">
			<a href="<%= request.getContextPath() %>/">Top</a>
		</div>
		<div class="grid_11">
			&nbsp;
		</div>
	</div>
</div>

<div id="content">
	<div class="container_12">
		<div class="grid_3">&nbsp;</div>
		<div class="grid_9">
			<div id="title" style="padding-left: 65px;">Sign in</div>
		</div>

		<div class="clear"></div>
		<div class="grid_3">&nbsp;</div>
		<div class="grid_1 user_form_label">
			<label for="emal">Email</label>
		</div>
		<div class="grid_3 user_form_input">
			<form:input path="email" size="16" maxlength="64" />
		</div>
		<div class="grid_5">
			<spring:hasBindErrors name="userGetter"><form:errors path="email" cssStyle="color:red" /></spring:hasBindErrors>
		</div>
		
		<div class="clear"></div>
		<div class="grid_3">&nbsp;</div>
		<div class="grid_1 user_form_label">
			<label for="password">Password</label>
		</div>
		<div class="grid_3 user_form_input">
			<form:input path="password" size="16" maxlength="32" />
		</div>
		<div class="grid_5">
			<spring:hasBindErrors name="userGetter"><form:errors path="password" cssStyle="color:red" /></spring:hasBindErrors>
		</div>
		
		<div class="clear"></div>
		<div class="grid_5">&nbsp;</div>
		<div class="grid_7 user_form_button">
			<input type="submit" value="Sign in"/>
		</div>
		
		<div class="clear"></div>
		<div class="grid_5">&nbsp;</div>
		<div class="grid_7 user_form_button">
			<a class="appeal" href="create">or Register</a>
		</div>
	</div>
</div>

<div id="footer">
	<div class="container_12">
		<div class="grid12">
			<div class="footer_item">
			&copy;ippoippo
			</div>
		</div>
	</div>
</div>
</form:form>
</body>
</html>
