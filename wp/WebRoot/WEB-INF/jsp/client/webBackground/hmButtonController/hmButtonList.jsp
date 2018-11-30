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
	<title>按钮列表</title>

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
  $("#addButton").click(function(){
	  if(count > 7){
		  alert("最多添加8个首页按钮！");
		  return false;
	  }
	  window.location.href="${ctx}/HmBt/addHmButton.do";
  });
});
function updateBt(BT_ID){
	window.location.href="${ctx}/HmBt/addHmButton.do?BT_ID="+BT_ID;
}
function deleteBt(id){
	defaultConfirm("你确定要删除吗，可能关联首页信息？删除后不可恢复！",(function(){
		BaseUtils.showWaitMsg();
		$.ajax({
			type: "post",
			url:'${ctx}/HmBt/delete.do',
			data : {"BT_ID":id},
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
                <h3>按钮列表</h3>
     </div>
    
    <div class="rightinfo">
    
    <div class="tools">
    
    	<ul class="toolbar toolbar-ul">
				    	<form id="queryForm" action="${ctx}/HmBt/hmButtonList.do" method="post">
				    			<input name="pageNow" type="hidden" value="${pageView.pageNow}" />
								<li style="cursor:default;">&nbsp;名称：<input type="text" name="NAME" value="${record.NAME }" class="search-input" />
								<span style="float:right" onclick="$('#queryForm').submit();"><img src="${ctx}/skin/default/images/search.png" class="search-img" style="cursor:pointer" /></span></li> 		
						</form>
				        <!-- <li style="padding-left: 10px;">
				        	商品类别：
				        <select class="zero-select-base zero-select select-class" >
				       		<option value="1">商品类别1</option>
							<option value="2">商品类别2</option>
				        </select>
				        </li> -->
				        <li id="addButton" class="click"><span><img src="${ctx}/skin/default/images/t01.png" /></span>添加按钮</li>
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
    <th style=" text-indent: 11px;width: 50px;">编号</th>
    <th width="auto;">缩略图</th>
    <th width="40%;">名称</th>
    <th width="20%;">时间</th>
    <!-- <th width="15%;">开启</th> -->
    <th >操作</th>
    </tr>
    </thead>
    
    <tbody>
    <c:forEach var="r" items="${pageView.records}" varStatus="status">
    <tr id="tr_${status.index}">
    <td>${(pageView.pageNow - 1) * pageView.pageSize + status.index + 1}</td>
    <td class="imgtd"><img src="${r.PIC_URL }" style="width: 201px; height: 82px;"/></td>
    <td><a href="#" onclick="updateAc('${r.BT_ID}')">${r.NAME }</a></td>
    <td>${r.CREATE_TIME }</td>
    <%-- <td>
        <section class="model-2">
			  <div class="checkbox checkbox_normal">
			    <input id="PUBLISH_${status.index}" type="checkbox" ${r.PUBLISH eq 'on' ? 'checked=""' : ''} onchange="updateSwitchery('${r.BT_ID}','PUBLISH_${status.index}');"/>
			    <label style="width: 54px; height: 33px;" class="checkbox-lebal-normal"></label>
			  </div></section></td> --%>
    <td><a class="a_link"  style="cursor:pointer"  onclick="updateBt('${r.BT_ID}')">编辑</a>&nbsp;&nbsp;&nbsp;&nbsp;<a onclick="deleteBt('${r.BT_ID}')" class="a_link" style="cursor:pointer" >删除</a> 
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

    
	function updateSwitchery(BT_ID,id){
		var PUBLISH = "";
		
		if($("#"+id).is(':checked') == true){
			PUBLISH = "on";
		}else{
			PUBLISH = "false";
		}
		
		BaseUtils.showWaitMsg();
		$.ajax({
			url : "${ctx}/HmBt/update.do",
			type : "post",
			data : {"PUBLISH":PUBLISH,"BT_ID":BT_ID},
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
