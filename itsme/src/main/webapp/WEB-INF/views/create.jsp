<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page session="false" %>
<html>
<head>
	<title>Create</title>
</head>
<body>
<p>
<h1>List</h1>
<c:forEach var="temp" items="${tempList}" varStatus="status">
	${temp.userId} : ${temp.userName}<br>
</c:forEach>
</p>

<p>
<h1>Form</h1>
<form:form modelAttribute="temp" action="save" method="post">
	userId:<form:input path="userId" style="ime-mode: disabled;" />
	<br>
	userName:<form:input path="userName" />
	<br>
	<input type="submit">
</form:form>
</p>
</body>
</html>
