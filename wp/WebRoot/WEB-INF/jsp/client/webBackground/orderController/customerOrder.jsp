<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../../../common/common_header.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>角色分页列表</title>
<meta http-equiv="X-UA-Compatible" content="IE=8"/>
<%@ include file="../../../common/common_header.jsp"%>
<!--通用控件  -->
<link rel="stylesheet" href="${ctx}/skin/common/css/elementStyle.css"/>
<!--开关控件  -->
	<link rel="stylesheet" href="${ctx}/skin/switchery/css/switchery.css" />
	<script src="${ctx}/skin/switchery/js/switchery.js"></script>
	<!--end  -->
	<!-- 日期选择器  -->
    <script type="text/javascript" src="${ctx }/skin/statistics/js/dateRange.js"></script>
    <script type="text/javascript" src="${ctx }/skin/statistics/js/monthPicker.js"></script>
    <link rel="stylesheet" type="text/css" href="${ctx }/skin/statistics/css/dateRange.css"/>
    <link rel="stylesheet" type="text/css" href="${ctx }/skin/statistics/css/monthPicker.css"/>
<script type="text/javascript">
$(document).ready(function(){
	  $("#addGoodsClass").click(function(){
		  window.location.href="${ctx}/goodsClassBC/addGoodsClass.do";
	  });
	});
	function orderDeal(orderId,openId,memberId){
		window.location.href="${ctx}/orders/orderDeal.do?ORDER_ID="+orderId+"&OPEN_ID="+openId+"&MEMBER_ID="+memberId;
	}
	function orderDetail(orderId,openId,memberId){
		window.location.href="${ctx}/orders/orderDetail.do?ORDER_ID="+orderId+"&OPEN_ID="+openId+"&MEMBER_ID="+memberId;
	}
	function dealType(){
		var type = $("#selectDealType").val();
		$("#DEAL_TYPE").val(type);
		document.getElementById("queryForm").submit();
	}
