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
	<style type="text/css">
<!--
#feed_message { width: 100%; position: absolute; margin: -26px auto; text-align: center; z-index: 999; }

/* background style */
#background { width: 100%; height: 100%; position: absolute; left: 0px; top: 0px; z-index: -1; }
.stretch {width:100%;height:auto;min-height:100%;}

/* profile box */
#user_profile { z-index:9; padding: 20px 15px; }
#user_content { margin: 5px 0; }

/* etc */
.func_element { background-color: #333333; text-align: center; height: 24px; line-height: 20px; }
.func_element a:link, .func_element a:visited { color: #FFFFFF; }
.func_element a:hover, .func_element a:active { color: #F0F8FF; }
// -->
	</style>

<script type="text/javascript">
<!--
// utility functions
jQuery.fn.setFont = function (size, color) {
	this.css('font-size', size+'px');
	this.css('color', color);
};
//referece from http://stackoverflow.com/questions/210717/using-jquery-to-center-a-div-on-the-screen
jQuery.fn.setPos = function (pos) {
	this.css('position','absolute');
	if (pos.match(/top/)) {
		this.css('top', (($(window).height() - this.outerHeight()) / 4));
	} else if (pos.match(/middle/)) {
		this.css('top', (($(window).height() - this.outerHeight()) / 2));
	} else if (pos.match(/bottom/)) {
		this.css('top', (($(window).height() - this.outerHeight())*3 / 4));
	}
	if (pos.match(/left/)) {
		this.css('left', (($(window).width() - this.outerWidth()) / 4));
	} else if (pos.match(/center/)) {
		this.css('left', (($(window).width() - this.outerWidth()) / 2));
	} else if (pos.match(/right/)) {
		this.css('left', (($(window).width() - this.outerWidth())*3 / 4));
	}
	return this;
};
jQuery.fn.setBg = function (url, layout) {
	if (url == '') {
		url = '<%= request.getContextPath() %>/resources/img/sample/brick01.jpg';
		layout = 'tile';
	}
	if (layout == 'center') {
		this.css('background', 'url('+url+') no-repeat fixed 50% 50%').html('');
	} else if (layout == 'tile') {
		this.css('background', 'url('+url+') repeat fixed 0 30px');
		this.html('');
	} else if (layout == 'stretch') {
		this.css('background', '');
		this.html('<img src="'+url+'" class="stretch" alt="background image" />');
	}
};
jQuery.fn.setBgColor = function (color, isTransparent) {
	this.css('background-color', ((isTransparent == 'true') ? 'transparent' : color));
};

$(function(){
	if($('#feed_message')!=null) $('#feed_message').fadeOut(3000);

	$('#stream').colorbox({iframe:true, width:"82%", height:"80%"});

	// initialize page
	$('#background').setBg('${userProfileDisplay.bgImgUrl}', '${userProfileDisplay.bgImgLayout}');
	$('.func_element').corner('5px');
	$('#user_name').setFont('${userProfileDisplay.nameFontSize}', '${userProfileDisplay.nameFontColor}');
	$('#user_title').setFont('${userProfileDisplay.titleFontSize}', '${userProfileDisplay.titleFontColor}');
	$('#user_content').setFont('${userProfileDisplay.contentFontSize}', '${userProfileDisplay.contentFontColor}');
	$('#user_profile').setBgColor('${userProfileDisplay.profileBoxColor}', '${userProfileDisplay.profileBoxTransparent}');
	$('#user_profile').setPos('${userProfileDisplay.profileBoxPosition}');
});
// -->
</script>

<c:if test="${editMode}">
	<link rel="stylesheet" type="text/css"  media="screen" href="<%= request.getContextPath() %>/resources/css/jquery.minicolors.css" />
	<script type="text/javascript"  charset="utf-8" src="<%= request.getContextPath() %>/resources/js/jquery.minicolors.min.js"></script>
	<link rel="stylesheet" type="text/css"  media="screen" href="<%= request.getContextPath() %>/resources/css/jquery-ui-1.8.16.custom.css">
	<script type="text/javascript"  charset="utf-8" src="<%= request.getContextPath() %>/resources/js/jquery-ui-1.8.16.custom.min.js"></script>
	<style type="text/css">
<!--
	/* profile edit */
	#prof_edit_box {
		position: absolute;
		top: 33px;
		left: 10px;
		z-index: 99;
		width: 500px;
		padding: 5px 10px;
		background-color: #FFFFFF;
		border: 3px solid #666666;
	}
	#prof_menu {
		background-color: #000000;
		padding: 3px;
		width: 80px;
		text-align: center;
	}
	#prof_menu a:link, #prof_menu a:visited, #prof_menu a:hover, #prof_menu a:active {
		color: #FFFFFF;
		outline: none; /* avoid showing a dotted border of firefox */
	}
	#prof_tab_btns {
		margin: 30px 0;
	}
	#prof_tab_btns ul {
		margin:0;
		padding:0;
		list-style:none;
		height:30px;
	}
	#prof_tab_btns li {
		float:left;
		width:120px;
		margin:0 20px 0 0;
		padding:5px 0 0 0;
		text-align:center;
	}
	#prof_edit_tbl {
		/*border-spacing: 10px 50px;*/
	}
	.prof_edit_label { width: 80px; padding: 0 5px; font-weight: bold; }
	.prof_edit_sublabel { padding: 0 5px; }
	.prof_edit_txtinput { width: 320px; }
	.prof_edit_txtinput input, .prof_edit_txtinput textarea { width: 100%; }
	.prof_edit_input { }
	.prof_edit_panel { text-align: right; }
	
	#box_pos_tbl {
		width: 200px;
		border-collapse: collapse;
		border-left: #cccccc 1px solid;
		border-bottom: #cccccc 1px solid;
		text-align: center;
	}
	#box_pos_tbl td {
		padding: 3px;
		border-top: #cccccc 1px solid;
		border-right: #cccccc 1px solid;
		text-align: center;
	}	
