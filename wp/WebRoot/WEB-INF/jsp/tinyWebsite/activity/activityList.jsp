<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>活动列表</title>
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
<link rel="stylesheet" type="text/css" href="${ctx }/skin/tinyWebsite/css/DHstyle.css" />
<link rel="stylesheet" type="text/css" href="${ctx }/skin/tinyWebsite/FortAwesome/docs/assets/css/font-awesome.css">
<link rel="stylesheet" type="text/css" href="${ctx }/skin/tinyWebsite/css/style.css" />
<script type="text/javascript" src="${ctx }/skin/tinyWebsite/js/jquery-2.0.3.min.js"></script>
<script type="text/javascript">
   var _global = {};
	   _global.spm = {};
	   
document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {WeixinJSBridge.call('hideToolbar');});
function goActivity(RESPONSE,ACTIVITY_ID,RESPONSE_ID){
	if("1" == RESPONSE){
		window.location="${ctx}/TWeb/goods/goodsDetail.htmls?GOODS_ID="+RESPONSE_ID;
	}else if("2" == RESPONSE){
		window.location="${ctx}/TWeb/act/forActivity.htmls?ACTIVITY_ID="+ACTIVITY_ID;
	}
}
</script>
</head>

<body>
<div class="body">
<h3 class="fn-tit"  style="padding-bottom: 0px;background-color: #ffc275;padding-bottom: 5px;padding-top: 5px;"><a href="javascript:history.go(-1);" class="nback">返回</a><b class="tit">活动</b></h3>
  <div class="gb-contain" style="padding-top: 0px;">
    <!-- <div class="gb-intro">
      <h3 class="tit"><a href="groupbuy-content.html">双人餐！体验云南的异乡风情，带给你时尚的用餐体验</a></h3>
      <div class="gb-con"><a class="gb-img " href="#"><img class="img" src="images/gbimg.jpg" alt="菜品图片"></a>
        <p class="clearfix price-btn"><span class="floatl"><em class="gbprice">¥78</em> / <em class="yprice">¥120</em></span><a href="groupbuy-content.html" class="orange-btn floatr">立即抢购</a></p>
        <p class="clearfix gb-num-time"><span class="gmnum floatl"><i></i>购买人数：104人</span><span class="endtime floatr"><i></i>距离结束：3天</span></p>
        <em class="lt ltred">特色<br>
        推荐</em> </div>
      gb-con
      <p class="more"><a href="groupbuy-content.html">点击进入详情页></a></p>
    </div> -->
    <!--gb-intro-->
    <ul class="gb-list">
    <c:forEach var="r" items="${pageView.records}" varStatus="status">
      <li>
        <h3 class="tit" style="white-space: nowrap;overflow: hidden;text-overflow: ellipsis;"><a href="groupbuy-content.html">${r.TITLE }</a></h3>
        <div class="gbl-intro clearfix" style=";"> <a href="groupbuy-content.html" class="gbl-img  floatl"><img style="width: 110px;height:110px;" class="img" src="${r.PIC_URL }" alt="图片"></a>
          <div class="gbl-con floatl" >
          <c:if test="${r.RESPONSE == '1'}">
          <p class="price" style="padding-bottom: 0px; padding-top: 0px;"><em class="gbprice" style="font-size: 130%;">¥${r.SHOW_PRICE}</em></p>
          <p style="word-break:break-all;min-height:40px"><span style="padding-left: 0px;" >${fn:substring(r.DESCRIPTION,0,20)}<c:if test="${fn:length(r.DESCRIPTION)>25 }">...</c:if></span></p>
          </c:if>
          <c:if test="${r.RESPONSE == '2'}">
          <p style="word-break:break-all;min-height:67px"><span  style="padding-left: 0px;">${fn:substring(r.DESCRIPTION,0,25)}<c:if test="${fn:length(r.DESCRIPTION)>25 }">...</c:if></span></p>
          </c:if>
            <!-- <p class="price"><em class="gbprice">¥78</em> / <em class="yprice">¥120</em></p> -->
            
            <p class="btn" style="bottom:0px;float:right;"><a onclick="goActivity('${r.RESPONSE}','${r.ACTIVITY_ID}','${r.RESPONSE_ID}');" class="orange-btn">查看详情</a></p>
          </div>
          
          <!--gbl-con--> 
        </div>
      </li>
      </c:forEach>
      <!-- <li>
        <h3 class="tit"><a href="groupbuy-content.html">斑鱼火锅3人餐，多店通用</a></h3>
        <div class="gbl-intro clearfix"> <a href="#" class="gbl-img  floatl"><img class="img" src="images/tgimg1.jpg" alt="菜品图片"></a>
          <div class="gbl-con floatl">
            <p class="price"><em class="gbprice">¥78</em> / <em class="yprice">¥120</em></p>
            <p><span class="gmnum"><i></i>购买人数：104人</span></p>
            <p><span class="endtime"><i></i>距离结束：3天</span></p>
            <p class="btn"><a href="#" class="orange-btn">立即抢购</a></p>
          </div>
          gbl-con 
        </div>
      </li> -->
    </ul>
  </div>
  <!--gb-contain--> 

</div>
<!--body--> 
 <!--↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓导航开始↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓-->
  <%@ include file="../common/tinyNavBottom.jsp"%>
  <!--↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑导航end↑↑↑↑↑↑↑↑↑↑↑↑↑↑-->
<script type="text/javascript" src="js/wap.min.js"></script>
</body>
</html>