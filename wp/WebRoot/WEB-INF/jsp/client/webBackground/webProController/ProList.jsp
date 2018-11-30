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
	<%-- <link rel="stylesheet" href="${ctx}/skin/switchery/css/newSwitchery.css" /> --%>
	<!--end  -->
	<!--继承css  -->
	<link rel="stylesheet" href="${ctx}/skin/webBase/goods/css/goodsStyle.css"/>
	<!--end  -->
	<title>宣传列表</title>

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
	  
		if(count > 20){
			  alert("添加数量达到上限！");
			  return false;
		  }
	  window.location.href="${ctx}/webPro/addPro.do";
  });
});
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
function updatePro(PRO_ID){
	window.location.href="${ctx}/webPro/addPro.do?PRO_ID="+PRO_ID;
}
function deletePro(id){
	defaultConfirm("你确定要删除吗，可能有关联信息？删除后不可恢复！",(function(){
		BaseUtils.showWaitMsg();
		$.ajax({
			type: "post",
			url:'${ctx}/webPro/deletePro.do',
			data : {"PRO_ID":id},
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
                <h3>宣传列表</h3>
     </div>
    
    <div class="rightinfo">
    
    <div class="tools">
    
    	<ul class="toolbar toolbar-ul">
				    	<form id="queryForm" action="${ctx}/webPro/proList.do" method="post">
				    			<input name="pageNow" type="hidden" value="${pageView.pageNow}" />
								<li style="cursor:default;">&nbsp;标题：<input type="text" name="PRO_TITLE" value="${record.PRO_TITLE }" class="search-input" />
								<span style="float:right"><img src="${ctx}/skin/default/images/search.png" onclick="$('#queryForm').submit();" class="search-img" style="cursor:pointer" /></span></li> 		
						</form>
				        <!-- <li style="padding-left: 10px;">
				        	商品类别：
				        <select class="zero-select-base zero-select select-class" >
				       		<option value="1">商品类别1</option>
							<option value="2">商品类别2</option>
				        </select>
				        </li> -->
				        <li id="addGoods" class="click"><span><img src="${ctx}/skin/default/images/t01.png" /></span>添加宣传</li>
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
    <th width="40%;">标题</th>
    <th width="30%;">时间</th>
    <th width="17%;">操作</th>
    </tr>
    </thead>
    
    <tbody>
    <c:forEach var="r" items="${pageView.records}" varStatus="status">
    <tr id="tr_${status.index}" style="height:40px;">
    <td>${(pageView.pageNow - 1) * pageView.pageSize + status.index + 1}</td>
    <td><a href="#" onclick="updatePro('${r.PRO_ID}')">${r.PRO_TITLE }</a></td>
    <td>${r.CREATE_TIME }</td>
    <td><a class="a_link"  style="cursor:pointer"  onclick="updatePro('${r.PRO_ID}')">编辑</a>&nbsp;&nbsp;&nbsp;&nbsp;<a onclick="deletePro('${r.PRO_ID}')" class="a_link" style="cursor:pointer" >删除</a> 
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
</html>
