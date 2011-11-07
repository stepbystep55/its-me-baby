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
<%@ include file="_body_header.jsp"%>

<form:form modelAttribute="userGetter" action="login" method="post">
<div id="content">
	<div class="container_12">
		<div class="grid_11">
			<div id="title" style="text-align:center;">Sign in</div>
		</div>
		<div class="grid_1">&nbsp;</div>

		<div class="clear"></div>
		<div class="grid_3">&nbsp;</div>
		<div class="grid_1 user_form_label align_right">
			<label for="emal">Email</label>
		</div>
		<div class="grid_3 user_form_input align_right">
			<form:input path="email" size="16" maxlength="64" />
		</div>
		<div class="grid_5">
			<spring:hasBindErrors name="userGetter"><form:errors path="email" cssStyle="color:red" /></spring:hasBindErrors>
		</div>
		
		<div class="clear"></div>
		<div class="grid_3">&nbsp;</div>
		<div class="grid_1 user_form_label align_right">
			<label for="password">Password</label>
		</div>
		<div class="grid_3 user_form_input align_right">
			<form:password path="password" size="16" maxlength="32" />
		</div>
		<div class="grid_5">
			<spring:hasBindErrors name="userGetter"><form:errors path="password" cssStyle="color:red" /></spring:hasBindErrors>
		</div>
		
		<div class="clear"></div>
		<div class="grid_4">&nbsp;</div>
		<div class="grid_3 user_form_button align_right">
			<input type="submit" value="Sign in"/>
		</div>
		<div class="grid_5">&nbsp;</div>
		
		<div class="clear"></div>
		<div class="grid_4">&nbsp;</div>
		<div class="grid_3 user_form_button align_right">
			<a class="appeal" href="create">or Register</a>
		</div>
		<div class="grid_5">&nbsp;</div>
	</div>
</div>
</form:form>

<div id="footer">
	<div class="container_12">
		<div class="grid12">
			<div class="footer_item">
			&copy;ippoippo
			</div>
		</div>
	</div>
</div>
</body>
</html>
