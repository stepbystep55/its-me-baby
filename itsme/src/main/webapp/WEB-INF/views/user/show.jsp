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
	<style type="text/css">
<!--
<c:choose>
	<c:when test="${user.bgImgLayout == 'center'}">
		body { background: url(${user.bgImgUrl}) no-repeat fixed 50% 50%; }
	</c:when>
	<c:when test="${user.bgImgLayout == 'tile'}">
		body { background: url(${user.bgImgUrl}) no-repeat fixed 50% 50%; }
	</c:when>
	<c:when test="${user.bgImgLayout == 'stretch'}">
		#background {
			width: 100%; 
			height: 100%; 
			position: absolute;
			left: 0px; 
			top: 0px; 
			z-index: -1;
		}
		.stretch {width:100%;height:auto;min-height:100%;}
	</c:when>
</c:choose>
// -->
	</style>
</head>
<body>
<c:if test="user.bgImgUrl != null && user.bgImgUrl != ''">
	<c:if test="${user.bgImgLayout == 'stretch'}">
		<div id="background"><img src="${user.bgImgUrl}" class="center" alt="" /></div>
	</c:if>
</c:if>
<jsp:include page="../_body_header.jsp"/>

<div id="user_profile"
	style="
	z-index:999;
	<c:choose>
		<c:when test="${user.profileBoxPosition == 'left'}">position:absolute;top:30%;left:20%;</c:when>
		<c:when test="${user.profileBoxPosition == 'right'}">position:absolute;top:30%;right:20%;</c:when>
	</c:choose>
	background-color:${user.profileBoxColor} no-repeat fixed 0 0;"
>
	<div id="user_name" style="font-size:${user.nameFontSize}; color:${user.nameFontColor}">
		${user.name}
	</div>
	<div id="user_title" style="font-size:${user.titleFontSize}; color:${user.titleFontColor}">
		${user.title}
	</div>
	&nbsp;
	<div id="user_content" style="font-size:${user.contentFontSize}; color:${user.contentFontColor}">
		${user.content}
	</div>
	&nbsp;
	<div id="user_stream" class="align_right">
		<a id="stream" href="<%= request.getContextPath() %>/stream/${user.id}">view stream</a>
	</div>
</div>

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