// -->
	</style>
	<script type="text/javascript">
	<!--
	$(function(){
		$('#prof_edit_box').corner('5px');
		$('#prof_menu').corner('20px');
		$('.minicolors').miniColors();
		$('#prof_edit_toggle').click(function() {
			$('#prof_tabs').toggle('fast', function() {
				if ($('#prof_edit_toggle').text() == 'Close') {
					$('#prof_edit_toggle').text('Open');
				} else {
					$('#prof_edit_toggle').text('Close');
				}
			});
		});

		$('#edit_content').click(activateTab);
		$('#edit_box').click(activateTab);
		$('#edit_bg').click(activateTab);

		$('#edit_content').trigger('click');

		// preview
		$('#previewContentBtn').click(function() {
			$('#user_name').text($('#name').val());
			$('#user_name').setFont($('#nameFontSize').val(), $('#nameFontColor').val());
			$('#user_title').text($('#title').val());
			$('#user_title').setFont($('#titleFontSize').val(), $('#titleFontColor').val());
			$('#user_content > pre').text($('#content').val());
			$('#user_content').setFont($('#contentFontSize').val(), $('#contentFontColor').val());
		});
		$('#previewBoxBtn').click(function() {
			$('#user_profile').setBgColor($('#profileBoxColor').val(), ''+$('input[name="profileBoxTransparent"]').is(':checked'));
			$('#user_profile').setPos($('input[name="profileBoxPosition"]:checked').val());
		});
		$('#previewBgBtn').click(function() {
			$('#background').setBg($('#bgImgUrl').val(), $('#bgImgLayout option:selected').val());
		});
	});

	function activateTab(){
		switch ($(this).attr('id')) {
		case 'edit_content':
			$('#prof_edit_tab1').show();
			$('#prof_edit_tab2').hide();
			$('#prof_edit_tab3').hide();
			break;
		case 'edit_box':
			$('#prof_edit_tab1').hide();
			$('#prof_edit_tab2').show();
			$('#prof_edit_tab3').hide();
			break;
		case 'edit_bg':
			$('#prof_edit_tab1').hide();
			$('#prof_edit_tab2').hide();
			$('#prof_edit_tab3').show();
			break;
		default:
			$('#prof_edit_tab1').show();
			$('#prof_edit_tab2').hide();
			$('#prof_edit_tab3').hide();
			break;
		}
		$('p[class="tab_button_disabled"]').removeClass('tab_button_disabled').addClass('tab_button');
		$(this).removeClass('tab_button').addClass('tab_button_disabled');
		$('p[class="tab_button"]').each(function(){
			var bgColor = $(this).css('backgroundColor');
			$(this).hover(function(){
				$(this).css({ backgroundColor:'#E6E6FA' });
			},
			function(){
				$(this).css({ backgroundColor:bgColor });
			});
		});
		$('p[class="tab_button_disabled"]').each(function() {
			$(this).unbind('hover');
			$(this).css({ backgroundColor: ''});
		});
	}
	// -->
	</script>
</c:if>

</head>
<body>
<div id="background">
</div>
<jsp:include page="../_menu_bar.jsp"/>

<div id="feed_message">
	<c:if test="${created}"><span class="confirm"><spring:message code="result.created" /></span></c:if>
	<c:if test="${updated}"><span class="confirm"><spring:message code="result.updated.page" /></span></c:if>
</div>

<div class="container_12">
	<div class="grid_12">&nbsp;</div>
</div>
<div class="container_12">
	<div class="grid_10">&nbsp;</div>
	<div class="grid_2 func_element">
		<a id="stream" href="<%= request.getContextPath() %>/stream/${userProfileDisplay.userId}">view stream</a>
	</div>
</div>

<div id="user_profile">
	<div id="user_name"><c:out value="${userProfileDisplay.name}" /></div>
	<div id="user_title"><c:out value="${userProfileDisplay.title}" /></div>
	<div id="user_content"><pre><c:out value="${userProfileDisplay.content}" /></pre></div>
</div>

