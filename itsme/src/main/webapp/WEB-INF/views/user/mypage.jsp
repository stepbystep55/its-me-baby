<%@ page language="java" session="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="its.me.baby.dto.UserProfile" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
	<title>Show</title>
	<%@ include file="../_head_base.jsp"%>
	<%@ include file="../_head_menu_bar.jsp"%>
	<%@ include file="../_head_grid.jsp"%>
	<link rel="stylesheet" type="text/css"  media="screen" href="<%= request.getContextPath() %>/resources/css/colorbox.css">
	<script type="text/javascript"  charset="utf-8" src="<%= request.getContextPath() %>/resources/js/jquery.colorbox-min.js"></script>
	<link rel="stylesheet" type="text/css"  media="screen" href="<%= request.getContextPath() %>/resources/css/jquery-ui-1.8.16.custom.css">
	<script type="text/javascript"  charset="utf-8" src="<%= request.getContextPath() %>/resources/js/jquery-ui-1.8.16.custom.min.js"></script>
	<link rel="stylesheet" type="text/css"  media="screen" href="<%= request.getContextPath() %>/resources/css/jquery.minicolors.css" />
	<script type="text/javascript"  charset="utf-8" src="<%= request.getContextPath() %>/resources/js/jquery.minicolors.min.js"></script>
	<style type="text/css">
<!--
#feed_message { width: 100%; position: absolute; margin: -26px auto; text-align: center; z-index: 999; }

/* background style */
#background { width: 100%; height: 100%; position: absolute; left: 0px; top: 0px; z-index: -1; }
.stretch {width:100%;height:auto;min-height:100%;}

/* sticky */
.sticky_editor {
	border: solid 1px #000000;
	z-index: 9;
	width: 500px;
}
.sticky_editor_tbl {
	width: 100%;
}
.sticky {
	width: 100%;
	height: 100%;
	background-color: #FFFFFF;
	padding:20px 15px;
	cursor: pointer;
}
	/* profile edit */
	#edit_box {
		position: absolute;
		top: 33px;
		right: 10px;
		z-index: 99;
		/*width: 500px;*/
		padding: 5px 10px;
		background-color: #FFFFFF;
		border: 3px solid #666666;
	}
	#edit_bar {
		background-color: #000000;
		margin: 3px 0;
		padding: 5px;
		width: 80px;
		text-align: center;
	}
	#edit_bar a:link, #edit_bar a:visited, #edit_bar a:hover, #edit_bar a:active {
		color: #FFFFFF;
		outline: none; /* avoid showing a dotted border of firefox */
	}
	#edit_ctrl { margin: 15px 0; }
	table#edit_tbl { width: 100%; border-spacing: 10px; }
	table td.edit_label { padding: 3px 5px; font-weight: bold; }
	table td.edit_sublabel { padding: 3px 5px; }
	table td.edit_input { padding: 3px 5px; }
	#new_stick { text-size: 20px; }
// -->
	</style>
<script type="text/javascript">
<!--
function applyPgBg(url, layout) {
	if (url == '') {
		url = '<%= request.getContextPath() %>/resources/img/sample/brick01.jpg';
		layout = 'tile';
	}
	switch (layout) {
		case 'center':
			$('#background').css('background', 'url('+url+') no-repeat fixed 50% 50%').html('');
			break;
		case 'tile':
			$('#background').css('background', 'url('+url+') repeat fixed 0 30px').html('');
			break;
		case 'stretch':
			$('#background').css('background', '').html('<img src="'+url+'" class="stretch" alt="background image" />');
			break;
	}
}
jQuery.fn.setBgColor = function (color, isTransparent) {
	this.css('background-color', ((isTransparent == 'true') ? 'transparent' : color));
};

function editable() {
	$(this).wrapInner('<textarea class="txtara"></textarea>')
	.find('textarea')
	.focus()
	.select()
	.blur(function() {
		var stickyContent = $(this).val();
		var stickyPositionTop = $(this).parent().position().top;
		var stickyPositionLeft = $(this).parent().position().left;
		var stickyHeight = $(this).parent().innerHeight();
		var stickyWidth = $(this).parent().innerWidth();
		$(this).parent().html(stickyContent);
		$.ajax({
			type: "POST",
			url: 'addSticky',
			data: {
				userId: '<c:out value="${userProfile.userId}" />',
				positionTop: stickyPositionTop,
				positionLeft: stickyPositionLeft,
				width: stickyWidth,
				height: stickyHeight,
				content: stickyContent
			},
			dataType: 'json',
			cache: false,
			success: function(res){
				alert(res.msg);
				//$("#feed_message > span").html(res);
				//$('#feed_message').fadeOut(3000);
			}
		});
	});
}

