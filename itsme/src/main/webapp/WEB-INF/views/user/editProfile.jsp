<%@ page language="java" session="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

		<form:form modelAttribute="userProfile" action="updateProfile" method="post">
		<form:hidden path="userId" />
			<div class="grid_5 form_label align_right">
				<label for="name">Name</label>
			</div>
			<div class="grid_5 form_input_stretch">
				<form:input path="name" maxlength="32" />&nbsp;
			</div>
			<div id="errmsg_name" class="grid_6">
				<spring:hasBindErrors name="userProfile"><form:errors path="name" cssStyle="color:red" /></spring:hasBindErrors>
			</div>
			<div class="clear"></div>
			<div class="grid_5">&nbsp;</div>
			<div class="grid_11">
				<span class="form_sublabel">Color</span>&nbsp;<form:input path="nameFontColor" readonly="true" cssClass="minicolors" size="8" maxlength="6" />&nbsp;
				<span class="form_sublabel">Font size</span>&nbsp;<form:input path="nameFontSize" size="3" maxlength="3" />
			</div>

			<div class="clear"></div>
			<div class="grid_16">&nbsp;</div>
			<div class="clear"></div>
			<div class="grid_5 form_label align_right">
				<label for="title">Title</label>
			</div>
			<div class="grid_5  form_input_stretch">
				<form:input path="title" maxlength="128" />&nbsp;
			</div>
			<div id="errmsg_title" class="grid_6">
				<spring:hasBindErrors name="userProfile"><form:errors path="title" cssStyle="color:red" /></spring:hasBindErrors>
			</div>
			<div class="clear"></div>
			<div class="grid_5">&nbsp;</div>
			<div class="grid_11">
				<span class="form_sublabel">Color</span>&nbsp;<form:input path="titleFontColor" readonly="true" cssClass="minicolors" size="8" maxlength="6" />&nbsp;
				<span class="form_sublabel">Font size</span>&nbsp;<form:input path="titleFontSize" size="3" maxlength="3" />
			</div>

			<div class="clear"></div>
			<div class="grid_16">&nbsp;</div>
			<div class="clear"></div>
			<div class="grid_5 form_label align_right">
				<label for="content">Content</label>
			</div>
			<div class="grid_5 form_input_stretch">
				<form:textarea path="content" rows="5" />&nbsp;
			</div>
			<div id="errmsg_content" class="grid_6">
				<spring:hasBindErrors name="userProfile"><form:errors path="content" cssStyle="color:red" /></spring:hasBindErrors>
			</div>
			<div class="clear"></div>
			<div class="grid_5">&nbsp;</div>
			<div class="grid_11">
				<span class="form_sublabel">Color</span>&nbsp;<form:input path="contentFontColor" readonly="true" cssClass="minicolors" size="8" maxlength="6" />&nbsp;
				<span class="form_sublabel">Font size</span>&nbsp;<form:input path="contentFontSize" size="3" maxlength="3" />
			</div>

			<div class="clear"></div>
			<div class="grid_16">&nbsp;</div>
			<div class="clear"></div>
			<div class="grid_5 form_label align_right">
				<label>Profile Box</label>
			</div>
			<div class="grid_11">
				<span class="form_sublabel">Color</span>&nbsp;<form:input path="profileBoxColor" readonly="true" cssClass="minicolors" size="8" maxlength="6" />&nbsp;
				<span class="form_sublabel">Transparent</span>&nbsp;<form:checkbox path="profileBoxTransparent" />
			</div>
			<div class="clear"></div>
			<div class="grid_5">&nbsp;</div>
			<div class="grid_11">
				<span class="form_sublabel">Position</span>&nbsp;
				<form:select path="profileBoxPosition">
					<form:option value="top-left"/>
					<form:option value="top-right"/>
					<form:option value="top-center"/>
					<form:option value="middle-left"/>
					<form:option value="middle-right"/>
					<form:option value="middle-center"/>
					<form:option value="bottom-left"/>
					<form:option value="bottom-right"/>
					<form:option value="bottom-center"/>
				</form:select>
			</div>

			<div class="clear"></div>
			<div class="grid_16">&nbsp;</div>
			<div class="clear"></div>
			<div class="grid_5 form_label align_right">
				<label>Background URL</label>
			</div>
			<div class="grid_5  form_input_stretch">
				<form:input path="bgImgUrl" maxlength="512" />&nbsp;
			</div>
			<div id="errmsg_bgurl" class="grid_6">
				<spring:hasBindErrors name="userProfile"><form:errors path="bgImgUrl" cssStyle="color:red" /></spring:hasBindErrors>
			</div>
			<div class="clear"></div>
			<div class="grid_5">&nbsp;</div>
			<div class="grid_11">
				<span class="form_sublabel">Layout</span>&nbsp;
				<form:select path="bgImgLayout">
					<form:option value="center"/>
					<form:option value="tile"/>
					<form:option value="stretch"/>
				</form:select>
			</div>
			<div class="clear"></div>
			<div class="grid_16">&nbsp;</div>

			<div class="clear"></div>
			<div class="grid_10 form_button align_right">
				<input type="submit" name="updateProfile" value="update"/>
			</div>
			<div class="grid_6">&nbsp;</div>
		</form:form>
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
			nameFontSize: {
				required: true,
				number: true
			},
			title: {
				minlength: 128
			},
			titleFontSize: {
				required: true,
				number: true
			},
			content: {
				maxlength: 2048
			},
			contentFontSize: {
				required: true,
				number: true
			},
			bgImgUrl: {
				url:true 
			}
		},
		messages: {
			name: {
				required: "Please provide a name",
				minlength: "must be at least 3 characters long"
			},
			nameFontSize: {
				required: "Please provide the font size",
				number: "The font size must be number"
			},
			title: {
				minlength: "must be at most 128 characters long"
			},
			titleFontSize: {
				required: "Please provide the font size",
				number: "The font size must be number"
			},
			content: {
				maxlength: "must be at most 2048 characters long"
			},
			contentFontSize: {
				required: "Please provide the font size",
				number: "The font size must be number"
			},
			bgImgUrl: {
				url: "Please enter a valid url"
			}
		},
		errorPlacement: function(error, element) {
			switch (element.attr('id')) {
			case 'name':
				error.appendTo($('#errmsg_name'));
				break;
			case 'nameFontSize':
				error.appendTo($('#errmsg_name'));
				break;
			case 'title':
				error.appendTo($('#errmsg_title'));
				break;
			case 'titleFontSize':
				error.appendTo($('#errmsg_title'));
				break;
			case 'content':
				error.appendTo($('#errmsg_content'));
				break;
			case 'contentFontSize':
				error.appendTo($('#errmsg_content'));
				break;
			case 'bgImgUrl':
				error.appendTo($('#errmsg_bgurl'));
				break;
			default:
				break;
			}
			//error.appendTo( element.parent("div").next("div") );
		}
	});
	$('.minicolors').miniColors();
});
// -->
</script>