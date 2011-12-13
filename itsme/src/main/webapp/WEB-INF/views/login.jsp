<%@ page language="java" session="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
	<title>Login</title>
	<%@ include file="_head_base.jsp"%>
	<%@ include file="_head_menu_bar.jsp"%>
	<%@ include file="_head_grid.jsp"%>
	<script type="text/javascript"  charset="utf-8" src="<%= request.getContextPath() %>/resources/js/jquery.validate.min.js"></script>	
	<style type="text/css">
<!--
.error { color: red; }
// -->
	</style>
</head>
<body>
<jsp:include page="_menu_bar.jsp"/>

<form:form modelAttribute="user" action="login" method="post">
<div id="page_content">
	<div class="container_16">
		<div class="grid_16">
			<div id="page_title" class="align_center">Sign in</div>
		</div>
		<div class="clear"></div>
		<div class="grid_16">&nbsp;</div>

		<div class="clear"></div>
		<div class="grid_5 form_label align_right">
			<label for="emal">Email</label>
		</div>
		<div class="grid_6 form_input_large form_input_stretch align_right">
			<form:input path="email" maxlength="64" />
		</div>
		<div class="grid_5">
			<spring:hasBindErrors name="user"><form:errors path="email" cssStyle="color:red" /></spring:hasBindErrors>
		</div>
		
		<div class="clear"></div>
		<div class="grid_5 form_label align_right">
			<label for="password">Password</label>
		</div>
		<div class="grid_6 form_input_large form_input_stretch align_right">
			<form:password path="password" maxlength="32" />
		</div>
		<div class="grid_5">
			<spring:hasBindErrors name="user"><form:errors path="password" cssStyle="color:red" /></spring:hasBindErrors>
		</div>
		
		<div class="clear"></div>
		<div class="grid_11 user_form_button align_right">
			<input type="submit" value="Sign in"/>
		</div>
		<div class="grid_5">&nbsp;</div>

		<div class="clear"></div>
		<div class="container_16">
			<div class="grid_16">&nbsp;</div>
		</div>
		
		<div class="clear"></div>
		<div class="grid_11 user_form_button align_right">
			<a class="appeal" href="create">or Register</a>
		</div>
		<div class="grid_5">&nbsp;</div>
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
		<div class="grid12">
			<div class="footer_item">
			&copy;ippoippo
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
<!--
$(function(){
	// validate signup form on keyup and submit
	$("#user").validate({
		rules: {
			password: { required: true },
			email: { required: true }
		},
		messages: {
			password: { required: "Please provide a password" },
			email: { required: "Please provide a email" }
		},
		errorPlacement: function(error, element) {
			error.appendTo( element.parent("div").next("div") );
		}
	});
});
// -->
</script>
</body>
</html>
