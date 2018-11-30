<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<%-- <%@ include file="../../common/common_header.jsp"%> --%>
<meta charset="utf-8" />
<title>商品列表</title>
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
<!--底部导航css  -->
<link rel="stylesheet" type="text/css" href="${ctx }/skin/tinyWebsite/css/DHstyle.css" />
<!--end  -->
<link rel="stylesheet" type="text/css" href="${ctx }/skin/tinyWebsite/FortAwesome/docs/assets/css/font-awesome.css">
<link rel="stylesheet" type="text/css" href="${ctx }/skin/tinyWebsite/css/style.css" />

<script type="text/javascript" src="${ctx }/skin/tinyWebsite/js/jquery-2.0.3.min.js"></script>
<script type="text/javascript" src="${ctx }/skin/tinyWebsite/js/swipe.js"></script>

<!--菜单导航 -->
<link rel="stylesheet" type="text/css" href="${ctx }/skin/tinyWebsite/nav/css/styles.css" />
<!-- end -->
<script type="text/javascript">

   var _global = {};
	   _global.spm = {};
	   
document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {WeixinJSBridge.call('hideToolbar');});
</script>
<script type="text/javascript">

var pageNow = ${pageView.pageNow};
var rowCount = ${pageView.rowCount};
var nowCount = ${pageView.nowCount};
$(document).ready(function(){	
$(".dci").click( function () { 
$(this).toggleClass("selected");
 }); 
});
$(document).ready(function (){
  var documentHight = 0; //滚动距离总长(注意不是滚动条的长度)
  var scrollTop = 0;   //滚动的距离
  var windowHight = $(window).height();    //窗口高度

  $(window).scroll(function(){
    var documentHight = $(document).height(); //文档高度
    var scrollTop = $(window).scrollTop();  //滑动的距离
    var windowHight = $(window).height();    //窗口高度
    /*alert("文档高度"+documentHight);
    alert("滑动的距离"+scrollTop);
    alert("窗口高度"+windowHight);*/
    if(scrollTop + windowHight == documentHight){
		var displayType = $("#imloading").attr("displayType");
		if(nowCount >= rowCount){
			return false;
		}else if(displayType == "open"){
    		$("#imloading").css("display","");
    		$("#imloading").attr("displayType","stop");
    		var CLASSIFY = $("#CLASSIFY").val();
    		pageNow += 1;
    		$.ajax({
    			async:true,
    			global:false,
    			url : '${ctx}/TWeb/goods/queryGoodsList.htmls',
    			type : "post",
    			data : {"pageNow":pageNow,"CLASSIFY":CLASSIFY},
    			dataType : "json",
    			success : function(data) {
    				var count = nowCount;
    				//alert(data.obj.pageNow);
    				if(data.flag){
    					
    				}
    				var jsonList = data.obj.records;
    				for (var i = 0; i < jsonList.length; i++){
    					$("#ul_list").append(
    		    				"<li id=\"li_"+count+"\">"
    		    		        +"<h3 style=\"white-space: nowrap;overflow: hidden;text-overflow: ellipsis;\" class=\"tit\"><a >"+jsonList[i].GOODS_NAME+"</a></h3>"
    		    		        +"<div class=\"foodintro clearfix\"> <a href=\"\" class=\"foodimg floatl\"><img src=\""+jsonList[i].PIC_URL1+"\" style=\"max-height: 110px; min-height:80px;\"></a>"
    		    		          +"<div class=\"foodcon floatl\" style=\"float:right;\">"
    		    		            +"<p style=\"word-wrap: break-word;word-break:break-all;\">单价：<b>￥"+jsonList[i].SHOW_PRICE+"</b></p>"
    		    		            +"<p style=\"word-wrap: break-word;word-break:break-all;\">积分：<b>"+jsonList[i].SHOW_POINT+"分</b></p>"
    		    		            +"<p style=\"white-space: nowrap;overflow: hidden;text-overflow: ellipsis;\">简介：<b>"+jsonList[i].INTRODUCTION+"</b></p>"
    		    		            +"<p class=\"btn fts clearfix\"><a  data-id=\""+jsonList[i].GOODS_ID+"\" class=\"floatl orange-btn goodsDetail\" style=\"float:right;\">详情</a></p>"
    		    		            +"</div>"
    		    		            +"</div>"
    		    		            +"<em class=\"lt ltred\" style=\"font-size: 13px\">店长<br>"
    		    		            +"推荐</em> "
    		    		      +"</li>");
    					count++;
    		            
    				}
    				
    				nowCount += data.obj.nowCount;
    				if(nowCount >= rowCount){
    					$("#imloading").attr("displayType","close");
    					$("#imloading").css("display","none");
    				}else{
    					$("#imloading").attr("displayType","open");
    					$("#imloading").css("display","none");
    				}
    				
    			},error: function(data) {
    				 alert("服务异常，请联系管理员！");
    				   },
    		}); 
    	}else{
    		return false;
    	}   	
    }     
  });
  $(".goodsDetail").click(function(){
	  var id = $(this).attr("data-id");
	  window.location.href="${ctx}/TWeb/goods/goodsDetail.htmls?GOODS_ID="+id ;
  });
});