$(function(){
	if($('#feed_message')!=null) $('#feed_message').fadeOut(3000);

	$('.minicolors').miniColors();

	applyPgBg('${userProfileDisplay.bgImgUrl}', '${userProfileDisplay.bgImgLayout}');

	$('#edit_toggle').click(function() {
		$('#edit_ctrl').toggle('fast', function() {
			($('#edit_toggle').text() == 'Close') ? $('#edit_toggle').text('Open') : $('#edit_toggle').text('Close');
		});
	});

	$('#new_sticky').click(function() {
		$($('#sticky_editor_in').html())
		.css({position:'absolute',top:100, left:150})
		.appendTo('body')
		.resizable()
		.draggable()
		.dblclick(editable);
	});

	$('#preview_bg_btn').click(function() {
		applyPgBg($('#bgImgUrl').val(), $('#bgImgLayout option:selected').val());
	});
	
});
// -->
</script>

</head>
<body>
<div id="background"></div>

<jsp:include page="../_menu_bar.jsp"/>

<div id="feed_message">
	<span class="confirm">
	<c:if test="${created}"><spring:message code="result.created" /></c:if>
	<c:if test="${updated}"><spring:message code="result.updated.page" /></c:if>
	</span>
</div>

<div id="sticky_editor_in" style="display: none;">
	<div class="sticky_editor">
		<form action="#" method="post">
		<table class="sticky_editor_tbl">
			<tr>
				<td><input type="button" value="delete" /></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td class="edit_label">FONT</td>
				<td class="edit_sublabel">Size:</td><td><input type="text" size="3" maxlength="3" /></td>
				<td class="edit_sublabel">Color:</td><td><input type="text" id="fontColor" name="fontColor" class="minicolors" size="8" maxlength="6" /></td>
			</tr>
			<tr>
				<td class="edit_label">BACKGROUND:</td>
				<td class="edit_sublabel">Transparent:</td><td><input type="checkbox" name="transparent" /></td>
				<td class="edit_sublabel">Color:</td><td><input type="text" id="bgColor" readonly="readonly" name="bgColor" class="minicolors" size="8" maxlength="6" /></td>
			</tr>
			<tr><td colspan="5">
				<div class="sticky">Drag &amp; Double Click!</div>
			</td></tr>
		</table>
		</form>
	</div>
</div>

<c:if test="${editMode}">
	<div id="edit_box">
		<div id="edit_bar"><a id="edit_toggle" href="#">Close</a></div>
		<div id="edit_ctrl">
		<form:form modelAttribute="userProfile" action="updateMyPage" method="post">
		<form:hidden path="userId" />
			<table id="edit_tbl">
				<tr>
					<td class="edit_label align_right">BACKGROUNDS</td>
					<td class="edit_sublabel">URL</td>
					<td class="edit_input form_input_stretch"><form:input path="bgImgUrl" size="60" maxlength="512" /></td>
				</tr>
				<tr>
					<td></td>
					<td class="edit_sublabel">Layout</td>
					<td class="edit_input">
						<form:select path="bgImgLayout">
							<form:option value="center"/>
							<form:option value="tile"/>
							<form:option value="stretch"/>
						</form:select>
					</td>
				</tr>
				<tr><td colspan="3">&nbsp;</td></tr>
				<tr>
					<td>
						<input id="new_sticky" type="button" value="new sticky" />&nbsp;
					</td>
					<td class="align_right" colspan="2">
						<input id="preview_bg_btn" type="button" value="preview" />&nbsp;&nbsp;
						<input type="submit" name="updateMyPage" value="update"/>
					</td>
				</tr>
			</table>
		</form:form>
		</div>
	</div>
</c:if>

<c:forEach items="${userStickyList}" var="userSticky">
	<div class="stickyFixed"
		style="
		position:absolute;
		top:${userSticky.positionTop}px;
		left:${userSticky.positionLeft}px;
		height:${userSticky.height}px;
		width:${userSticky.width}px;
		font-size:${userSticky.fontSize}px;
		">
		<c:out value="${userSticky.content}" />
	</div>
</c:forEach>

</body>
</html>
