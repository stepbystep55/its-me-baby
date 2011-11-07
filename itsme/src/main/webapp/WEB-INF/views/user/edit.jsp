<%@ page language="java" session="true" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<html>
<head>
	<%@ include file="../_head.jsp"%>
	<title>Edit</title>
</head>
<body>
<%@ include file="../_body_header.jsp"%>
<c:if test="${resultCreated}"><spring:message code="result.created" /></c:if>
<c:if test="${resultUpdated}"><spring:message code="result.updated" /></c:if>

<div id="content">
<form:form modelAttribute="user" action="update" method="post">
<form:hidden path="id" />
	<div class="container_12">
		<div class="grid_11">
			<div id="title" style="text-align:center;">Your Information</div>
		</div>
		<div class="grid_1">&nbsp;</div>

		<div class="clear"></div>
		<div class="grid_3">&nbsp;</div>
		<div class="grid_1">
			<label for="name">Name</label>
		</div>
		<div class="grid_3">
			<form:input path="name" size="16" maxlength="32" />
		</div>
		<div class="grid_5">
			<spring:hasBindErrors name="user"><form:errors path="name" cssStyle="color:red" /></spring:hasBindErrors>
		</div>

		<div class="clear"></div>
		<div class="grid_3">&nbsp;</div>
		<div class="grid_1">
			<label for="emal">Email</label>
		</div>
		<div class="grid_3">
			<form:input path="email" size="16" maxlength="64"/>
		</div>
		<div class="grid_5">
			<spring:hasBindErrors name="user"><form:errors path="email" cssStyle="color:red" /></spring:hasBindErrors>
		</div>

		<div class="clear"></div>
		<div class="grid_3">&nbsp;</div>
		<div class="grid_1">
			<label for="password">Password</label>
		</div>
		<div class="grid_3">
			<form:password path="password" size="16" maxlength="32" />
		</div>
		<div class="grid_5">
			<spring:hasBindErrors name="user"><form:errors path="password" cssStyle="color:red" /></spring:hasBindErrors>
		</div>
		
		<div class="clear"></div>
		<div class="grid_3">&nbsp;</div>
		<div class="grid_1">
			<label for="password">Profile</label>
		</div>
		<div class="grid_3">
			<form:textarea path="profile" rows="5" cols="30" />
		</div>
		<div class="grid_5">
			<spring:hasBindErrors name="user"><form:errors path="profile" cssStyle="color:red" /></spring:hasBindErrors>
		</div>
		
		<div class="clear"></div>
		<div class="grid_3">&nbsp;</div>
		<div class="grid_2">&nbsp;</div>
		<div class="grid_1 user_form_button" style="padding-left: 33px;">
			<input type="submit" value="Update"/>
		</div>
		<div class="grid_6">&nbsp;</div>
	</div>
</form:form>

	<div class="container_12">
			<div class="clear"></div>
		<div class="grid_3">&nbsp;</div>
		<div class="grid_2">&nbsp;</div>
		<div class="grid_1">
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
		<div class="grid_6">&nbsp;</div>
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
$(function(){
});
</script>
</body>
</html>
