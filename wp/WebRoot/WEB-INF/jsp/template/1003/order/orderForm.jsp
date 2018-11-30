<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<title>订单信息</title>
<script type="text/javascript" src="${ctx}/component/jQuery/jquery.min.js"></script>
<!-- wechatUI -->
<link rel="stylesheet" type="text/css" href="${ctx }/skin/common/css/weui.min.css" >
<!--end  -->
<!-- 导航 -->
<link rel="stylesheet" type="text/css" href="${ctx }/skin/tinyWebsite/css/DHstyle.css" />
<!--end  -->
<link rel="stylesheet" type="text/css" href="${ctx }/skin/tinyWebsite/order/orderform/css/orderForm.css" />
<!--form 验证 -->
<script type="text/javascript" src="${ctx}/component/layer/layer.js"></script>
<script type="text/javascript" src="${ctx}/component/layer/extend/layer.ext.js"></script>
<script type="text/javascript" src="${ctx }/Validform/js/Validform_v5.3.2.js"></script>
<link rel="stylesheet" href="${ctx }/Validform/css/style.css" />
<!--end  -->
<!-- wechatUI -->
<link rel="stylesheet" type="text/css" href="${ctx }/skin/common/css/weui.min.css" >
<!--end  -->
</head>

<body>
<h1 class="odform-tit">订单信息</h1>
	<div class="odform" >
	<div class="ui-btn-inner ui-li">
	<div class="ui-btn-text">
	<p class="ui-li-desc">
	订单编号：
	<span class="text-no">${record.ORDER_ID }</span>
	</p>
	<p class="ui-li-desc">
	创建时间：
	<span class="text-no">${record.CREATE_TIME }</span>
	</p>
	<p class="ui-li-desc">
	总价：
	<span class="text-no">￥ ${record.TOTAL_PRICE }</span>
	<span class="text-no" style="float: right;width: 150px;">总积分：<span class="text-no">${record.TOTAL_POINT }</span></span>
	</p>
	<p class="ui-li-desc">
	订单状态：
	<span class="text-no">填写信息，确认下单</span>
	</p>
	</div>
	<span class="ui-icon ui-icon-arrow-r ui-icon-shadow"> </span>
	</div>
	<form action="${ctx}/TWeb/order/updateOrder.htmls" id="orderForm" name="orderForm" method="post" class="basic-grey registerform">
		<input type="hidden" name="ORDER_ID" value="${record.ORDER_ID }"  datatype="*" nullmsg="此订单已失效，或者已确认，请勿重复操作！" >
		
		<div class="input-group">
			<label for="wdname">客户姓名：</label>
			<input type="text" name="CUSTOMER_NAME" value="${record.CUSTOMER_NAME }"  placeholder="下单的客户姓名" datatype="s1-10" nullmsg="请填写客户姓名！" errormsg="客户名字最多10个字！">
			
		</div>
		<div class="input-group">
			<label for="khname">手机号码：</label>
			<input type="text" name="ORDER_PHONE" value="${record.ORDER_PHONE }" placeholder="下单客户的联系方式" datatype="m" nullmsg="请填写单客户手机！" errormsg="请填写正确格式手机号！">
		</div>
		<div class="input-group">
			<label for="khname">收件人姓名：</label>
			<input type="text" name="CONSIGNEE" value="${record.CONSIGNEE }" placeholder="收件人的姓名" datatype="s1-10" nullmsg="请填写收件人姓名！" errormsg="收件人最多10个字！">
		</div>
		<div class="input-group">
			<label for="khname">收件人手机：</label>
			<input type="text" name="ADDRESS_PHONE" value="${record.ADDRESS_PHONE }" placeholder="收件人的联系方式" datatype="m" nullmsg="请填写收件人手机！"  errormsg="收件人手机请填写正确格式！">
		</div>
		<div class="input-group">
			<label for="khname">收件人地址：</label>
			<!-- <input type="text" class="cal" id="khname" placeholder="请选择提现时间"> -->
			<input type="text" name="ADDRESS" value="${record.ADDRESS }" placeholder="省     市     详细地址" datatype="s7-35" nullmsg="请填写收件人地址！" errormsg="请填写详细地址，最多35个字！">
		</div>
		<div class="input-group">
			<label for="khname">买家留言：</label>
			<input type="text" name="BUYER_LEAVE_MESSAGE" value="${record.BUYER_LEAVE_MESSAGE }" placeholder="备注" datatype="*0-40"  errormsg="最多40字！">
		</div>
		<div class="input-group">
			<label for="wdname">支付方式：</label>
			<input type="text" readonly="readonly" class="xl" id="wdname" placeholder="线下支付">
			
		</div>
		<!-- <div class="input-group" style="margin-bottom: 35px;">
			<div class="weui_cells">
				<div class="weui_cell weui_cell_select">
					<div class="weui_cell_bd weui_cell_primary">
					<select class="weui_select" name="PAY_TYPE" style="padding-left: 0px;">
					<option selected="">支付方式</option>
					<option value="2">线下支付</option>
					<option value="3">在线余额支付</option>
					</select>
					</div>
				</div>
			</div>
		</div> -->
		
			
		<button id="save">确认下单</button>
	</form>
