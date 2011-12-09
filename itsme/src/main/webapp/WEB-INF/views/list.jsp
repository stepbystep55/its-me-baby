<%@ page language="java" session="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
	<title>People</title>
	<%@ include file="_head_base.jsp"%>
	<%@ include file="_head_grid.jsp"%>
	<style type="text/css">
<!--
.user_box {
	width: 250px;
	margin: 3px;
	padding: 5px 10px;
	border-bottom: 1px solid #999999;
}
// -->
	</style>
</head>
<body>

<jsp:include page="_body_header.jsp"/>

<div id="page_content">
	<div class="container_16">
		<div class="grid_16">&nbsp;</div>
	</div>
	<div class="container_16">
		<div class="grid_8">
			<c:forEach items="${userProfileList}" var="userProfile">
				<div class="user_box">
					<a href="<%= request.getContextPath() %>/show/${userProfile.userId}"><c:out value="${userProfile.name}" /></a>
				</div>
			</c:forEach>
		</div>
		<div class="grid_8 align_center">
			<div id="reg_btn"><a class="appeal" href="create">Register</a></div>
		</div>
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
});
// -->
</script>
</body>
</html>
