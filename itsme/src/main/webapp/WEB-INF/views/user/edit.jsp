<%@ page language="java" session="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
	<title>Edit</title>
	<%@ include file="../_head_base.jsp"%>
	<%@ include file="../_head_menu_bar.jsp"%>
	<%@ include file="../_head_grid.jsp"%>
	<script type="text/javascript"  charset="utf-8" src="<%= request.getContextPath() %>/resources/js/jquery.validate.min.js"></script>	
	<style type="text/css">
<!--
.error { color: red; }
#feed_message { width: 100%; position: absolute; margin: -26px auto; text-align: center; z-index: 99; }
// -->
	</style>
	<link rel="stylesheet" type="text/css"  media="screen" href="<%= request.getContextPath() %>/resources/css/jquery.minicolors.css" />
	<script type="text/javascript"  charset="utf-8" src="<%= request.getContextPath() %>/resources/js/jquery.minicolors.min.js"></script>
</head>
<body>
<jsp:include page="../_menu_bar.jsp"/>

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

<script type="text/javascript">
<!--
$(function(){
	if($('#feed_message')!=null) $('#feed_message').fadeOut(3000);
	$('#edit_account').click(activateTab);
	$('#edit_password').click(activateTab);
	$('#edit_profile').click(activateTab);
	$('#edit_social').click(activateTab);
	<c:choose>
		<c:when test="${activeTab == 'password'}">$('#edit_password').trigger('click');</c:when>
		<c:when test="${activeTab == 'profile'}">$('#edit_profile').trigger('click');</c:when>
		<c:when test="${activeTab == 'social'}">$('#edit_social').trigger('click');</c:when>
		<c:otherwise>$('#edit_account').trigger('click');</c:otherwise>
	</c:choose>
});
function activateTab(){
	var url = 'updateAccount';
	switch ($(this).attr('id')) {
	case 'edit_password':
		url = 'updatePassword';
		break;
	case 'edit_profile':
		url  = 'updateProfile';
		break;
	case 'edit_social':
		url = 'updateSocial';
		break;
	default:
		url = 'updateAccount';
		break;
	}
	$.ajax({
		type: "GET",
		url: url,
		cache: false,
		success: function(formHtml){
			$("#form_area").html(formHtml);
		}
	});
	$('p[class="tab_button_disabled"]').removeClass('tab_button_disabled').addClass('tab_button');
	$(this).removeClass('tab_button').addClass('tab_button_disabled');
	$('p[class="tab_button"]').each(function(){
		var bgColor = $(this).css('backgroundColor');
		$(this).hover(function(){
			$(this).css({ backgroundColor:'#E6E6FA' });
		},
		function(){
			$(this).css({ backgroundColor:bgColor });
		});
	});
	$('p[class="tab_button_disabled"]').each(function() {
		$(this).unbind('hover');
		$(this).css({ backgroundColor: ''});
	});
}
// -->
</script>
</body>
</html>