</script>
</head>
<body>
	<div class="modstitle">
                <h3>顾客订单</h3>
     </div>
	<div class="right_con" style="height: 100%">
		<div class="alert">
                <!-- <p>生成自定义菜单,必须在已经保存的基础上进行,临时勾选启用点击生成是无效的! 第一步必须先修改保存状态！第二步点击生成!</p>
                <p>当您为自定义菜单填写链接地址时请填写以"http://"开头，这样可以保证用户手机浏览的兼容性更好</p>
                <p>撤销自定义菜单：撤销后，您的微信公众帐号上的自定义菜单将不存在；如果您想继续在微信公众帐号上使用自定义菜单，请点击“生成自定义菜单”按钮，将重新启用！</p>  -->
            </div>
		<div class="form_box" style="padding-left: 0px; margin-top: 10px;">
			<div class="tools">
    	
    	
    	
    	<ul class="toolbar toolbar-ul" style="width: 1016px;">
				    			<form id="queryForm" action="${ctx}/orders/customerOrder.do" method="post" >
				    			<input type="hidden" value="${record.DEAL_TYPE }" name="DEAL_TYPE" id="DEAL_TYPE"/>
								<li style="cursor:default;">&nbsp;订单编号：<input type="text" name="ORDER_ID" value="${record.ORDER_ID }" class="search-input" style="height: 20px; width: 150px;"/>
								<span onclick="$('#queryForm').submit();" style="float:right"><img src="${ctx}/skin/default/images/search.png" class="search-img" style="width: 24px;height:24px;"/></span></li> 		
								</form>
				        <!-- <div class="ta_date" id="div_date1" style="margin-right: 5px;">
               				 <span class="date_title" id="date1"></span>
                            <a class="opt_sel" id="input_trigger1" href="#" style="height: 32px;line-height: 35px;">
                                <i class="i_orderd" style="display:inline;"></i>
                            </a>
                        </div> -->
                        <%-- <input type="text" class="zero-input-text" style="height: 25px; width: 140px; float: left; margin-top: 1px; margin-bottom: 1px;"/>
       			 
        <li><span><img src="${ctx}/skin/skinExample/images/icon08.png" style="width: 24px; height: 24px;"/></span>地区</li> --%>
         <select id="selectDealType" class="zero-select-base zero-select select-class" onchange="dealType();" style="height: 33px; width: 150px; float: left; margin-top: 1px; margin-bottom: 1px;">
				       		<option value="">全部订单</option>
							<option value="0" ${record.DEAL_TYPE eq '0' ? 'selected':''}>未处理</option>
							<option value="1" ${record.DEAL_TYPE eq '1' ? 'selected':''}>正在配货</option>
							<option value="2" ${record.DEAL_TYPE eq '2' ? 'selected':''}>已发货</option>
							<option value="3" ${record.DEAL_TYPE eq '3' ? 'selected':''}>交易完成</option>
							<option value="10" ${record.DEAL_TYPE eq '10' ? 'selected':''}>订单取消</option>
							<option value="30" ${record.DEAL_TYPE eq '30' ? 'selected':''}>订单信息待补充</option>
				        </select>
        </ul>
        
        
        <%-- <ul class="toolbar1">
        <li><span><img src="${ctx}/skin/default/images/t05.png" /></span>发布排序</li>
        </ul> --%>
    
    </div>
		</div>
		
		<div class="right_list">
			<table class="tablelist">
				<tr>
					<th width="4%" align="center">编号&nbsp;&nbsp;</th>
					<th width="17%" align="center">订单编号</th>
					<th width="10%" align="center">顾客</th>
					<th width="8%" align="center">城市</th>
					<th width="8%" align="center">总价&nbsp;&nbsp;<span class="zero-icon-rank" style=" text-indent: 0px;">
						<i class="zero-arrow zero-arrow-up"></i>
						<i class="zero-arrow zero-arrow-down"></i>
						</span></th>
					<th width="7%" align="center">支付方式</th>
					<th width="11%" align="center">状态&nbsp;&nbsp;<!-- <span class="zero-icon-rank" style=" text-indent: 0px;">
						<i class="zero-arrow zero-arrow-up"></i>
						<i class="zero-arrow zero-arrow-down"></i>
						</span> --></th>
					<th width="11%" align="center">下单时间&nbsp;&nbsp;<span class="zero-icon-rank" style=" text-indent: 0px;">
						<i class="zero-arrow zero-arrow-up"></i>
						<i class="zero-arrow zero-arrow-down"></i>
						</span></th>
					<!-- <th width="11%" align="center">处理时间&nbsp;&nbsp;<span class="zero-icon-rank" style=" text-indent: 0px;">
						<i class="zero-arrow zero-arrow-up"></i>
						<i class="zero-arrow zero-arrow-down"></i>
						</span></th> -->
					<th width="7%" align="center">操作</th>
				</tr>
				<c:forEach var="r" items="${pageView.records}" varStatus="status">
				<tr id="tr_${status.index}">
		        <td>${(pageView.pageNow - 1) * pageView.pageSize + status.index + 1}</td>
		        <td>${r.ORDER_ID }</td>
		        <td>${r.CUSTOMER_NAME }</td>
		        <td>${r.CITY }</td>
		        <td>￥${r.TOTAL_PRICE }</td>
		        <td>${r.PAY_TYPE eq '1'? '<a>在线支付</a>': '<a>线下支付</a>' }</td>
		        <td>
		        	<c:if test="${r.DEAL_TYPE =='0' }">
		        	<a style="color:red;">未处理</a>
		        	</c:if>
		        	<c:if test="${r.DEAL_TYPE =='1' }">
		        	<a style="color:#f46a6a;">正在配货</a>
		        	</c:if>
		        	<c:if test="${r.DEAL_TYPE =='2' }">
		        	<a style="color:#2aed3d;">已发货</a>
		        	</c:if>
		        	<c:if test="${r.DEAL_TYPE =='3' }">
		        	<a style="color:#48abf3;">交易完成</a>
		        	</c:if>
		        	<c:if test="${r.DEAL_TYPE =='10' }">
		        	<a style="color:#ae3db3;">订单取消</a>
		        	</c:if>
		        	<c:if test="${r.DEAL_TYPE =='30' }">
		        	<a style="color:#ae3db3;">订单信息待补充</a>
		        	</c:if>
		        </td>
		        <td>${r.CREATE_TIME }</td>
		       	<!-- <td>2013-09-06 10:36</td> -->
		        <td>
		        <c:if test="${r.DEAL_TYPE =='0' || r.DEAL_TYPE == '1' || r.DEAL_TYPE == '2' || r.DEAL_TYPE == '30'}">
	        	<a href="#" class="tablelink" onclick="orderDeal('${r.ORDER_ID}','${r.OPEN_ID}','${r.MEMBER_ID}')">处理</a>
	        	</c:if>
	        	<c:if test="${r.DEAL_TYPE =='10' || r.DEAL_TYPE == '3'}">
	        	<a href="#" class="tablelink" onclick="orderDetail('${r.ORDER_ID}','${r.OPEN_ID}','${r.MEMBER_ID}')">详情</a>
	        	</c:if>
	        	</td>
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
		        <td>2013-09-06 10:36</td>
		        <td>2013-09-06 10:36</td>
		        <td><a href="#" class="tablelink" onclick="orderDeal()">处理</a>  &nbsp;&nbsp;    <a href="#" onclick="orderDetail()" class="tablelink">详情</a></td>
		        </tr> -->
				<%-- <c:forEach var="r" items="${pageView.records}" varStatus="status">
					<tr>
						<td><input class="formcheckbox" type="checkbox" name="check" value="${r.ROLE_ID}" /></td>
						<td>${(pageView.pageNow - 1) * pageView.pageSize + status.index + 1}</td>
						<td>${r.ROLE_NAME }</td>
						<td>${r.ROLE_TYPE }</td>
						<td>${r.ROLE_DESC }</td>
						<td>${r.CREATE_TIME }</td>
						<td><a href="javascript:forUpdate('${r.ROLE_ID}');">修改</a> 
						<a href="javascript:forAcFuncCheckTree('${r.ROLE_ID}','${r.APP_ID}');">功能分配</a> 
						<a href="javascript:forOmEmployeeCheckTree('${r.ROLE_ID}');">关联人员</a>
						<a href="javascript:forAcHomeModuleCheck('${r.ROLE_ID}','${r.APP_ID}');">首页模块</a></td>
					</tr>
				</c:forEach> --%>
			</table>
			<%@ include file="../../../common/pagination_tail.jsp"%>
		</div>
	</div>
</body>
<script type="text/javascript">
    //var STATS_START_TIME = '1329148800';
    var dateRange1 = new pickerDateRange('date1', {
        isTodayValid : true,
        startDate : '${record.startDate}',
        endDate : '${record.endDate}',
        needCompare : false,
        defaultText : ' 至 ',
        //autoSubmit : true,
        inputTrigger : 'input_trigger1',
        theme : 'ta',
        success : function(obj) {
            //$("#dCon2").html('开始时间 : ' + obj.startDate + '<br/>结束时间 : ' + obj.endDate);
            window.location.href="${ctx}/orders/betweenTime.do?startDate="+obj.startDate+"&endDate="+obj.endDate;
        	/* $.ajax({
				url : '${ctx}/orders/betweenTime.do',
				type : "post",
				data : {"START_TIME":obj.startDate,"END_TIME":obj.endDate},
				dataType : "json",
				success : function(data) {
					//var ret = jQuery.parseJSON(data);
					
					//alert(data.msg);
					if (data.flag) {
						BaseUtils.hideWaitMsg();
					}
				}
			}); */
        }
    });

</script>
</html>
