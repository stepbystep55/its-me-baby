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
	background: #FFFFFF url(http://farm7.static.flickr.com/6161/6180399199_347c33cbfa_z.jpg) no-repeat fixed 90% 30%;
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
-->
</style>
</head>
<body>
<%@ include file="_body_header.jsp"%>

<div id="content">
	<div class="container_12">
		<div class="grid_1">&nbsp;</div>
		<div class="grid_11">
			<div id="title">It's me, baby!</div>
			<div id="sub_title">Create your online profile page.</div>
		</div>
	
		<div class="clear"></div>
		<div class="grid_1">&nbsp;</div>
		<div class="grid_6">
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
		<div class="grid_5">&nbsp;</div>
			
		<div class="clear"></div>
		<div class="grid_1">&nbsp;</div>
		<div class="grid_11">
			<div id="reg_btn"><a class="appeal" href="create">Register</a></div>
		</div>
	</div>
</div>

<div id="footer">
	<div class="container_12">
		<div class="grid_12">
			<div class="footer_item">
			&copy;ippoippo
			</div>
		</div>
	</div>
</div>

</body>
</html>
