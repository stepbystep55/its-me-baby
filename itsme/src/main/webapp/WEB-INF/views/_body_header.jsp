<div id="header">
	<div class="container_12">
		<div class="grid_1">
			<a href="<%= request.getContextPath() %>/">Top</a>
		</div>
		<div class="grid_9">
			&nbsp;
		</div>
		<div class="grid_2" style="text-align:right;">
		<c:choose>
			<c:when test="${user == null}"><a href="login">Sign in</a></c:when>
			<c:otherwise><a href="show">My page</a></c:otherwise>
		</c:choose>
		</div>
	</div>
</div>