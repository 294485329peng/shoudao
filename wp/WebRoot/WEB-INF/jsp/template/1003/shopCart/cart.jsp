<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<!-- saved from url=(0068)http://502420.m.weimob.com/vshop/502420/UserCenter/MyShoppingCartNew -->
<html lang="zh-CN" ng-app="WmallAPP" class="ng-scope">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>购物车</title>
    <meta charset="utf-8">
    <meta content="" name="description">
    <meta content="" name="keywords">
    <meta content="eric.wu" name="author">

    <meta content="no-cache,must-revalidate" http-equiv="Cache-Control">
    <meta content="no-cache" http-equiv="pragma">
    <meta content="0" http-equiv="expires">
    <meta content="telephone=no, address=no" name="format-detection">
    <meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
    <script type="text/javascript" src="${ctx }/skin/tinyWebsite/js/jquery-2.0.3.min.js"></script>
    <link href="${ctx }/skin/tinyWebsite/cart/css/reset.css" rel="stylesheet">
    <link href="${ctx }/skin/tinyWebsite/cart/css/common.css" rel="stylesheet">
    <link href="${ctx }/skin/tinyWebsite/cart/css/shopcart2.css" rel="stylesheet">
	<!--数量加减插件  -->
	<link href="${ctx }/skin/tinyWebsite/count/css/count.css" rel="stylesheet"> 
	<script type="text/javascript" src="${ctx }/skin/tinyWebsite/count/js/jquery.Spinner.js"></script>   
	<!-- end -->
	<!-- 导航 -->
    <link rel="stylesheet" type="text/css" href="${ctx }/skin/tinyWebsite/css/DHstyle.css" />
    <!--end  -->
    <!-- wechatUI -->
    <link rel="stylesheet" type="text/css" href="${ctx }/skin/common/css/weui.min.css" >
    <!--end  -->
    <script type="text/javascript">
   /*  var goods = 0;
    $(document).ready(function(){
    	  $(".input_wrap").click(function(){
    		  //alert("111");
    		  var flag = $("#checkAll").attr("ng-checked");
    		  if(flag == 'false'){
    			  $("div[name='good_id']") .attr('ng-checked','true');
    			  $("#checkAll") .attr('ng-checked','true');
    			  goods = 2;
    		  }else{
    			  $("div[name='good_id']") .attr('ng-checked','false');
    			  $("#checkAll") .attr('ng-checked','false');
    			  goods = 0;
    		  }
    	  });
    	  $("a[name='good_id']").click(function(){
    		  
    		  var flag = $(this).children("div").attr("ng-checked");
    		  if(flag == 'false'){
    			  $(this).children("div").attr('ng-checked','true');
    			  goods++;
    			  if(goods == 2){
    				  $("#checkAll") .attr('ng-checked','true'); 
    			  }
    		  }else{
    			  $(this).children("div").attr('ng-checked','false');
    			  goods--;
    			  $("#checkAll") .attr('ng-checked','false');
    		  }
    		    });  
    	  
    	});	
    
    function save(){
    	alert("111");
    } */
