<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>已成交列表</title>
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
<link rel="stylesheet" type="text/css" href="${ctx }/skin/tinyWebsite/FortAwesome/docs/assets/css/font-awesome.css">
<link rel="stylesheet" type="text/css" href="${ctx }/skin/tinyWebsite/css/style.css" />
<link rel="stylesheet" type="text/css" href="${ctx }/skin/tinyWebsite/css/DHstyle.css" />
<link rel="stylesheet" type="text/css" href="${ctx }/skin/tinyWebsite/css/finishOrder.css" />

<!--tinyPage  -->
<link rel="stylesheet" type="text/css" href="${ctx }/skin/tinyPage/css/tinyPage.css" />
<!--  -->
<script type="text/javascript" src="${ctx }/skin/tinyWebsite/js/jquery-2.0.3.min.js"></script>
<script type="text/javascript">
function orderDetail(order_id){
	window.location.href="${ctx}/TWeb/order/orderDetail.htmls?id="+order_id;
}
</script>

</head>

<body>
<div>
<div class="body" style="padding-bottom: 50px;">
<c:if test="${record.type=='1'}">
<h3 class="fn-tit" style="padding-bottom: 0px; padding-top: 7px;"><a href="javascript:history.go(-1);" class="nback">返回</a><b class="tit">全部订单</b></h3>
</c:if>
<c:if test="${record.type=='2'}">
<h3 class="fn-tit" style="padding-bottom: 0px; padding-top: 7px;"><a href="javascript:history.go(-1);" class="nback">返回</a><b class="tit">未成交</b></h3>
</c:if>
<c:if test="${record.type=='3'}">
<h3 class="fn-tit" style="padding-bottom: 0px; padding-top: 7px;"><a href="javascript:history.go(-1);" class="nback">返回</a><b class="tit">已成交</b></h3>
</c:if>

<form id="queryForm" action="${ctx}/Center/MemberFinishOrder/List.htmls" method="post">
<input type="hidden" name="type" value="${record.type}" />
</form>
<%--   <div class="dingdanlist" style="margin-top: 7px;">
    <table>
      <tbody>
      <tr>
        <td width="65%" colspan="2">
          订单号：
          <strong>PO20150819111145</strong>
        </td>
        <td width="35%" align="right">
          <div class="qingqu">
            <a class="orange" href="javascript:;">订单取消</a>
          </div>
        </td>
      </tr>
      <tr>
        <td class="dingimg" width="15%">
          <img style="width: 45px; height: 45px;" src="${ctx }/skin/tinyWebsite/images/zf3.jpg">
        </td>
        <td width="50%">
          <h3>十七素材农庄有机瓢瓜400g</h3>
          <time>下单时间：2015-08-11 13:51</time>
        </td>
        <td align="right">
          <img class="ord_img " src="${ctx }/skin/tinyWebsite/images/jian-new.png">
        </td>
      </tr>
      <tr>
        <th colspan="3" class="th-text">
          <strong class="orange strong-text">¥36.60</strong>
        </th>
      </tr>
      </tbody>
    </table>
  </div> --%>
  <c:forEach var="map" items="${list}" varStatus="status">
  <div class="dingdanlist" style="margin-top: 7px;">
    <table>
      <tbody>
      <tr>
        <td colspan="3">
          订单号：
          <strong>${map.ORDER_ID}</strong>
          <div class="qingqu" style="float:right;">
            <a class="orange" href="javascript:;" onclick="orderDetail('${map.ORDER_ID}')">订单详情</a>
          </div>
          <time>下单时间:${map.CREATE_TIME}</time>
          <c:if test="${map.DEAL_TYPE=='10'}">
          <strong>下单状态:订单取消</strong>
          </c:if>
          <c:if test="${map.DEAL_TYPE=='3'}">
          <strong>下单状态:交易完成</strong>
          </c:if>
          <c:if test="${map.DEAL_TYPE=='1'}">
          <strong>下单状态:正在配货</strong>
          </c:if>
          <c:if test="${map.DEAL_TYPE=='0'}">
          <strong>下单状态:未处理</strong>
          </c:if>
          <c:if test="${map.DEAL_TYPE=='2'}">
          <strong>下单状态:已发货</strong>
          </c:if>
          <c:if test="${map.DEAL_TYPE=='20'}">
          <strong>下单状态:用户申请取消订单</strong>
          </c:if>
          <c:if test="${map.DEAL_TYPE=='21'}">
          <strong>下单状态:商家同意取消订单</strong>
          </c:if>
          <c:if test="${map.DEAL_TYPE=='22'}">
          <strong>下单状态:商家拒绝取消订单</strong>
          </c:if>
          <c:if test="${map.DEAL_TYPE=='30'}">
          <strong>下单状态:待填写配送信息</strong>
          </c:if>
        </td>
        <%-- <td align="right">
          <div class="qingqu">
            <a class="orange" href="javascript:;" onclick="orderDetail(${map.ORDER_ID})">订单详情</a>
          </div>
        </td> --%>
      </tr>
       <c:forEach var="list" items="${map.good}" varStatus="status">
      <tr>
        <td class="dingimg" width="22%">
          <img style="width: 45px; height: 45px;" src="${list.PIC_URL}">
        </td>
        <td width="55%">
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
        <th colspan="3" class="th-text">
          <strong class="orange strong-text">¥${map.TOTAL_PRICE}</strong>
        </th>
      </tr>
      </tbody>
    </table>
  </div>
</c:forEach>
	<c:if test="${fn:length(list)>0}">
  <!--↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓分页开始↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓-->
  <%@ include file="../common/tinyPage.jsp"%>
  <!--↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑end↑↑↑↑↑↑↑↑↑↑↑↑↑↑-->
  <div style="height: 15px;"></div>
  </c:if>
</div>
<!--body--> 
<!--↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓导航开始↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓-->
  <%@ include file="../common/tinyNavBottom.jsp"%>
  <!--↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑导航end↑↑↑↑↑↑↑↑↑↑↑↑↑↑-->
</div>
</body>
</html>