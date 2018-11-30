<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>首页</title>
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
<script type="text/javascript" src="${ctx }/skin/tinyWebsite/js/swipe.js"></script>
<script type="text/javascript">
document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {WeixinJSBridge.call('hideToolbar');});
		$(function(){
			new Swipe(document.getElementById('banner_box'), {
				speed:500,
				auto:3000,
				callback: function(){
					var lis = $(this.element).next("ol").children();
					lis.removeClass("on").eq(this.index).addClass("on");
				}
			});
		});
function openShare(){
	$("#shareCover").addClass("on");
}
</script>
</head>

<body>



<div class="body" style="padding-bottom: 50px;">
 <%--  <p class="logo clearfix"><span class="floatl"><img src="${ctx }/skin/tinyWebsite/images/logo.png" alt="logo"></span><em class="floatl"><img src="${ctx }/skin/tinyWebsite/images/sybar.jpg" alt=""></em></p> --%>
  <div class="banner clearfix">
    <div style="-webkit-transform:translate3d(0,0,0);">
      <div id="banner_box" class="box_swipe">
        <ul>
         <c:forEach var="list" items="${record.mapNav}" varStatus="status">
        	  <%-- <c:forEach items="${list.value}" var="map"> --%> 
        	  <li> <a onclick="goActivity('${list.RESPONSE}','${list.RESPONSE_ID}')"> <img src="${list.PIC_URL}" alt="" style="height: 210px;" /> </a>    
        	 </li>
        	 <%-- </c:forEach> --%>
        	 </c:forEach>
<%--           <li> <a onClick="return false;"> <img src="${ctx }/skin/tinyWebsite/images/goods1.jpg" alt="" style="height: 250px;" /> </a>    
          
          </li>       
          <li> <a onClick="return false;"> <img src="${ctx }/skin/tinyWebsite/images/goods2.jpg" alt="" style="height: 250px;" /> </a> 
          
          </li> --%>
        </ul>
        
        <ol style="">
        <c:forEach var="list" items="${record.mapNav}" varStatus="status">
          <!-- <li class="on" ></li> -->
          <li  ${status.index eq '0' ? 'class="on"' : ''}></li>
          </c:forEach>
        </ol>
        
        
      </div><!--#banner_box-->
      
    </div>
  </div><!--banner-->
  <ul class="clearfix synav">
  <c:forEach var="listHmBt" items="${record.mapHmBt}" varStatus="status">
  <li class="floatl"><a style="background-image:url(${listHmBt.PIC_URL})" href="${listHmBt.URL }"><b>${listHmBt.NAME }</b><em>${listHmBt.DESCRIPTION }</em></a></li>
  </c:forEach>
    <%-- <li class="syn1 floatl"><a href="${ctx }/TWeb/goods/goodsList.htmls"><b>商品</b><em>商品展示</em></a></li>
    <li class="syn2 floatl"><a href="${ctx }/MemberCenter/memberInfo.htmls"><b>订单</b><em>显示订单</em></a></li>
    <li class="syn3 floatl"><a href="${ctx }/MemberCenter/memberInfo.htmls"><b>会员</b><em>成为VIP</em></a></li>
    <li class="syn4 floatl"><a href="${ctx }/TWeb/act/list.htmls"><b>活动</b><em>最新活动</em></a></li>
    <li class="syn5 floatl"><a href=""><b>公司</b><em>公司展示</em></a></li>
    <li class="syn6 floatl"><a href=""><b>团队</b><em>团队展示</em></a></li> --%>
  </ul>
  <c:forEach var="listHac" items="${record.mapHac}" varStatus="status">
  <div class="syad clearfix" style="margin-bottom: 10px; padding-bottom: 9px; padding-top: 9px;">
  <em class="floatl tgimg"><img src="${listHac.PIC_URL }" style="width: 140px; height: 110px;"></em>
  <em class="floatr tgtxt" style="padding-top: 0px;">
  <span style="text-align: left;font-size: 22px;white-space:nowrap; overflow:hidden; text-overflow:ellipsis;height: 75px;">
  <p style="font-size: 20px;">${listHac.TITLE }</p>
  <p style="font-size: 18px; margin-top: 4px;">${listHac.INTRO }</p>
  </span>

  <a onclick="goActivity('${listHac.RESPONSE}','${listHac.RESPONSE_ID}');">查看详情</a></em>
  </div>
  </c:forEach>
  <%-- <div class="syad clearfix">
  <em class="floatl tgimg"><img src="${ctx }/skin/tinyWebsite/images/goods4.jpg" alt="广告图"></em>
  <em class="floatr tgtxt"><span><img src="${ctx }/skin/tinyWebsite/images/goods5.jpg" alt="A4打印纸 团购特价仅58元"></span><a href="javascript:void(0);">立即参团</a></em>
  </div> --%>
  
  <a class="gotop" href="javascript:openShare();" style="width: 47px; height: 47px;">	
     <img src="${ctx }/skin/tinyWebsite/images/share1.png" style="width: 20px; height: 20px; margin-left: 15px; margin-top: 5px;">
     <em style="font-size: 13px; margin-left: 11px;">分享</em>
  </a>
 
 </div>
 <!--<footer class="syfooter">
    <ul class="clearfix">
      <li class="ft1 floatl"><a href="index.html" class="icon-home"></a></li>
      <li class="ft2 floatl"><a href="tel:024-31891570">电话</a></li>
      <li class="ft3 floatl"><a href="#">导航</a></li>
      <li class="ft4 floatl"><a href="javascript:$('#shareCover').toggleClass('on');">分享</a></li>
    </ul>
  </footer>-->
  <!--↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓导航开始↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓-->
  <%@ include file="common/tinyNavBottom.jsp"%>
  <!--↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑导航end↑↑↑↑↑↑↑↑↑↑↑↑↑↑-->>
  <!--↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓3列菜单开始↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓-->
  <!-- <div  class=" btn3 clearfix syfooterdiv">
    <div class="menu ft1 floatl" style="width: 10%;border-left: 1px solid #aeaeae;">
      <div class="bt-name"><a href="http://www.baidu.com" style="font-size:20px; " class="icon-home greencolor"></a></div>
    </div>

    <div class="menu" style="width: 30%">
      <div class="bt-name"><a href="javascript:void(0);" >首页</a></div>
    </div>menu


    <div class="menu" style="width: 30%">
      <div class="bt-name"><a href="javascript:void(0);" >第二个菜单</a></div>
      <div class="sanjiao"></div>
      <div class="new-sub">
        <ul >
          <li><a href="javascript:;">二、第一个</a></li>
          <li><a href="javascript:;" >二、第二个</a></li>
        </ul>
        <div class="tiggle"></div>
        <div class="innertiggle"></div>
      </div>

    </div> --><!--menu-->


    <!-- <div class="menu" style="width: 30%">
      <div class="bt-name"><a  onclick="openShare();" href="javascript:void(0);" >分享</a></div> -->
      <!-- <div class="sanjiao"></div>
      <div  class="new-sub">
        <ul>
          <li><a href="javascript:;">三、第一个</a></li>
          <li><a href="javascript:;" >三、第二个</a></li>
          <li><a href="javascript:;" >三、第三个</a></li>
        </ul>
        <div class="tiggle"></div>
        <div class="innertiggle"></div>
      </div> -->
    <!-- </div> --><!--menu-->

  <!-- </div> --><!--btn3-->
  <!--↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑3列菜单end↑↑↑↑↑↑↑↑↑↑↑↑↑↑-->