</script>
</head>

<body>
<nav id="navmenu" class="navmenu">
	<a href="${ctx}/TWeb/goods/goodsList.htmls">
		<header class="navmenu-header">
			<span class="navmenu-header-title">全部商品</span>
		</header>
	</a>
	<input type="hidden" id="CLASSIFY" value="${record.CLASSIFY}"/>
	<section class="navmenu-section">
		<h3 class="navmenu-section-title">商品分类</h3>
		<ul class="navmenu-section-list">
			<c:forEach var="c" items="${classList}" varStatus="status">
			<li><a href="${ctx}/TWeb/goods/goodsList.htmls?CLASSIFY=${c.GOODS_CLASSIFY_ID}&CLASSIFY_NAME=${c.CLASSIFY_NAME }">${c.CLASSIFY_NAME }</a></li>
			</c:forEach>
		</ul>
	</section>

	<!-- <section class="navmenu-section">
		<h3 class="navmenu-section-title">flash动画</h3>
		<ul class="navmenu-section-list">
			<li><a href="#">节日动画</a></li>
			<li><a href="#">flash植物</a></li>
			<li><a href="#">flash动物</a></li>
		</ul>
	</section>

	<section class="navmenu-section">
		<h3 class="navmenu-section-title">音效下载</h3>
		<ul class="navmenu-section-list">
			<li><a href="#">鸟叫声</a></li>
			<li><a href="#">狗叫声</a></li>
		</ul>
	</section> -->
