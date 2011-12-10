<%@ page language="java" session="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="its.me.baby.dto.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<div id="page_header">
	<div class="container_12">
		<div class="grid_1"><a class="attention" href="<%=request.getContextPath()%>/">Its me</a></div>
		<div class="grid_1"><a href="<%=request.getContextPath()%>/list">People</a></div>
		<%
			if (request.getSession(false) == null || request.getSession(false).getAttribute(User.SESSION_KEY_AUTH) == null) {
		%>
			<div class="grid_9">&nbsp;</div>
			<div class="grid_1 align_right"><a href="<%=request.getContextPath()%>/login">Sign in</a></div>
		<%
			} else { User authUser = (User)request.getSession(false).getAttribute(User.SESSION_KEY_AUTH);
		%>
			<div class="grid_9">&nbsp;</div>
			<div class="grid_1 align_right">
				<ul class="dropdown">
					<li><a href="#">Account</a>
						<ul class="sub_menu">
							<li><a href="<%= request.getContextPath() %>/show/<%=authUser.getId() %>">My page</a></li>
							<li><a href="<%= request.getContextPath() %>/edit">Settings</a></li>
							<li><a href="<%= request.getContextPath() %>/logout">Sign out</a></li>
						</ul>
					</li>
				</ul>
			</div>
		<% } %>
	</div>
</div>