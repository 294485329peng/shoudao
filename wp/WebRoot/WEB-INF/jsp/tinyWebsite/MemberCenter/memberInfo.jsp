<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>会员中心</title>
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
<!-- wechatUI -->
<link rel="stylesheet" type="text/css" href="${ctx }/skin/common/css/weui.min.css" >
<!--end  -->
<link rel="stylesheet" type="text/css" href="${ctx }/skin/tinyWebsite/css/DHstyle.css" />
<link rel="stylesheet" type="text/css" href="${ctx }/skin/tinyWebsite/FortAwesome/docs/assets/css/font-awesome.css">
<link rel="stylesheet" type="text/css" href="${ctx }/skin/tinyWebsite/css/style.css" />
<script type="text/javascript">
   var _global = {};
	   _global.spm = {};
	   
document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {WeixinJSBridge.call('hideToolbar');});
</script>
<script type="text/javascript" src="${ctx }/skin/tinyWebsite/js/jquery-2.0.3.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){	
$(".dci").click( function () { 
$(this).toggleClass("selected");
 }); 
});
function jumpToOrder(type){
		window.location.href="${ctx}/Center/MemberFinishOrder/List.htmls?type="+type;
}

</script>
</head>

<body>
<div class="body" style="padding-bottom: 55px;">
  <div class="mem-top clearfix">
  	<em class="floatl mem-img">
  	<c:if test="${empty record.HEADIMGURL}">
  	<img src="${ctx }/skin/tinyWebsite/images/head-img.jpg" width="100%" alt="头像">
  	</c:if>
  	<c:if test="${! empty record.HEADIMGURL}">
  	<img src="${record.HEADIMGURL}" width="100%" alt="头像">
  	</c:if>
  	
  	</em>
    <div class="mem-intro floatr">
    	<p><b>${record.NICKNAME}</b></p>
        <p style="margin-top: 6px;">账户余额：<strong>${empty record.MONEY ? '0.00' : record.MONEY}&nbsp;元</strong></p>
        <p style="margin-top: 6px;" ><a href="card.html">我的VIP会员卡</a></p>
        <!-- <p>会员卡号：</p> -->
        <!-- <p><a href="card.html">我的VIP会员卡</a>，我还不是VIP，<br /><a href="register.html">申请成为VIP</a></p> -->
    </div><!--mem-intro-->    
  </div><!--mem-top-->
  <dl class="mem-orderlist mem">
  	<dt>订单</dt>
    <dd>
    	<p><a onclick="jumpToOrder('1')" class="clearfix"><span class="floatl"><i class="icon-pencil"></i>全部</span><em class="floatr"><i class="icon-chevron-right"></i></em></a></p>
        <p><a onclick="jumpToOrder('3')" class="clearfix"><span class="floatl"><i class="icon-check"></i>已成交</span><em class="floatr"><i class="icon-chevron-right"></i></em></a></p>
        <p><a onclick="jumpToOrder('2')" class="clearfix"><span class="floatl"><i class="icon-check-empty"></i>未成交</span><em class="floatr"><!-- 0 --><i class="icon-chevron-right"></i></em></a></p>
    </dd>
  </dl>
  <dl class="mem-score mem">
  	<dt>会员积分</dt>
    <dd>
    	<p><a href="#"  class="clearfix"><span class="floatl"><i class="icon-money"></i>现有积分：<b class="orange">${empty record.POINT ? '0' : record.POINT}</b></span><em class="floatr"><!-- 积分记录<i class="icon-chevron-right"></i> --></em></a></p>
        <p><a onclick="jumpToActivity()" class="clearfix"><span class="floatl"><i class="icon-gift"></i>积分活动</span><em class="floatr"><i class="icon-chevron-right"></i></em></a></p>
        <p><a onclick="jumpToActRule()" class="clearfix"><span class="floatl"><i class="icon-book"></i>积分规则</span><em class="floatr"><i class="icon-chevron-right"></i></em></a></p>
    </dd>
  </dl>
  <dl class="mem-set mem">
  	<dt>账户信息</dt>
    <dd>
    	<p><a onclick="memberDetail();" class="clearfix"><span class="floatl"><i class="icon-user"></i>${record.NICKNAME}</span><em class="floatr">查看<i class="icon-chevron-right"></i></em></a></p>
        <!-- <p><a href="xiugaimima.html" class="clearfix"><span class="floatl"><i class="icon-edit"></i>修改密码</span><em class="floatr">0<i class="icon-chevron-right"></i></em></a></p>  -->       
    </dd>
  </dl>
  
</div>
<!--↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓导航开始↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓-->
  <%@ include file="../common/tinyNavBottom.jsp"%>
  <!--↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑导航end↑↑↑↑↑↑↑↑↑↑↑↑↑↑-->
<!--body--> 
<div class="weui_dialog_alert" style="display: none;">
    <div class="weui_mask"></div>
    <div class="weui_dialog">
        <div class="weui_dialog_hd"><strong class="weui_dialog_title">温馨提示</strong></div>
        <div class="weui_dialog_bd">弹窗内容，告知当前页面信息等</div>
        <div class="weui_dialog_ft">
            <a onclick="suer();" class="weui_btn_dialog primary">确定</a>
        </div>
    </div>
</div>
<!-- <script type="text/javascript" src="js/wap.min.js"></script> -->
</body>
<script type="text/javascript">
/*关闭微信ui  */
function suer(){
	$(".weui_dialog_alert").attr("style", "display:none");
}
function memberDetail(){
	window.location.href="${ctx}/MemberCenter/memberDetail.htmls"
}
function jumpToActRule(){
	$(".weui_dialog_bd").html("积分所得根据产品所定！");
	$(".weui_dialog_alert").removeAttr("style");
}
function jumpToActivity(){
	$(".weui_dialog_bd").html("请参照商家活动中心的信息！");
	$(".weui_dialog_alert").removeAttr("style");
}
</script>
</html>