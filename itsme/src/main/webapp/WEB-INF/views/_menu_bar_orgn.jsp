<%@ page language="java" session="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="its.me.baby.util.UserCookieGenerator" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<%!
	private UserCookieGenerator userCookieGenerator = new UserCookieGenerator();
%>
<div id="page_header">
	<div class="container_12">
		<div class="grid_1"><a class="attention" href="<%=request.getContextPath()%>/">Its me</a></div>
		<div class="grid_1"><a href="<%=request.getContextPath()%>/list">People</a></div>

		<% if (userCookieGenerator.getUserId(request) == null) { %>
			<div class="grid_9">&nbsp;</div>
			<div class="grid_1 align_right"><a class="normal" href="<%=request.getContextPath()%>/login">Sign in</a></div>

		<% } else { %>
			<div class="grid_9">&nbsp;</div>
			<div class="grid_1 align_right">
				<ul class="dropdown">
					<li><a class="normal" href="#">Account</a>
						<ul class="sub_menu">
						<%--
							<li><a class="normal" href="<%= request.getContextPath() %>/show/<%=authUser.getId() %>">My page</a></li>
						--%>
							<li><a class="normal" href="<%= request.getContextPath() %>/gotoMyPage">My page</a></li>
							<li><a class="normal" href="<%= request.getContextPath() %>/edit">Settings</a></li>
							<li><a class="normal" href="<%= request.getContextPath() %>/logout">Sign out</a></li>
						</ul>
					</li>
				</ul>
			</div>
		<% } %>

	</div>
</div>