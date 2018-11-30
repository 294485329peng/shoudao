<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>会员中心</title>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0"/>
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
<link rel="stylesheet" type="text/css" href="${ctx }/skin/tinyWebsite/memberCard/css/css.css" >
<!-- wechatUI -->
<link rel="stylesheet" type="text/css" href="${ctx }/skin/common/css/weui.min.css" >
<!--end  -->
<link rel="stylesheet" type="text/css" href="${ctx }/skin/tinyWebsite/css/DHstyle.css" />
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
<body style="background:#f0f0f0;">
<div class="content">
	<div class="ding">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td class="xia"><%-- <img src="${ctx }/skin/tinyWebsite/memberCard/img/xia.png" width="25" height="25"/> --%></td>
            <td class="huiyuan">我的会员卡</td>
            <td class="home"><%-- <img src="${ctx }/skin/tinyWebsite/memberCard/img/home.png" width="25" height="25"/> --%></td>
          </tr>
        </table>
    </div>
    <div class="huiyuanka" style="position: relative;">
    <img src="${cardPic.PIC_URL }" width="100%" height="auto"/>
    <%-- <img src="${ctx }/skin/tinyWebsite/memberCard/img/t1.png" width="100%" height="auto"/> --%>
    <!-- <div class="verify pdo">
    <span>卡号：</span>
    </div> -->
    </div>
    <div class="chushi">使用时向服务员出示此卡</div>
    <div class="kuang">
    	<div class="yue">
        	<div class="tubiao"><img src="${ctx }/skin/tinyWebsite/memberCard/img/ka.png" width="30" height="31"/></div>
            <div class="yueyue">卡号：${record.CARD_ID }</div>
            <%-- <a href="yue.html"><div class="jiantou"><img src="${ctx }/skin/tinyWebsite/memberCard/img/jian.png" width="30" height="31"/></div></a> --%>
        </div>
        <div style="width:100%; height:1px; background:#c2c2c2;"></div>
    	<div class="yue">
        	<div class="tubiao"><img src="${ctx }/skin/tinyWebsite/memberCard/img/b2.png" width="30" height="31"/></div>
            <div class="yueyue">余额：${empty record.MONEY ? '0.00' : record.MONEY}元</div>
            <%-- <a href="yue.html"><div class="jiantou"><img src="${ctx }/skin/tinyWebsite/memberCard/img/jian.png" width="30" height="31"/></div></a> --%>
        </div>
        <div style="width:100%; height:1px; background:#c2c2c2;"></div>
        <div class="jifen">
        <div class="yue">
        	<div class="tubiao"><img src="${ctx }/skin/tinyWebsite/memberCard/img/b1.png" width="30" height="31"/></div>
            <div class="yueyue">积分：${empty record.POINT ? '0' : record.POINT}分</div>
            <%-- <a href="jifen.html"><div class="jiantou"><img src="${ctx }/skin/tinyWebsite/memberCard/img/jian.png" width="30" height="31"/></div></a> --%>
        </div>
        </div>
    </div>
    <div class="kuang_1" style="height:auto;">
        <div class="yue">
                <div class="yue_1">会员卡特权</div>
                <div class="yue_2">查看特权信息</div>
                <a href="${ctx }/MemberCenter/tequan.htmls"><div class="jiantou"><img src="${ctx }/skin/tinyWebsite/memberCard/img/jian.png" width="30" height="31"/></div></a>
        </div>
        <div style="width:100%; height:1px; background:#c2c2c2;"></div>
        <div class="yue">
                <div class="yue_1">个人信息</div>
                <div class="yue_2">查看信息</div>
                <a onclick="memberDetail();""><div class="jiantou"><img src="${ctx }/skin/tinyWebsite/memberCard/img/jian.png" width="30" height="31"/></div></a>
        </div>
    </div>
    <div class="kuang_2">
    	<%-- <div class="yue">
            <div class="yue_1">我的订单</div>
            <a href="wodedingdan.html"><div class="jiantou"><img src="${ctx }/skin/tinyWebsite/memberCard/img/jian.png" width="30" height="31"/></div></a>
        </div> --%>
        <div style="width:100%; height:1px; background:#c2c2c2;"></div>
        <div class="jifen">
        <div class="yue">
            <div class="yue_1">消费记录</div>
            <a href="${ctx }/MemberCenter/xiaofeijilu.htmls"><div class="jiantou"><img src="${ctx }/skin/tinyWebsite/memberCard/img/jian.png" width="30" height="31"/></div></a>
        </div>
        </div>
        <%-- <div style="width:100%; height:1px; background:#c2c2c2;"></div>
        <div class="jifen">
        <div class="yue">
            <div class="yue_1">会员卡说明</div>
            <a href="shuoming.html"><div class="jiantou"><img src="${ctx }/skin/tinyWebsite/memberCard/img/jian.png" width="30" height="31"/></div></a>
        </div>
        </div> --%>
        <div style="width:100%; height:1px; background:#c2c2c2;"></div>
        <div class="jifen">
        <div class="yue">
            <div class="yue_1">门店电话及地址</div>
            <a href="${ctx }/MemberCenter/dianmian.htmls"><div class="jiantou"><img src="${ctx }/skin/tinyWebsite/memberCard/img/jian.png" width="30" height="31"/></div></a>
        </div>
        </div>
        <div style="width:100%; height:1px; background:#c2c2c2;"></div>
        <div class="jifen">
        <div class="yue">
            <div class="yue_1">退出登录</div>
            <a onclick="outLogin();"><div class="jiantou"><img src="${ctx }/skin/tinyWebsite/memberCard/img/jian.png" width="30" height="31"/></div></a>
        </div>
        </div>
    </div>
    <div style="clear:both"></div>
    <!-- <div class="foot"><a href=">技术支持：</a></div> -->
    <div style="width:100%; height:100px;"></div>
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
function outLogin(){
	$.ajax({
		url : "${ctx }/MemberCenter/outLogin.htmls",
		type : "post",
		data : {},
		dataType : "json",
		success : function(data) {
			window.location.href="${ctx}/TWeb/bs/home.htmls?store=${seTicket.gzhId}";

		}
	});
	
}
</script>
</html>