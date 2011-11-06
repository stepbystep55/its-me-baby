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
	<div class="container clearfix">
		<div class="grid1 first">
			<a href="<%= request.getContextPath() %>/">Top</a>
		</div>
		<div class="grid10">
			&nbsp;
		</div>
		<div class="grid1">
			<a href="login">Sign in</a>
		</div>
	</div>
</div>

<div id="content">
	<div class="grid3 first">&nbsp;</div>
	<div class="grid9">
			<div class="grid9 first">
				<div id="title" style="padding-left: 65px;">Sign in</div>
			</div>

			<div class="grid1 first user_form_label">
				<label for="emal">Email</label>
			</div>
			<div class="grid3 user_form_input">
				<form:input path="email" size="16" maxlength="64" />
			</div>
			<div class="grid5">
				<spring:hasBindErrors name="userGetter"><form:errors path="email" cssStyle="color:red" /></spring:hasBindErrors>
			</div>
		
			<div class="grid1 first user_form_label">
				<label for="password">Password</label>
			</div>
			<div class="grid3 user_form_input">
				<form:input path="password" size="16" maxlength="32" />
			</div>
			<div class="grid5">
				<spring:hasBindErrors name="userGetter"><form:errors path="password" cssStyle="color:red" /></spring:hasBindErrors>
			</div>
		
			<div class="grid2 first">&nbsp;</div>
			<div class="grid1 user_form_button" style="padding-left: 33px;">
				<input type="submit" value="Sign in"/>
			</div>
			<div class="grid6">&nbsp;</div>
		
			<div class="grid2 first">&nbsp;</div>
			<div class="grid7 user_form_button">
				<a class="appeal" href="create">or Register</a>
			</div>
	</div>
</div>

<div id="footer">
	<div class="container clearfix">
		<div class="grid12 first">
			<div class="footer_item">
			&copy;ippoippo
			</div>
		</div>
	</div>
</div>
</form:form>
</body>
</html>
