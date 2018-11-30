<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>商品详情</title>
<meta name="Keywords" content="">
<meta name="Description" content="">
<!-- 移动设备支持 -->
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
	
	<link rel="stylesheet" type="text/css" href="${ctx }/skin/tinyWebsite/css/DHstyle.css" />
	<link rel="stylesheet" type="text/css" href="${ctx }/skin/tinyWebsite/css/style.css" />
    <link rel="stylesheet" type="text/css" href="${ctx }/skin/tinyWebsite/css/mall.css" >
    <!-- wechatUI -->
    <link rel="stylesheet" type="text/css" href="${ctx }/skin/common/css/weui.min.css" >
    <!--end  -->
    <script type="text/javascript" src="${ctx }/skin/tinyWebsite/js/jquery-2.0.3.min.js"></script>
    <script type="text/javascript" src="${ctx }/skin/tinyWebsite/js/jquery.Spinner.js"></script>

</head>

<body class="body_color">
<!-- <div class="topsearch">
<form class="clearfix">
	  <a href="order.html" title="我的订单" class="floatl" style="margin-top: 2px;"></a>
      <input type="text" name="keys" id="keys" class="stxt" onfocus="if (value==defaultValue)value=''" onblur="if(!value)value=defaultValue" value="寻找菜品、店面" >
      <input type="submit" class="sbtn icon-search" style="height: 23px;">
