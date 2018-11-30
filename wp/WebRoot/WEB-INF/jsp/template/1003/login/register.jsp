<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>会员注册</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
<!-- Mobile Devices Support @begin -->
<meta content="application/xhtml+xml;charset=UTF-8" http-equiv="Content-Type">
<meta content="no-cache,must-revalidate" http-equiv="Cache-Control">
<meta content="no-cache" http-equiv="pragma">
<meta content="0" http-equiv="expires">
<meta content="telephone=no, address=no" name="format-detection">
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta name="apple-mobile-web-app-capable" content="yes" />
<!-- apple devices fullscreen -->
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
<!-- Mobile Devices Support @end -->

<link rel="stylesheet" type="text/css" href="${ctx }/skin/tinyWebsite/login/css/style.css">
 <script type="text/javascript" src="${ctx }/skin/tinyWebsite/js/jquery-2.0.3.min.js"></script> 
<!--form 验证 -->
<script type="text/javascript" src="${ctx}/component/layer/layer.js"></script>
<script type="text/javascript" src="${ctx}/component/layer/extend/layer.ext.js"></script>
<script type="text/javascript" src="${ctx }/Validform/js/Validform_v5.3.2.js"></script>
<link rel="stylesheet" href="${ctx }/Validform/css/style.css" />
<!--end  -->
</head>
<body>

<div class="register-container" style="margin-bottom: 20px;">
	<h1>注&nbsp;&nbsp;册</h1>
	
	<!-- <div class="connect">
		<p>Link the world. Share to world.</p>
	</div> -->
	
	<form action="${ctx }/TWebLogin/Member/addMember.htmls" method="post" id="registerForm" class="registerform">
		<div>
			<input type="text" name="LOGIN_NAME" class="username" placeholder="账号" autocomplete="off" datatype="*6-16" errormsg="账户范围在6~16位之间！" nullmsg="请填写账户！"/>
		</div>
		<div>
			<input type="password" name="LOGIN_PASSWORD" class="password" placeholder="输入密码" datatype="*6-16" errormsg="密码范围在6~16位之间！" nullmsg="请填写密码！" />
		</div>
		<div>
			<input type="password" name="confirm_password" class="confirm_password" placeholder="再次输入密码" errormsg="您两次输入的账号密码不一致！" nullmsg="请再输入一次密码！" recheck="LOGIN_PASSWORD" datatype="*" tip="test" name="userpassword2"/>
		</div>
		<div>
			<input type="text" name="NICKNAME" class="username" placeholder="您的姓名" autocomplete="off" datatype="*2-6" errormsg="姓名范围在2~6位之间！" nullmsg="请填写姓名！"/>
		</div>
		<div>
			<input type="text" name="CITY" class="username" placeholder="所在城市" autocomplete="off" datatype="*2-10" errormsg="城市在2~10范围内！" nullmsg="请填写城市！"/>
		</div>
		<div>
			<input type="text" name="PHONE" class="phone_number" placeholder="输入手机号码" autocomplete="off" id="number" datatype="m" errormsg="请填写正确格式手机号！" nullmsg="请填写手机号！"/>
		</div>
		<!-- <div>
			<input type="email" name="email" class="email" placeholder="输入邮箱地址" datatype="e" errormsg="请填写正确邮箱格式" nullmsg="请填写邮箱！" />
		</div> -->

		<button id="submit" type="submit">注 册</button>
	</form>
	<a >
		<button onclick="login();" type="button" class="register-tis">已经有账号？</button>
	</a>

</div>

</body>
<script type="text/javascript">
var index;
/*通用验证框架  */
$("body").append("<!--验证的遮蔽层  -->"  
		+"<div id=\"mask\" class=\"mask\"></div>"
		+"<!-- end -->");
$(function(){
	//$(".registerform").Validform();  //就这一行代码！;
	$(".registerform:eq(0)").Validform({
		btnSubmit:"#submit",
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
			/* $.ajax({
				url : $("#orderForm").attr("action"),
				type : "post",
				data : $("#orderForm").serialize(),
				dataType : "json",
				success : function(data) {
					//var ret = jQuery.parseJSON(data);
					
					alert(data.msg);
					if (data.flag) {
						
					}
				}
			}); */
			index = layer.load(1, {
			    shade: [0.1,'#fff'] //0.1透明度的白色背景
			});
		},
		callback:function(data){
			layer.close(index);
				if(data.status=="y"){
					setTimeout(function(){
						$.Showmsg(data.msg);
						//alert(data.obj.url);
						window.location="${ctx}"+data.obj.url;
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
function login(){
	window.location="${ctx}/TWebLogin/Member/login.htmls";
}
</script>
</html>