<%@ page language="java" session="true" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<html>
<head>
	<%@ include file="_head.jsp"%>
	<title>Create</title>
	<script type="text/javascript">
<!--
$(function(){
});
// -->
	</script>
</head>
<body>
<%@ include file="_body_header.jsp"%>

<form:form modelAttribute="user" action="save" method="post">
<div id="content">
	<div class="container_12">
		<div class="grid_11">
			<div id="title" style="text-align:center;">Register</div>
		</div>
		<div class="grid_1">&nbsp;</div>

		<div class="clear"></div>
		<div class="grid_3">&nbsp;</div>
		<div class="grid_1 user_form_label align_right">
			<label for="name">Name</label>
		</div>
		<div class="grid_3 user_form_input align_right">
			<form:input path="name" size="16" maxlength="32" />
		</div>
		<div class="grid_5">
			<spring:hasBindErrors name="user"><form:errors path="name" cssStyle="color:red" /></spring:hasBindErrors>
		</div>

		<div class="clear"></div>
		<div class="grid_3">&nbsp;</div>
		<div class="grid_1 user_form_label align_right">
			<label for="emal">Email</label>
		</div>
		<div class="grid_3 user_form_input align_right">
			<form:input path="email" size="16" maxlength="64"/>
		</div>
		<div class="grid_5">
			<spring:hasBindErrors name="user"><form:errors path="email" cssStyle="color:red" /></spring:hasBindErrors>
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
			<spring:hasBindErrors name="user"><form:errors path="password" cssStyle="color:red" /></spring:hasBindErrors>
		</div>

		<div class="clear"></div>
		<div class="grid_3">&nbsp;</div>
		<div class="grid_1">&nbsp;</div>
		<div class="grid_3 user_form_button align_right" style="padding-left: 33px;">
			<input type="submit" value="Sign up"/>
		</div>
		<div class="grid_5">&nbsp;</div>
	</div>
</div>
</form:form>

<div id="footer">
	<div class="container_12">
		<div class="grid_12">
			<div class="footer_item">
			&copy;ippoippo
			</div>
		</div>
	</div>
</div>
</body>
</html>