</script>
</head>
<body onselectstart="return true;" ondragstart="return false;" ng-controller="shopcart_Controller" class="ng-scope">
<div data-role="container" class="container shopcart">
	<c:if test="${scList== null || fn:length(scList) == 0}">
	<div style="margin-top: 100px;">
	<img class="img-cart" src="${ctx }/skin/tinyWebsite/cart/images/nocart.png" >
	<p class="cart-text">购物车为空</p>
	</div>
	</c:if>
	<c:if test="${scList!= null && fn:length(scList) > 0}">
	<header data-role="header">
        <!---->
    </header>
    <section data-role="body" class="body" style="min-height: 901px;">
        <div class="section_goods _goods ">
            <form id="form_shopcart_list" action="" method="post" class="hidden ng-pristine ng-valid" style="display: inherit;">
                <!-- ngIf: data.length --><div ng-if="data.length" class="shopcart_list_header ng-scope">
                <li class="tbox">
                    <div ng-click="selectAll($this, $event);">
                                <span class="input_wrap">
                                    <div id="checkAll"  name="" value="" class="radio " ng-checked="false"></div>
                                </span>
                    </div>
                    <div style="width: 100%;">
                        <label>全选</label>
                    </div>
                    <div>
                        <a onclick="deleteSC();" class="icon_del" id="delGoods" >&nbsp;</a>
                    </div>
                </li>
            </div><!-- end ngIf: data.length -->
                <ul id="shopcart_list_body" class="shopcart_list_body list_goods">
                    <!-- ngRepeat: g in data -->
                    <c:forEach var="sc" items="${scList}" varStatus="status">
                    <li ng-repeat="g in data" class="ng-scope li-totalPrice">
                    <div class="tbox">
                        <div ng-if="0 != g.Sum" ng-click="selectOne($this, $event, $index);" class="ng-scope">
                                    <a name="good_id" style="height: 30px;"> 
                                        <div ng-checked="false" name="goods-select"   class="radio" sc-id="${sc.SC_ID }" goodsName="${sc.GOODS_NAME }" goodsDetail="${sc.GOODS_DETAIL_ID }" 
                                        total-price="${sc.AMOUNT * sc.PRICE}" total-point="${sc.AMOUNT * sc.POINT}" amount="${sc.AMOUNT }" unit-price="${sc.PRICE }" 
                                        goods-id="${sc.GOODS_ID }" goodsPic="${sc.PIC_URL1}" main-specification="${sc.MAIN_SPECIFICATION }"
                                        child-specification="${sc.CHILD_SPECIFICATION }"></div>
                                    </a>
                   		 </div>
                        <div>
                                    <span class="img_wrap">
                                        <img ng-src="${sc.PIC_URL1 }" ng-click="goToDetail($this, $event, g);" src="${sc.PIC_URL1 }">
                                    </span>
                            <figcaption class="ng-binding">&nbsp;</figcaption>
                        </div>
                        <div>
                            <p class="title ng-binding">${sc.GOODS_NAME }</p>
                            <p class="price ng-binding">￥<span name="goodsPrice" goodsPrice="${sc.PRICE }">${sc.PRICE }</span> 
                            <span style="width: 90px;float: right;">积分：<span name="goodsPoint" goodsPoint="${sc.POINT }">${sc.POINT }</span></span>
                            
                            </p>
                            <p class="ng-binding">${sc.MAIN_SPECIFICATION }
                            <c:if test="${not empty sc.CHILD_SPECIFICATION}">  / ${sc.CHILD_SPECIFICATION }</c:if>
                            
                            </p>
                            <div style="box-sizing:;" id="a${status.index }" class="Spinner">
                            <c style="float:right;margin-right: 20px;font-size: 14px;line-height: 24px;">库存：<c>${sc.INVENTORY }</c></c>
                            </div><!-- ngIf: 0 != g.Sum --><!-- <dl ng-if="0 != g.Sum" class="ng-scope"> -->
                            
                            <%-- <dd>
                                <a href="javascript:;" ng-click="changeSum($this, $event, &#39;-&#39;, $index);">&nbsp;</a>
                            </dd>
                            <dd>
                                <input type="tel" name="sum" value="${sc.AMOUNT }" readonly="true" data-itemid="">
                            </dd>
                            <dd>
                                <a href="javascript:;" ng-click="changeSum($this, $event, &#39;+&#39;, $index);">&nbsp;</a>
                            </dd> --%>
                        <!-- </dl> --><!-- end ngIf: 0 != g.Sum -->
                            <!-- <p></p> -->
                        </div>
                    </div>
                </li>
                </c:forEach>
                <!-- end ngRepeat: g in data -->
                
                    <!-- ngRepeat: g in invalidData -->
                </ul>
                <input type="hidden" id="cartData" name="data" value="">
            </form>
        </div>
        <!-- <div class="hidden" style="display: hidden;">
            <a href="javascript:;" class="btn_del_invalid_goods" ng-click="delInvalidGoods($this, $event);">清空失效商品</a>
        </div> -->
    </section>
    <footer data-role="footer">
        <div data-role="widget" data-widget="footer_sub_btn" class="footer_sub_btn">
            <div class="widget_wrap hidden" style="display: inherit;">
                <ul style="margin-bottom: 54px;">
                    <ol class="tbox activity" style="visibility: hidden;">
                        <dd>
                            <label class="ng-binding">您可以参加活动</label>
                        </dd>
                        <dd>
                            <label ng-show="activity.price_youhui" class="ng-binding ng-hide">已减 - ￥NaN</label>
                        </dd>
                    </ol>
                    <ol class="tbox">
                        <li>
                            <div class="price_des" id="price_des">
                                <p>总计<span class="price_total ng-binding">￥</span><span id="totalPrice" value="0.00" class="price_total ng-binding" style="margin-left: 0px;">0.00</span>
                                <span class="price_total ng-binding" style="color: #6c6c6c;font-size: 10px; line-height: 17px;">总积分:</span><span id="totalPoint" value="0" style="margin-left: 5px;" class="price_total ng-binding">0</span>
                                </p>
                                <p class="ng-binding">(共<span id="selectedGoodsTotal" value="0">0</span>件，不含运费)</p>
                            </div>
                        </li>
                        <li>
                            <a class="btn red" onclick="saveOrder();">去下单</a>
                        </li>
                    </ol>
                </ul>
            </div>
        </div>
    </footer>
	</c:if>
   
