<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Easy-Demo</title>

<link rel="stylesheet" href="${ctx }/skin/form/css/style.css">

<script type="text/javascript" src="${ctx }/skin/form/js/jquery-2.1.0.min.js"></script>
<script type="text/javascript" src="${ctx }/skin/form/js/easyform.js"></script>

</head>
<body>

<div class="form-div">
    <form id="reg-form" action="" method="post">

        <table>
            <tr>
                <td>用户名</td>
                <td><input name="uid" type="text" id="uid" easyform="length:4-16;char-normal;real-time;" message="用户名必须为4—16位的英文字母或数字" easytip="disappear:lost-focus;theme:blue;" ajax-message="用户名已存在!">
                </td>
            </tr>
            <tr>
                <td>密码</td>
                <td><input name="psw1" type="password" id="psw1" easyform="length:6-16;" message="密码必须为6—16位" easytip="disappear:lost-focus;theme:blue;"></td>
            </tr>
            <tr>
                <td>确认密码</td>
                <td><input name="psw2" type="password" id="psw2" easyform="length:6-16;equal:#psw1;" message="两次密码输入要一致" easytip="disappear:lost-focus;theme:blue;"></td>
            </tr>
            <tr>
                <td>email</td>
                <td><input name="email" type="text" id="email" easyform="email;real-time;" message="Email格式要正确" easytip="disappear:lost-focus;theme:blue;" ajax-message="这个Email地址已经被注册过，请换一个吧!"></td>
            </tr>
            <tr>
                <td>昵称</td>
                <td><input name="nickname" type="text" id="nickname" easyform="length:2-16" message="昵称必须为2—16位" easytip="disappear:lost-focus;theme:blue;"></td>
            </tr>            
        </table>

		<div class="buttons">
			<input value="注 册" type="submit" style="margin-right:20px; margin-top:20px;">
			<input value="我有账号，我要登录" type="button" style="margin-right:45px; margin-top:20px;">
        </div>
		
        <br class="clear">
    </form>
</div>

<script type="text/javascript">
$(document).ready(function(){
	$('#reg-form').easyform();
});
</script>

</body>
</html>