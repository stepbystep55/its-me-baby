<%@ page language="java" session="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

	<style type="text/css">
<!--
#prop_box {
}
#prop_menu {
}
.prop_menu_item {
	float: left;
	width: 60px;
}
#prop_form {
}
.prop_row {
	border-bottom: 1px solid #999999;
}
.prop_label {
	float: left;
	font-weight: bold;
}
.prop_sublabel {
	float: left;
}
.prop_txtval {
	float: left;
	width: 160px;
}
.prop_val {
	float: left;
}
// -->
	</style>
	<div id="prop_box">
		<div id="prop_form">
			<form:form modelAttribute="userProfile" action="updateProfile" method="post">
			<form:hidden path="userId" />
			<div class="prop_row">
				<div class="prop_label"><label for="name">Name</label></div>
				<div class="prop_txtval form_input_stretch">
					<form:input path="name" maxlength="32" />
				</div>
				<div class="prop_sublabel">Color</div>
				<div class="prop_val">
					<form:input path="nameFontColor" readonly="true" cssClass="minicolors" size="8" maxlength="6" />
				</div>
				<div class="prop_sublabel">Font size</div>
				<div class="prop_val">
					<form:input path="nameFontSize" size="3" maxlength="3" />
				</div>
			</div>

			<div class="prop_row">
				<div class="prop_label"><label for="title">Title</label></div>
				<div class="prop_txtval form_input_stretch">
					<form:input path="title" maxlength="128" />
				</div>
				<div class="prop_sublabel">Color</div>
				<div class="prop_val">
					<form:input path="titleFontColor" readonly="true" cssClass="minicolors" size="8" maxlength="6" />&nbsp;
				</div>
				<div class="prop_sublabel">Font size</div>
				<div class="prop_val">
					<form:input path="titleFontSize" size="3" maxlength="3" />
				</div>
			</div>

			<div class="prop_row">
				<div class="prop_label"><label for="content">Content</label></div>
				<div class="prop_txtval form_input_stretch">
					<form:textarea path="content" rows="5" />
				</div>
				<div class="prop_sublabel">Color</div>
				<div class="prop_val">
					<form:input path="contentFontColor" readonly="true" cssClass="minicolors" size="8" maxlength="6" />
				</div>
				<div class="prop_sublabel">Font size</div>
				<div class="prop_val">
					<form:input path="contentFontSize" size="3" maxlength="3" />
				</div>
			</div>

			<div class="">
				<input type="submit" name="updateProfile" value="update"/>
			</div>
		</form:form>
		</div>
	</div>
<script type="text/javascript">
<!--
$(function(){
	// validate signup form on keyup and submit
	$("#userProfile").validate({
		rules: {
			name: {
				required: true,
				minlength: 3
			},
			content: {
				maxlength: 2048
			}
		},
		messages: {
			name: {
				required: "Please provide a name",
				minlength: "must be at least 3 characters long"
			},
			content: {
				maxlength: "must be at most 2048 characters long"
			},
		},
		errorPlacement: function(error, element) {
			error.appendTo( element.parent("div").next("div") );
		}
	});
	$('.minicolors').miniColors();
});
// -->
</script>