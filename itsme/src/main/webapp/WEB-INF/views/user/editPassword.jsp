<%@ page language="java" session="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

		<form:form modelAttribute="user" action="updatePassword" method="post">
		<form:hidden path="id" />
			<div class="grid_5 form_label align_right">
				<label for="password">Password</label>
			</div>
			<div class="grid_5 form_input_large form_input_stretch align_right">
				<form:password path="password" maxlength="32" />
			</div>
			<div class="grid_6">
				<spring:hasBindErrors name="user"><form:errors path="password" cssStyle="color:red" /></spring:hasBindErrors>
			</div>
	
			<div class="clear"></div>
			<div class="grid_5 form_label_br align_right">
				<label for="reenter_password">Re-enter<br/>Password</label>
			</div>
			<div class="grid_5 form_input_large form_input_stretch align_right">
				<input type="password" id="reenter_password" name="reenter_password" maxlength="32" />
			</div>
			<div class="grid_6"></div>

			<div class="clear"></div>
			<div class="grid_10 form_button align_right">
				<input type="submit" name="updatePassword" value="update"/>
			</div>
			<div class="grid_6">&nbsp;</div>
		</form:form>
<script type="text/javascript">
<!--
$(function(){
	// for use validator, user class must be divided to some classes because of some form's ids are same now.
	// validate signup form on keyup and submit
	$("#user").validate({
		rules: {
			password: {
				required: true,
				minlength: 8
			},
			reenter_password: {
				required: true,
				minlength: 8,
				equalTo: "#password"
			}
		},
		messages: {
			password: {
				required: "Please provide a password",
				minlength: "must be at least 8 characters long"
			},
			reenter_password: {
				required: "Please provide a password",
				minlength: "must be at least 8 characters long",
				equalTo: "Please enter the same password as above"
			}
		},
		errorPlacement: function(error, element) {
			error.appendTo( element.parent("div").next("div") );
		}
	});
});
// -->
</script>