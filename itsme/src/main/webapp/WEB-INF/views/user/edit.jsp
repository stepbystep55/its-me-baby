<%@ page language="java" session="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<html>
<head>
	<title>Edit</title>
	<%@ include file="../_head_base.jsp"%>
	<%@ include file="../_head_grid.jsp"%>
	<script type="text/javascript"  charset="utf-8" src="<%= request.getContextPath() %>/resources/js/jquery.validate.min.js"></script>	
	<style type="text/css">
<!--
.error { color: red; }
// -->
	</style>
	<link rel="stylesheet" type="text/css"  media="screen" href="<%= request.getContextPath() %>/resources/css/jquery.minicolors.css" />
</head>
<body>
<jsp:include page="../_body_header.jsp"/>

<div id="page_content">
	<div class="container_16">
		<div class="grid_16">
			<div id="page_title" style="text-align:center;">Settings</div>
		</div>

		<div class="clear"></div>
		<div class="grid_16 align_center">
			<c:if test="${created}"><span class="confirm"><spring:message code="result.created" /></span></c:if>
			<c:if test="${updated != null}"><span class="confirm"><spring:message code="result.updated" /></span></c:if>
		</div>
		<div class="clear"></div>
		<div class="grid_16">&nbsp;</div>

		<div class="clear"></div>
		<div class="grid_4">&nbsp;</div>
		<div class="grid_2">
			<p id="edit_profile" class="tab_button">Profile</p>
		</div>
		<div class="grid_2">
			<p id="edit_social" class="tab_button">Social</p>
		</div>
		<div class="grid_2">
			<p id="edit_account" class="tab_button_disabled">Account</p>
		</div>
		<div class="grid_2">
			<p id="edit_password" class="tab_button">Password</p>
		</div>
		<div class="grid_4">&nbsp;</div>
		<div class="clear"></div>
		<div class="grid_16">&nbsp;</div>

		<div class="clear"></div>
		<div id="form_profile" style="display:none;">
			<form:form modelAttribute="user" action="updateProfile" method="post">
			<form:hidden path="id" />
			<div class="grid_5 form_label align_right">
				<label for="name">Name</label>
			</div>
			<div class="grid_5 form_input_stretch">
				<form:input path="name" maxlength="32" />&nbsp;
			</div>
			<div class="grid_6">
				<spring:hasBindErrors name="user"><form:errors path="name" cssStyle="color:red" /></spring:hasBindErrors>
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
			<div class="grid_6">
				<spring:hasBindErrors name="user"><form:errors path="title" cssStyle="color:red" /></spring:hasBindErrors>
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
			<div class="grid_6">
				<spring:hasBindErrors name="user"><form:errors path="content" cssStyle="color:red" /></spring:hasBindErrors>
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
				<span class="form_sublabel">Opacity</span>&nbsp;<form:input path="profileBoxOpacity" size="3" maxlength="3" />
				<span class="form_sublabel">Position</span>&nbsp;
				<form:select path="profileBoxPosition">
					<form:option value="left"/>
					<form:option value="right"/>
				</form:select>
			</div>

			<div class="clear"></div>
			<div class="grid_16">&nbsp;</div>
			<div class="clear"></div>
			<div class="grid_5 form_label align_right">
				<label>Background</label>
			</div>
			<div class="grid_5  form_input_stretch">
				<form:input path="bgImgUrl" maxlength="512" />&nbsp;
			</div>
			<div class="grid_6">
				<spring:hasBindErrors name="user"><form:errors path="bgImgUrl" cssStyle="color:red" /></spring:hasBindErrors>
			</div>
			<div class="clear"></div>
			<div class="grid_5">&nbsp;</div>
			<div class="grid_11">
				<form:select path="bgImgLayout">
					<form:option value="center"/>
					<form:option value="tile"/>
					<form:option value="stretch"/>
				</form:select>
			</div>
			<div class="clear"></div>
			<div class="grid_16">&nbsp;</div>

			<div class="clear"></div>
			<div class="grid_8 form_button align_right">
				<input type="button" value="preview"/>
			</div>
			<div class="grid_2 form_button align_right">
				<input type="submit" value="update"/>
			</div>
			<div class="grid_6">&nbsp;</div>
			</form:form>
		</div>

		<div class="clear"></div>
		<div id="form_social" style="display:none;">
			<div class="grid_7 form_label align_right">Facebook</div>
			<div class="grid_3 form_button">
				<c:choose>
				<c:when test="${facebookConnected}">
				<form action="disconnect" method="POST">
					<input type="submit" value="disconnect" />
					<input type="hidden" name="provider" value="facebook" />
				</form>
				</c:when>
				<c:otherwise>
				<form action="<c:url value="/signin/facebook" />" method="POST">
					<input type="submit" value="connect" />
				<input type="hidden" name="scope" value="email,read_stream,offline_access" />
				</form>
				</c:otherwise>
				</c:choose>
			</div>
			<div class="grid_6">&nbsp;</div>

			<div class="clear"></div>
			<div class="grid_7 form_label align_right">Twitter</div>
			<div class="grid_3 form_button">
				<c:choose>
				<c:when test="${twitterConnected}">
				<form action="disconnect" method="POST">
					<input type="submit" value="disconnect" />
					<input type="hidden" name="provider" value="twitter" />
				</form>
				</c:when>
				<c:otherwise>
				<form action="<c:url value="/signin/twitter" />" method="POST">
					<input type="submit" value="connect" />
				</form>
				</c:otherwise>
				</c:choose>
			</div>
			<div class="grid_6">&nbsp;</div>
		</div>

		<div class="clear"></div>
		<div id="form_account">
			<form:form modelAttribute="user" action="updateAccount" method="post">
			<form:hidden path="id" />
			<div class="clear"></div>
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
				<input type="submit" value="update"/>
			</div>
			<div class="grid_6">&nbsp;</div>
			</form:form>
			
			<div class="clear"></div>
			<div class="grid_16">&nbsp;</div>
			<div class="clear"></div>
			<div class="grid_16">&nbsp;</div>

			<div class="clear"></div>
			<div class="grid_16">&nbsp;</div>
			<div class="clear"></div>
			<div class="grid_16">&nbsp;</div>
			<form:form modelAttribute="user" action="delete" method="post">
			<form:hidden path="id" />
			<div class="clear"></div>
			<div class="grid_10 form_button align_right">
				<input type="submit" value="delete account"/>
			</div>
			<div class="grid_6">&nbsp;</div>
			</form:form>
		</div>

		<div class="clear"></div>
		<div id="form_password" style="display:none;">
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
				<input type="submit" value="update"/>
			</div>
			<div class="grid_6">&nbsp;</div>
			</form:form>
		</div>
		
	</div>

	<div class="container_16">
		<div class="grid_16">&nbsp;</div>
	</div>
	<div class="container_16">
		<div class="grid_16">&nbsp;</div>
	</div>
