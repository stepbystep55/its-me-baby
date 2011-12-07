<%@ page language="java" session="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
	<title>Show</title>
	<%@ include file="../_head_base.jsp"%>
	<%@ include file="../_head_grid.jsp"%>
	<link rel="stylesheet" type="text/css"  media="screen" href="<%= request.getContextPath() %>/resources/css/colorbox.css">
	<script type="text/javascript"  charset="utf-8" src="<%= request.getContextPath() %>/resources/js/jquery.colorbox-min.js"></script>
	<link rel="stylesheet" type="text/css"  media="screen" href="<%= request.getContextPath() %>/resources/css/jsticky.css">
	<script type="text/javascript"  charset="utf-8" src="<%= request.getContextPath() %>/resources/js/jquery-ui.custom.min.js"></script>
	<script type="text/javascript"  charset="utf-8" src="<%= request.getContextPath() %>/resources/js/jquery.stickynote.js"></script>
	<style type="text/css">
<!--
<c:if test="${userProfile.bgImgUrl != null and userProfile.bgImgUrl != ''}">
<c:choose>
	<c:when test="${userProfile.bgImgLayout == 'center'}">
		body { background: url(${userProfile.bgImgUrl}) no-repeat fixed 50% 50%; }
	</c:when>
	<c:when test="${userProfile.bgImgLayout == 'tile'}">
		body { background: url(${userProfile.bgImgUrl}) repeat fixed 50% 50%; }
	</c:when>
	<c:when test="${userProfile.bgImgLayout == 'stretch'}">
		#background { width: 100%; height: 100%; position: absolute; left: 0px; top: 0px; z-index: -1; }
		.stretch {width:100%;height:auto;min-height:100%;}
	</c:when>
</c:choose>
</c:if>
// -->
	</style>
</head>
<body>
<c:if test="${userProfile.bgImgUrl != null and userProfile.bgImgUrl != ''}">
	<c:if test="${userProfile.bgImgLayout == 'stretch'}">
		<div id="background"><img src="${userProfile.bgImgUrl}" class="stretch" alt="" /></div>
	</c:if>
</c:if>
<jsp:include page="../_body_header.jsp"/>

<div id="content" class="content"></div> 
<div class="container_12">
	<div class="grid_8">&nbsp;</div>
	<div class="grid_2">
		<a id="sticky" href="#">sticky</a>
	</div>
	<div class="grid_2">
		<a id="stream" href="<%= request.getContextPath() %>/stream/${userProfile.userId}">view stream</a>
	</div>
</div>

<script type="text/javascript">
<!--
$(function(){
	//$('#stream').colorbox({width:"80%", height:"50%"});
	$('#stream').colorbox({iframe:true, width:"80%", height:"80%"});
	/*
	$("#sticky").stickynote();
	*/
	$("#sticky").stickynote({
		size: large,
		color: '#FF0000'
	});
});
// -->
</script>
</body>
</html>
