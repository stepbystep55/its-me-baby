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
	<script type="text/javascript"  charset="utf-8" src="<%= request.getContextPath() %>/resources/js/jquery.corner.js"></script>
	<link rel="stylesheet" type="text/css"  media="screen" href="<%= request.getContextPath() %>/resources/css/colorbox.css">
	<script type="text/javascript"  charset="utf-8" src="<%= request.getContextPath() %>/resources/js/jquery.colorbox-min.js"></script>
	<link rel="stylesheet" type="text/css"  media="screen" href="<%= request.getContextPath() %>/resources/css/jquery-ui-1.8.16.custom.css">
	<script type="text/javascript"  charset="utf-8" src="<%= request.getContextPath() %>/resources/js/jquery-ui-1.8.16.custom.min.js"></script>
	<style type="text/css">
<!--
#feed_message { width: 100%; position: absolute; margin: -26px auto; text-align: center; z-index: 999; }

/* background style */
#background { width: 100%; height: 100%; position: absolute; left: 0px; top: 0px; z-index: -1; }
.stretch {width:100%;height:auto;min-height:100%;}

/* sticky */
.sticky {
    width: 250px;
    height: 50px;
    background-color: #FFFFFF;
    z-index:9;
    padding:20px 15px;
    cursor: pointer;
}

// -->
	</style>
	<style type="text/css">
<!--
	/* profile edit */
	#edit_box {
		position: absolute;
		top: 33px;
		left: 10px;
		z-index: 99;
		width: 500px;
		padding: 5px 10px;
		background-color: #FFFFFF;
		border: 3px solid #666666;
	}
	#edit_bar {
		background-color: #000000;
		padding: 3px;
		width: 80px;
		text-align: center;
	}
	#edit_bar a:link, #edit_bar a:visited, #edit_bar a:hover, #edit_bar a:active {
		color: #FFFFFF;
		outline: none; /* avoid showing a dotted border of firefox */
	}
	.prof_edit_label { width: 80px; padding: 0 5px; font-weight: bold; }
	.prof_edit_sublabel { padding: 0 5px; }
	.prof_edit_panel { text-align: right; }
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
var stickyForm = '<textarea></textarea>';
$(function(){
	if($('#feed_message')!=null) $('#feed_message').fadeOut(3000);

	applyPgBg('${userProfileDisplay.bgImgUrl}', '${userProfileDisplay.bgImgLayout}');

	$('#prof_edit_toggle').click(function() {
		$('#prof_tabs').toggle('fast', function() {
			if ($('#prof_edit_toggle').text() == 'Close') {
				$('#prof_edit_toggle').text('Open');
			} else {
				$('#prof_edit_toggle').text('Close');
			}
		});
	});

	$('#new_sticky').click(function() {
		$('<div class="sticky">Drag & Double Click!</div>')
		.appendTo('body')
		.resizable()
		.draggable()
		.dblclick(function() {
			$(this).wrapInner(stickyForm)
			.find('textarea')
			.focus()
			.select()
			.blur(function() {
				$(this).parent().html($(this).val());
				$.ajax({
					type: "GET",
					url: url,
					data: url,
					cache: false,
					success: function(html){
						$("#feed_message > span").html(html);
						$('#feed_message').fadeOut(3000);
					}
				});
			});
		});
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

<c:if test="${editMode}">
	<div id="edit_box">
		<div id="edit_bar"><a id="prof_edit_toggle" href="#">Close</a></div>
		<div id="edit_ctrl">
		<form:form modelAttribute="userProfile" action="updateMyPage" method="post">
		<form:hidden path="userId" />
			<table id="edit_tbl">
				<tr>
					<td class="edit_label align_right">Backgrounds</td>
					<td><span class="edit_sublabel">URL</span></td>
					<td><form:input path="bgImgUrl" maxlength="512" /></td>
				</tr>
				<tr>
					<td></td>
					<td>
					 	<span class="edit_sublabel">Layout</span>
					</td>
					<td>
						<form:select path="bgImgLayout">
							<form:option value="center"/>
							<form:option value="tile"/>
							<form:option value="stretch"/>
						</form:select>
					</td>
				</tr>
				<tr>
					<td class="edit_panel" colspan="3">
						<input id="preview_bg_btn" type="button" value="preview" />
					</td>
				</tr>
			</table>
			<input id="new_sticky" type="button" value="new sticky" />
			<input type="submit" name="updateMyPage" value="update"/>
		</form:form>
		</div>
	</div>
</c:if>

</body>
</html>
