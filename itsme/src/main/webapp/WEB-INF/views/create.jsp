<%@ page language="java" session="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<html>
<head>
	<title>Create</title>
	<%@ include file="_head_base.jsp"%>
	<%@ include file="_head_grid.jsp"%>
	<script type="text/javascript"  charset="utf-8" src="<%= request.getContextPath() %>/resources/js/jquery.validate.min.js"></script>	
	<script type="text/javascript">
<!--
$(function(){
	// validate signup form on keyup and submit
	$("#user").validate({
		rules: {
			name: {
				required: true,
				minlength: 3
			},
			password: {
				required: true,
				minlength: 8
			},
			reenter_password: {
				required: true,
				minlength: 8,
				equalTo: "#password"
			},
			email: {
				required: true,
				email: true
			}
		},
		messages: {
			name: {
				required: "Please enter your name",
				minlength: "Your name must be at least 3 characters long"
			},
			password: {
				required: "Please provide a password",
				minlength: "Your password must be at least 8 characters long"
			},
			reenter_password: {
				required: "Please provide a password",
				minlength: "Your password must be at least 8 characters long",
				equalTo: "Please enter the same password as above"
			},
			email: {
				required: "Please provide a email",
				email: "Please enter a valid email address"
			}
		},
		errorPlacement: function(error, element) {
			error.appendTo( element.parent("div").next("div") );
		}
	});
});
// -->
	</script>
	<style type="text/css">
<!--
.error { color: red; }
// -->
	</style>
</head>
<body>
<jsp:include page="_body_header.jsp"/>

<form:form modelAttribute="user" action="save" method="post">
<div id="content">
	<div class="container_16">
		<div class="grid_16">
			<div id="title" style="text-align:center;">Sign up</div>
		</div>
		<div class="clear"></div>
		<div class="grid_16">&nbsp;</div>

		<div class="clear"></div>
		<div class="grid_5 user_form_label align_right">
			<label for="name">Name</label>
		</div>
		<div class="grid_5 user_form_input align_right">
			<form:input path="name" maxlength="32" />
		</div>
		<div class="grid_6">
			<spring:hasBindErrors name="user"><form:errors path="name" cssStyle="color:red" /></spring:hasBindErrors>
		</div>

		<div class="clear"></div>
		<div class="grid_5 user_form_label align_right">
			<label for="emal">Email</label>
		</div>
		<div class="grid_5 user_form_input align_right">
			<form:input path="email" maxlength="128"/>
		</div>
		<div class="grid_6">
			<spring:hasBindErrors name="user"><form:errors path="email" cssStyle="color:red" /></spring:hasBindErrors>
		</div>

		<div class="clear"></div>
		<div class="grid_5 user_form_label align_right">
			<label for="password">Password</label>
		</div>
		<div class="grid_5 user_form_input align_right">
			<form:password path="password" maxlength="32" />
		</div>
		<div class="grid_6">
			<spring:hasBindErrors name="user"><form:errors path="password" cssStyle="color:red" /></spring:hasBindErrors>
		</div>

		<div class="clear"></div>
		<div class="grid_5 user_form_label_br align_right">
			<label for="reenter_password">Re-enter<br/>Password</label>
		</div>
		<div class="grid_5 user_form_input align_right">
			<input type="password" id="reenter_password" name="reenter_password" maxlength="32" />
		</div>
		<div class="grid_6"></div>

		<div class="clear"></div>
		<div class="grid_10 user_form_button align_right">
			<input type="submit" value="Sign up"/>
		</div>
		<div class="grid_6"></div>
	</div>

	<div class="container_16">
		<div class="grid_16">&nbsp;</div>
	</div>
	<div class="container_16">
		<div class="grid_16">&nbsp;</div>
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
