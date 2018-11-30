<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="${ctx}/skin/skinExample/css/style.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/skin/UserInfo/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/skin/skinExample/js/jquery.js"></script>
<script type="text/javascript" src="${ctx}/skin/skinExample/js/jsapi.js"></script>
<script type="text/javascript" src="${ctx}/skin/skinExample/js/format+zh_CN,default,corechart.I.js"></script>		

<script type="text/javascript" src="${ctx}/skin/skinExample/js/jquery.ba-resize.min.js"></script>

</head>


<body>

	<div class="place">
    <span style="font-size:14px;">欢迎</span>
    
    </div>
    
    
    <div class="mainbox">
    
    <div class="mainleft">

    <div class="leftinfo">
    <div class="listtitle">用户信息</div>

    <div class="maintj" >
        <div class="span8" style="margin-bottom: 20px;">
		<dl class="dl-horizontal">
		<dt>
		<img class="img-rounded" style="width: 70px; height: 70px" src="${record.GZH_HEADER_IMG }">
		</dt>
		<dd style="margin-left: 85px;">
		<p style="font-size:16px;margin-top:10px;">
		<strong style="font-size:16px;">${record.GZH_NICK_NAME }</strong>
		<!-- <a style="color: #08c;text-decoration: none; font-size: 16px; margin-left: 20px;" data-toggle="modal" href="#upgradeModal">
		编辑
		</a> -->
		</p>
		<p style="font-size:16px;margin-top:25px;">
		<a href="/wechat/menuset?aid=55614007" style="color: #08c;
    text-decoration: none; font-size: 16px;">
		<i></i>
		<c:if test="${record.GZH_AUTH_TYPE == '10' }">未认证订阅号</c:if>
		<c:if test="${record.GZH_AUTH_TYPE == '11' }">认证订阅号</c:if>
		<c:if test="${record.GZH_AUTH_TYPE == '20' }">未认证服务号</c:if>
		<c:if test="${record.GZH_AUTH_TYPE == '21' }">认证服务号</c:if>
		
		</a>
		<!-- <a href="/shrz/attestation/indexPage/aid/55614007">未认证商户</a> -->
		</p>
		</dd>
		</dl>
		</div>
		
		<div class="box-content" style="padding-bottom: 10px;">
		<table class="table noborder">
		<tbody>
		<tr>广告板块...</tr>
		<!-- <tr>
		<td>套餐有效期：2016-10-10</td>
		<td>文本自定义：1/100</td>
		<td>图文自定义：1/100</td>
		<td>语音自定义：0/0</td>
		</tr>
		<tr>
		<td>请求数剩余： 10000 </td>
		<td>总请求数：0</td>
		<td>本月请求数：</td>
		<td>每月可请求总数：10000</td>
		</tr> -->
		</tbody>
		</table>
		<!-- <p>
		<strong>接口地址：</strong>
		http://api.weimob.com/api?t=7d27cef0921c29996b22c72050f823b5==Y    
		<strong>TOKEN：</strong>
		432036_u    
		<strong>个性域名：</strong>
		55614007.m.weimob.com
		</p> -->
		<img alt="" src="${ctx}/skin/default/images/guanggao.jpg" style=" width: 100%; height: 95px;">
		</div> 
    </div>
    
    
    
    </div>
    <!--leftinfo end-->
    
    
    <div class="leftinfos">
    
   
    <div class="infoleft">
    
    <div class="listtitle"><a href="#" class="more1">更多</a>热点新闻</div>    
    <ul class="newlist">
    <li><a href="#">待开放....</a><b>10-09</b></li>
    <!-- <li><a href="#">习近平将访东南亚两国 首次出席APEC峰会</a><b>10-08</b></li>
    <li><a href="#">最高法:谎称炸弹致航班备降者从重追刑责</a><b>10-09</b></li>
    <li><a href="#">华北大部遭遇雾霾天 北京全城陷重污染</a><b>10-06</b></li>
    <li><a href="#">"环保专家"董良杰涉嫌寻衅滋事被刑拘</a><b>10-05</b></li>
    <li><a href="#">中央巡视组：重庆对一把手监督不到位</a><b>10-04</b></li>
    <li><a href="#">囧!悍马没改好成华丽马车(图)</a><b>10-03</b></li> -->
    </ul>   
    
    </div>
    
    <div class="inforight">
    <div class="listtitle">合作信息</div>
    
    <ul class="newlist">
    <li><a href="#">有"空"就来，此广告位信息出租！</a><b>03-17</b></li>
    <li><a href="#">青岛奥菲斯文化用品有限公司，欢迎您的和合作！</a><b>03-17</b></li>
    </ul>
    <%-- <ul class="tooli">
    <li><span><img src="${ctx}/skin/skinExample/images/d01.png" /></span><p><a href="#">信息资料</a></p></li>
    <li><span><img src="${ctx}/skin/skinExample/images/d02.png" /></span><p><a href="#">编辑</a></p></li>
    <li><span><img src="${ctx}/skin/skinExample/images/d03.png" /></span><p><a href="#">记事本</a></p></li>
    <li><span><img src="${ctx}/skin/skinExample/images/d04.png" /></span><p><a href="#">任务日历</a></p></li>
    <li><span><img src="${ctx}/skin/skinExample/images/d05.png" /></span><p><a href="#">图片管理</a></p></li>
    <li><span><img src="${ctx}/skin/skinExample/images/d06.png" /></span><p><a href="#">交易</a></p></li>
    <li><span><img src="${ctx}/skin/skinExample/images/d07.png" /></span><p><a href="#">档案袋</a></p></li>    
    </ul> --%>
    
    </div>
    <%-- <div class="inforight">
    <div class="listtitle"><a href="#" class="more1">添加</a>常用工具</div>
    
    <ul class="tooli">
    <li><span><img src="${ctx}/skin/skinExample/images/d01.png" /></span><p><a href="#">信息资料</a></p></li>
    <li><span><img src="${ctx}/skin/skinExample/images/d02.png" /></span><p><a href="#">编辑</a></p></li>
    <li><span><img src="${ctx}/skin/skinExample/images/d03.png" /></span><p><a href="#">记事本</a></p></li>
    <li><span><img src="${ctx}/skin/skinExample/images/d04.png" /></span><p><a href="#">任务日历</a></p></li>
    <li><span><img src="${ctx}/skin/skinExample/images/d05.png" /></span><p><a href="#">图片管理</a></p></li>
    <li><span><img src="${ctx}/skin/skinExample/images/d06.png" /></span><p><a href="#">交易</a></p></li>
    <li><span><img src="${ctx}/skin/skinExample/images/d07.png" /></span><p><a href="#">档案袋</a></p></li>    
    </ul>
    
    </div> --%>
    
    
    </div>
    
    
    </div>
    <!--mainleft end-->
    
    
    <div class="mainright">
    
    
    <div class="dflist">
    <div class="listtitle"><a href="#" class="more1">更多</a>平台信息</div>    
    <ul class="newlist">
    <li><a href="#">微信公众平台试运营，欢迎您的加入！</a></li>
    <li><a href="#">欢迎“青岛奥菲斯文化用品有限公司”加盟！</a></li>
    <li><a href="#">欢迎“万象前沿”加盟，有态度的公众号！</a></li>
    <li><a href="#">欢迎“享天然鲜奶吧”加盟，只做优质好奶！</a></li>
    <li><a href="#">欢迎“CD咖啡”加盟，你我齐分享！</a></li>
    <li><a href="#">欢迎“营养顾问代老师”加盟！</a></li>
    <li><a href="#">欢迎“仙逆时尚”加盟，做最美的你！</a></li>
    <!-- <li><a href="#">最高法:谎称炸弹致航班备降者从重追刑责</a></li>
    <li><a href="#">华北大部遭遇雾霾天 北京全城陷重污染</a></li>
    <li><a href="#">"环保专家"董良杰涉嫌寻衅滋事被刑拘</a></li>
    <li><a href="#">中央巡视组：重庆对一把手监督不到位</a></li>
    <li><a href="#">囧!悍马没改好成华丽马车(图)</a></li>
    <li><a href="#">澳门黄金周加派稽查人员监察出租车违规行为</a></li>
    <li><a href="#">香港环境局长吁民众支持政府扩建堆填区</a></li> --> 
    </ul>        
    </div>
    
    
    <div class="dflist1">
    <div class="listtitle"><a href="#" class="more1">更多</a>信息统计</div>    
    <ul class="newlist">
    <!-- <li><i>会员数：</a></i>2535462</li>
    <li><i>文档数：</a></i>5546</li>
    <li><i>普通文章：</a></i>2315</li>
    <li><i>软件：</a></i>1585</li>
    <li><i>评论数：</a></i>5342</li> -->  
    <li>即将上线，敬请期待！</li>  
    </ul>        
    </div>
    
    

    
    
    </div>
    <!--mainright end-->
    
    
    </div>



</body>
<script type="text/javascript">
	setWidth();
	$(window).resize(function(){
		setWidth();	
	});
	function setWidth(){
		var width = ($('.leftinfos').width()-12)/2;
		$('.infoleft,.inforight').width(width);
	}
</script>
</html>
