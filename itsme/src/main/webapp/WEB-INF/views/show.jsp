<%@ page language="java" session="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
	<title>Show</title>
	<%@ include file="_head_base.jsp"%>
	<%@ include file="_head_menu_bar.jsp"%>
	<%@ include file="_head_grid.jsp"%>
	<script type="text/javascript"  charset="utf-8" src="<%= request.getContextPath() %>/resources/js/jquery.corner.js"></script>
	<link rel="stylesheet" type="text/css"  media="screen" href="<%= request.getContextPath() %>/resources/css/colorbox.css">
	<script type="text/javascript"  charset="utf-8" src="<%= request.getContextPath() %>/resources/js/jquery.colorbox-min.js"></script>
	<style type="text/css">
<!--
/* background style */
<c:choose>
<c:when test="${userProfile.bgImgUrl != null and userProfile.bgImgUrl != ''}">
	<c:choose>
	<c:when test="${userProfile.bgImgLayout == 'center'}">
		body { background: url(${userProfile.bgImgUrl}) no-repeat fixed 50% 50%; }
	</c:when>
	<c:when test="${userProfile.bgImgLayout == 'tile'}">
		body { background: url(${userProfile.bgImgUrl}) repeat fixed 0 30px; }
	</c:when>
	<c:when test="${userProfile.bgImgLayout == 'stretch'}">
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
</c:when>
<c:otherwise>
	body { background: url(<%= request.getContextPath() %>/resources/img/sample/brick01.jpg) repeat fixed 0 30px; }
</c:otherwise>
</c:choose>
/* etc */
.func_element {
	background-color: #333333;
	text-align: center;
	height: 24px;
	line-height: 20px;
}
.func_element a:link, .func_element a:visited { color: #FFFFFF; }
.func_element a:hover, .func_element a:active { color: #F0F8FF; }
// -->
	</style>
</head>
<body>
<c:if test="${userProfile.bgImgUrl != null and userProfile.bgImgUrl != '' and userProfile.bgImgLayout == 'stretch'}">
	<div id="background"><img src="${userProfile.bgImgUrl}" class="stretch" alt="" /></div>
</c:if>
<jsp:include page="_menu_bar.jsp"/>

<div class="container_12">
	<div class="grid_12">&nbsp;</div>
</div>
<div class="container_12">
	<div class="grid_10">&nbsp;</div>
	<div class="grid_2 func_element">
		<a id="stream" href="<%= request.getContextPath() %>/stream/${userProfile.userId}">view stream</a>
	</div>
</div>

<div id="user_profile" style='
	z-index:999;
	padding: 20px 15px;
	<c:if test="${!userProfile.profileBoxTransparent}">background:${userProfile.profileBoxColor} no-repeat fixed 0 0;</c:if>
	'>
	<div id="user_name" style="font-size:${userProfile.nameFontSize}; color:${userProfile.nameFontColor}">
		<c:out value="${userProfile.name}" />
	</div>
	<div id="user_title" style="font-size:${userProfile.titleFontSize}; color:${userProfile.titleFontColor}">
		<c:out value="${userProfile.title}" />
	</div>
	&nbsp;
	<div id="user_content" style="font-size:${userProfile.contentFontSize}; color:${userProfile.contentFontColor}">
		<pre><c:out value="${userProfile.content}" /></pre>
	</div>
</div>

<div>
</div>
<script type="text/javascript">
<!--
$(function(){
	//$('#stream').colorbox({width:"80%", height:"50%"});
	$('#stream').colorbox({iframe:true, width:"82%", height:"80%"});

	//referece from http://stackoverflow.com/questions/210717/using-jquery-to-center-a-div-on-the-screen
	jQuery.fn.fixPos = function () {
		this.css("position","absolute");
		<c:choose>
		<c:when test="${userProfile.profileBoxPosition == 'top-right' or userProfile.profileBoxPosition == 'middle-right' or userProfile.profileBoxPosition == 'bottom-right'}">
			this.css("left", (($(window).width() - this.outerWidth())*3 / 4));
		</c:when>
		<c:when test="${userProfile.profileBoxPosition == 'top-left' or userProfile.profileBoxPosition == 'middle-left' or userProfile.profileBoxPosition == 'bottom-left'}">
			this.css("left", (($(window).width() - this.outerWidth()) / 4));
		</c:when>
		<c:when test="${userProfile.profileBoxPosition == 'top-center' or userProfile.profileBoxPosition == 'middle-center' or userProfile.profileBoxPosition == 'bottom-center'}">
			this.css("left", (($(window).width() - this.outerWidth()) / 2));
		</c:when>
		</c:choose>
		<c:choose>
		<c:when test="${userProfile.profileBoxPosition == 'top-right' or userProfile.profileBoxPosition == 'top-center' or userProfile.profileBoxPosition == 'top-left'}">
			this.css("top", (($(window).height() - this.outerHeight()) / 4));
		</c:when>
		<c:when test="${userProfile.profileBoxPosition == 'middle-right' or userProfile.profileBoxPosition == 'middle-center' or userProfile.profileBoxPosition == 'middle-left'}">
			this.css("top", (($(window).height() - this.outerHeight()) / 2));
		</c:when>
		<c:when test="${userProfile.profileBoxPosition == 'bottom-right' or userProfile.profileBoxPosition == 'bottom-center' or userProfile.profileBoxPosition == 'bottom-left'}">
			this.css("top", (($(window).height() - this.outerHeight())*3 / 4));
		</c:when>
		</c:choose>
		return this;
	}
	$('#user_profile').fixPos();
	
	$('.func_element').corner('5px');
});
// -->
</script>
</body>
</html>
