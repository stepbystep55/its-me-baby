<%@ page language="java" session="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
	<link rel="stylesheet" type="text/css"  media="screen" href="<%= request.getContextPath() %>/resources/css/jquery.minicolors.css" />
	<script type="text/javascript"  charset="utf-8" src="<%= request.getContextPath() %>/resources/js/jquery.minicolors.min.js"></script>
	<link rel="stylesheet" type="text/css"  media="screen" href="<%= request.getContextPath() %>/resources/css/jquery-ui-1.8.16.custom.css">
	<script type="text/javascript"  charset="utf-8" src="<%= request.getContextPath() %>/resources/js/jquery-ui-1.8.16.custom.min.js"></script>
	<style type="text/css">
<!--
/* background style */
#background { width: 100%; height: 100%; position: absolute; left: 0px; top: 0px; z-index: -1; }
.stretch {width:100%;height:auto;min-height:100%;}

/* profile box */
#user_name { font-size:${userProfile.nameFontSize}px; color:${userProfile.nameFontColor}; }
#user_title { font-size:${userProfile.titleFontSize}px; color:${userProfile.titleFontColor}; }
#user_content { margin: 5px 0; font-size:${userProfile.contentFontSize}px; color:${userProfile.contentFontColor}; }

/* etc */
.func_element { background-color: #333333; text-align: center; height: 24px; line-height: 20px; }
.func_element a:link, .func_element a:visited { color: #FFFFFF; }
.func_element a:hover, .func_element a:active { color: #F0F8FF; }

/* profile edit */
#prof_edit_box {
	position: absolute;
	top: 33px;
	left: 10px;
	z-index: 999;
	width: 500px;
	padding: 15px 30px;
	background-color: #FFFFFF;
	border: 3px solid #666666;
}
#prof_edit_tbl {
	/*border-spacing: 10px 50px;*/
}
.prof_edit_label {
	width: 80px;
	padding: 0 5px;
	font-weight: bold;
}
.prof_edit_sublabel {
	padding: 0 5px;
}
.prof_edit_txtinput {
	width: 320px;
}
.prof_edit_txtinput input, .prof_edit_txtinput textarea {
	width: 100%;
}
.prof_edit_input {
}
.prof_edit_panel {
	text-align: right;
}

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
</head>
<body>
<div id="background">
</div>
<jsp:include page="../_menu_bar.jsp"/>

<div class="container_12">
	<div class="grid_12">&nbsp;</div>
</div>
<div class="container_12">
	<div class="grid_10">&nbsp;</div>
	<div class="grid_2 func_element">
		<a id="stream" href="<%= request.getContextPath() %>/stream/${userProfile.userId}">view stream</a>
	</div>
</div>

<div id="user_profile" style="z-index:99; padding: 20px 15px; <c:choose><c:when test="${userProfile.profileBoxTransparent}">background-color: transparent;</c:when><c:otherwise>background-color: ${userProfile.profileBoxColor};</c:otherwise></c:choose>">
	<div id="user_name"><c:out value="${userProfile.name}" /></div>
	<div id="user_title"><c:out value="${userProfile.title}" /></div>
	<div id="user_content"><pre><c:out value="${userProfile.content}" /></pre></div>
</div>

<div id="prof_edit_box">
	<div><a id="prof_edit_toggle" href="#">Open/Close</a></div>
	<div id="prof_tabs">
		<ul>
			<li><a href="#prof_edit_tab1"><span>Content</span></a></li>
			<li><a href="#prof_edit_tab2"><span>Box</span></a></li>
			<li><a href="#prof_edit_tab3"><span>Backgrounds</span></a></li>
		</ul>
	
		<form:form modelAttribute="userProfile" action="updateProfile" method="post">
		<div id="prof_edit_tab1">
				<table id="prof_edit_tbl">
					<tr>
						<td class="prof_edit_label">Name</td>
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
						<td class="prof_edit_label">Title</td>
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
						<td class="prof_edit_label">Content</td>
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
						<td class="prof_edit_label">Box</td>
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
						<td class="prof_edit_label">Backgrounds</td>
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
		</form:form>
	</div>
</div>

<script type="text/javascript">
<!--
$(function(){
	$('#stream').colorbox({iframe:true, width:"82%", height:"80%"});

	// position fix function
	//referece from http://stackoverflow.com/questions/210717/using-jquery-to-center-a-div-on-the-screen
	jQuery.fn.fixPos = function (pos) {
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
		if (layout == 'center') {
			this.css('background', 'url('+url+') no-repeat fixed 50% 50%');
			this.html('');
		} else if (layout == 'tile') {
			this.css('background', 'url('+url+') repeat fixed 0 30px');
			this.html('');
		} else if (layout == 'stretch') {
			this.css('background', '');
			this.html('<img src="'+url+'" class="stretch" alt="background image" />');
		}
	};

	$('#user_profile').fixPos('${userProfile.profileBoxPosition}');
	$('#background').setBg('${userProfile.bgImgUrl}', '${userProfile.bgImgLayout}');

	$('.func_element').corner('5px');
	$('#prof_edit_box').corner('10px');

	$('#prof_tabs').tabs();

	$('.minicolors').miniColors();

	$('#prof_edit_toggle').click(function() { $('#prof_tabs').toggle(); });

	// preview
	$('#previewContentBtn').click(function() {
		$('#user_name').text($('#name').val());
		$('#user_name').css('font-size', $('#nameFontSize').val()+'px');
		$('#user_name').css('color', $('#nameFontColor').val());
		$('#user_title').text($('#title').val());
		$('#user_title').css('font-size', $('#titleFontSize').val()+'px');
		$('#user_title').css('color', $('#titleFontColor').val());
		$('#user_content > pre').text($('#content').val());
		$('#user_content').css('font-size', $('#contentFontSize').val()+'px');
		$('#user_content').css('color', $('#contentFontColor').val());
	});
	$('#previewBoxBtn').click(function() {
		if ($('input[name="profileBoxTransparent"]').is(':checked')) {
			$('#user_profile').css('background-color', 'transparent');
		} else {
			$('#user_profile').css('background-color', $('#profileBoxColor').val());
		}
		$('#user_profile').fixPos($('input[name="profileBoxPosition"]:checked').val());
	});
	$('#previewBgBtn').click(function() {
		$('#background').setBg($('#bgImgUrl').val(), $('#bgImgLayout option:selected').val());
	});
});
// -->
</script>
</body>
</html>
