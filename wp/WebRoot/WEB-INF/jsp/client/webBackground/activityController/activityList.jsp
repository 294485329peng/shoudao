<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
 <head>
 	<%@ include file="../../../common/common_header.jsp"%>
 	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
 	<link href="${ctx}/skin/skinExample/css/style.css" rel="stylesheet" type="text/css" />
 	
 	<!--共同控件  -->
	<link rel="stylesheet" href="${ctx}/skin/common/css/elementStyle.css"/>
	<!--end  -->
	<!--开关控件  -->
	<link rel="stylesheet" href="${ctx}/skin/switchery/css/newSwitchery.css" />
	
	<!--end  -->
	<!--本页专属css  -->
	<link rel="stylesheet" href="${ctx}/skin/webBase/goods/css/goodsStyle.css"/>
	<!--end  -->
	<title>活动列表</title>

<script language="javascript">
$(function(){	
	//导航切换
	$(".imglist li").click(function(){
		$(".imglist li.selected").removeClass("selected")
		$(this).addClass("selected");
	})	
})	
</script>
<script type="text/javascript">
var count = ${pageView.pageCount};
$(document).ready(function(){
  $("#addGoods").click(function(){
	  window.location.href="${ctx}/acBC/addActivity.do";
  });
});
/**
*添加分组
*/
function addGroupLayer() {
	if(count > 24){
		  alert("添加数量达到上限！");
		  return false;
	  }
	window.location.href="${ctx}/goodsClassBC/addGoodsClass.do";
	/* layer.open({
	    type: 2,
	    area: ['700px', '530px'],
	    fix: false, //不固定
	    maxmin: true,
	    content: '${ctx}/goodsBC/addGoodsClass.do'
	});  */
}
function updateAc(ACTIVITY_ID){
	window.location.href="${ctx}/acBC/forUpdateActivity.do?ACTIVITY_ID="+ACTIVITY_ID;
}
function deleteActivity(id){
	defaultConfirm("你确定要删除吗，可能关联首页信息？删除后不可恢复！",(function(){
		BaseUtils.showWaitMsg();
		$.ajax({
			type: "post",
			url:'${ctx}/acBC/delete.do',
			data : {"ACTIVITY_ID":id},
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
</script>
</head>


<body>

	<div class="modstitle">
                <h3>活动列表</h3>
     </div>
    
    <div class="rightinfo">
    
    <div class="tools">
    
    	<ul class="toolbar toolbar-ul">
				    	<form id="queryForm" action="${ctx}/acBC/activityList.do" method="post">
				    			<input name="pageNow" type="hidden" value="${pageView.pageNow}" />
								<li style="cursor:default;">&nbsp;标题：<input type="text" name="TITLE" value="${record.TITLE }" class="search-input" />
								<span style="float:right"><img src="${ctx}/skin/default/images/search.png" onclick="$('#queryForm').submit();" class="search-img" style="cursor:pointer" /></span></li> 		
						</form>
				        <!-- <li style="padding-left: 10px;">
				        	商品类别：
				        <select class="zero-select-base zero-select select-class" >
				       		<option value="1">商品类别1</option>
							<option value="2">商品类别2</option>
				        </select>
				        </li> -->
				        <li id="addGoods" class="click"><span><img src="${ctx}/skin/default/images/t01.png" /></span>添加活动</li>
        				<%-- <li class="click" onclick="addGroupLayer();"><span><img src="${ctx}/skin/default/images/t02.png" /></span>添加类别</li> --%>
        <!-- li><span><img src="images/t03.png" /></span>删除</li>
        <li><span><img src="images/t04.png" /></span>统计</li> -->
        </ul>
        
        
        <%-- <ul class="toolbar1">
        <li><span><img src="${ctx}/skin/default/images/t05.png" /></span>发布排序</li>
        </ul> --%>
    
    </div>
    <table class="imgtable">
    
    <thead>
    <tr>
    <th style=" text-indent: 11px;min-width: 45px;">编号</th>
    <th width="100px;">缩略图</th>
    <th width="20%;">标题</th>
    <th width="30%;">简介</th>
    <th width="15%;">时间</th>
    <th width="12%;">开启</th>
    <th >操作</th>
    </tr>
    </thead>
    
    <tbody>
    <c:forEach var="r" items="${pageView.records}" varStatus="status">
    <tr id="tr_${status.index}">
    <td>${(pageView.pageNow - 1) * pageView.pageSize + status.index + 1}</td>
    <td class="imgtd"><img src="${r.PIC_URL }" style="width: 80px;height:60px;"/></td>
    <td><a href="#" onclick="updateAc('${r.ACTIVITY_ID}')">${r.TITLE }</a></td>
    <td>${r.DESCRIPTION }</td>
    <td>${r.CREATE_TIME }</td>
    <td>
        <section class="model-2">
			  <div class="checkbox checkbox_normal">
			    <input id="PUBLISH_${status.index}" type="checkbox" ${r.PUBLISH eq 'on' ? 'checked=""' : ''} onchange="updateSwitchery('${r.ACTIVITY_ID}','PUBLISH_${status.index}');"/>
			    <label style="width: 54px; height: 33px;" class="checkbox-lebal-normal"></label>
			  </div></section></td>
    <td><a class="a_link"  style="cursor:pointer"  onclick="updateAc('${r.ACTIVITY_ID}')">编辑</a>&nbsp;&nbsp;&nbsp;&nbsp;<a onclick="deleteActivity('${r.ACTIVITY_ID}')" class="a_link" style="cursor:pointer" >删除</a> 
		</td>
    </tr>
    </c:forEach>
    
    
    </tbody>
    
    </table>
	<div class="pagin" style="margin-top: -10px;">
    	<%@ include file="../../../common/pagination_tail.jsp"%>
    </div>
</div>


    
    
    

    
</body>
<script type="text/javascript">

    
	function updateSwitchery(ACTIVITY_ID,id){
		var PUBLISH = "";
		
		if($("#"+id).is(':checked') == true){
			PUBLISH = "on";
		}else{
			PUBLISH = "false";
		}
		
		BaseUtils.showWaitMsg();
		$.ajax({
			url : "${ctx}/acBC/updatePublish.do",
			type : "post",
			data : {"PUBLISH":PUBLISH,"ACTIVITY_ID":ACTIVITY_ID},
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
</html>
