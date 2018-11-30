<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>订单详情</title>
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
<!-- wechatUI -->
<link rel="stylesheet" type="text/css" href="${ctx }/skin/common/css/weui.min.css" >
<!--end  -->
<script type="text/javascript" src="${ctx }/skin/tinyWebsite/js/jquery-2.0.3.min.js"></script>
<script type="text/javascript">
function writeInfo(ORDER_ID){
	window.location.href="${ctx}/TWeb/order/tinyOrderForm.htmls?ORDER_ID="+ORDER_ID;
}
function suer(){
	$(".weui_dialog_alert").attr("style", "display:none");
}
function cancelOrder(ORDER_ID){
	$.ajax({
		url : '${ctx}/TWeb/order/cancelOrder.htmls',
		type : "post",
		data : {"ORDER_ID":ORDER_ID},
		dataType : "json",
		success : function(data) {
			if(!data.flag){
				$(".weui_dialog_bd").html(data.msg);
				$(".weui_dialog_alert").removeAttr("style");
				return false;
			}else{
				$(".weui_dialog_bd").html(data.msg);
				$(".weui_dialog_alert").removeAttr("style");
				return false;
			}
			
		},error :function(data){
			$(".weui_dialog_bd").html("服务异常！");
			$(".weui_dialog_alert").removeAttr("style");
			return false;
		}
	});
}
function enterOrder(ORDER_ID){
	$.ajax({
		url : '${ctx}/TWeb/order/enterOrder.htmls',
		type : "post",
		data : {"ORDER_ID":ORDER_ID},
		dataType : "json",
		success : function(data) {
			if(!data.flag){
				$(".weui_dialog_bd").html(data.msg);
				$(".weui_dialog_alert").removeAttr("style");
				return false;
			}else{
				$(".weui_dialog_bd").html(data.msg);
				$(".weui_dialog_alert").removeAttr("style");
				return false;
			}
			
		},error :function(data){
			$(".weui_dialog_bd").html("服务异常！");
			$(".weui_dialog_alert").removeAttr("style");
			return false;
		}
	});
}

</script>
	<style>
        .title{
            color:#3D4245;
            background: #F9F9F9;
        }
    </style>
</head>
<body style="position: relative;">
<header class="bar bar-nav h-bar">
    <a href="javascript:history.back(-1)" class="icon icon-left-nav pull-left"></a>
    <h1 class="title">订单详情</h1>
</header>
<div>
<ul class="table-view" style="margin-top: 45px;">
    <li class="table-view-cell" style="font-size:14px;">订单编号：${good.ORDER_ID }</li>
    <li class="table-view-cell" style="font-size:14px;">
    	  <c:if test="${good.DEAL_TYPE=='10'}">下单状态：订单取消</c:if>
          <c:if test="${good.DEAL_TYPE=='3'}">下单状态：交易完成</c:if>
          <c:if test="${good.DEAL_TYPE=='1'}">下单状态：正在配货</c:if>
          <c:if test="${good.DEAL_TYPE=='0'}">下单状态：未处理</c:if>
          <c:if test="${good.DEAL_TYPE=='2'}">下单状态：已发货</c:if>
          <c:if test="${good.DEAL_TYPE=='30'}">下单状态：待填写配送信息</c:if>
    </li> 
    <li class="table-view-cell" style="font-size:14px;">创建时间：${good.CREATE_TIME }</li>
    <li class="table-view-cell" style="font-size:14px;">收&nbsp;&nbsp;件&nbsp;&nbsp;人：${good.CONSIGNEE }</li>
    <li class="table-view-cell" style="font-size:14px;">联系方式：${good.ADDRESS_PHONE }</li>
    <li class="table-view-cell" style="font-size:14px;">快递公司：${good.MAIL_COMPANY }</li>
    <li class="table-view-cell" style="font-size:14px;">快递单号：${good.MAIL_NUMBER }</li>
    
</ul>
</div>
<div  style="padding-bottom: 120px;">
  <div class="dingdanlist" style="margin-top: 7px;">
    <table>
      <tbody>
       <c:forEach var="list" items="${good.goodList}" varStatus="status">
      <tr>
        <td class="dingimg" width="20%">
          <img style="width: 45px; height: 45px;" src="${list.PIC_URL}">
        </td>
        <td width="50%">
          <h3>商品名称：${list.GOODS_NAME}</h3>
          <time>商品规格：${list.MAIN_SPECIFICATION}</time>
          <c:if test="${''!=list.CHILD_SPECIFICATION&&null!=list.CHILD_SPECIFICATION}">
          	<time>商品规格：${list.CHILD_SPECIFICATION}</time>
          </c:if>
        </td>
        <td align="right">
          <strong class="orange strong-text">¥${list.TOTAL_PRICE}</strong>
        </td>
      </tr>
      </c:forEach>
       <tr>
        <th colspan="3" class="th-text" style="font-size: 15px;">
                          总价：<strong class="orange strong-text" style="margin-right: 20px;font-size:">¥${good.TOTAL_PRICE}</strong>
                          积分：<strong class="orange strong-text" >${good.TOTAL_POINT}</strong>
        </th>
      </tr>
      </tbody>
    </table>
  </div>
</div>
<c:if test="${good.DEAL_TYPE!='3'}">
<div style="position:fixed;bottom:50px;right: 0px;z-index: 5;">
<div style="float: right;margin-right: 10px;">
    <button onclick="enterOrder('${good.ORDER_ID }');" class="btn btn-primary btn-block"style="padding:10px;font-size: 13px;">完成交易</button>
</div>
<c:if test="${good.DEAL_TYPE=='30'}">
<div style="float: right;margin-right: 15px">
    <button onclick="writeInfo('${good.ORDER_ID }');" class="btn btn-block" style="padding:10px;font-size: 13px;">填写信息</button>
</div>
</c:if>
<c:if test="${good.DEAL_TYPE=='0' }">
<div style="float: right;margin-right: 15px">
    <button onclick="writeInfo('${good.ORDER_ID }');" class="btn btn-block" style="padding:10px;font-size: 13px;">修改信息</button>
</div>
</c:if>

<div style="float: right;margin-right: 15px">
    <button onclick="cancelOrder('${good.ORDER_ID }')" class="btn btn-block" style="padding:10px;font-size: 13px;">取消订单</button>
</div>
</div>
</c:if>
<!--body--> 
<!--↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓导航开始↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓-->
  <%@ include file="../common/tinyNavBottom.jsp"%>
  <!--↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑导航end↑↑↑↑↑↑↑↑↑↑↑↑↑↑-->
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
</body>
</html>