</nav>
<main id="main" class="panel">
<div class="body" style=" background-color: #f4f4f4;">
  <div class="topsearch">
    <form class="clearfix">
	  <a  title="我的订单" class="floatl js-slideout-toggle" style="margin-top: 2px;"></a>
      <input type="text" name="keys" id="keys" class="stxt"  value="" >
      <input type="submit" class="sbtn icon-search" style="height: 23px;">
	</form>
  </div>
  <!--topsearch-->
  <div id="nav" class="container" >
    <ul class="assort clearfix nav-main">
      <li id="li-1" class="ast1 floatl ast-cur"><a href="#">${empty record.CLASSIFY_NAME ? '全部' : record.CLASSIFY_NAME}<i class="icon-caret-down"></i></a></li>
      <!-- <li class="ast2 floatl"><a href="#">分类<i class="icon-caret-down"></i></a></li>
      <li class="ast3 floatl"><a href="#">店长推荐<i class="icon-caret-down"></i></a></li>
      <li class="ast4 floatl"><a href="#">精品上市<i class="icon-caret-down"></i></a></li> -->
    </ul>
    <!--assort-->
    <ul class="foodlist" id="ul_list">
    <c:forEach var="r" items="${pageView.records}" varStatus="status">
      <li id="li_${status.index}">
        <h3 class="tit" style="white-space: nowrap;overflow: hidden;text-overflow: ellipsis;"><a >${r.GOODS_NAME }</a></h3>
        <div class="foodintro clearfix"> <a href="foodcontent.html" class="foodimg floatl"><img src="${r.PIC_URL1 }" style="max-height: 110px; min-height:80px;"></a>
          <div class="foodcon floatl" style="float:right;">
            <p style="word-wrap: break-word;word-break:break-all;">单价：<b >￥${r.SHOW_PRICE }</b></p>
            <%-- <p class="fts orange">VIP价格：￥${r. }</p> --%>
            <p style="word-wrap: break-word;word-break:break-all;">积分：<b>${r.SHOW_POINT }分</b></p>
            <p style="white-space: nowrap;overflow: hidden;text-overflow: ellipsis;">简介：<b>${r.INTRODUCTION }</b></p>
            <p class="btn fts clearfix"><a data-id="${r.GOODS_ID }" style="float: right;" class="floatl orange-btn goodsDetail">详情</a><!-- <i class="icon-ok floatl dci"></i> --></p>
          </div>
          <!--foodcon--> 
        </div>
        <!--foodintro-->
        <!-- <p class="fcomment clearfix"> <span class="floatl"><a href="#"><i class="icon-thumbs-up"></i>赞<em>215</em></a></span> <span class="floatl"><a href="#"><i class="icon-comment"></i>评论<em>15</em></a></span> <span class="floatl" style="border-right:0; border-right:none;"><a href="#"><i class="icon-share-alt"></i>转发</a></span> </p> -->
        <em class="lt ltred" style="font-size: 13px">店长<br>
        	推荐</em> 
      </li>
      </c:forEach>
      <%-- <li>
        <h3 class="tit"><a href="foodcontent.html">惠心上品斑鱼火锅</a></h3>
        <div class="foodintro clearfix"> <a href="foodcontent.html" class="foodimg floatl"><img src="${ctx }/skin/tinyWebsite/images/cpimg.jpg" alt="菜品图片"></a>
          <div class="foodcon floatl">
            <p>单价：<b>￥38</b></p>
            <p class="fts orange">VIP：￥0.1</p>
            <p>制作时间：<b>10分钟</b></p>
            <p>可获积分：<b>380分</b></p>
            <p>特点：<b>鲜嫩可口</b></p>
            <p><b>回味无穷~</b></p>
            <p class="btn fts clearfix"><a href="foodcontent.html" class="floatl orange-btn">点菜</a><i class="dci icon-ok floatl"></i></p>
          </div>
          <!--foodcon--> 
        </div>
        <!--foodintro-->
        <p class="fcomment clearfix"> <span class="floatl"><a href="#"><i class="icon-thumbs-up"></i>赞<em>215</em></a></span> <span class="floatl"><a href="#"><i class="icon-comment-alt"></i>评论<em>15</em></a></span> <span class="floatl" style="border-right:0; border-right:none;"><a href="#"><i class="icon-share-alt"></i>转发</a></span> </p>
        <em class="lt ltgreen">新品<br>
        上市</em> 
     </li>
     <li>
        <h3 class="tit"><a href="foodcontent.html">惠心上品斑鱼火锅</a></h3>
        <div class="foodintro clearfix"> <a href="foodcontent.html" class="foodimg floatl"><img src="${ctx }/skin/tinyWebsite/images/cpimg.jpg" alt="菜品图片"></a>
          <div class="foodcon floatl">
            <p>单价：<b>￥38</b></p>
            <p class="fts orange">VIP：￥0.1</p>
            <p>制作时间：<b>10分钟</b></p>
            <p>可获积分：<b>380分</b></p>
            <p>特点：<b>鲜嫩可口</b></p>
            <p><b>回味无穷~</b></p>
            <p class="btn fts clearfix"><a href="foodcontent.html" class="floatl orange-btn">点菜</a><i class="dci icon-ok floatl"></i></p>
          </div>
          <!--foodcon--> 
        </div>
        <!--foodintro-->
        <p class="fcomment clearfix"> <span class="floatl"><a href="#"><i class="icon-thumbs-up"></i>赞<em>215</em></a></span> <span class="floatl"><a href="#"><i class="icon-comment-alt"></i>评论<em>15</em></a></span> <span class="floatl" style="border-right:0; border-right:none;"><a href="#"><i class="icon-share-alt"></i>转发</a></span> </p>
        <em class="lt ltgreen">新品<br>
        上市</em> 
     </li>
     <li>
        <h3 class="tit"><a href="foodcontent.html">惠心上品斑鱼火锅</a></h3>
        <div class="foodintro clearfix"> <a href="foodcontent.html" class="foodimg floatl"><img src="${ctx }/skin/tinyWebsite/images/cpimg.jpg" alt="菜品图片"></a>
          <div class="foodcon floatl">
            <p>单价：<b>￥38</b></p>
            <p class="fts orange">VIP：￥0.1</p>
            <p>制作时间：<b>10分钟</b></p>
            <p>可获积分：<b>380分</b></p>
            <p>特点：<b>鲜嫩可口</b></p>
            <p><b>回味无穷~</b></p>
            <p class="btn fts clearfix"><a href="foodcontent.html" class="floatl orange-btn">点菜</a><i class="dci icon-ok floatl"></i></p>
          </div>
          <!--foodcon--> 
        </div>
        <!--foodintro-->
        <p class="fcomment clearfix"> <span class="floatl"><a href="#"><i class="icon-thumbs-up"></i>赞<em>215</em></a></span> <span class="floatl"><a href="#"><i class="icon-comment-alt"></i>评论<em>15</em></a></span> <span class="floatl" style="border-right:0; border-right:none;"><a href="#"><i class="icon-share-alt"></i>转发</a></span> </p>
        <em class="lt ltgreen">新品<br>
        上市</em> 
     </li> --%>
     
    </ul>
    <div id="imloading" displayType="open" class="imloading" style="display:none;">
      Loading.....
    </div>
    <!--<p class="fenye clearfix"><a href="#" class="floatl clearfix"><i class="icon-caret-left floatl"></i><span class="floatl">上一页</span></a><a href="#" class="floatr clearfix"><i class="icon-caret-right floatr"></i><span class="floatr">下一页</span></a></p>-->
  </div>
  <!-- loading按钮自己通过样式调整 -->

  <!--container--> 
  
