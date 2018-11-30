<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>会员登录</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">

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

<div class="login-container">
	<h1>管理员登录</h1>
	
	<div class="connect">
		<p></p>
	</div>
	
	<form action="${ctx }/TWebLogin/Member/loginCheck.htmls" class="registerform" method="post" id="loginForm ">
		<div>
			<input type="text" name="userId" class="username" placeholder="用户名" autocomplete="off" datatype="s6-16" nullmsg="请填写用户名！" errormsg="至少6个字符,最多16个字符！"/>
		</div>
		<div>
			<input type="password" name="password" class="password" placeholder="密码" datatype="s1-16" nullmsg="请填写密码！" errormsg="密码至少1位,最多16位！"/>
		</div>
		<button id="submit" type="submit">登 陆</button>
	</form>

	<!-- <a>
		<button type="button" onclick="register();" class="register-tis">还有没有账号？</button>
	</a> -->
	<!-- <a href="register.html">
		<button type="button" class="register-tis">继续浏览</button>
	</a> -->

</div>
<!-- <div class="footTitle">
	<p>部分网页无法继续浏览需用户登录。</p>
</div> -->

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
</script>
</html>