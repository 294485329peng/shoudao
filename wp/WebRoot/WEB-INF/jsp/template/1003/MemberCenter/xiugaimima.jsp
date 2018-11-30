<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>消费记录</title>
<meta name="Keywords" content="">
<meta name="Description" content="">
<!-- 移动设备支持 -->
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
	<link rel="stylesheet" type="text/css" href="${ctx }/skin/tinyWebsite/css/DHstyle.css" />
	<link rel="stylesheet" type="text/css" href="${ctx }/skin/tinyWebsite/css/style.css" />
    <link rel="stylesheet" type="text/css" href="${ctx }/skin/tinyWebsite/css/mall.css" >
    <!-- wechatUI -->
    <link rel="stylesheet" type="text/css" href="${ctx }/skin/common/css/weui.min.css" >
    <script type="text/javascript" src="${ctx }/skin/tinyWebsite/js/jquery-2.0.3.min.js"></script>
    <script type="text/javascript" src="${ctx }/skin/tinyWebsite/js/jquery.Spinner.js"></script>
    <!--form 验证 -->
	<script type="text/javascript" src="${ctx}/component/layer/layer.js"></script>
	<script type="text/javascript" src="${ctx}/component/layer/extend/layer.ext.js"></script>
	<script type="text/javascript" src="${ctx }/Validform/js/Validform_v5.3.2.js"></script>
	<link rel="stylesheet" href="${ctx }/Validform/css/style.css" />
	<!--end  -->
	<style>
        .title{
            color:#3D4245;
            background: #F9F9F9;
        }
    </style>
</head>

<body class="body_color">
<div class="body">
<h3 class="fn-tit"><a href="javascript:history.go(-1);" class="nback">返回</a><b class="tit">修改密码</b></h3>
  <div class="jf-body">
  	<div class="edit">
  		<form action="${ctx }/TWebLogin/Member/updatePassWord.htmls" method="post" id="registerForm" class="registerform">
    	<p>当前密码：</p>
        <p><input name="OLD_PASSWORD" type="password" class="etxt" datatype="*6-16" errormsg="密码范围在6~16位之间！" nullmsg="请填写当前密码！"></p>
        <p>新密码：</p>
        <p><input name="LOGIN_PASSWORD" type="password" class="etxt" datatype="*6-16" errormsg="密码范围在6~16位之间！" nullmsg="请填写新密码！"></p>
        <p>确认新密码：</p>
        <p><input type="password" class="etxt" name="mima"  errormsg="您两次输入的账号密码不一致！" nullmsg="请再输入一次密码！" recheck="LOGIN_PASSWORD" datatype="*"></p>
        <p class="tips">密码长度至少6个字符，最多32个字符</p>
        <p><input id="save" type="submit" class="ebtn orange-btn" value="确 定"></p>
        </form>
    </div>
  </div>

</div>

  <!--↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓导航开始↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓-->
  <%@ include file="../common/tinyNavBottom.jsp"%>
  <!--↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑导航end↑↑↑↑↑↑↑↑↑↑↑↑↑↑-->
</body>
<script type="text/javascript">
/*关闭微信ui  */
function suer(){
	$(".weui_dialog_alert").attr("style", "display:none");
}
function updatePassWord(){
	window.location.href="${ctx}/MemberCenter/updatePassWord.htmls"
}
var index;
/*通用验证框架  */
$("body").append("<!--验证的遮蔽层  -->"  
		+"<div id=\"mask\" class=\"mask\"></div>"
		+"<!-- end -->");
$(function(){
	//$(".registerform").Validform();  //就这一行代码！;
	$(".registerform:eq(0)").Validform({
		btnSubmit:"#save",
		tipSweep:true,
		tiptype:1,
		/* tiptype:function(msg,o,cssctl){
			o.obj.attr("ok","ok");
			alert(msg+"___"+o.obj+"______"+o.type+"___"+o.conform);
			
		    //msg：提示信息;
		    //o:{obj:*,type:*,curform:*},
		    //obj指向的是当前验证的表单元素（或表单对象，验证全部验证通过，提交表单时o.obj为该表单对象），
		    //type指示提示的状态，值为1、2、3、4， 1：正在检测/提交数据，2：通过验证，3：验证失败，4：提示ignore状态, 
		    //curform为当前form对象;
		    //cssctl:内置的提示信息样式控制函数，该函数需传入两个参数：显示提示信息的对象 和 当前提示的状态（既形参o中的type）;
		}, */
		ajaxPost:true,
		beforeCheck:function(curform){
			//在表单提交执行验证之前执行的函数，curform参数是当前表单对象。
			//这里明确return false的话将不会继续执行验证操作;	
		},
		beforeSubmit:function(curform){
			//在验证成功后，表单提交前执行的函数，curform参数是当前表单对象。
			//这里明确return false的话表单将不会提交;
			
			index = layer.load(1, {
			    shade: [0.1,'#fff'] //0.1透明度的白色背景
			});
		},
		callback:function(data){
			layer.close(index);
				if(data.status=="y"){
					setTimeout(function(){
						$.Showmsg(data.msg);
						$.Hidemsg(); //公用方法关闭信息提示框;显示方法是$.Showmsg("message goes here.");
					},2000);
				}else{
					$.Showmsg(data.msg);
				}
			//返回数据data是json对象，{"info":"demo info","status":"y"}
			//info: 输出提示信息;
			//status: 返回提交数据的状态,是否提交成功。如可以用"y"表示提交成功，"n"表示提交失败，在ajax_post.php文件返回数据里自定字符，主要用在callback函数里根据该值执行相应的回调操作;
			//你也可以在ajax_post.php文件返回更多信息在这里获取，进行相应操作；
			//ajax遇到服务端错误时也会执行回调，这时的data是{ status:**, statusText:**, readyState:**, responseText:** }；
	 
			//这里执行回调操作;
			//注意：如果不是ajax方式提交表单，传入callback，这时data参数是当前表单对象，回调函数会在表单验证全部通过后执行，然后判断是否提交表单，如果callback里明确return false，则表单不会提交，如果return true或没有return，则会提交表单。
		}
	});
})
</script>
</html>