</form>
</div> --><!--topsearch-->
<div class="mall_main">
    <div id="child_header">
        <div class="goback"><a href="javascript:history.back(-1)"><i></i></a></div>
        <div class="current_location"><span>商品详情</span></div>
    </div>

	<div id="banner_box" class="box_swipe">
		<ul>
			<li><img src="${goods.PIC_URL1 }" style="max-height: 220px;"></li>
			<!-- <li><img src="images/2.jpg"></li>
			<li><img src="images/3.jpg"></li>
			<li><img src="images/4.jpg"></li> -->
		</ul>
		<!-- <ol>
			<li class="on"></li>&nbsp;
			<li></li>&nbsp;
			<li></li>&nbsp;
			<li></li>&nbsp;
		</ol> -->
	</div>
    <!-- <a class="praise_icon" href="#">2658</a> -->
    <div class="des_goods">
        <p>${goods.GOODS_NAME }</p>
        <!-- <p><span class="sp_style1">皮薄爽脆 口口诱人</span><em class="em_integral">积分：20</em></p> -->
        <p><span class="pr">单价</span><!-- <span class="sp_style2"> --><span class="sp_style3">¥<a id="price">${goods.SHOW_PRICE }</a></span>
        <em class="em_integral">积分：${goods.SHOW_POINT }</em></p>
        <!-- <p><span class="pr">促销价</span><span class="sp_style3">¥398</span></p> -->
        <!-- <p><span class="pr">促销有效期</span><span>2015-11-01~2015-11-30</span></p> -->
        <!-- <p><span class="pr">服务</span><span>由微分销销售和发货并提供售后服务</span></p> -->
        <p><span class="pr">快递信息：</span><span>${goods.TRANSPORTATION_INFO }</span><span>运费：${goods.TRANSPORTATION_PICE }</span></p>
        <hr/>
        <div class="spec_select">
            <ul>
                <li class="spec_main_select">
                    <span style="padding-right: 0px;">商品规格:</span>
                    <!-- <em class="click">HX6730</em> -->
                    <c:forEach var="r" items="${goodsList}" varStatus="status">
                    <em data-id="${r.MAIN_SPECIFICATION_ID }" gd="${r.GOODS_DETAIL_ID }" inven="${r.INVENTORY }" pri="${r.PRICE }">${r.MAIN_SPECIFICATION }</em>
                    </c:forEach>
                </li>
                <c:forEach var="r" items="${goodsList}" varStatus="status">
                <c:if test="${fn:length(r.childList) > 0}">
                <li id="${r.MAIN_SPECIFICATION_ID }" class="spec_child_select" style="display: none">
                    <!-- <span>颜色</span>
                    <em class="click">白色</em> -->
                    <span>&nbsp;&nbsp;&nbsp;&nbsp;</span>
                    <c:forEach var="c" items="${r.childList}" varStatus="status">
                    <em inven="${c.INVENTORY }" pri="${c.PRICE }" gd="${c.GOODS_DETAIL_ID }">${c.CHILD_SPECIFICATION }</em>
                    </c:forEach>
                </li>
                </c:if>
                </c:forEach>
            </ul>
        </div>
        <hr/>
        <div class="goods_activity">
            <!-- <p><span class="pr">备注</span><a href=""><span class="sp_style3">满200减10 满599减30</span></a></p> -->
             <div class="num">
                 <span style="margin-top: 3px;">数量</span>
                <span id="a"  class="Spinner"></span>
                <span style="margin-top: 3px;">库存：<a id="inventory"></a></span>
             </div>
            <!-- <p><span class="pr">服务承诺</span><span>7天无理由退货 正品保证</span></p>
            <p class="pay_type"><span class="pr">支付类别</span><span><i class="pay01"></i>信用卡</span><span><i class="pay02"></i>快捷支付</span><span><i class="pay03"></i>微信支付</span></p> -->
        </div>
    </div>

    <div class="box_list">
        <ul class="box_nav">
            <li class="current" style="width:100%"><a>商品详情</a></li>
            <!-- <li><a>评论(230)</a></li>
            <li><a>成交记录</a></li>
            <li><a>商品咨询</a></li> -->
        </ul>
        <div class="goods_box">
        	<div>
        	 ${goods.DETAIL }
        	</div>
            <%-- <img src="${ctx }/skin/tinyWebsite/images/1.jpg" width="100%">
			<img src="${ctx }/skin/tinyWebsite/images/2.jpg" width="100%">
			<img src="${ctx }/skin/tinyWebsite/images/3.jpg" width="100%">
			<img src="images/4.jpg" width="100%"> --%>
        </div>
        <!-- <div class="goods_box" style="display: none">
            <h3>累计评价(25)：</h3>
            <div class="evaluate">
                <span>18762678928</span><span class="text_t">2015-10-19</span>
                <p>速度快，服务周到</p>
                <hr/>
            </div>
            <div class="evaluate">
                <span>18762678928</span><span class="text_t">2015-10-19</span>
                <p>速度快，服务周到速度快，服务周到速度快，服务周到速度快，服务周到速度快，服务周到</p>
                <hr/>
            </div>
            <div class="evaluate">
                <span>18762678928</span><span class="text_t">2015-10-19</span>
                <p>速度快，服务周到</p>
                <hr/>
            </div>
        </div>
        <div class="goods_box" style="display: none">
            <div class="deal_list">
                <p><span>18762678928</span> <span>1<em>[xl,深蓝]</em></span><span>2015-12-04</span></p>
                <p><span>18762678928</span> <span>1<em>[xl,深蓝]</em></span><span>2015-12-04</span></p>
                <p><span>18762678928</span> <span>1<em>[xl,深蓝]</em></span><span>2015-12-04</span></p>
                <p><span>18762678928</span> <span>1<em>[xl,深蓝]</em></span><span>2015-12-04</span></p>
            </div>
        </div>
        <div class="goods_box" style="display: none">
            <div class="ask_list">
                <textarea></textarea>
                <input class="btn_remove" type="button" value="提交"/>
            </div>
        </div> -->
    </div>
    <div class="bottomdiv clearfix">
        <div class="inner clearfix">
        	<input type="hidden" id="subGd" value=""/>
        	<input type="hidden" id="subGi" value="${goods.GOODS_ID }"/>
        	<input type="hidden" id="subGn" value="${goods.GOODS_NAME }"/>
        	<div class="fr btn_buy_detail">
                <a class="addshop_cat">加入购物车</a>
            </div>
            <!-- <div class="fr btn_sure">
                <a href="">立即购买</a>
            </div> -->
            
        </div>

    </div>
     <!--↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓导航开始↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓-->
  <%@ include file="../common/tinyNavBottom.jsp"%>
  <!--↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑导航end↑↑↑↑↑↑↑↑↑↑↑↑↑↑-->
  <!--wechatAlert  -->
  <div class="weui_dialog_alert" style="display: none;">
    <div class="weui_mask" style="z-index: 51;"></div>
    <div class="weui_dialog" style="z-index: 55;">
        <div class="weui_dialog_hd"><strong class="weui_dialog_title">温馨提示</strong></div>
        <div class="weui_dialog_bd">错误</div>
        <div class="weui_dialog_ft">
            <a onclick="suer();" class="weui_btn_dialog primary">确定</a>
        </div>
    </div>
 </div>
 <div id="loadingToast" class="weui_loading_toast" style="display:none;">
    <div class="weui_mask_transparent"></div>
    <div class="weui_toast">
        <div class="weui_loading">
            <!-- :) -->
            <div class="weui_loading_leaf weui_loading_leaf_0"></div>
            <div class="weui_loading_leaf weui_loading_leaf_1"></div>
            <div class="weui_loading_leaf weui_loading_leaf_2"></div>
            <div class="weui_loading_leaf weui_loading_leaf_3"></div>
            <div class="weui_loading_leaf weui_loading_leaf_4"></div>
            <div class="weui_loading_leaf weui_loading_leaf_5"></div>
            <div class="weui_loading_leaf weui_loading_leaf_6"></div>
            <div class="weui_loading_leaf weui_loading_leaf_7"></div>
            <div class="weui_loading_leaf weui_loading_leaf_8"></div>
            <div class="weui_loading_leaf weui_loading_leaf_9"></div>
            <div class="weui_loading_leaf weui_loading_leaf_10"></div>
            <div class="weui_loading_leaf weui_loading_leaf_11"></div>
        </div>
        <p class="weui_toast_content">数据加载中</p>
    </div>
</div>
  <!-- end -->
