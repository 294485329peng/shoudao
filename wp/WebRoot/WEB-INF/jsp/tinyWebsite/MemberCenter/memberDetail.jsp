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
<!-- ratchet -->
<link rel="stylesheet" type="text/css" href="${ctx }/skin/common/css/ratchet.min.css" >
<script type="text/javascript" src="${ctx }/skin/tinyWebsite/js/jquery-2.0.3.min.js"></script>
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
    <a href="javascript:history.back(-1)" class="icon icon-left-nav pull-left"></a>
    <h1 class="title">会员信息</h1>
</header>
<div style="padding-top: 44px;">
<ul class="table-view">
    <!-- <li class="table-view-cell" style="font-size:14px">头像:</li> -->
    <li class="table-view-cell" style="font-size:14px">昵称：${record.NICKNAME}</li>
    <c:if test="${record.SEX=='1'}">
    <li class="table-view-cell" style="font-size:14px">性别：男</li>
    </c:if>
    <c:if test="${record.SEX=='2'}">
    <li class="table-view-cell" style="font-size:14px">性别：女</li>
    </c:if>
    <li class="table-view-cell" style="font-size:14px">手机：${record.PHONE}</li>
    <li class="table-view-cell" style="font-size:14px">地区：${record.COUNTRY}${record.PROVINCE}${record.CITY}</li>
    <li class="table-view-cell" style="font-size:14px">积分：${empty record.POINT ? '0' : record.POINT}</li>
    <li class="table-view-cell" style="font-size:14px">余额：${empty record.MONEY ? '0.00' : record.MONEY}</li>
</ul>
</div>
<!--body--> 
<!--↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓导航开始↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓-->
  <%@ include file="../common/tinyNavBottom.jsp"%>
  <!--↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑导航end↑↑↑↑↑↑↑↑↑↑↑↑↑↑-->
</body>
</html>