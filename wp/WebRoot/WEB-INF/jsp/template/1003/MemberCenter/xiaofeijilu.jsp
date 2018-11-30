<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>消费记录</title>
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
<!--tinyPage  -->
<link rel="stylesheet" type="text/css" href="${ctx }/skin/tinyPage/css/tinyPage.css" />
<!--  -->
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

<body style="background:#f0f0f0;">
<div class="content">
	<div class="ding">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td class="xia" style="line-height: 0px;"><div><img  onclick="javascript:history.go(-1);" src="${ctx }/skin/tinyWebsite/memberCard/img/xia.png" width="25" height="25"/></div></td>
            <td class="huiyuan">我的消费记录</td>
            <td class="home"><%-- <img src="${ctx }/skin/tinyWebsite/memberCard/img/home.png" width="25" height="25"/> --%></td>
          </tr>
        </table>
    </div>
    <div class="dingdan">消费记录</div>
    <form id="queryForm" action="${ctx }/MemberCenter/xiaofeijilu.htmls" method="post">
	</form>
    <ul>
    	<c:forEach var="r" items="${pageView.records}" varStatus="status">
        <li>
            <div class="kuang_1">
                <div class="yue" style="line-height: 18px">
                        <div class="yue_11" style="width:100%;">时间：${r.CREATE_TIME}</div>
                        <c:if test="${r.TYPE == 1 }">
                        	<div class="yue_2222" style="width:100%;margin-left: 10px;">
                        	<c:if test="${! empty r.MONEY}">充值:${r.MONEY }元 </c:if>
                        	<c:if test="${! empty r.POINT}">充值积分:${r.POINT }分</c:if>
                        	</div>
                        </c:if>
                        <c:if test="${r.TYPE == 2 }">
                        	<div class="yue_2222" style="width:100%;margin-left: 10px; color:red;">
                        	<c:if test="${! empty r.MONEY}">消费:${r.MONEY }元</c:if>
                        	<c:if test="${! empty r.POINT}">消费积分:${r.POINT }分</c:if>
                        	<c:if test="${! empty r.GET_POINT}">获得积分:${r.GET_POINT }分</c:if>
                        	</div>
                        </c:if>
                    </div>
            </div>
        </li>
        </c:forEach>
        
    </ul>
    <div style="clear:both"></div>
    <c:if test="${fn:length(pageView.records)>0}">
    <!--↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓分页开始↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓-->
	  <%@ include file="../common/tinyPage.jsp"%>
	  <!--↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑end↑↑↑↑↑↑↑↑↑↑↑↑↑↑-->
	  </c:if>
    <div style="width:100%; height:50px;"></div>
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