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
	
	<title>无标题文档</title>
	
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
		if(count > 50){
			  alert("添加数量达到上限！");
			  return false;
		  }
	  window.location.href="${ctx}/goodsBC/addGoods.do";
  });
  $(".goodsEdit").click(function(){
	  var id = $(this).attr("data-id");
	  BaseUtils.showWaitMsg();
	  window.location.href="${ctx}/goodsBC/forUpdateGoods.do?GOODS_ID="+id ;
  });
  $(".goodsDelete").click(function(){
	  var id = $(this).attr("data-id");
	  defaultConfirm("确定要删除？<font color='red'>该操作不可逆，并删除所有关联项！</font> ",(function(){
		  
		  BaseUtils.showWaitMsg();
	      $.ajax({
			url : '${ctx}/goodsBC/deleteGoods.do',
			type : "post",
			data : {"GOODS_ID":id},
			dataType : "json",
			success : function(data) {
				//var ret = jQuery.parseJSON(data);
				BaseUtils.hideWaitMsg();
				alert(data.msg);
				if (data.flag) {
					$('#queryForm').submit();
					BaseUtils.hideWaitMsg();
				}
			}
		});
		}));
	  
  });
});
function classQueryPage(CLASSIFY1){
	$("#CLASSIFY1").val(CLASSIFY1);
	window.location.href="${ctx}/goodsBC/goodsList.do?CLASSIFY1="+CLASSIFY1;
}
/**
*添加分组
*/
function addGroupLayer() {
	window.location.href="${ctx}/goodsClassBC/addGoodsClass.do";
	/* layer.open({
	    type: 2,
	    area: ['700px', '530px'],
	    fix: false, //不固定
	    maxmin: true,
	    content: '${ctx}/goodsBC/addGoodsClass.do'
	});  */
}

</script>
</head>


<body>

	<div class="modstitle">
                <h3>商品列表</h3>
     </div>
    
    <div class="rightinfo">
    
    <div class="tools">
    
    	<ul class="toolbar toolbar-ul">
				    	<form id="queryForm" action="${ctx}/goodsBC/goodsList.do" method="post">
				    			<input name="pageNow" type="hidden" value="${pageView.pageNow}" />
				    			<input id="CLASSIFY1" name="CLASSIFY1" type="hidden" value="${record.CLASSIFY1}" />
								<li style="cursor:default;">&nbsp;标题：<input type="text" name="GOODS_NAME" value="${record.GOODS_NAME }" class="search-input" />
								<span style="float:right" onclick="$('#queryForm').submit();"><img src="${ctx}/skin/default/images/search.png" class="search-img" /></span></li> 		
						</form>
				        <li style="padding-left: 10px; width: 273px;">
				        	商品类别：
				        <select class="zero-select-base zero-select select-class" style="width: 200px;" >
				        	<option onclick="classQueryPage('')" >全部</option>
				        	<c:forEach var="c" items="${classList}" varStatus="status">
				       		<option onclick="classQueryPage('${c.GOODS_CLASSIFY_ID }')" ${record.CLASSIFY1 eq c.GOODS_CLASSIFY_ID ? 'selected':''}>${c.CLASSIFY_NAME }</option>
				       		</c:forEach>
							
				        </select>
				        </li>
				        <li id="addGoods" class="click"><span><img src="${ctx}/skin/default/images/t01.png" /></span>添加商品</li>
        				<li class="click" onclick="addGroupLayer();"><span><img src="${ctx}/skin/default/images/t02.png" /></span>添加类别</li>
        <!-- li><span><img src="images/t03.png" /></span>删除</li>
        <li><span><img src="images/t04.png" /></span>统计</li> -->
        </ul>
        
        
        <%-- <ul class="toolbar1">
        <li><span><img src="${ctx}/skin/default/images/t05.png" /></span>发布排序</li>
        </ul> --%>
    
    </div>
    
    <div class="right_list">
    <table class="imgtable">
    
    <thead>
    <tr>
    <th width="100px;">缩略图</th>
    <th width="35%;">标题</th>
    <th width="17%;">分类</th>
    <th width="12%;">响应</th>
    <th width="12%;">开启</th>
    <th>操作</th>
    </tr>
    </thead>
    
    <tbody>
    <c:forEach var="r" items="${pageView.records}" varStatus="status">
    <tr id="tr_${status.index}">
    <td class="imgtd"><img src="${r.PIC_URL1 }" Style="width:100px;height:75px;"/></td>
    <td><a href="#">${r.GOODS_NAME}</a></td>
    <td><c:forEach var="c" items="${classList}" varStatus="status">
    	<c:if test="${c.GOODS_CLASSIFY_ID eq r.CLASSIFY1}">${c.CLASSIFY_NAME }</c:if>
    </c:forEach>
    </td>
    <td>开放浏览</td>
    <td><section class="model-2">
			  <div class="checkbox checkbox_normal">
			    <input id="PUBLISH_${status.index}" type="checkbox" ${r.PUBLISH eq 'on' ? 'checked=""' : ''} onchange="updateSwitchery('${r.GOODS_ID}','PUBLISH_${status.index}');"/>
			    <label style="width: 54px; height: 33px;" class="checkbox-lebal-normal"></label>
			  </div></section></td>
    <td><a class="a_link goodsEdit" data-id="${r.GOODS_ID}" href="#">编辑</a>&nbsp;&nbsp;&nbsp;&nbsp;<a class="a_link goodsDelete" data-id="${r.GOODS_ID}" href="#">删除</a> 
		</td>
    </tr>
    </c:forEach>
    <%-- <tr>
    <td class="imgtd"><img src="${ctx}/skin/default/images/img12.png" /></td>
    <td><a href="#">一套简约形状图标UI下载</a><p>发布时间：2013-10-12 09:25:18</p></td>
    <td>图标设计<p>ID: 82122</p></td>
    <td>开放浏览</td>
    <td><div class="switch_is">
        	<input id="switch_check1" class="js-switch" type="checkbox" ${record.IS_OPEN eq '1' ? 'checked=""' : ''} onchange="switchery();" />
						
        </div></td>
    <td>235</td>
    </tr> --%>
    
    
    </tbody>
    
    </table>
    
   
   <div class="pagin">
    	<%@ include file="../../../common/pagination_tail.jsp"%>
    </div> 
   </div>
    
    
    
    
    
<!-- <script type="text/javascript">
	$('.imgtable tbody tr:odd').addClass('odd');
	</script> -->
    
</body>
<script type="text/javascript">
function updateSwitchery(GOODS_ID,id){
	var PUBLISH = "";
	
	if($("#"+id).is(':checked') == true){
		PUBLISH = "on";
	}else{
		PUBLISH = "false";
	}
	
	BaseUtils.showWaitMsg();
	$.ajax({
		url : "${ctx}/goodsBC/updatePublish.do",
		type : "post",
		data : {"PUBLISH":PUBLISH,"GOODS_ID":GOODS_ID},
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
