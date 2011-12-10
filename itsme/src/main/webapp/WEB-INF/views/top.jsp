<%@ page language="java" session="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
	<title>Top</title>
	<%@ include file="_head_base.jsp"%>
	<%@ include file="_head_menu_bar.jsp"%>
	<%@ include file="_head_grid.jsp"%>
	<style type="text/css">
<!--
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
// -->
	</style>
</head>
<body>

<jsp:include page="_menu_bar.jsp"/>

<div id="page_content">
	<div class="container_16">
		<div class="grid_16">&nbsp;</div>
	</div>
	<div class="container_16">
		<div class="grid_1">&nbsp;</div>
		<div class="grid_15">
			<div id="page_title">It's me, baby!</div>
			<div id="sub_title">Create your online profile page.</div>
		</div>
	
		<div class="clear"></div>
		<div class="grid_1">&nbsp;</div>
		<div class="grid_8">
			<div id="profile">
				<p>
				You can create your online profile page in minutes.<br/>
				It's easy to put all your online contents together.
				</p>
				<p>&nbsp;</p>
				<p class="notice">
				This site is just a showcase.<br/>
				This application will not store your privacy information.<br/>
				Feel free to try!
				</p>
			</div>
		</div>
		<div class="grid_7">&nbsp;</div>
			
		<div class="clear"></div>
		<div class="grid_1">&nbsp;</div>
		<div class="grid_15">
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

<script type="text/javascript">
<!--
$(function(){
});
// -->
</script>
</body>
</html>
