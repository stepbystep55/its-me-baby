<%@ page language="java" session="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<html>
<head>
	<%@ include file="../_head.jsp"%>
	<title>View</title>
</head>
<body>
<div id="edit">
	<a href="edit">edit your profile</a>
</div>
<div id="show">
<ul>
	<li>
	id:${user.id}
	</li>
	<li>
	name:${user.name}
	</li>
	<li>
	email:${user.email}
	</li>
	<li>
	password:${user.password}
	</li>
	<li>
	profile:${user.profile}
	</li>
</ul>
</div>

<div>
	<c:if test="${feedList != null}">
	Facebook
	<ul>
	<c:forEach items="${feedList}" var="post">
		<li>${post.updatedTime}: ${post.type}: ${post.message}</li>
	</c:forEach>
	</ul>
	</c:if>
	
	<c:if test="${tweets != null}">
	Twitter
	<ul>
	<c:forEach items="${tweets}" var="tweet">
		<li>${tweet.createdAt}: ${tweet.text}</li>
	</c:forEach>
	</ul>
	</c:if>
</div>
</body>
</html>
