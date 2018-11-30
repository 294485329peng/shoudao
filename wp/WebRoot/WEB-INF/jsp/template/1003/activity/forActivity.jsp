<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>活动详情</title>
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
    <!-- ratchet -->
    <link rel="stylesheet" type="text/css" href="${ctx }/skin/common/css/ratchet.min.css" >
    <!--end  -->
    <script type="text/javascript" src="${ctx }/skin/tinyWebsite/js/jquery-2.0.3.min.js"></script>
    <script type="text/javascript" src="${ctx }/skin/tinyWebsite/js/jquery.Spinner.js"></script>
	<style>
        .title{
            color:#3D4245;
            background: #F9F9F9;
        }
    </style>
</head>
<body style="position: relative;">
<!-- <body class="body_color"> -->
<div class="mall_main">
<header class="bar bar-nav h-bar">
	<a href="javascript:history.back(-1)" class="icon icon-left-nav pull-left"></a>
    <h1 class="title">${record.TITLE}</h1>
</header>
  <%--   <div id="child_header">
        <div class="goback"><a href="javascript:history.back(-1)"><i></i></a></div>
        <div class="current_location"><span>${record.PRO_TITLE}</span></div>
    </div> --%>
	<!-- <div class="content" > -->
	<div style="margin-top: 44px;"> 
	<div>${record.CONTENT}</div>
	</div>
  <!--↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓导航开始↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓-->
  <%@ include file="../common/tinyNavBottom.jsp"%>
  <!--↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑导航end↑↑↑↑↑↑↑↑↑↑↑↑↑↑-->
</div>
</body>
</html>