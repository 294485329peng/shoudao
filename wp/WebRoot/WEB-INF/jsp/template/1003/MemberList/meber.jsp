<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>宣传页</title>
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

<body class="body_color">
<div class="mall_main">
<header class="bar bar-nav h-bar">
    <a href="javascript:history.back(-1)" class="icon icon-left-nav pull-left"></a>
    <h1 class="title">会员列表</h1>
</header>
<div class="content">
    <div class="card">
        <ul class="table-view">
            <li class="table-view-cell">卡号：</li>
            <li class="table-view-cell">昵称：</li>
            <li class="table-view-cell">资金：</li>
            <li class="table-view-cell">积分：</li>
        </ul>
    </div>
    <div>
        <button class="btn btn-positive" style="width: 30%;margin-left: 5%">充值</button>
        <button class="btn btn-positive" style="width: 30%">消费</button>
        <button class="btn btn-positive" style="width: 30%">消费记录</button>
    </div>
</div>
     <!--↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓导航开始↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓-->
  <c:if test="${record.IS_NAV=='1'}">
  <!--↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓导航开始↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓-->
  <%@ include file="../common/tinyNavBottom.jsp"%>
  <!--↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑导航end↑↑↑↑↑↑↑↑↑↑↑↑↑↑-->
</c:if>
  <!--↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑导航end↑↑↑↑↑↑↑↑↑↑↑↑↑↑-->
</div>
<script src="${ctx }/skin/tinyWebsite/js/swipe2.js" type="text/javascript"></script>
</body>
</html>