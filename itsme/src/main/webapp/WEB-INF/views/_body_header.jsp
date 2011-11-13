<div id="header">
	<div class="container_12">
		<div class="grid_1">
			<a href="<%= request.getContextPath() %>/">Its me</a>
		</div>
<%--
		<c:choose>
		<c:when test="${user == null}">
			<div class="grid_9">&nbsp;</div>
			<div class="grid_2" style="text-align:right;">
				<a href="login">Sign in</a>
			</div>
		</c:when>
		<c:otherwise>
			<div class="grid_9">&nbsp;</div>
			<div class="grid_1" style="text-align:right;">
				<a href="show/${user.id}">My page</a>
			</div>
			<div class="grid_1" style="text-align:right;">
				<a href="edit">Settings</a>
			</div>
		</c:otherwise>
		</c:choose>
--%>
		<% if (request.getSession(false) == null) { %>
			<div class="grid_9">&nbsp;</div>
			<div class="grid_2" style="text-align:right;">
				<a href="login">Sign in</a>
			</div>
		<% } else { %>
			<div class="grid_9">&nbsp;</div>
			<div class="grid_1" style="text-align:right;">
				<a href="<%= request.getContextPath() %>/show/${user.id}">My page</a>
			</div>
			<div class="grid_1" style="text-align:right;">
				<a href="<%= request.getContextPath() %>/edit">Settings</a>
			</div>
		<% } %>
	</div>
</div>