</div>
 
   <!--↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓导航开始↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓-->
  <%@ include file="../common/tinyNavBottom.jsp"%>
  <!--↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑导航end↑↑↑↑↑↑↑↑↑↑↑↑↑↑-->
<div class="weui_dialog_alert" style="display: none;">
    <div class="weui_mask"></div>
    <div class="weui_dialog">
        <div class="weui_dialog_hd"><strong class="weui_dialog_title">系统提示</strong></div>
        <div class="weui_dialog_bd">弹窗内容，告知当前页面信息等</div>
        <div class="weui_dialog_ft">
            <a onclick="suer();" class="weui_btn_dialog primary">确定</a>
        </div>
    </div>
</div>
<script type="text/javascript">
<c:forEach var="sc" items="${scList}" varStatus="status">
$("#a"+${status.index }).Spinner({value:${sc.AMOUNT}, min:1, len:3, max:${sc.INVENTORY}});
</c:forEach>
</script>
<script type="text/javascript">
    var goodsTotalNum = document.getElementsByName("goods-select").length;   //总商品数
    var goodsNowNum = 0;     //当前选中的商品数
    $(document).ready(function(){
    	  $(".input_wrap").click(function(){                  
    		  //全选    全不选
    		  var flag = $("#checkAll").attr("ng-checked");
    		  if(flag == 'false'){
    			  $("div[name='goods-select']") .attr('ng-checked','true');
    			  $("#checkAll") .attr('ng-checked','true');
    			  liTotalPrice();
    			  goodsNowNum = goodsTotalNum;
    		  }else{
    			  $("div[name='goods-select']") .attr('ng-checked','false');
    			  $("#checkAll") .attr('ng-checked','false');
    			  goodsNowNum = 0;
    			  liTotalPrice();
    		  }
    	  });
    	  $("a[name='good_id']").click(function(){
    		  //单选一个 
    		  var flag = $(this).children("div").attr("ng-checked");
    		  if(flag == 'false'){
    			  $(this).children("div").attr('ng-checked','true');
    			  goodsNowNum++;
    			  if(goodsNowNum == goodsTotalNum){
    				  $("#checkAll") .attr('ng-checked','true'); 
    			  }
    			  liTotalPrice();
    		  }else{
    			  $(this).children("div").attr('ng-checked','false');
    			  goodsNowNum--;
    			  $("#checkAll") .attr('ng-checked','false');
    			  liTotalPrice();
    		  }
    	 });
    	  $("a[name='Decrease']").click(function(){
    		  var goodsAmount = $(this).next('input').val();
    		  var goodsPrice = $(this).parents("li").find("span[name='goodsPrice']").attr("goodsPrice");
    		  var goodsPoint = $(this).parents("li").find("span[name='goodsPoint']").attr("goodsPoint");
 			  var totalPrice = parseFloat(goodsPrice) * parseInt(goodsAmount);
 			  var totalPoint = parseInt(goodsPoint) * parseInt(goodsAmount);
 			  totalPrice = totalPrice.toFixed(2);
 			  
 			  $(this).parents("li").find("div[name='goods-select']").attr("total-price",totalPrice);
 			  $(this).parents("li").find("div[name='goods-select']").attr("total-point",totalPoint);
 			  $(this).parents("li").find("div[name='goods-select']").attr("amount",goodsAmount);
 			  
 			 liTotalPrice();
    		  
    	 });
		 $("a[name='Increase']").click(function(){
			 var goodsAmount = $(this).prev('input').val();
			 var goodsPrice = $(this).parents("li").find("span[name='goodsPrice']").attr("goodsPrice");
			 var goodsPoint = $(this).parents("li").find("span[name='goodsPoint']").attr("goodsPoint");
			 var totalPrice = parseFloat(goodsPrice) * parseFloat(goodsAmount);
			 var totalPoint = parseInt(goodsPoint) * parseInt(goodsAmount);
			 totalPrice = totalPrice.toFixed(2);
			 
			 $(this).parents("li").find("div[name='goods-select']").attr("total-price",totalPrice);
			 $(this).parents("li").find("div[name='goods-select']").attr("total-point",totalPoint);
			 $(this).parents("li").find("div[name='goods-select']").attr("amount",goodsAmount);
			 //.parent("p").
			 liTotalPrice();
    	 });
    	  
    	});	
    function orderGoods(scId,goodsDetail,goodsName,goodsPic,unitPrice,mainSpecification,childSpecification,amount,totalPrice,totalPoint,goodsId){
    	this.SC_ID = scId;
    	this.GOODS_DETAIL_ID = goodsDetail;
    	this.GOODS_NAME = goodsName;
    	this.PIC_URL = goodsPic;
    	this.UNIT_PRICE = unitPrice;
    	this.MAIN_SPECIFICATION = mainSpecification;
    	this.CHILD_SPECIFICATION = childSpecification;
    	this.AMOUNT = amount;
    	this.TOTAL_PRICE = totalPrice;
    	this.TOTAL_POINT = totalPoint;
    	this.GOODS_ID = goodsId;
    	return this;
    }
    function saveOrder(){
    	var order = new Array();
    	/* var order = [];
    	var goodsPrice = [];
    	var goodsDetail = [];
    	var totalPrice = [];
    	var amount = [];
    	var unitPrice = [];
    	var goodsId = [];
    	var goodsPic = [];
    	var mainSpecification = [];
    	var childSpecification = []; */
    	var selectedGoodsTotal = 0;
    	var goods= document.getElementsByName("goods-select");
    	for(var i=0;i<goods.length;i++)
		{
    		var checked = goods[i].getAttribute("ng-checked");
    		if(checked == 'true'){
    			var scId = goods[i].getAttribute("sc-id");
    			var goodsName = goods[i].getAttribute("goodsName");
    	    	var goodsDetail = goods[i].getAttribute("goodsDetail");
    	    	var totalPrice = goods[i].getAttribute("total-price");
    	    	var totalPoint = goods[i].getAttribute("total-point");
    	    	var amount = goods[i].getAttribute("amount");
    	    	var unitPrice = goods[i].getAttribute("unit-price");
    	    	var goodsId = goods[i].getAttribute("goods-id");
    	    	var goodsPic = goods[i].getAttribute("goodsPic");
    	    	var mainSpecification = goods[i].getAttribute("main-specification");
    	    	var childSpecification = goods[i].getAttribute("child-specification");
    	    	var orderGoodsMap = new orderGoods(scId,goodsDetail,goodsName,goodsPic,unitPrice,mainSpecification,childSpecification,amount,totalPrice,totalPoint,goodsId);
    			order.push(orderGoodsMap);
    	    	/* goodsPrice.push(goods[i].getAttribute("total-price"));
    			goodsDetail.push(goods[i].getAttribute("goodsDetail"));
    			totalPrice.push(goods[i].getAttribute("total-price"));
    			amount.push(goods[i].getAttribute("amount"));
    			unitPrice.push(goods[i].getAttribute("unit-price"));
    			goodsId.push(goods[i].getAttribute("goods-id"));
    			goodsPic.push(goods[i].getAttribute("goodsPic"));
    			mainSpecification.push(goods[i].getAttribute("main-specification"));
    			childSpecification.push(goods[i].getAttribute("chil-specification")); */
        		selectedGoodsTotal = selectedGoodsTotal + 1;
    		}
		}
    	if(selectedGoodsTotal == 0){
    		
    	}else{
    		var TOTAL_PRICE =  $("#totalPrice").val();
    		var TOTAL_POINT =  $("#totalPoint").val();
    		var orderMap = {"order":order,"TOTAL_PRICE":TOTAL_PRICE,"TOTAL_POINT":TOTAL_POINT};
    		orderMap = JSON.stringify(orderMap);
    		$.ajax({
    			url:"${ctx}/TWeb/order/addOrder.htmls",
    			type:"post",
    			data:orderMap,
    			dataType:"json",
    			cache:false,
    			contentType: "application/json;",
    			success:function(data){
    				if(data.flag){
    					window.location = "${ctx}/TWeb/order/tinyOrderForm.htmls?ORDER_ID="+data.obj.ORDER_ID;
    				}else{
    					$("#loadingToast").attr("style", "display:none");
    					$(".weui_dialog_bd").html("操作失败！");
    					$(".weui_dialog_alert").removeAttr("style");
    				}
    				}
    			});
    	}
    }
    /*判断是否选中  选中的获取数据*/
    function liTotalPrice(){
    	//var li = document.getElementsByName("li-goods");
    	var totalPrice = 0;      //总价
    	var totalPoint = 0;      //总积分
    	var selectedGoodsTotal = 0;
    	var goods= document.getElementsByName("goods-select");
    	for(var i=0;i<goods.length;i++)
		{
    		var checked = goods[i].getAttribute("ng-checked");
    		if(checked == 'true'){
    			var goodsPrice = goods[i].getAttribute("total-price");
    			var goodsPoint = goods[i].getAttribute("total-point");
        		totalPrice = parseFloat(totalPrice) + parseFloat(goodsPrice);
        		totalPoint = parseFloat(totalPoint) + parseFloat(goodsPoint);
        		selectedGoodsTotal = selectedGoodsTotal + 1;
    		}
		}
    	totalPrice = totalPrice.toFixed(2);
    	changeTolPriceAndAmount(totalPrice,selectedGoodsTotal,totalPoint);
    }
    function changeTolPriceAndAmount(totalPrice,selectedTotal,totalPoint){
    	$("#totalPrice").html(totalPrice);
    	$("#totalPrice").val(totalPrice);
    	$("#totalPoint").html(totalPoint);
    	$("#totalPoint").val(totalPoint);
    	$("#selectedGoodsTotal").html(selectedTotal);
    	$("#selectedGoodsTotal").val(selectedTotal);
    }
    
    /*关闭微信ui  */
    function suer(){
    	$(".weui_dialog_alert").attr("style", "display:none");
    }
    function deleteSC(){
    	var goods= document.getElementsByName("goods-select");
    	var scMap = new Array();
    	var c = 0;
    	for(var i=0;i<goods.length;i++){
    		var checked = goods[i].getAttribute("ng-checked");
    		if(checked == 'true'){
    			var SC_ID = goods[i].getAttribute("sc-id");
    			var scId = new scIdFn(SC_ID);
    			scMap.push(scId);
    			c ++;
			}
    	}
    	if(c > 0){
    		var record = {"scMap":scMap};
    		$.ajax({
       			url:"${ctx}/TWeb/cart/deleteSC.htmls",
       			type:"post",
       			data:JSON.stringify(record),
       			dataType:"json",
       			cache:false,
       			contentType: "application/json;",
       			success:function(data){
       				if(data.flag){
       					window.location = "${ctx}/TWeb/cart/memberShopCart.htmls";
       				}else{
       					$("#loadingToast").attr("style", "display:none");
       					$(".weui_dialog_bd").html("操作失败！");
       					$(".weui_dialog_alert").removeAttr("style");
       				}
       				}
       			});
    	}else{
    		return false;
    	}
   		
    }
    function scIdFn(scId){
    	this.SC_ID = scId;
    	return this;
    }	
</script>
</body>
</html>