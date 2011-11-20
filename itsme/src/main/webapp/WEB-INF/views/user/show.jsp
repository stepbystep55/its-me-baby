<%@ page language="java" session="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<html>
<head>
	<title>Show</title>
	<%@ include file="../_head_base.jsp"%>
	<%@ include file="../_head_grid.jsp"%>
	<link rel="stylesheet" type="text/css"  media="screen" href="<%= request.getContextPath() %>/resources/css/colorbox.css">
	<script type="text/javascript"  charset="utf-8" src="<%= request.getContextPath() %>/resources/js/jquery.colorbox-min.js"></script>
</head>
<body>
<jsp:include page="../_body_header.jsp"/>

<div id="page_content">
	<div class="container_12">
		<div class="grid_1">&nbsp;</div>
		<div class="grid_11">
			<div id="page_title">${user.name}</div>
		</div>

		<div class="clear"></div>
		<div class="grid_1">&nbsp;</div>
		<div class="grid_6">
			<div id="content">${user.content}</div>
		</div>
		<div class="grid_5">&nbsp;</div>

	</div>
</div>

<a id="stream" href="<%= request.getContextPath() %>/stream/${user.id}">view stream</a>
<script type="text/javascript">
<!--
$(function(){
	//$('#stream').colorbox({width:"80%", height:"50%"});
	$('#stream').colorbox({iframe:true, width:"80%", height:"80%"});
});
// -->
</script>
</body>
</html>