</div>
</main>
<!--↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓导航开始↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓-->
  <%@ include file="../common/tinyNavBottom.jsp"%>
  <!--↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑导航end↑↑↑↑↑↑↑↑↑↑↑↑↑↑--> 
<!--body--> 
<script type="text/javascript" src="${ctx }/skin/tinyWebsite/nav/js/slideout.js"></script>
<script type="text/javascript">
var slideout = new Slideout({
	'panel': document.getElementById('main'),
	'navmenu': document.getElementById('navmenu'),
	'padding': 256,
	'tolerance': 70
  });

  document.querySelector('.js-slideout-toggle').addEventListener('click', function() {
	slideout.toggle();
  });

  document.querySelector('.navmenu').addEventListener('click', function(eve) {
	if (eve.target.nodeName === 'A') { slideout.close(); }
  });
 function aload(t){"use strict";t=t||window.document.querySelectorAll("[data-aload]"),void 0===t.length&&(t=[t]);var a,e=0,r=t.length;for(e;r>e;e+=1)a=t[e],a["LINK"!==a.tagName?"src":"href"]=a.getAttribute("data-aload"),a.removeAttribute("data-aload");return t}
/* window.onload = function(){
	aload();
	document.querySelector('.iphone').className += ' shown';
} */
</script>
</body>
</html>