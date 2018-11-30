
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>jquery表单验证插件制作多张提交表单验证</title>
<script type="text/javascript" src="${ctx}/component/jQuery/jquery.min.js"></script>
<script type="text/javascript">
var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
function check(id){
	if(id == 'urlLink'){
		var urlLink = $("#urlLink").val();
		if(urlLink == '' || urlLink == undefined){
			$("#urlLink").addClass("highlight2");
			$("#urlLink_error").addClass("error");
			$("#urlLink_error").html("网址不能为空");
			return false;
		}
		var check = /((http|ftp|https):\/\/)[^\s]/;
		if (!check.test(urlLink)) {
			$("#urlLink").addClass("highlight2");
			$("#urlLink_error").addClass("error");
			$("#urlLink_error").html("网址格式不对,例如：http://www.baidu.com。");
			return false;
		}
		$("#urlLink_error").html("");
		$("#urlLink_error").removeClass("error");
		$("#urlLink").removeClass("highlight2");
		$("#urlLink_succeed").addClass("succeed");
	}else if(id == 'urlName'){
		var urlName = $("#urlName").val();
		if(urlName == '' || urlName == undefined){
			$("#urlName").addClass("highlight2");
			$("#urlName_error").addClass("error");
			$("#urlName_error").html("名称不能为空");
			return false;
		}
		$("#urlName_succeed").addClass("succeed");
		$("#urlName_error").html("");
		$("#urlName_error").removeClass("error");
		$("#urlName").removeClass("highlight2");
	}
}
$(document).ready(function(){
//表单提交验证和服务器请求
$("#submit").click(function() {
	var urlName = $("#urlName").val();
	var urlLink = $("#urlLink").val();
	if(urlName == '' || urlName == undefined){
		$("#urlName").addClass("highlight2");
		$("#urlName_error").addClass("error");
		$("#urlName_error").html("名称不能为空");
		return false;
	}
	$("#urlLink_error").html("");
	$("#urlLink_error").removeClass("error");
	$("#urlLink").removeClass("highlight2");
	$("#urlLink_succeed").addClass("succeed");
	if(urlLink == '' || urlLink == undefined){
		$("#urlLink").addClass("highlight2");
		$("#urlLink_error").addClass("error");
		$("#urlLink_error").html("网址不能为空");
		return false;
	}
	var check = /((http|ftp|https):\/\/)[^\s]/;
	if (!check.test(urlLink)) {
		$("#urlLink_error").html("网址格式不对,例如：http://www.baidu.com。");
		return false;
	}
	$("#urlLink_error").html("");
	$("#urlLink_error").removeClass("error");
	$("#urlLink").removeClass("highlight2");
	$("#urlLink_succeed").addClass("succeed");
	parent.addLink(urlName,urlLink);
	parent.layer.close(index);
    });
});
</script>
<link href="${ctx}/skin/massfunction/css/formStyle.css" rel="stylesheet" type="text/css" />
</head>
<body>

<div id="formbox" style="margin-top: 20px;">
	<form id="formpersonal" method="post" onsubmit="return false;">
	<div class="form">
		<div class="item">
			<span class="label"><span class="red">*</span>名称：</span>
			<div class="fl">
				<input type="text" id="urlName" onblur="check('urlName');" name="urlName" class="text" tabindex="1" value=""/>
				<label id="urlName_succeed" class="blank"></label>
				<span class="clear"></span>
				<label id="urlName_error" class=""> </label>
				<div id="username_error"></div>
			</div>
		</div><!--item end-->
		

		<div class="item">
			<span class="label"><span class="red">*</span>网址：</span>
			<div class="fl">
				<input type="text" id="urlLink" placeholder="例如：http://www.baidu.com" onblur="check('urlLink');" name="urlLink" class="text " tabindex="14" value=""/>
				<label id="urlLink_succeed" class="blank"></label>
				<span class="clear"></span>
				<label id="urlLink_error" class="error"> </label>
			</div>
		</div><!--item end-->

		<div class="item">
			<span class="label">&nbsp;</span>
			<input type="button"  class="yellow_button" id="submit" value="提交"  />
		</div><!--item end-->
		
	</div>
	</form>
</div>
</body>
</html>
