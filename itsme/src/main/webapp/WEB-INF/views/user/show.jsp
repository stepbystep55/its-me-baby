<%@ page language="java" session="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
	<title>Show</title>
	<%@ include file="../_head_base.jsp"%>
	<%@ include file="../_head_menu_bar.jsp"%>
	<%@ include file="../_head_grid.jsp"%>
	<script type="text/javascript"  charset="utf-8" src="<%= request.getContextPath() %>/resources/js/jquery.corner.js"></script>
	<link rel="stylesheet" type="text/css"  media="screen" href="<%= request.getContextPath() %>/resources/css/colorbox.css">
	<script type="text/javascript"  charset="utf-8" src="<%= request.getContextPath() %>/resources/js/jquery.colorbox-min.js"></script>
	<link rel="stylesheet" type="text/css"  media="screen" href="<%= request.getContextPath() %>/resources/css/jquery.minicolors.css" />
	<script type="text/javascript"  charset="utf-8" src="<%= request.getContextPath() %>/resources/js/jquery.minicolors.min.js"></script>
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

/* profile edit */
#prof_edit_box {
	position: absolute;
	top: 33px;
	left: 10px;
	z-index: 999;
	width: 520px;
	padding: 15px 30px;
	background-color: #FFFFFF;
	border: 3px solid #666666;
}
#prof_edit_tbl {
	/*border-spacing: 10px 50px;*/
}
.prof_edit_label {
	width: 80px;
	padding: 0 5px;
	font-weight: bold;
}
.prof_edit_sublabel {
	padding: 0 5px;
}
.prof_edit_txtinput {
	width: 150px;
}
.prof_edit_txtinput input, .prof_edit_txtinput textarea {
	width: 100%;
}
.prof_edit_input {
}
.prof_edit_panel {
}
// -->
	</style>
</head>
<body>
<c:if test="${userProfile.bgImgUrl != null and userProfile.bgImgUrl != '' and userProfile.bgImgLayout == 'stretch'}">
	<div id="background"><img src="${userProfile.bgImgUrl}" class="stretch" alt="" /></div>
</c:if>
<jsp:include page="../_menu_bar.jsp"/>

<div class="container_12">
	<div class="grid_12">&nbsp;</div>
</div>
<div class="container_12">
	<div class="grid_10">&nbsp;</div>
	<div class="grid_2 func_element">
		<a id="stream" href="<%= request.getContextPath() %>/stream/${userProfile.userId}">view stream</a>
	</div>
</div>

<div id="user_profile" style="z-index:99; padding: 20px 15px; <c:if test="${!userProfile.profileBoxTransparent}">background:${userProfile.profileBoxColor} no-repeat fixed 0 0;</c:if>">
	<div id="user_name" style="font-size:${userProfile.nameFontSize}px; color:${userProfile.nameFontColor};">
		<c:out value="${userProfile.name}" />
	</div>
	<div id="user_title" style="font-size:${userProfile.titleFontSize}px; color:${userProfile.titleFontColor};">
		<c:out value="${userProfile.title}" />
	</div>
	&nbsp;
	<div id="user_content" style="font-size:${userProfile.contentFontSize}px; color:${userProfile.contentFontColor};">
		<pre><c:out value="${userProfile.content}" /></pre>
	</div>
</div>

<div id="prof_edit_box">
<form:form modelAttribute="userProfile" action="updateProfile" method="post">
	<table id="prof_edit_tbl">
		<tr>
			<td class="prof_edit_label">Name</td>
			<td class="prof_edit_txtinput"><form:input path="name" maxlength="32" /></td>
			<td class="prof_edit_sublabel">Color</td>
			<td class="prof_edit_input"><form:input path="nameFontColor" readonly="true" cssClass="minicolors" size="8" maxlength="6" /></td>
			<td class="prof_edit_sublabel">Font</td>
			<td><form:input path="nameFontSize" size="3" maxlength="3" /></td>
		</tr>
		<tr><td colspan="6">&nbsp;</td></tr>
		<tr>
			<td class="prof_edit_label">Title</td>
			<td class="prof_edit_txtinput"><form:input path="title" maxlength="128" /></td>
			<td class="prof_edit_sublabel">Color</td>
			<td class="prof_edit_input"><form:input path="titleFontColor" readonly="true" cssClass="minicolors" size="8" maxlength="6" /></td>
			<td class="prof_edit_sublabel">Font</td>
			<td><form:input path="titleFontSize" size="3" maxlength="3" /></td>
		</tr>
		<tr><td colspan="6">&nbsp;</td></tr>
		<tr>
			<td class="prof_edit_label">Content</td>
			<td class="prof_edit_txtinput"><form:textarea path="content" rows="5" /></td>
			<td class="prof_edit_sublabel">Color</td>
			<td class="prof_edit_input"><form:input path="contentFontColor" readonly="true" cssClass="minicolors" size="8" maxlength="6" /></td>
			<td class="prof_edit_sublabel">Font</td>
			<td><form:input path="contentFontSize" size="3" maxlength="3" /></td>
		</tr>
		<tr><td colspan="6">&nbsp;</td></tr>
		<tr>
			<td colspan="4">&nbsp;</td>
			<td colspan="2">
				<input type="button" value="preview" />
			</td>
		</tr>
	</table>
</form:form>
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
	$('#prof_edit_box').corner('10px');

	$('.minicolors').miniColors();
});
// -->
</script>
</body>
</html>
