<%@ page language="java" session="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<html>
<head>
	<title>Top</title>
	<%@ include file="_head_base.jsp"%>
	<%@ include file="_head_grid.jsp"%>
	<style type="text/css">
<!--
#background {
	width: 100%; 
	height: 100%; 
	position: absolute;
	left: 0px; 
	top: 0px; 
	z-index: -1;
}
.stretch {width:100%;height:auto;min-height:100%;}
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

	<script type="text/javascript">
<!--
$(function(){
});
// -->
	</script>
</head>
<body>
<div id="background"><img src="<%= request.getContextPath() %>/resources/img/bk_shift.jpg" class="stretch" alt="" /></div>

<%@ include file="_body_header.jsp"%>

<div id="content">
	<div class="container_16">
		<div class="grid_16">&nbsp;</div>
	</div>
	<div class="container_16">
		<div class="grid_1">&nbsp;</div>
		<div class="grid_15">
			<div id="title">It's me, baby!</div>
			<div id="sub_title">Create your online profile page.</div>
		</div>
	
		<div class="clear"></div>
		<div class="grid_1">&nbsp;</div>
		<div class="grid_9">
			<div id="profile">
				<p>
				You can create your online profile page in minutes.<br/>
				It's easy to put all your online contents together.
				</p>
				<p class="attention">
				This site is just a showcase .The application stores only your accout ids.
				Feel free to try!
				</p>
			</div>
		</div>
		<div class="grid_6">&nbsp;</div>
			
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
</body>
</html>
