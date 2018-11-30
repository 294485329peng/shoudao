<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
 <head>
 	<%@ include file="../../../common/common_header.jsp"%>
 	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
 	<link href="${ctx}/skin/skinExample/css/style.css" rel="stylesheet" type="text/css" />
 	<!--上传图片  -->
	<link rel="stylesheet" href="${ctx }/editor/themes/default/default.css" />
	<script charset="utf-8" src="${ctx }/editor/kindeditor.js"></script>
	<script charset="utf-8" src="${ctx }/editor/lang/zh_CN.js"></script>
	<!--end  -->
	<!--开关控件  -->
	<link rel="stylesheet" href="${ctx}/skin/switchery/css/newSwitchery.css" />
	<!--end  -->
	<title>首页活动</title>

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
  $("#addHomeAc").click(function(){
		if(count > 25){
			  alert("添加数量达到上限！");
			  return false;
		  }
	  window.location.href="${ctx}/webBgAc/forAddHomeAc.do";
  });

});
function updateHAc(HAC_ID){
	window.location.href="${ctx}/webBgAc/forUpdateHomeAc.do?HAC_ID="+HAC_ID;
}
function deleteHAc(id,pageNow){
	defaultConfirm("你确定要删除吗？删除后不可恢复！",(function(){
		BaseUtils.showWaitMsg();
		$.ajax({
			type: "post",
			url:'${ctx}/webBgAc/delete.do',
			data : {"HAC_ID":id},
			dataType:"json",
			success : function(data) {
				//var ret = jQuery.parseJSON(data);
				BaseUtils.hideWaitMsg();
				alert(data.msg);
				if (data.flag) {
					$('#queryForm').submit();
				}
			}
		});
	}));
}
</script>
</head>


<body>

	<div class="modstitle">
                <h3>首页活动</h3>
            </div>
    
    <div class="rightinfo">
    
    <div class="tools">
    	<form id="queryForm" action="${ctx}/webBgAc/homeAc.do" method="post">
    	<input name="pageNow" type="hidden" value="${pageView.pageNow}" />
    	<ul class="toolbar">
    	<li style="cursor:default;">&nbsp;标题：<input type="text" name="TITLE" value="${record.TITLE }" class="search-input" />
		<span style="float:right" onclick="$('#queryForm').submit();"><img src="${ctx}/skin/default/images/search.png" class="search-img" style="cursor:pointer;width: 24px; height: 24px;" /></span></li>
        <li id="addHomeAc" class="click"><span><img src="${ctx}/skin/default/images/t01.png" /></span>添加</li>
        <%-- <li class="click"><span><img src="${ctx}/skin/default/images/t02.png" /></span>选择开启</li> --%>
        <!-- li><span><img src="images/t03.png" /></span>删除</li>
        <li><span><img src="images/t04.png" /></span>统计</li> -->
        </ul>
        </form>
        
        <%-- <ul class="toolbar1">
        <li><span><img src="${ctx}/skin/default/images/t05.png" /></span>发布排序</li>
        </ul> --%>
    
    </div>
    
    
    <table class="imgtable">
    
    <thead>
    <tr>
    <th style=" text-indent: 11px;min-width: 45px;">编号</th>
    <th width="100px;">缩略图</th>
    <th width="40%;">标题</th>
    <th width="12%;">栏目</th>
    <th width="12%;">响应</th>
    <th width="12%;">开启</th>
    <th>操作</th>
    </tr>
    </thead>
    
    <tbody>
    <c:forEach var="r" items="${pageView.records}" varStatus="status">
    <tr id="tr_${status.index}">
    <td>${(pageView.pageNow - 1) * pageView.pageSize + status.index + 1}</td>
    <td class="imgtd"><img src="${r.PIC_URL }" style="width: 80px;height:60px;"/></td>
    <td><a href="#" onclick="updateHAc('${r.HAC_ID}')">${r.TITLE }</a></td>
    <td>${r.CATEGORY }</td>
    <td>${r.RESPONSE eq '1' ? '商品详情' : '活动详情'}</td>
    <td><section class="model-2">
			  <div class="checkbox checkbox_normal">
			    <input id="PUBLISH_${status.index}" type="checkbox" ${r.PUBLISH eq 'on' ? 'checked=""' : ''} onchange="updateSwitchery('${r.HAC_ID}','PUBLISH_${status.index}');"/>
			    <label style="width: 54px; height: 33px;" class="checkbox-lebal-normal"></label>
			  </div></section></td>
    <td><a class="a_link"  style="cursor:pointer"  onclick="updateHAc('${r.HAC_ID}')">编辑</a>&nbsp;&nbsp;&nbsp;&nbsp;<a onclick="deleteHAc('${r.HAC_ID}','${pageView.pageNow}')" class="a_link" style="cursor:pointer">删除</a> 
		</td>
    </tr>
    </c:forEach>
    <%-- <tr>
    <td class="imgtd"><img src="${ctx}/skin/default/images/img12.png" /></td>
    <td><a href="#">一套简约形状图标UI下载</a><p>发布时间：2013-10-12 09:25:18</p></td>
    <td>图标设计<p>ID: 82122</p></td>
    <td>开放浏览</td>
    <td><i>未开启</i></td>
    <td>235</td>
    </tr> --%>
    
    
    
    </tbody>
    
    </table>
    
    
    <div class="pagin">
    	<%@ include file="../../../common/pagination_tail.jsp"%>
    </div>

</body>
<script type="text/javascript">
function updateSwitchery(HAC_ID,id){
	var PUBLISH = "";
	
	if($("#"+id).is(':checked') == true){
		PUBLISH = "on";
	}else{
		PUBLISH = "off";
	}
	
	BaseUtils.showWaitMsg();
	$.ajax({
		url : "${ctx}/webBgAc/updatePublish.do",
		type : "post",
		data : {"PUBLISH":PUBLISH,"HAC_ID":HAC_ID},
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
