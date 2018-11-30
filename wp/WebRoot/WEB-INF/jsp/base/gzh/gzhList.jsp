<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
 <head>
 	<%@ include file="../../common/common_header.jsp"%>
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
	<title>公众号列表</title>

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
function selectTem(ADMIN_ID,TEMPLATE_ID){
	layer.open({
		title : '选择图片',
		type : 2,
		area : [ '840px', '480px' ],
		fix : false, //不固定
		offset : '50px',
		maxmin : true,
		shadeClose : true,
		shade : 0.8,
		content: '${ctx}/tinyWeb/forSelectQueryPage.do?ADMIN_ID='+ADMIN_ID+'&TEMPLATE_ID='+TEMPLATE_ID
	});
}
function deleteGzh(ADMIN_ID){
	defaultConfirm("你确定要删除吗？删除后不可恢复！",(function(){
		BaseUtils.showWaitMsg();
		$.ajax({
			type: "post",
			url:'${ctx}/gzhBs/delete.do',
			data : {"ADMIN_ID":ADMIN_ID},
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
                <h3>公众号管理</h3>
            </div>
    
    <div class="rightinfo">
    
    <div class="tools">
    	<form id="queryForm" action="${ctx}/gzhBs/gzhList.do" method="post">
    	<input name="pageNow" type="hidden" value="${pageView.pageNow}" />
    	<ul class="toolbar">
    	<li style="cursor:default;">&nbsp;名称：<input type="text" name="GZH_NICK_NAME" value="${record.GZH_NICK_NAME }" class="search-input" />
		<span style="float:right" onclick="$('#queryForm').submit();"><img src="${ctx}/skin/default/images/search.png" class="search-img" style="cursor:pointer;width: 24px; height: 24px;" /></span></li>
        <li id="addNav" class="click"><span><img src="${ctx}/skin/default/images/t01.png" /></span>添加</li>
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
    <th width="25%;">名称</th>
    <th width="5%;">类型</th>
    <th width="5%;">授权</th>
    <th width="20%;">管理员</th>
    <th width="12%;">时间</th>
    <th>操作</th>
    </tr>
    </thead>
    
    <tbody>
    <c:forEach var="r" items="${pageView.records}" varStatus="status">
    <tr id="tr_${status.index}">
    <td>${(pageView.pageNow - 1) * pageView.pageSize + status.index + 1}</td>
    <td class="imgtd"><img src="${r.GZH_HEADER_IMG }" style="width: 80px;height:60px;"/></td>
    <td><a >${r.GZH_NICK_NAME }</a></td>
    <td>${r.GZH_AUTH_STATUS }</td>
    <td>${r.GZH_AUTH_TYPE }</td>
    <td>${r.OPERATOR_ID}</td>
    <td>${r.CREATE_TIME}</td>
    <td>
    <a class="a_link"  style="cursor:pointer"  onclick="selectTem('${r.ADMIN_ID}','${r.TEMPLATE_ID}')">模板</a>&nbsp;&nbsp;
    <a class="a_link"  style="cursor:pointer" >编辑</a>&nbsp;&nbsp;
    <a onclick="deleteGzh('${r.ADMIN_ID}')" class="a_link" style="cursor:pointer">删除</a> 
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
    	<%@ include file="../../common/pagination_tail.jsp"%>
    </div>

</body>
<script type="text/javascript">
function updateSwitchery(NAV_ID,id){
	var PUBLISH = "";
	
	if($("#"+id).is(':checked') == true){
		PUBLISH = "on";
	}else{
		PUBLISH = "off";
	}
	
	BaseUtils.showWaitMsg();
	$.ajax({
		url : "${ctx}/webBgNav/updatePublish.do",
		type : "post",
		data : {"PUBLISH":PUBLISH,"NAV_ID":NAV_ID},
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