<div>
  <article id="shareCover" class="share" onclick="$('#shareCover').toggleClass('on')">
    <table>
      <tr>
        <td colspan="2" style="text-align:right;"><img src="${ctx }/skin/tinyWebsite/images/share_1.png" style="width:120px!important;" /> <img src="${ctx }/skin/tinyWebsite/images/share_2.png" style="width:30px!important;" /></td>
      </tr>
      <tr>
        <td style="width:50%;"><img src="${ctx }/skin/tinyWebsite/images/share_4.png" />
          <div>发送给朋友</div></td>
        <td><img src="${ctx }/skin/tinyWebsite/images/share_3.png" />
          <div>分享到朋友圈</div></td>
      </tr>
    </table>
  </article>
</div>
<!--body-->
</body>
<script type="text/javascript">
function goActivity(RESPONSE,RESPONSE_ID){
	if("1" == RESPONSE){
		window.location="${ctx}/TWeb/goods/goodsDetail.htmls?store=${seTicket.gzhId}&GOODS_ID="+RESPONSE_ID;
	}else if("2" == RESPONSE){
		window.location="${ctx}/TWeb/act/forActivity.htmls?store=${seTicket.gzhId}&ACTIVITY_ID="+RESPONSE_ID;
	}
}
</script>
<!-- <script type="text/javascript">
  //弹出垂直菜单
  $(".menu").click(function() {
    if ($(this).hasClass("cura")) {
      $(this).children(".new-sub").hide(); //当前菜单下的二级菜单隐藏
      $(".menu").removeClass("cura"); //同一级的菜单项
    } else {
      $(".menu").removeClass("cura"); //移除所有的样式
      $(this).addClass("cura"); //给当前菜单添加特定样式
      $(".menu").children(".new-sub").slideUp("fast"); //隐藏所有的二级菜单
      $(this).children(".new-sub").slideDown("fast"); //展示当前的二级菜单
    }
  });
  /* $("[class!='.menu']").click(function() {
	  alert("1");
	 
	  $(".menu").removeClass("cura"); //移除所有的样式
	  $(".menu").children(".new-sub").slideUp("fast"); //隐藏所有的二级菜单
	}); */
	$(function(){
		$(document).bind("click",function(e){
			var target  = $(e.target);
			if(target.closest(".menu").length == 0){
				$(".menu").removeClass("cura"); //移除所有的样式
				$(".menu").children(".new-sub").slideUp("fast"); //隐藏所有的二级菜单
			}
		})
	})
</script> -->
</html>

