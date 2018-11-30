<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html> 
<html>
	<head>
		<title>用户注册</title>
		
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
		
		<link rel="stylesheet" href="${ctx}/skin/register/css/demo.css">
		<link rel="stylesheet" href="${ctx}/skin/register/css/sky-forms.css">
		<!--[if lt IE 9]>
			<link rel="stylesheet" href="css/sky-forms-ie8.css">
		<![endif]-->
		
		<script src="${ctx}/skin/register/js/jquery-1.9.1.min.js"></script>
		<script src="${ctx}/skin/register/js/jquery.validate.min.js"></script>
		<!--[if lt IE 10]>
			<script src="js/jquery.placeholder.min.js"></script>
		<![endif]-->		
		<!--[if lt IE 9]>
			<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
			<script src="js/sky-forms-ie8.js"></script>
		<![endif]-->
	</head>
	
	<body class="bg-cyan">
		<div class="body body-s">		
			<form id="registerForm" class="sky-form">
				<header>用户注册</header>
				
				<fieldset>					
					<section>
						<label class="input">
							<i class="icon-append icon-user"></i>
							<input type="text" name="USER_ID" placeholder="用户名">
							<b class="tooltip tooltip-bottom-right">请输入用户名</b>
						</label>
					</section>
					
					<section>
						<label class="input">
							<i class="icon-append icon-envelope-alt"></i>
							<input type="email" name="EMAIL" placeholder="Email">
							<b class="tooltip tooltip-bottom-right">请输入您的Email地址</b>
						</label>
					</section>
					
					<section>
						<label class="input">
							<i class="icon-append icon-lock"></i>
							<input type="password" name="PASSWORD" placeholder="密码" id="PASSWORD">
							<b class="tooltip tooltip-bottom-right">请输入您的密码</b>
						</label>
					</section>
					
					<section>
						<label class="input">
							<i class="icon-append icon-lock"></i>
							<input type="password" name="passwordConfirm" placeholder="请再次输入您的密码">
							<b class="tooltip tooltip-bottom-right">请再次输入您的密码</b>
						</label>
					</section>
				</fieldset>
					
				<fieldset>
					<div class="row">
						<section class="col col-6">
							<label class="input">
								<input type="text" name="EMP_NAME" placeholder="您的姓名">
							</label>
						</section>
						<section class="col col-6">
							<label class="input">
								<input type="text" name="MOBILE_NO" placeholder="手机号">
							</label>
						</section>
					</div>
					
					<section>
						<label class="select">
							<select name="GENDER">
								<option value="0" selected disabled>请选择性别</option>
								<option value="1">男性</option>
								<option value="2">女性</option>
					
							</select>
							<i></i>
						</label>
					</section>
					<!-- 
					<section>
						<label class="checkbox"><input type="checkbox" name="subscription" id="subscription"><i></i>I 
					我愿意接受代码笔记最新动态</label>
						<label class="checkbox"><input type="checkbox" name="terms" id="terms"><i></i>I 
					我同意注册许可</label>
					</section> -->
				</fieldset>
				<footer>
					<input onclick="loginbtn();" type="button" class="button"  value="返回登录" style="background-color: #2dd;"/>	
					<button type="submit" class="button">提交注册</button>
					
					
				</footer>
			</form>			
		</div>
		
		<script type="text/javascript">
		
		var chick = 0;
		function loginbtn(){
			window.top.location = '${ctx }/login.do';
		}
		
			$(function()
			{
				// 手机号码验证
				jQuery.validator.addMethod("isMobile", function(value, element) {
				    var length = value.length;
				    var mobile = /^(13[0-9]{9})|(18[0-9]{9})|(14[0-9]{9})|(17[0-9]{9})|(15[0-9]{9})$/;
				    return this.optional(element) || (length == 11 && mobile.test(value));
				}, "请填写您正确手机号");
				// Validation		
				$("#registerForm").validate(
				{					
					// Rules for form validation
					rules:
					{
						USER_ID:
						{
							required: true,
							minlength: 6,
							maxlength: 16
						},
						EMAIL:
						{
							required: true,
							email: true
						},
						PASSWORD:
						{
							required: true,
							minlength: 6,
							maxlength: 20
						},
						passwordConfirm:
						{
							required: true,
							minlength: 6,
							maxlength: 20,
							equalTo: '#PASSWORD'
						},
						EMP_NAME:
						{
							required: true,
							minlength: 2,
							maxlength: 8
						},
						GENDER:
						{
							required: true
						},
						MOBILE_NO : {
				            required : true,
				            minlength : 11,
				            // 自定义方法：校验手机号在数据库中是否存在
				            // checkPhoneExist : true,
				            isMobile : true
				        },
					},
					
					// Messages for form validation
					messages:
					{
						USER_ID:
						{
							required: '请填写用户名',
							minlength: "最少要输入6个字符",
							maxlength: "最多可以输入15个字符"
						},
						EMAIL:
						{
							required: '请填写邮箱地址',
							email: '请填写正确邮箱地址'
						},
						PASSWORD:
						{
							required: '请输入密码',
							minlength: "最少要输入6个字符",
							maxlength: "最多可以输入20个字符"
						},
						passwordConfirm:
						{
							required: '请再输入一次密码',
							equalTo: '请输入相同密码',
							minlength: "最少要输入6个字符",
							maxlength: "最多可以输入20个字符"
						},
						EMP_NAME:
						{
							required: '请输入您的姓名',
							minlength: "最少要输入2个字符",
							maxlength: "最多可以输入8个字符"
						},
						GENDER:
						{
							required: '请选择您的性别'
						},
						MOBILE_NO : {
				            required : "请输入手机号",
				            minlength : "确认手机不能小于11个字符",
				            isMobile : "请正确填写您的手机号码"
				        },
					},					
					
					// Do not change code below
					errorPlacement: function(error, element)
					{
						error.insertAfter(element.parent());
					},
					submitHandler: function() {
						
						/* if(chick == 0){
							chick++;
							$.ajax({
								url : "${ctx}/registerCheck.do",
								type : "post",
								data : $("#registerForm").serialize(),
								dataType : "json",
								success : function(data) {
									//var ret = jQuery.parseJSON(data);
									if(data.flag){
										alert("注册成功，将自动跳转到登陆页面！");
										window.top.location = '${ctx }/login.do';
									}else{
										alert(data.msg);
										chick = 0;
									}
								
								}
							}); 
							
						} */
						
					}
				});
			});			
		</script>
	</body>
</html>