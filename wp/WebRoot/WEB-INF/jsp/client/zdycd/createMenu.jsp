<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	 String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/"; 
			//String basePath ="http://1.sunpeng.sinaapp.com:80";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta charset="utf-8">
	<title>创建菜单</title>
	<meta name="viewport"
		content="initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
		<meta name="apple-mobile-web-app-capable" content="yes">
			<meta name="apple-mobile-web-app-status-bar-style" content="black">
				<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
				<script src="${ctx}/skin/zdycd/js/bootstrap.js"></script>
				<script src="${ctx}/skin/zdycd/js/ratchet.js"></script>
				<script src="${ctx}/skin/zdycd/js/bootstrap.min.js"></script>
				<link href="${ctx}/skin/zdycd/css/bootstrap.css" rel="stylesheet"
					media="screen">
				<link href="${ctx}/skin/zdycd/css/ratchet.css" rel="stylesheet"/>
    <script type="javascript">
    </script>
</head>
<body>
<!-- Make sure all your bars are the first things in your <body> -->
<header class="bar bar-nav">
    <h1 class="title">自定义菜单管理</h1>

</header>
<!-- Wrap all non-bar HTML in the .content div (this is actually what scrolls) -->
<div class="content">
    <form class="input-group" action="<%=basePath%>menu/createMenu.html">
        <div class="input-row">
            <label>主菜单一</label>
            <input type="text" placeholder="write name" name="menu1">
        </div>
        <div class="input-row">
            <label>主菜单二</label>
            <input type="text" placeholder="write name" name="menu2">
        </div>
        <div class="input-row">
            <label>主菜单三</label>
            <input type="text" placeholder="write name" name="menu3">
        </div>
        <button type="submit" class="btn btn-primary btn-block"">生成自定义菜单</button>
    </form>
</div>

</body>
</html>