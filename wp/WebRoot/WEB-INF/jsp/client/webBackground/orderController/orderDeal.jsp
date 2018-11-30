<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
 <head>
 <%@ include file="../../../common/common_header.jsp"%>
 <link href="${ctx}/skin/skinExample/css/style.css" rel="stylesheet" type="text/css" />
<!--通用控件  -->
<link rel="stylesheet" href="${ctx}/skin/common/css/elementStyle.css"/>
<!--end  -->
<!--orderCss  -->
<link rel="stylesheet" href="${ctx}/skin/webBase/order/css/order.css"/>
<!--end  -->
<!--form 验证 -->
<script type="text/javascript" src="${ctx }/Validform/js/Validform_v5.3.2.js"></script>
<link rel="stylesheet" href="${ctx }/Validform/css/style.css" />
<!--end  -->
<script type="text/javascript">
$(document).ready(function(){
	  $("#addGoodsClass").click(function(){
		  window.location.href="${ctx}/goodsClassBC/addGoodsClass.do";
	  });
	});
function getGoods(id){
	 window.location.href="${ctx}/goodsClassBC/addGoodsClass.do?GOODS_ID="+id;
}
function getUser(id){
	 window.location.href="${ctx}/memberBC/memberDetail.do?OPEN_ID="+id;
}
function dealType(){
	var type = $("#DEAL_TYPE").val();
	if(type == '1' || type == '0' ){
		$("#mail").attr("style","display:none");
	}else{
		$("#mail").removeAttr("style");
	}
}
</script>
</head>
<body>
	<div class="modstitle">
                <h3>订单详情</h3>
     </div>
	<div class="right_con" style="height: 100%">
		<div class="alert">
                <p>注意：确认您的订单的详细信息!</p>
                <!-- <p>生成自定义菜单,必须在已经保存的基础上进行,临时勾选启用点击生成是无效的! 第一步必须先修改保存状态！第二步点击生成!</p>
                <p>当您为自定义菜单填写链接地址时请填写以"http://"开头，这样可以保证用户手机浏览的兼容性更好</p>
                <p>撤销自定义菜单：撤销后，您的微信公众帐号上的自定义菜单将不存在；如果您想继续在微信公众帐号上使用自定义菜单，请点击“生成自定义菜单”按钮，将重新启用！</p>  -->
        </div>
		<div class="" style="padding-left: 0px; margin-top: 10px;">
		<div class="tabs-panels">
			<div class="info-box order-info" style="display: block;">
				<h2 style="font-size: 15px;">收货信息</h2>
				<div class="bd">
				<form action="${ctx}/orders/update.do" id="orderForm1" name="orderForm1" method="post" class="basic-grey registerform">
				<div class="addr_and_note">
				<input type="hidden" name="ORDER_ID" value="${record.recordOrder.ORDER_ID }" />
				<dl>
				<dt> 收货姓名 ： </dt>
				<dd> <input type="text" name="CONSIGNEE" class="zero-input-text input-text" value="${record.recordOrder.CONSIGNEE }" datatype="s1-8" nullmsg="请填写姓名！" errormsg="名称至少1个字,最多8个字！" /> </dd>
				<dt> 联系方式 ： </dt>
				<dd> <input type="text" name="ADDRESS_PHONE" class="zero-input-text input-text"  value="${record.recordOrder.ADDRESS_PHONE }" datatype="n6-16" nullmsg="请填写联系方式！" errormsg="至少6位,最多16位数字！" /> </dd>
				<dt> 收货地址 ： </dt>
				<dd> <input type="text" name="ADDRESS" class="zero-input-text input-text" value="${record.recordOrder.ADDRESS }" datatype="s1-30" nullmsg="请填写地址！" errormsg="地址至少1个字,最多30个字！" /> </dd>
				<dt>买家留言：</dt>
				<dd>
				<input type="text" name="BUYER_LEAVE_MESSAGE"  readonly="readonly" class="zero-input-text input-text input-text-readonly" style="width:450px;" value="${record.recordOrder.BUYER_LEAVE_MESSAGE }" />
				</dd>
				</dl>
				<div style="margin-top: 10px; margin-left: 80px;">
				<input id="orderUpdate1" type="button" class="zero_btn zero_btn_primary" value="保存" />
				</div>
				</div>
				</form>
				<hr>
				<div class="contact-info">
				<h3 ><a onclick="getUser('${record.recordMember.OPEN_ID }')"  style="font-size: 15px;color: blue;cursor: pointer;">买家信息</a></h3>
				<dl>
				<dt>昵称：</dt>
				<dd>
				<input type="text" name="" readonly="readonly" class="zero-input-text input-text input-text-readonly" value="${record.recordMember.NICKNAME }" />
				</dd>
				<dt>真实姓名：</dt>
				<dd><input type="text" name="" readonly="readonly" class="zero-input-text input-text input-text-readonly" value="${record.recordMember.REAL_NAME }" /></dd>
				<dt>城市：</dt>
				<dd><input type="text" name="" readonly="readonly" class="zero-input-text input-text input-text-readonly" value="${record.recordMember.CITY }" /></dd>
				</dl>
				<dl>
				<dt>联系电话：</dt>
				<dd><input type="text" name="" readonly="readonly" class="zero-input-text input-text input-text-readonly" value="${record.recordMember.PHONE }" /></dd>
				<dt>认证：</dt>
				<dd>
				<input type="text" name="" readonly="readonly" class="zero-input-text input-text input-text-readonly" value="${record.recordMember.ATTESTATION eq '1' ? '认证' : '未认证' }" />
				</dd>
				<%-- <dt>支 付 宝：</dt>
				<dd><input type="text" name="" readonly="readonly" class="zero-input-text input-text input-text-readonly" value="${record.recordMember }" /></dd> --%>
				</dl>
				<div class="clearfix"></div>
				</div>
				<hr>
				<div class="misc-info">
				<h3 style="font-size: 15px;">订单信息</h3>
				<dl>
				<dt>订单编号：</dt>
				<dd><input type="text" name="ORDER_ID" readonly="readonly" class="zero-input-text input-text input-text-readonly" value="${record.recordOrder.ORDER_ID }" /></dd>
				<dt>支付方式：</dt>
				<dd><input type="text" name="PAY_TYPE" readonly="readonly" class="zero-input-text input-text input-text-readonly" value="${record.recordOrder.PAY_TYPE eq '1' ? '在线支付' : '线下支付' }" /></dd>
				<dt>支付状态：</dt>
				<dd><input type="text" name="IS_PAY" readonly="readonly" class="zero-input-text input-text input-text-readonly" value="${record.recordOrder.IS_PAY eq '1' ? '已支付' : '未支付' }" /></dd>
				</dl>
				<dl>
				<dt>下单时间：</dt>
				<dd><input type="text" name="CREATE_TIME"  readonly="readonly" class="zero-input-text input-text input-text-readonly" value="${record.recordOrder.CREATE_TIME }" /></dd>
				<dt>发货时间：</dt>
				<dd><input type="text" name="DELIVER_TIME" readonly="readonly" class="zero-input-text input-text input-text-readonly" value="${record.recordOrder.DELIVER_TIME }" /></dd>
				<dt>付款时间：</dt>
				<dd><input type="text" name="PAY_TIME" readonly="readonly" class="zero-input-text input-text input-text-readonly" value="${record.recordOrder.PAY_TIME }" /></dd>
				</dl>
				<dl>
				<dt>完成时间：</dt>
				<dd><input type="text" name="FINISH_TIME" readonly="readonly" class="zero-input-text input-text input-text-readonly" value="${record.recordOrder.FINISH_TIME }" /></dd>
				</dl>
				<form action="${ctx}/orders/update.do" id="orderForm" name="orderForm" method="post" class="basic-grey registerform">
				<input type="hidden" name="ORDER_ID" value="${record.recordOrder.ORDER_ID }" />
				<dl>
				<dt>下单人姓名：</dt>
				<dd><input type="text" name="CUSTOMER_NAME" class="zero-input-text input-text" value="${record.recordOrder.CUSTOMER_NAME }" datatype="s1-8" nullmsg="请填写姓名！" errormsg="名称至少1个字,最多8个字！" /></dd>
				<dt>联系方式：</dt>
				<dd><input type="text" name="ORDER_PHONE" class="zero-input-text input-text" value="${record.recordOrder.ORDER_PHONE }" datatype="n6-16" nullmsg="请填写联系方式！" errormsg="至少1位，最多16位数字！" /></dd>
				<dt>城市：</dt>
				<dd><input type="text" name="CITY" class="zero-input-text input-text" value="${record.recordOrder.CITY }" datatype="s1-12" nullmsg="请填写城市！" errormsg="名称至少1个字,最多12个字！" /></dd>
				</dl>
				<div style="margin-top: 10px; margin-left: 80px;">
				<input id="orderUpdate2" type="button" class="zero_btn zero_btn_primary" value="保存" />
				</form>
				</div>
				<div class="clearfix"></div>
				</div>
				<hr>
				<form action="${ctx}/orders/update.do" id="orderForm" name="orderForm" method="post" class="basic-grey registerform">
				<div class="contact-info">
				<input type="hidden" name="ORDER_ID" value="${record.recordOrder.ORDER_ID }" />
				<h3 style="font-size: 15px;">订单资费</h3>
				<dl>
				<dt>总价：</dt>
				<dd>
				<input type="text" name="TOTAL_PRICE" class="zero-input-text input-text" value="${record.recordOrder.TOTAL_PRICE }" datatype="money" nullmsg="请填写总价！" errormsg="请输入正确总价！" />
				</dd>
				<dt>邮费：</dt>
				<dd><input type="text" name="TRANSPORTATION_PICE" class="zero-input-text input-text" value="${record.recordOrder.TRANSPORTATION_PICE }" datatype="money" nullmsg="请填写邮费！" errormsg="请输入正确邮费价格！" /></dd>
				<dt>积分：</dt>
				<dd><input type="text" name="TOTAL_POINT" class="zero-input-text input-text" value="${record.recordOrder.TOTAL_POINT }" datatype="n0-8" errormsg="最多8位数字！" /></dd>
				</dl>
				<div style="margin-top: 10px; margin-left: 80px;">
				<input id="orderUpdate3" type="button" class="zero_btn zero_btn_primary" value="保存" />
				</div>
				<div class="clearfix"></div>
				</div>
				</form>
				<table>
				<colgroup>
				<tbody class="order">
				</table>
				<div style="margin-top: 10px; margin-left: 80px;">
				
				</div>
				</div>
				</div>
		</div>
		<div class="tabs-panels">
			<div class="info-box order-info" style="display: block;">
				<h2 style="font-size: 15px;">订单处理</h2>
				<div class="bd">
				<form action="${ctx}/orders/update.do" id="orderForm" name="orderForm" method="post" class="basic-grey registerform">
				<div class="addr_and_note">
				<input type="hidden" name="ORDER_ID" value="${record.recordOrder.ORDER_ID }" />
				<dl>
				<dt> 订单状态 ： </dt>
				<dd><select id="DEAL_TYPE" name="DEAL_TYPE" class="zero-select-base zero-select order-select" onchange="dealType();">
					<option value="0" ${record.recordOrder.DEAL_TYPE eq '0' ? 'selected':''}>未处理</option>
					<option value="1" ${record.recordOrder.DEAL_TYPE eq '1' ? 'selected':''}>正在配货</option>
					<option value="2" ${record.recordOrder.DEAL_TYPE eq '2' ? 'selected':''}>已发货</option>
					<option value="3" ${record.recordOrder.DEAL_TYPE eq '3' ? 'selected':''}>交易完成</option>
					<option value="10" ${record.recordOrder.DEAL_TYPE eq '10' ? 'selected':''}>订单取消</option>
				</select> </dd>
				<div id="mail" style="display:${record.recordOrder.DEAL_TYPE eq '2' ||  record.recordOrder.DEAL_TYPE eq '3' ? 'display':'none'}" >
				<dt>发货公司：</dt>
				<dd>
				<input type="text" name="MAIL_COMPANY"  class="zero-input-text input-text" value="${record.recordOrder.MAIL_COMPANY }" datatype="*1-15" errormsg="发货公司名称在1-15字之间！" />
				</dd>
				<dt> 发货单号 ： </dt>
				<dd> <input type="text" name="MAIL_NUMBER" class="zero-input-text input-text" value="${record.recordOrder.MAIL_NUMBER }" datatype="*6-36" errormsg="运单号范围在6~36位之间！" /> </dd>
				</div>
				<dt>卖家留言：</dt>
				<dd>
				
				<input type="text" name="SELLER_LEAVE_MESSAGE" class="zero-input-text input-text" style="width:450px;" value="${record.recordOrder.SELLER_LEAVE_MESSAGE }" datatype="*1-50" errormsg="卖家留言范围在1-50字之间！" />
				</dd>
				<div style="margin-top: 10px; margin-left: 80px;">
				<input id="orderUpdate4" type="button" class="zero_btn zero_btn_primary" value="保存" />
    			<input type="button" class="zero_btn zero_btn_red" onclick="deleteNav();" value="删除并返回" style="margin-left: 15px;"/>
				</div>
				</dl>
				</div>
				</form>
				</div>
				</div>
		</div>
		<div class="right_list">
			<form id="queryForm" action="${ctx}/orders/orderDeal.do" method="post">
	    			<input type="hidden" name="ORDER_ID" value="${record.recordOrder.ORDER_ID }" />
			</form>
			<table class="imgtable">
				<tr>
					<th width="5%" align="center">编号&nbsp;&nbsp;</th>
					<th width="9%" align="center">缩略图</th>
					<th width="10%" align="center">名称</th>
					<th width="10%" align="center">主规格</th>
					<th width="10%" align="center">子规格</th>
					<th width="10%" align="center">单价</th>
					<th width="7%" align="center">数量</th>
					<th width="8%" align="center">总价</th>
				</tr>
				<c:forEach var="r" items="${pageView.records}" varStatus="status">
				<tr id="tr_${status.index}">
		        <td>${(pageView.pageNow - 1) * pageView.pageSize + status.index + 1}</td>
		        <td class="imgtd"><img src="${r.PIC_URL }" style="width: 80px;height:60px;"/></td>
		        <td><a href="#" onclick="getGoods('${r.GOODS_ID}')">${r.GOODS_NAME }</a></td>
		        <td>${r.MAIN_SPECIFICATION}</td>
    			<td>${r.CHILD_SPECIFICATION }</td>
		        <td>￥${r.UNIT_PRICE }</td>
		        <td>${r.AMOUNT }</td>
		        <td>￥${r.TOTAL_PRICE }</td>
		        </tr>
				</c:forEach>
		        <!-- <tr>
		        <td>1</td>
		        <td>分类1</td>
		        <td>江西</td>
		        <td>vip4</td>
		        <td>青岛</td>
		        <td>100.22</td>
		        <td><a>未支付</a></td>
		        <td><a>未支付</a></td>
		        
		        </tr> -->
			</table>
		</div>
		<div class="pagin" style="margin-top: -10px;">
    	<%@ include file="../../../common/pagination_tail.jsp"%>
    	</div>
		</div>
	</div>
