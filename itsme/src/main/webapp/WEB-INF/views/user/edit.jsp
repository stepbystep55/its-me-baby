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
#feed_message { width: 100%; position: absolute; margin: 15px auto; text-align: center; z-index: 99; }
// -->
	</style>
	<link rel="stylesheet" type="text/css"  media="screen" href="<%= request.getContextPath() %>/resources/css/jquery.minicolors.css" />
</head>
<body>
<jsp:include page="../_body_header.jsp"/>

<div id="feed_message">
	<c:if test="${created}"><span class="confirm"><spring:message code="result.created" /></span></c:if>
	<c:if test="${updated}"><span class="confirm"><spring:message code="result.updated" /></span></c:if>
</div>

<div id="page_content">
	<div class="container_16">
		<div class="grid_16">
			<div id="page_title" class="align_center">Settings</div>
		</div>

		<div class="clear"></div>
		<div class="grid_4">&nbsp;</div>
		<div class="grid_2">
			<p id="edit_account" class="tab_button_disabled">Account</p>
		</div>
		<div class="grid_2">
			<p id="edit_password" class="tab_button">Password</p>
		</div>
		<div class="grid_2">
			<p id="edit_profile" class="tab_button">Profile</p>
		</div>
		<div class="grid_2">
			<p id="edit_social" class="tab_button">Social</p>
		</div>
		<div class="grid_6">&nbsp;</div>
		<div class="clear"></div>
		<div class="grid_16">&nbsp;</div>

		<div class="clear"></div>
		<div id="form_area">
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

<script type="text/javascript"  charset="utf-8" src="<%= request.getContextPath() %>/resources/js/jquery.minicolors.min.js"></script>
<script type="text/javascript">
<!--
$(function(){
	if($('#feed_message')!=null) $('#feed_message').fadeOut(3000);
	// choose tab
	<c:choose>
		<c:when test="${activeTab == 'password'}">activateTab('password');</c:when>
		<c:when test="${activeTab == 'profile'}">activateTab('profile');</c:when>
		<c:when test="${activeTab == 'social'}">activateTab('social');</c:when>
		<c:otherwise>activateTab('account');</c:otherwise>
	</c:choose>
	$('#edit_account').click(activateTab('account'));
	$('#edit_password').click(activateTab('password'));
	$('#edit_profile').click(activateTab('profile'));
	$('#edit_social').click(activateTab('social'));
});
function activateTab(target){
	var btnId = 'account';
	var url = 'updateAccount';
	if (target == 'password') { btnId = 'password'; url = 'updatePassword'; }
	else if (target == 'profile') { btnId = 'profile'; url = 'updateProfile'; }
	else if (target == 'social') { btnId = 'social'; url = 'updateSocial'; }
	else { btnId = 'account'; url = 'updateAccount'; }
	$.ajax({
		type: "GET",
		url: url,
		cache: false,
		success: function(formHtml){
			$("#form_area").html(formHtml);
		}
	});
	$('p[id^="edit_"]').removeClass('tab_button_disabled').addClass('tab_button');
	$('#edit_'+btnId).removeClass('tab_button').addClass('tab_button_disabled');
}
// -->
</script>
</body>
</html>
