<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>会员信息</title>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
<!-- Mobile Devices Support @begin -->
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
<!-- apple devices fullscreen -->
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
<!-- Mobile Devices Support @end -->
<link rel="stylesheet" type="text/css" href="${ctx }/skin/tinyWebsite/css/style.css" />
<link rel="stylesheet" type="text/css" href="${ctx }/skin/tinyWebsite/css/DHstyle.css" />
<link rel="stylesheet" type="text/css" href="${ctx }/skin/tinyWebsite/css/finishOrder.css" />

<script type="text/javascript" src="${ctx }/skin/tinyWebsite/js/jquery-2.0.3.min.js"></script>
<!--form 验证 -->
<script type="text/javascript" src="${ctx}/component/layer/layer.js"></script>
<script type="text/javascript" src="${ctx}/component/layer/extend/layer.ext.js"></script>
<script type="text/javascript" src="${ctx }/Validform/js/Validform_v5.3.2.js"></script>
<link rel="stylesheet" href="${ctx }/Validform/css/style.css" />
<!--end  -->
<!-- wechatUI -->
<link rel="stylesheet" type="text/css" href="${ctx }/skin/common/css/weui.min.css" >
<!--end  -->
<!-- ratchet -->
<link rel="stylesheet" type="text/css" href="${ctx }/skin/common/css/ratchet.min.css" >

<script type="text/javascript">
</script>
	<style>
        .title{
            color:#3D4245;
            background: #F9F9F9;
        }
    </style>
</head>
<body>
<header class="bar bar-nav h-bar">
    <a href="javascript:history.back(-1)" class="icon icon-left-nav pull-left" style="width: auto;height: auto"></a>
    <h1 class="title">会员详情</h1>
</header>
<div class="content" style="padding-top: 44px;width:auto;">
<form action="${ctx}/TWebLogin/Member/updateMemberInfo.htmls" class="input-group registerform" style="width: 100%">
    <div class="input-row">
        <label style="width:32%;">昵称：</label>
        <input  name="NICKNAME" type="text" value="${record.NICKNAME}" style="width:68%;" datatype="s1-10" nullmsg="请填写昵称！" errormsg="昵称最多10个字！">
    </div>
    <div class="input-row">
        <label style="width:32%;">手机：</label>
        <input name="PHONE" type="text" value="${record.PHONE}" style="width:68%;" datatype="m" nullmsg="请填写手机！" errormsg="请填写正确手机号！">
    </div>
    <div class="input-row">
        <label style="width:32%;">地区：</label>
        <input name="CITY" type="text" value="${record.COUNTRY}${record.PROVINCE}${record.CITY}" style="width:68%;" datatype="s1-10" nullmsg="请填写地区！" errormsg="地区最多10个字！">
    </div>

    <div class="input-row">
        <label style="width:32%;">积分：</label>
        <input type="text" placeholder="${empty record.POINT ? '0' : record.POINT}" disabled style="width:68%;">
    </div>
    <div class="input-row">
        <label style="width:32%;">余额：</label>
        <input type="text" placeholder="${empty record.MONEY ? '0.00' : record.MONEY}" disabled style="width:68%;">
    </div>

  <div style="margin-top: 10px;">
      <button type="button" id="saveInfo" class="btn btn-primary" style="width: 40%;margin-left:5%;font-size: 14px;">保存</button>
      <button type="button" onclick="updatePassWord();" class="btn btn-positive" style="width: 40%;float: right;margin-right: 5%;font-size: 14px;">修改密码</button>
  </div>
  </form>
 </div>
<!--body--> 
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
		btnSubmit:"#saveInfo",
		tipSweep:true,
		tiptype:1,
		ajaxPost:true,
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