</div>
<script src="${ctx }/skin/tinyWebsite/js/swipe2.js" type="text/javascript"></script>
<script type="text/javascript">
    $(function(){
        new Swipe(document.getElementById('banner_box'), {
            speed: 500,
            auto: 3000,
            callback: function(){
                var lis = $(this.element).next("ol").children();
                lis.removeClass("on").eq(this.index).addClass("on");
            }
        });
    });
</script>
<script type="text/javascript">
    $(function(){
        $(".spec_main_select em").click(function(){
            $(this).addClass("click").siblings().removeClass("click");
            var id = $(this).attr("data-id");
            var price = $(this).attr("pri");
            var inventory = $(this).attr("inven");
            var goodsDetailId = $(this).attr("gd");
            
            if(undefined != id && "" != id){
            	$(".spec_child_select em").removeClass("click");
            	
            	$(".spec_child_select").attr("style", "display:none");
            	if(document.getElementById(id)){
            		passVale();
            		$("#"+id).removeAttr("style");
            	} else {
            		passVale(price,inventory);
            		$("#subGd").val(goodsDetailId);
            	}
            	
            }
            
        })
    })
    $(function(){
        $(".spec_child_select em").click(function(){
            $(this).addClass("click").siblings().removeClass("click");
            var price = $(this).attr("pri");
            var inventory = $(this).attr("inven");
            var goodsDetailId = $(this).attr("gd");
            passVale(price,inventory);
            $("#subGd").val(goodsDetailId);
            /* var id =$(this).attr("data-id");
            
            if(undefined != id && "" != id){
            	$(".spec_child_select").attr("style", "display:none");
            	$("#"+id).removeAttr("style");
            } */
            
        })
    })
    function passVale(price,inventory){
    	if(undefined == price || "" == price){
    		$("#price").html("---");
    		$("#price").val("");
    	}else{
    		$("#price").html(price);
    		$("#price").val(price);
    	}
    	if(undefined == inventory || "" == inventory){
    		$("#inventory").html("---");
    		$("#inventory").val("");
    		document.getElementById("a").innerHTML="";
    		$("#a").Spinner({value:0, min:0, len:3, max:0});
    	}else{
    		$("#inventory").html(inventory);
    		$("#inventory").val(inventory);
    		document.getElementById("a").innerHTML="";
    		$("#a").Spinner({value:0, min:0, len:3, max:inventory});
    	}
    }
</script>
<!--商品数量加减-->
<script type="text/javascript">
$(function(){
	$("#a").Spinner({value:0, min:0, len:3, max:0});
	});
   /*  $(function(){
    	$("#a").click(function() {
    		var inventory = $("#inventory").val();
    		$("#a").Spinner({value:1, min:0, len:3, max:10000}); 
    	}); 
        
    });*/
</script>
<!--加入购物车-->
<script type="text/javascript">
var num = 1;

$(document).ready(function() {
	$(".addshop_cat").click(function() {
		var AMOUNT = $(".Amount").val();
		var INVENTORY = $("#inventory").val();
		var GOODS_DETAIL_ID = $("#subGd").val();
		var GOODS_NAME = $("#subGn").val();
		var GOODS_ID = $("#subGi").val();
		if(AMOUNT > 0){
			$("#loadingToast").removeAttr("style");
			if(AMOUNT > INVENTORY){
				$("#loadingToast").attr("style", "display:none");
				$(".weui_dialog_bd").html("购买数量大于库存，请重选！");
				$(".weui_dialog_alert").removeAttr("style");
				return false;
			}else{
				
					$.ajax({
		    			url : '${ctx}/TWeb/cart/insterTemp.htmls',
		    			type : "post",
		    			data : {"GOODS_ID":GOODS_ID,"AMOUNT":AMOUNT,"GOODS_DETAIL_ID":GOODS_DETAIL_ID,"GOODS_NAME":GOODS_NAME,"NUM":num},
		    			dataType : "json",
		    			success : function(data) {
		    				if(!data.flag){
		    					$("#loadingToast").attr("style", "display:none");
		    					$(".weui_dialog_bd").html(data.msg);
		    					$(".weui_dialog_alert").removeAttr("style");
		    					return false;
		    				}else{
		    					//$("#ECS_CARTINFO").html(num);
		    					num ++;
		    					$("#loadingToast").attr("style", "display:none");
		    					$(".weui_dialog_bd").html(data.msg);
		    					$(".weui_dialog_alert").removeAttr("style");
		    					return false;
		    				}
		    				
		    			},error :function(data){
		    				$("#loadingToast").attr("style", "display:none");
	    					$(".weui_dialog_bd").html("服务异常！");
	    					$(".weui_dialog_alert").removeAttr("style");
	    					return false;
		    			}
					});
					
				/* } */
				
			}
		}
	});
});
function suer(){
	$(".weui_dialog_alert").attr("style", "display:none");
}
</script>
<script type="text/javascript">
    jQuery(function($){
        $('.box_list ul li').click(function(){
            var index = $('.box_list ul li').index(this);
            $(this).addClass('current').siblings('li').removeClass('current');
            $('.box_list .goods_box:eq('+index+')').show().siblings('.goods_box').hide();
        })
    })
</script>
</body>
</html>