</div>
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
<script type="text/javascript">
function suer(){
	$(".weui_dialog_alert").attr("style", "display:none");
}
var index;
/*通用验证框架  */
$("body").append("<!--验证的遮蔽层  -->"  
		+"<div id=\"mask\" class=\"mask\"></div>"
		+"<!-- end -->");
$(function(){
	//$(".registerform").Validform();  //就这一行代码！;
	$(".registerform:eq(0)").Validform({
		btnSubmit:"#save",
		tipSweep:true,
		tiptype:1,
		/* tiptype:function(msg,o,cssctl){
			o.obj.attr("ok","ok");
			alert(msg+"___"+o.obj+"______"+o.type+"___"+o.conform);
			
		    //msg：提示信息;
		    //o:{obj:*,type:*,curform:*},
		    //obj指向的是当前验证的表单元素（或表单对象，验证全部验证通过，提交表单时o.obj为该表单对象），
		    //type指示提示的状态，值为1、2、3、4， 1：正在检测/提交数据，2：通过验证，3：验证失败，4：提示ignore状态, 
		    //curform为当前form对象;
		    //cssctl:内置的提示信息样式控制函数，该函数需传入两个参数：显示提示信息的对象 和 当前提示的状态（既形参o中的type）;
		}, */
		ajaxPost:true,
		beforeCheck:function(curform){
			//在表单提交执行验证之前执行的函数，curform参数是当前表单对象。
			//这里明确return false的话将不会继续执行验证操作;	
		},
		beforeSubmit:function(curform){
			//在验证成功后，表单提交前执行的函数，curform参数是当前表单对象。
			//这里明确return false的话表单将不会提交;
			/* $.ajax({
				url : $("#orderForm").attr("action"),
				type : "post",
				data : $("#orderForm").serialize(),
				dataType : "json",
				success : function(data) {
					//var ret = jQuery.parseJSON(data);
					
					alert(data.msg);
					if (data.flag) {
						
					}
				}
			}); */
			index = layer.load(1, {
			    shade: [0.1,'#fff'] //0.1透明度的白色背景
			});
		},
		callback:function(data){
			layer.close(index);
				if(data.status=="y"){
					setTimeout(function(){
						$.Showmsg(data.msg);
						window.location="${ctx}/TWeb/bs/home.htmls";
						$.Hidemsg(); //公用方法关闭信息提示框;显示方法是$.Showmsg("message goes here.");
					},2000);
				}else{
					
					$.Showmsg(data.msg);
					window.location="${ctx}/TWeb/bs/home.htmls";
				}
			//返回数据data是json对象，{"info":"demo info","status":"y"}
			//info: 输出提示信息;
			//status: 返回提交数据的状态,是否提交成功。如可以用"y"表示提交成功，"n"表示提交失败，在ajax_post.php文件返回数据里自定字符，主要用在callback函数里根据该值执行相应的回调操作;
			//你也可以在ajax_post.php文件返回更多信息在这里获取，进行相应操作；
			//ajax遇到服务端错误时也会执行回调，这时的data是{ status:**, statusText:**, readyState:**, responseText:** }；
	 
			//这里执行回调操作;
			//注意：如果不是ajax方式提交表单，传入callback，这时data参数是当前表单对象，回调函数会在表单验证全部通过后执行，然后判断是否提交表单，如果callback里明确return false，则表单不会提交，如果return true或没有return，则会提交表单。
		}
	});
})
</script>
</html>