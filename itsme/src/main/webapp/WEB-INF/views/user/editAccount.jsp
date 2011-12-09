<%@ page language="java" session="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

		<form:form modelAttribute="user" action="updateAccount" method="post">
		<form:hidden path="id" />
			<div class="grid_5 form_label align_right">
				<label for="emal">Email</label>
			</div>
			<div class="grid_5 form_input_large form_input_stretch align_right">
				<form:input path="email" maxlength="128"/>
			</div>
			<div class="grid_6">
				<spring:hasBindErrors name="user"><form:errors path="email" cssStyle="color:red" /></spring:hasBindErrors>
			</div>

			<div class="clear"></div>
			<div class="grid_10 form_button align_right">
				<input type="submit" name="update" value="update"/>
			</div>
			<div class="grid_6">&nbsp;</div>
			
			<div class="clear"></div>
			<div class="grid_16">&nbsp;</div>
			<div class="clear"></div>
			<div class="grid_16">&nbsp;</div>

			<div class="clear"></div>
			<div class="grid_16">&nbsp;</div>
			<div class="clear"></div>
			<div class="grid_16">&nbsp;</div>
			<div class="clear"></div>
			<div class="grid_10 form_button align_right">
				<input type="submit" name="delete" value="delete account"/>
			</div>
			<div class="grid_6">&nbsp;</div>
		</form:form>
<script type="text/javascript">
<!--
$(function(){
	// validate signup form on keyup and submit
	$("#user").validate({
		rules: {
			email: {
				required: true,
				email: true
			}
		},
		messages: {
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
