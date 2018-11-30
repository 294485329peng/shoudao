<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>欢迎登录系统</title>
<link href="${ctx}/skin/default/login/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/component/jQuery/jquery.min.js"></script>
<script src="${ctx}/skin/default/js/cloud.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/script/common/commonUtils.js" ></script>
<script language="javascript">

	
	$(function() {
		$('.loginbox').css({
			'position' : 'absolute',
			'left' : ($(window).width() - 692) / 2
		});
		$(window).resize(function() {
			$('.loginbox').css({
				'position' : 'absolute',
				'left' : ($(window).width() - 692) / 2
			});
		})
	});

	$(document).ready(function() {
		init();
		$("#loginbtn").submit();
		$("#loginbtn").click(function() {
			submitForm();
		});
		$("#registerbtn").click(function() {
			window.top.location = '${ctx }/register.do';
		});
	});
	var bikky = document.cookie;
	var today = new Date();
	var expiry = new Date(today.getTime() + 7 * 24 * 60 * 60 * 1000);
	function setCookie(name, value) {
		if (value != null && value != "")
			document.cookie = name + "=" + escape(value) + "; expires="
					+ expiry.toGMTString();
		bikky = document.cookie;
	}
	function getCookie(name) {
		var index = bikky.indexOf(name + "=");
		if (index == -1)
			return null;
		index = bikky.indexOf("=", index) + 1;
		var endstr = bikky.indexOf(";", index);
		if (endstr == -1)
			endstr = bikky.length;
		return unescape(bikky.substring(index, endstr));
	}
	function setall() {
		if ($("#remember").is(':checked')) {
			var userId = $("input[id='userId']").val();
			setCookie("userId", userId);
			var password = $("input[id='password']").val();
			setCookie("password", password);
		} else {
			document.cookie = "userId=" + escape(userId) + "; expires="
					+ today.toGMTString();
			document.cookie = "password=" + escape(password) + "; expires="
					+ today.toGMTString();
		}

	}
	function init() {
		var userId = getCookie("userId");
		if (userId != null && userId != "null") {
			$("input[id='userId']").val(userId);
		} else {
			$("#password").val("请输入用户名");
		}
		var password = getCookie("password");
		if (password != null && password != "null") {
			//IE不支持TYPE的变更，所以把控件中的type设成password
			//$("#password").attr('type', 'password');
			$("#password").val(password);
		} else {
			$("#password").val("");
		}
	}
	function submitForm() {
		var userId = $("input[id='userId']");
		if ($.trim(userId.val()) == "" || userId.val() == "请输入用户名") {
			alert("请输入用户名!");
			userId.focus();
			return;
		}
		var password = $("input[id='password']");
		if ($.trim(password.val()) == "" || password.attr('type') == "text") {
			alert("请输入密码!");
			password.focus();
			return;
		}
		setall();
		var url = "<%=request.getContextPath()%>"+"/loginCheck.do"; 
	//BaseUtils.showWaitMsg();
	$.ajax({
		type: "post",
		async:true,
		global:false,
		url: url,
		dataType:"json",
		data:{"userId":$.trim(userId.val()),"password":$.trim(password.val())},
		success: function(data) {
			//BaseUtils.hideWaitMsg();
			
			/* var ret = jQuery.parseJSON(data); */
			if(data.flag){
				//BaseUtils.showWaitMsg();
				window.location.href="main.do";
			}else{
				alert(data.msg);
			}
		}
	});
}

$(document).keydown(function(e){ 
    var ev = document.all ? window.event : e;
    if(ev.keyCode==13) {
    	submitForm();
    }
});
</script>

</head>

<%-- <body style="background-color:#1c77ac; background-image:url(${ctx}/skin/default/images/light.png); background-repeat:no-repeat; background-position:center top; overflow:hidden;">
 --%>
 <body>
    <div id="login_bg" class ="login_bg" style="background-image:url(${ctx}/skin/default/login/images/u3.jpg);"></div>
    <div class="login_header">
    	<span></span>
    </div>
    
    <div class="container">
    	<div class="form_header">
        	<h1 id="logo">木槿</h1>
			<h2 id="subheading">微信公众平台</h2>
        </div>
        <div class="signup_forms" class="signup_forms">
            	<div id="signup_forms_container" class="signup_forms_container">
                    	<form class="signup_form_form" id="sign_form" method="post" action="">
                        	<div class="signup_account" id="signup_account">
                            	<div class="form_user">	
        							<input type="text" id="userId" placeholder="账户" class="signup_email">
                                </div>
                                <div class="form_password">
           							<input type="password" id="password" placeholder="密码" class="signup_password">
        						</div>
                            </div>
                            </div>
               					 <button type="button" class="signup_forms_submit" id="loginbtn"><span><strong>登录</strong></span></button>
            				</div>
                        </form> 
                  		   
    			</div>
    	</div>
    <!-- <div class="footer">
    	<div class="footer_signup_link">
        	<a class="signup_link" href="register.html">Sign up</a>
            <a href="https://www.baidu.com" target="_blank" class="link unnamed_1">Patent</a>
            <a href="#" target="_blank" class="link unnamed_2">About</a>
        </div>
        <div class="design_show">
        	<div class="designer_info">
            	<a href="#">Designed by Class 2 Software 11 <strong>Ray</strong></a>
                <a href="#" target="_blank" class="face"><img id="face" src="images/face.jpg" alt="designed by RayZhang"/></a>
            </div>
        </div>
    </div> -->
</body>

</html>
