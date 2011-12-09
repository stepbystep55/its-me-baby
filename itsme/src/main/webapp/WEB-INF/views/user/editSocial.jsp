<%@ page language="java" session="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

		<div class="grid_7 form_label align_right">Facebook</div>
		<div class="grid_3 form_button">
			<c:choose>
			<c:when test="${facebookConnected}">
				<form:form action="disconnect" method="post">
					<input type="submit" name="disconnectFacebook" value="disconnect" />
				</form:form>
			</c:when>
			<c:otherwise>
				<form:form action="signin/facebook" method="post">
					<input type="hidden" name="scope" value="email,read_stream,offline_access" />
					<input type="submit" name="connectFacebook" value="connect" />
				</form:form>
			</c:otherwise>
			</c:choose>
		</div>
		<div class="grid_6">&nbsp;</div>

		<div class="clear"></div>
		<div class="grid_7 form_label align_right">Twitter</div>
		<div class="grid_3 form_button">
			<c:choose>
			<c:when test="${twitterConnected}">
				<form:form action="disconnect" method="post">
					<input type="submit" name="disconnectTwitter" value="disconnect" />
				</form:form>
			</c:when>
			<c:otherwise>
				<form:form action="signin/twitter" method="post">
					<input type="submit" name="connectTwitter" value="connect" />
				</form:form>
			</c:otherwise>
			</c:choose>
		</div>
		<div class="grid_6">&nbsp;</div>
<script type="text/javascript">
<!--
$(function(){
});
// -->
</script>