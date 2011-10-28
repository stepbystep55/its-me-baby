<%@ page language="java" session="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<meta http-equiv="Pragma" content="no-cache" />
	<meta http-equiv="Cache-Control" content="no-cache" />
	<meta http-equiv="Expires" content="-1" />
	<title>View</title>
</head>
<body>
<c:if test="${resultCreated}"><spring:message code="result.created" /></c:if>
<c:if test="${resultUpdated}"><spring:message code="result.updated" /></c:if>
<p>
	id:${user.id}
	<br>
	name:${user.name}
	<br>
	email:${user.email}
	<br>
	password:${user.password}
	<br>
	profile:${user.profile}
	<br>
</p>
</body>
</html>
