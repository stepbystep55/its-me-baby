<%@ page language="java" session="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<html>
<head>
	<%@ include file="_head.jsp"%>
	<title>Top</title>
	<style TYPE="text/css">
<!--
body {
	background: #FFFFFF url(http://farm7.static.flickr.com/6161/6180399199_347c33cbfa_z.jpg) no-repeat fixed 85% 30%;
}
#title {
	margin: 0;
	padding-top: 30px;
	padding-bottom: 10px;
	color: #DC143C;
	font-weight: bold;
	font-size: 42px;
}
#sub_title {
	margin: 0;
	padding-bottom: 30px;
	color: #FFA500;
	font-weight: bold;
	font-size: 20px;
}
#profile {
	font-size: 18px;
	font-weight: bold;
	margin: 0;
	padding-bottom: 30px;
}
#reg_btn {
	margin: 0;
	padding-bottom: 30px;
}
#attention {
	padding: 5px;
	border: 1px dotted #CCCCCC;
	background-color: #FFFFF0;
	font-weight: normal;
	font-size: 16px;
}
-->
</style>
</head>
<body>
<div id="header">
	<div class="container clearfix">
		<div class="grid1 first">
			<a href="<%= request.getContextPath() %>/">Top</a>
		</div>
		<div class="grid10">
			&nbsp;
		</div>
		<div class="grid1">
			<a href="login">Sign in</a>
		</div>
	</div>
</div>

<div id="content">
	<div class="container clearfix">
		<div class="grid1 first"></div>
		<div class="grid11">
			<div class="grid11 first">
				<div id="title">It's me, baby!</div>
				<div id="sub_title">Create your online profile page.</div>
			</div>
	
			<div class="grid6 first">
				<div id="profile">
					<p>
					You can create your online profile page in minutes.<br/>
					It's easy to gather all your online content around the web.
					</p>
					<p id="attention">
					This site is just a showcase .The application stores only your accout ids.
					So let's try freely!
					</p>
				</div>
			</div>
			<div class="grid5"></div>
			<div class="grid11 first">
				<div id="reg_btn"><a class="appeal" href="create">Register</a></div>
			</div>
		</div>
	</div>
</div>

<div id="footer">
	<div class="container clearfix">
		<div class="grid12 first">
			<div class="footer_item">
			&copy;ippoippo
			</div>
		</div>
	</div>
</div>

</body>
</html>
