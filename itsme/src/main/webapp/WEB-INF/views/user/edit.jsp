<%@ page language="java" session="true" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<html>
<head>
	<title>Edit</title>
	<%@ include file="../_head_base.jsp"%>
	<%@ include file="../_head_grid.jsp"%>
	<script type="text/javascript">
<!--
$(function(){
	$('#edit_account').click(function(){
		$('#form_password').hide();
		$('#form_profile').hide();
		$('#form_social').hide();
		$('#form_account').show();
		$('#edit_account').removeClass('tab_button').addClass('tab_button_disabled');
		$('#edit_password').removeClass('tab_button_disabled').addClass('tab_button');
		$('#edit_profile').removeClass('tab_button_disabled').addClass('tab_button');
		$('#edit_social').removeClass('tab_button_disabled').addClass('tab_button');
	});
	$('#edit_password').click(function(){
		$('#form_account').hide();
		$('#form_profile').hide();
		$('#form_social').hide();
		$('#form_password').show();
		$('#edit_account').removeClass('tab_button_disabled').addClass('tab_button');
		$('#edit_password').removeClass('tab_button').addClass('tab_button_disabled');
		$('#edit_profile').removeClass('tab_button_disabled').addClass('tab_button');
		$('#edit_social').removeClass('tab_button_disabled').addClass('tab_button');
	});
	$('#edit_profile').click(function(){
		$('#form_account').hide();
		$('#form_password').hide();
		$('#form_social').hide();
		$('#form_profile').show();
		$('#edit_account').removeClass('tab_button_disabled').addClass('tab_button');
		$('#edit_password').removeClass('tab_button_disabled').addClass('tab_button');
		$('#edit_profile').removeClass('tab_button').addClass('tab_button_disabled');
		$('#edit_social').removeClass('tab_button_disabled').addClass('tab_button');
	});
	$('#edit_social').click(function(){
		$('#form_account').hide();
		$('#form_password').hide();
		$('#form_profile').hide();
		$('#form_social').show();
		$('#edit_account').removeClass('tab_button_disabled').addClass('tab_button');
		$('#edit_password').removeClass('tab_button_disabled').addClass('tab_button');
		$('#edit_profile').removeClass('tab_button_disabled').addClass('tab_button');
		$('#edit_social').removeClass('tab_button').addClass('tab_button_disabled');
	});
});
// -->
	</script>
</head>
<body>
<%@ include file="../_body_header.jsp"%>

<div id="content">
	<div class="container_16">
		<div class="grid_16">
			<div id="title" style="text-align:center;">Settings</div>
		</div>

		<div class="clear"></div>
		<div class="grid_16 align_center">
			<c:if test="${resultCreated}"><span class="confirm"><spring:message code="result.created" /></span></c:if>
			<c:if test="${resultUpdated}"><span class="confirm"><spring:message code="result.updated" /></span></c:if>
		</div>
		<div class="clear"></div>
		<div class="grid_16">&nbsp;</div>

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
		<div class="grid_4">&nbsp;</div>
		<div class="clear"></div>
		<div class="grid_16">&nbsp;</div>

		<div class="clear"></div>
		<div id="form_account">
			<form:form modelAttribute="user" action="updateAccount" method="post">
			<form:hidden path="id" />
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
			<div class="grid_10 user_form_button align_right">
				<input type="submit" value="update"/>
			</div>
			<div class="grid_6">&nbsp;</div>
			</form:form>
		</div>

		<div class="clear"></div>
		<div id="form_password" style="display:none;">
			<form:form modelAttribute="user" action="updatePassword" method="post">
			<form:hidden path="id" />
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
				<input type="submit" value="update"/>
			</div>
			<div class="grid_6">&nbsp;</div>
			</form:form>
		</div>
		
		<div class="clear"></div>
		<div id="form_profile" style="display:none;">
			<form:form modelAttribute="user" action="updateProfile" method="post">
			<form:hidden path="id" />
			<div class="grid_5 align_right">
				<label for="password">Profile</label>
			</div>
			<div class="grid_5 align_right">
				<form:textarea path="profile" rows="5" cols="30" />
			</div>
			<div class="grid_6">
				<spring:hasBindErrors name="user"><form:errors path="profile" cssStyle="color:red" /></spring:hasBindErrors>
			</div>

			<div class="clear"></div>
			<div class="grid_10 user_form_button align_right">
				<input type="submit" value="update"/>
			</div>
			<div class="grid_6">&nbsp;</div>
			</form:form>
		</div>

		<div class="clear"></div>
		<div id="form_social" style="display:none;">
			<div class="grid_5">&nbsp;</div>
			<div class="grid_11">
				Facebook
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
				Twitter
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
</body>
</html>
