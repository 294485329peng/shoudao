<%@ page language="java" import="java.util.*,org.apache.log4j.Logger"
	pageEncoding="utf8"%>
<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Not Found!</title>
<link href="${ctx}/skin/skinExample/css/style.css" rel="stylesheet" type="text/css" />
<script language="javascript">
	$(function(){
    $('.error').css({'position':'absolute','left':($(window).width()-490)/2});
	$(window).resize(function(){  
    $('.error').css({'position':'absolute','left':($(window).width()-490)/2});
    })  
});  
</script> 
</head>
<body style="background:#edf6fa;">

    
    <div class="error">
    
    <h2>非常遗憾，您访问的页面不存在！</h2>
    <p>看到这个提示，就自认倒霉吧!</p>
    
    </div>

</body>
</html>