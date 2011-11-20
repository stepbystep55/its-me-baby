<%@ page language="java" session="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="its.me.baby.dto.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
	<script type="text/javascript"  charset="utf-8" src="<%= request.getContextPath() %>/resources/js/jquery.dropdownPlain.js"></script>
	<script type="text/javascript">
<!--
// -->
	</script>
	<style type="text/css">
<!--
/* dropdown menu */
/* LEVEL ONE */
ul.dropdown { text-align: center; width: 80px; position: relative; list-style: none; margin: 0; padding: 0; }
ul.dropdown li { zoom: 1;  margin: 0; padding: 0; }
ul.dropdown li a { display: block; padding: 0 5px; }
ul.dropdown li.hover, ul.dropdown li:hover { position: relative; background-color: #F0F0F0;  margin: 0; padding: 0; }
/* LEVEL TWO */
ul.dropdown ul { font-weight: normal; width: 80px; visibility: hidden; position: absolute; list-style: none; top: 100%;  margin: 0; padding: 0; }
ul.dropdown ul li { background-color: #FFFAFA; border-bottom: 1px solid #ccc; float: none; margin: 0; padding: 0; }
/* IE 6 & 7 Needs Inline Block */
ul.dropdown ul li a { width: 100%; display: inline-block; margin: 0; padding: 0; } 
/* LEVEL THREE */
/*
ul.dropdown ul ul { list-style: none; left: 100%; top: 0; margin: 0; padding: 0; }
ul.dropdown li:hover > ul { visibility: visible; margin: 0; padding: 0; }
*/
// -->
	</style>
<%--
<div id="page_header">
	<div class="container_12">
		<div class="grid_1"><a href="<%= request.getContextPath() %>/">Its me</a></div>
		<% if (request.getSession(false) == null || request.getSession(false).getAttribute("authUser") == null) { %>
			<div class="grid_9">&nbsp;</div>
			<div class="grid_2 align_right"><a href="<%= request.getContextPath() %>/login">Sign in</a></div>
		<%
			} else {
				User user = (User)request.getSession(false).getAttribute("authUser");
		%>
			<div class="grid_8">&nbsp;</div>
			<div class="grid_1 align_right"><a href="<%= request.getContextPath() %>/show/<%=user.getId() %>">My page</a></div>
			<div class="grid_1 align_right"><a href="<%= request.getContextPath() %>/edit">Settings</a></div>
			<div class="grid_1 align_right"><a href="<%= request.getContextPath() %>/logout">Sign out</a></div>
		<% } %>
--%>
<div id="page_header">
	<div class="container_12">
		<div class="grid_1"><a href="<%= request.getContextPath() %>/">Its me</a></div>
		<% if (request.getSession(false) == null || request.getSession(false).getAttribute("authUser") == null) { %>
			<div class="grid_10">&nbsp;</div>
			<div class="grid_1 align_right"><a href="<%= request.getContextPath() %>/login">Sign in</a></div>
		<% } else { User user = (User)request.getSession(false).getAttribute("authUser"); %>
			<div class="grid_10">&nbsp;</div>
			<div class="grid_1 align_right">
				<ul class="dropdown">
					<li><a href="#">Account</a>
						<ul class="sub_menu">
							<li><a href="<%= request.getContextPath() %>/show/<%=user.getId() %>">My page</a></li>
							<li><a href="<%= request.getContextPath() %>/edit">Settings</a></li>
							<li><a href="<%= request.getContextPath() %>/logout">Sign out</a></li>
						</ul>
					</li>
				</ul>
			</div>
		<% } %>
	</div>
</div>