<c:if test="${editMode}">
	<div id="prof_edit_box">
		<div id="prof_menu"><a id="prof_edit_toggle" href="#">Close</a></div>
		<form:form modelAttribute="userProfile" action="updateMyPage" method="post">
		<form:hidden path="userId" />
		<div id="prof_tabs">
			<div id="prof_tab_btns">
				<ul>
					<li><p id="edit_content" class="tab_button_disabled">Content</p></li>
					<li><p id="edit_box" class="tab_button">Box</p></li>
					<li><p id="edit_bg" class="tab_button">Backgrounds</p></li>
				</ul>
			</div>
		
			<div id="prof_edit_tab1">
				<table id="prof_edit_tbl">
					<tr>
						<td class="prof_edit_label align_right">Name</td>
						<td class="prof_edit_txtinput"><form:input path="name" maxlength="32" /></td>
					</tr>
					<tr>
						<td></td>
						<td>
						 	<span class="prof_edit_sublabel">Color</span>
							<span class="prof_edit_input"><form:input path="nameFontColor" readonly="true" cssClass="minicolors" size="8" maxlength="6" /></span>
							<span class="prof_edit_sublabel">Font</span>
							<span><form:input path="nameFontSize" size="3" maxlength="3" /></span>
						</td>
					</tr>
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr>
						<td class="prof_edit_label align_right">Title</td>
						<td class="prof_edit_txtinput"><form:input path="title" maxlength="128" /></td>
					</tr>
					<tr>
						<td></td>
						<td>
							<span class="prof_edit_sublabel">Color</span>
							<span class="prof_edit_input"><form:input path="titleFontColor" readonly="true" cssClass="minicolors" size="8" maxlength="6" /></span>
							<span class="prof_edit_sublabel">Font</span>
							<span><form:input path="titleFontSize" size="3" maxlength="3" /></span>
						</td>
					</tr>
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr>
						<td class="prof_edit_label align_right">Content</td>
						<td class="prof_edit_txtinput"><form:textarea path="content" rows="5" /></td>
					</tr>
					<tr>
						<td></td>
						<td>
							<span class="prof_edit_sublabel">Color</span>
							<span class="prof_edit_input"><form:input path="contentFontColor" readonly="true" cssClass="minicolors" size="8" maxlength="6" /></span>
							<span class="prof_edit_sublabel">Font</span>
							<span><form:input path="contentFontSize" size="3" maxlength="3" /></span>
						</td>
					</tr>
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr>
						<td class="prof_edit_panel" colspan="2">
							<input id="previewContentBtn" type="button" value="preview" />
						</td>
					</tr>
				</table>
			</div>
			<div id="prof_edit_tab2">
				<table id="prof_edit_tbl">
					<tr>
						<td class="prof_edit_label align_right">Box</td>
						<td>
							<span class="prof_edit_sublabel">Position</span>
						</td>
						<td>
							<table id="box_pos_tbl">
								<tr><td><form:radiobutton path="profileBoxPosition" value="top-left"/></td><td><form:radiobutton path="profileBoxPosition" value="top-center"/></td><td><form:radiobutton path="profileBoxPosition" value="top-right"/></td></tr>
								<tr><td><form:radiobutton path="profileBoxPosition" value="middle-left"/></td><td><form:radiobutton path="profileBoxPosition" value="middle-center"/></td><td><form:radiobutton path="profileBoxPosition" value="middle-right"/></td></tr>
								<tr><td><form:radiobutton path="profileBoxPosition" value="bottom-left"/></td><td><form:radiobutton path="profileBoxPosition" value="bottom-center"/></td><td><form:radiobutton path="profileBoxPosition" value="bottom-right"/></td></tr>
							</table>
						</td>
					</tr>
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr>
						<td></td>
						<td>
						 	<span class="prof_edit_sublabel">Color</span>
						</td>
						<td>
							<span class="prof_edit_input"><form:input path="profileBoxColor" readonly="true" cssClass="minicolors" size="8" maxlength="6" /></span>
							<span class="prof_edit_sublabel">Transparent</span>
							<span><form:checkbox path="profileBoxTransparent" /></span>
						</td>
					</tr>
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr>
						<td class="prof_edit_panel" colspan="3">
							<input id="previewBoxBtn" type="button" value="preview" />
						</td>
					</tr>
				</table>
			</div>
			<div id="prof_edit_tab3">
				<table id="prof_edit_tbl">
					<tr>
						<td class="prof_edit_label align_right">Backgrounds</td>
						<td>
							<span class="prof_edit_sublabel">URL</span>
						</td>
						<td>
							<form:input path="bgImgUrl" maxlength="512" />
						</td>
					</tr>
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr>
						<td></td>
						<td>
						 	<span class="prof_edit_sublabel">Layout</span>
						</td>
						<td>
							<form:select path="bgImgLayout">
								<form:option value="center"/>
								<form:option value="tile"/>
								<form:option value="stretch"/>
							</form:select>
						</td>
					</tr>
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr>
						<td class="prof_edit_panel" colspan="3">
							<input id="previewBgBtn" type="button" value="preview" />
						</td>
					</tr>
				</table>
			</div>
			&nbsp;
			<div class="prof_edit_panel"><input type="submit" name="updateMyPage" value="update"/></div>
		</div>
		</form:form>
	</div>
</c:if>

</body>
</html>