</body>
<script type="text/javascript">
var index;
/*通用验证框架  */
$("body").append("<!--验证的遮蔽层  -->"  
		+"<div id=\"mask\" class=\"mask\"></div>"
		+"<!-- end -->");
$(function(){
	//$(".registerform1").Validform();  //就这一行代码！;
	$(".registerform:eq(0)").Validform({
		btnSubmit:"#orderUpdate1",
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
			/* BaseUtils.showWaitMsg();
			$.ajax({
				url : $("#orderForm").attr("action"),
				type : "post",
				data : $("#orderForm").serialize(),
				dataType : "json",
				success : function(data) {
					//var ret = jQuery.parseJSON(data);
					
					//alert(data.msg);
					if (data.flag) {
						BaseUtils.hideWaitMsg();
					}
				}
			}); */
			index = layer.load(1, {
			    shade: [0.1,'#fff'] //0.1透明度的白色背景
			});
			
		},
		callback:function(data){
				if(data.status=="y"){
					$("#IS_USE").val("yes");
					setTimeout(function(){
						
						$.Hidemsg(); //公用方法关闭信息提示框;显示方法是$.Showmsg("message goes here.");
					},2000);
				}
				layer.close(index);
			//返回数据data是json对象，{"info":"demo info","status":"y"}
			//info: 输出提示信息;
			//status: 返回提交数据的状态,是否提交成功。如可以用"y"表示提交成功，"n"表示提交失败，在ajax_post.php文件返回数据里自定字符，主要用在callback函数里根据该值执行相应的回调操作;
			//你也可以在ajax_post.php文件返回更多信息在这里获取，进行相应操作；
			//ajax遇到服务端错误时也会执行回调，这时的data是{ status:**, statusText:**, readyState:**, responseText:** }；
	 
			//这里执行回调操作;
			//注意：如果不是ajax方式提交表单，传入callback，这时data参数是当前表单对象，回调函数会在表单验证全部通过后执行，然后判断是否提交表单，如果callback里明确return false，则表单不会提交，如果return true或没有return，则会提交表单。
		}
	});
	//$(".registerform1").Validform();  //就这一行代码！;
	$(".registerform:eq(1)").Validform({
		btnSubmit:"#orderUpdate2",
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
			/* BaseUtils.showWaitMsg();
			$.ajax({
				url : $("#orderForm").attr("action"),
				type : "post",
				data : $("#orderForm").serialize(),
				dataType : "json",
				success : function(data) {
					//var ret = jQuery.parseJSON(data);
					
					//alert(data.msg);
					if (data.flag) {
						BaseUtils.hideWaitMsg();
					}
				}
			}); */
			index = layer.load(1, {
			    shade: [0.1,'#fff'] //0.1透明度的白色背景
			});
			
		},
		callback:function(data){
				if(data.status=="y"){
					$("#IS_USE").val("yes");
					setTimeout(function(){
						
						$.Hidemsg(); //公用方法关闭信息提示框;显示方法是$.Showmsg("message goes here.");
					},2000);
				}
				layer.close(index);
			//返回数据data是json对象，{"info":"demo info","status":"y"}
			//info: 输出提示信息;
			//status: 返回提交数据的状态,是否提交成功。如可以用"y"表示提交成功，"n"表示提交失败，在ajax_post.php文件返回数据里自定字符，主要用在callback函数里根据该值执行相应的回调操作;
			//你也可以在ajax_post.php文件返回更多信息在这里获取，进行相应操作；
			//ajax遇到服务端错误时也会执行回调，这时的data是{ status:**, statusText:**, readyState:**, responseText:** }；
	 
			//这里执行回调操作;
			//注意：如果不是ajax方式提交表单，传入callback，这时data参数是当前表单对象，回调函数会在表单验证全部通过后执行，然后判断是否提交表单，如果callback里明确return false，则表单不会提交，如果return true或没有return，则会提交表单。
		}
	});
	//$(".registerform1").Validform();  //就这一行代码！;
	$(".registerform:eq(2)").Validform({
		btnSubmit:"#orderUpdate3",
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
			/* BaseUtils.showWaitMsg();
			$.ajax({
				url : $("#orderForm").attr("action"),
				type : "post",
				data : $("#orderForm").serialize(),
				dataType : "json",
				success : function(data) {
					//var ret = jQuery.parseJSON(data);
					
					//alert(data.msg);
					if (data.flag) {
						BaseUtils.hideWaitMsg();
					}
				}
			}); */
			index = layer.load(1, {
			    shade: [0.1,'#fff'] //0.1透明度的白色背景
			});
			
		},
		callback:function(data){
				if(data.status=="y"){
					$("#IS_USE").val("yes");
					setTimeout(function(){
						
						$.Hidemsg(); //公用方法关闭信息提示框;显示方法是$.Showmsg("message goes here.");
					},2000);
				}
				layer.close(index);
			//返回数据data是json对象，{"info":"demo info","status":"y"}
			//info: 输出提示信息;
			//status: 返回提交数据的状态,是否提交成功。如可以用"y"表示提交成功，"n"表示提交失败，在ajax_post.php文件返回数据里自定字符，主要用在callback函数里根据该值执行相应的回调操作;
			//你也可以在ajax_post.php文件返回更多信息在这里获取，进行相应操作；
			//ajax遇到服务端错误时也会执行回调，这时的data是{ status:**, statusText:**, readyState:**, responseText:** }；
	 
			//这里执行回调操作;
			//注意：如果不是ajax方式提交表单，传入callback，这时data参数是当前表单对象，回调函数会在表单验证全部通过后执行，然后判断是否提交表单，如果callback里明确return false，则表单不会提交，如果return true或没有return，则会提交表单。
		}
	});
	//$(".registerform1").Validform();  //就这一行代码！;
	$(".registerform:eq(3)").Validform({
		btnSubmit:"#orderUpdate4",
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
			/* BaseUtils.showWaitMsg();
			$.ajax({
				url : $("#orderForm").attr("action"),
				type : "post",
				data : $("#orderForm").serialize(),
				dataType : "json",
				success : function(data) {
					//var ret = jQuery.parseJSON(data);
					
					//alert(data.msg);
					if (data.flag) {
						BaseUtils.hideWaitMsg();
					}
				}
			}); */
			index = layer.load(1, {
			    shade: [0.1,'#fff'] //0.1透明度的白色背景
			});
			
		},
		callback:function(data){
				if(data.status=="y"){
					$("#IS_USE").val("yes");
					setTimeout(function(){
						$.Hidemsg(); //公用方法关闭信息提示框;显示方法是$.Showmsg("message goes here.");
					},2000);
				}
				layer.close(index);
			//返回数据data是json对象，{"info":"demo info","status":"y"}
			//info: 输出提示信息;
			//status: 返回提交数据的状态,是否提交成功。如可以用"y"表示提交成功，"n"表示提交失败，在ajax_post.php文件返回数据里自定字符，主要用在callback函数里根据该值执行相应的回调操作;
			//你也可以在ajax_post.php文件返回更多信息在这里获取，进行相应操作；
			//ajax遇到服务端错误时也会执行回调，这时的data是{ status:**, statusText:**, readyState:**, responseText:** }；
	 
			//这里执行回调操作;
			//注意：如果不是ajax方式提交表单，传入callback，这时data参数是当前表单对象，回调函数会在表单验证全部通过后执行，然后判断是否提交表单，如果callback里明确return false，则表单不会提交，如果return true或没有return，则会提交表单。
		}
	});
});
</script>
</html>
