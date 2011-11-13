<%@ page language="java" session="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="its.me.baby.dto.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%--
	<script type="text/javascript">
<!--
var timeout = 500;
var closetimer = 0;
var ddmenuitem = 0;

function jsddm_open() {
	jsddm_canceltimer();
	jsddm_close();
	ddmenuitem = $(this).find('ul').css('visibility', 'visible');
}
function jsddm_close() {
	if(ddmenuitem) ddmenuitem.css('visibility', 'hidden');
}
function jsddm_timer() {
	closetimer = window.setTimeout(jsddm_close, timeout);
}
function jsddm_canceltimer() {
	if(closetimer) {
		window.clearTimeout(closetimer);
		closetimer = null;
	}
}
$(function(){
	$('#dropdown > li').bind('mouseover', jsddm_open)
	$('#dropdown > li').bind('mouseout',  jsddm_timer)
});
document.onclick = jsddm_close;
// -->
	</script>
--%>
<div id="header">
	<div class="container_12">
		<div class="grid_1"><a href="<%= request.getContextPath() %>/">Its me</a></div>
		<% if (request.getSession(false) == null || request.getSession(false).getAttribute("authUser") == null) { %>
			<div class="grid_9">&nbsp;</div>
			<div class="grid_2" style="text-align:right;"><a href="<%= request.getContextPath() %>/login">Sign in</a></div>
		<%
			} else {
				User user = (User)request.getSession(false).getAttribute("authUser");
		%>
			<div class="grid_8">&nbsp;</div>
			<div class="grid_1" style="text-align:right;"><a href="<%= request.getContextPath() %>/show/<%=user.getId() %>">My page</a></div>
			<div class="grid_1" style="text-align:right;"><a href="<%= request.getContextPath() %>/edit">Settings</a></div>
			<div class="grid_1" style="text-align:right;"><a href="<%= request.getContextPath() %>/logout">Sign out</a></div>
		<% } %>
<%--
		<div class="grid_1"><a href="<%= request.getContextPath() %>/">Its me</a></div>
		<div class="grid_9">&nbsp;</div>
		<c:choose>
		<c:when test="${authUser == null}">
			<div class="grid_2" style="text-align:right;"><a href="<%= request.getContextPath() %>/login">Sign in</a></div>
		</c:when>
		<c:otherwise>
			<div class="grid_1" style="text-align:right;"><a href="<%= request.getContextPath() %>/show/${user.id}">My page</a></div>
			<div class="grid_1" style="text-align:right;"><a href="<%= request.getContextPath() %>/edit">Settings</a></div>
		</c:otherwise>
		</c:choose>
--%>
<%--
		<div class="grid_9">&nbsp;</div>
		<c:choose>
		<c:when test="${authUser == null}">
			<div class="grid_2" style="text-align:right;"><a href="<%= request.getContextPath() %>/login">Sign in</a></div>
		</c:when>
		<c:otherwise>
			<div class="grid_2" style="text-align:right;">
			<ul id="dropdown">
				<li><a href="#">Account</a>
					<ul>
						<li><a href="<%= request.getContextPath() %>/show/${user.id}">My page</a></li>
						<li><a href="<%= request.getContextPath() %>/edit">Settings</a></li>
					</ul>
				</li>
			</ul>
		</c:otherwise>
		</c:choose>
--%>
	</div>
</div>