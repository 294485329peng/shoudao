<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../../../common/common_header.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>商品分类</title>
<meta http-equiv="X-UA-Compatible" content="IE=8"/>
<%@ include file="../../../common/common_header.jsp"%>
<link href="${ctx}/skin/skinExample/css/style.css" rel="stylesheet" type="text/css" />
<!--开关控件  -->
	<link rel="stylesheet" href="${ctx}/skin/switchery/css/newSwitchery.css" />
	<!--end  -->
<script type="text/javascript">
$(document).ready(function(){
	  $("#addGoodsClass").click(function(){
		  window.location.href="${ctx}/goodsClassBC/addGoodsClass.do";
	  });


	});
function updateClass(GOODS_CLASSIFY_ID){
	window.location.href="${ctx}/goodsClassBC/forUpdateGoodsClass.do?GOODS_CLASSIFY_ID="+GOODS_CLASSIFY_ID;
}
function deleteClass(id){
	defaultConfirm("删除后不可恢复，并可能影响该类下的商品，无法显示！",(function(){
		BaseUtils.showWaitMsg();
		$.ajax({
			type: "post",
			url:'${ctx}/goodsClassBC/deleteClass.do',
			data : {"GOODS_CLASSIFY_ID":id},
			dataType:"json",
			success : function(data) {
				//var ret = jQuery.parseJSON(data);
				
				alert(data.msg);
				if (data.flag) {
					$('#queryForm').submit();
					BaseUtils.hideWaitMsg();
				}
				
			}
		});
	}));
}
function updateSwitchery(GOODS_CLASSIFY_ID,id){
	var PUBLISH = "";
	
	if($("#"+id).is(':checked') == true){
		PUBLISH = "on";
	}else{
		PUBLISH = "off";
	}
	
	BaseUtils.showWaitMsg();
	$.ajax({
		url : "${ctx}/goodsClassBC/updateClass.do",
		type : "post",
		data : {"PUBLISH":PUBLISH,"GOODS_CLASSIFY_ID":GOODS_CLASSIFY_ID},
		dataType : "json",
		success : function(data) {
			if(!data.flag){
				//反向选择如果当前变化到true 则记录 false；当错误时可以再返回！！所以要反向记录！
				if(PUBLISH == "on"){
					 $("#"+id).prop("checked",false);
				}else{
					 $("#"+id).prop("checked",true);
				}
			}
			BaseUtils.hideWaitMsg();
			alert(data.msg);
			
		
		}
	});  
}
</script>
</head>
<body>
	<div class="modstitle">
                <h3>商品分类</h3>
            </div>
	<div class="right_con" style="height: 100%">
		<div class="alert">
                <p>注意：对商品分类信息进行管理!</p>
                <!-- <p>生成自定义菜单,必须在已经保存的基础上进行,临时勾选启用点击生成是无效的! 第一步必须先修改保存状态！第二步点击生成!</p>
                <p>当您为自定义菜单填写链接地址时请填写以"http://"开头，这样可以保证用户手机浏览的兼容性更好</p>
                <p>撤销自定义菜单：撤销后，您的微信公众帐号上的自定义菜单将不存在；如果您想继续在微信公众帐号上使用自定义菜单，请点击“生成自定义菜单”按钮，将重新启用！</p>  -->
            </div>
		<div class="form_box" style="padding-left: 0px; margin-top: 10px;">
			<div class="tools">
    
    	<ul class="toolbar toolbar-ul" style="width: 616px;">
				    	<form id="queryForm" action="${ctx}/goodsClassBC/goodsClass.do" method="post">
    						<input name="pageNow" type="hidden" value="${pageView.pageNow}" />
								<li style="cursor:default;">&nbsp;分类名称：<input type="text" name="CLASSIFY_NAME" value="${record.CLASSIFY_NAME }" class="search-input" style="height: 20px; width: 150px;"/>
								<span style="float:right" onclick="$('#queryForm').submit();"><img src="${ctx}/skin/default/images/search.png" class="search-img" style="width: 24px;height:24px;"/></span></li> 		
						</form>
				        
				        <li id="addGoodsClass" class="click"><span><img src="${ctx}/skin/default/images/t01.png" /></span>添加分类</li>
        				
        <!-- li><span><img src="images/t03.png" /></span>删除</li>
        <li><span><img src="images/t04.png" /></span>统计</li> -->
        </ul>
        
        
        <%-- <ul class="toolbar1">
        <li><span><img src="${ctx}/skin/default/images/t05.png" /></span>发布排序</li>
        </ul> --%>
    
    </div>
		</div>

		<div class="right_list">
			<table class="tablelist">
				<tr>
					<th width="6%" align="center">编号&nbsp;&nbsp;<i class="sort"><img src="${ctx}/skin/default/images/px.gif" /></i></th>
					<th width="15%" align="center">分类名称</th>
					<th width="37%" align="center">描述</th>
					<th width="10%" align="center">开启</th>
					<th width="13%" align="center">创建时间</th>
					<th width="13%" align="center">操作</th>
				</tr>
				<c:forEach var="r" items="${pageView.records}" varStatus="status">
				 <tr id="tr_${status.index}" style="height: 45px;">
		        <td>${(pageView.pageNow - 1) * pageView.pageSize + status.index + 1}</td>
		        <td>${r.CLASSIFY_NAME }</td>
		        <td>${r.DETAIL }</td>
		        <td><section class="model-2">
			  <div class="checkbox checkbox_normal">
			    <input id="PUBLISH_${status.index}" type="checkbox" ${r.PUBLISH eq 'on' ? 'checked=""' : ''} onchange="updateSwitchery('${r.GOODS_CLASSIFY_ID}','PUBLISH_${status.index}');"/>
			    <label style="width: 54px; height: 33px;" class="checkbox-lebal-normal"></label>
			  </div></section></td>
		        <td>${r.CREATE_TIME }</td>
		       
		        <td><a class="a_link"  style="cursor:pointer"  onclick="updateClass('${r.GOODS_CLASSIFY_ID}')">编辑</a>&nbsp;&nbsp;&nbsp;&nbsp;<a onclick="deleteClass('${r.GOODS_CLASSIFY_ID}')" class="a_link" style="cursor:pointer" >删除</a></td>
		        </tr>
		        </c:forEach>
		        
			</table>
			<%@ include file="../../../common/pagination_tail.jsp"%>
		</div>
	</div>
</body>
</html>