</div>

<div id="footer">
	<div class="container_12">
		<div class="grid_12">
			<div class="footer_item">
			&copy;ippoippo
			</div>
		</div>
	</div>
</div>

<script type="text/javascript"  charset="utf-8" src="<%= request.getContextPath() %>/resources/js/jquery.minicolors.min.js"></script>	<script type="text/javascript">
<!--
$(function(){
	// for use validator, user class must be divided to some classes because of some form's ids are same now.
	// validate signup form on keyup and submit
	/*
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
	*/
	// 
	if($('.confirm')!=null) $('.confirm').fadeOut(3000);
	// choose tab
	<c:choose>
		<c:when test="${updated == 'account'}">activateAccountTab();</c:when>
		<c:when test="${updated == 'social'}">activateSocialTab();</c:when>
		<c:when test="${updated == 'password'}">activatePasswordTab();</c:when>
		<c:otherwise>activateProfileTab();</c:otherwise>
	</c:choose>
	$('#edit_profile').click(activateProfileTab);
	$('#edit_social').click(activateSocialTab);
	$('#edit_account').click(activateAccountTab);
	$('#edit_password').click(activatePasswordTab);
	// minicolor
	$('.minicolors').miniColors();
});
function activateProfileTab(){
	$('div[id^="form_"]').hide();
	$('#form_profile').show();
	$('p[id^="edit_"]').removeClass('tab_button_disabled').addClass('tab_button');
	$('#edit_profile').removeClass('tab_button').addClass('tab_button_disabled');
}
function activateSocialTab(){
	$('div[id^="form_"]').hide();
	$('#form_social').show();
	$('p[id^="edit_"]').removeClass('tab_button_disabled').addClass('tab_button');
	$('#edit_social').removeClass('tab_button').addClass('tab_button_disabled');
}
function activateAccountTab(){
	$('div[id^="form_"]').hide();
	$('#form_account').show();
	$('p[id^="edit_"]').removeClass('tab_button_disabled').addClass('tab_button');
	$('#edit_account').removeClass('tab_button').addClass('tab_button_disabled');
}
function activatePasswordTab(){
	$('div[id^="form_"]').hide();
	$('#form_password').show();
	$('p[id^="edit_"]').removeClass('tab_button_disabled').addClass('tab_button');
	$('#edit_password').removeClass('tab_button').addClass('tab_button_disabled');
}
// -->
</script>
</body>
</html>
