<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html >
  <head>
    <base href="<%=basePath%>">
    
    <title>微信图文信息</title>

        <meta http-equiv="pragma" content="no-cache">
        <meta http-equiv="cache-control" content="no-cache">
        <meta http-equiv="expires" content="0">
        <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
        <meta http-equiv="description" content="This is my page">
  		<%@ include file="../../common/common_header.jsp"%>
  		
        <script type="text/javascript">
        function cfAction(){
       	document.getElementById("respURL").style.display= "none";
		$("#xydz").attr("readonly","readonly");
		document.getElementById("xydz").style.background = "#F0F0F0";
		var CFDZ=$("#CFDZ").val();
		var ZCDMC=$("#ZCDMC").val();
		layer.open({
			title:'响应动作',
		    type: 2,
		    area: ['700px', '320px'],
		    fix: false, //不固定
		    maxmin: true,
		    shadeClose: true,
		    shade: 0.8,
		    content: '${ctx}/zdycd/xydz.do?CFDZ='+CFDZ+'&ZCDMC='+ZCDMC,
		}); 
		
		} 
        /* function forUpdateIT(IM_ID){
			window.location.href="${ctx}/ml/forUpdateIT.do?IM_ID="+IM_ID;
        }
		function forAddIT(){
			var IT_TYPE = 1;
			window.location.href="${ctx}/ml/forShowAddMessage.do?IT_TYPE="+IT_TYPE;		
		} */
		function updateIT(IT_ID,IT_GROUP_ID,PUBLISH){
			window.location.href="${ctx}/ml/forShowUpdateMessage.do?IT_ID="+IT_ID+"&IT_GROUP_ID="+IT_GROUP_ID+"&PUBLISH="+PUBLISH;
		}
		function deleteIT(IT_GROUP_ID,MEDIA_ID){
			//window.location.href="${ctx}/ml/deleteIT.do?IT_GROUP_ID="+IT_GROUP_ID;
			$.ajax({
				url:"${ctx}/ml/deletByGroupId.do",
				type:"post",
				data:{"IT_GROUP_ID":IT_GROUP_ID,"MEDIA_ID":MEDIA_ID},
				dataType:"json",
				success:function(data){
					window.location.href="${ctx}/ml/imageTextList.do";
					}
				});
		}
        </script>
       <script type="text/javascript">
			$(document).ready(function(){
			  $("#forAddIT").click(function(){
				  window.location.href="${ctx}/ml/forShowAddMessage.do";
			  });
			  $("#forSearchIT").click(function(){
				  alert("胖子程序猿太懒了，此功能还没维护");
				  //window.location.href="${ctx}/ml/forShowAddMessage.do";
			  });
			  $("#deleteChoseIT").click(function(){
				  //window.location.href="${ctx}/ml/forShowAddMessage.do";
				  alert("胖子程序猿太懒了");
			  });
			  $("#deleteAll").click(function(){
				  //window.location.href="${ctx}/ml/forShowAddMessage.do";
				  alert("胖子程序猿还在吃饭，快打电话让他修复此功能");
			  });
			});
	   </script>
    </head>
    <body>
        <div class="youkuangjia">
            <div class="modstitle">
                <h3>微信图文信息</h3>
            </div>
            <div class="mcontent_no_border">
	            <div class="alert" >
	                <!-- <p>注意：1级菜单最多只能开启3个，2级子菜单最多开启5个!</p>
	                <p>只有保存主菜单后才可以添加子菜单</p>
	                <p>生成自定义菜单,必须在已经保存的基础上进行,临时勾选启用点击生成是无效的! 第一步必须先修改保存状态！第二步点击生成!</p>
	                <p>当您为自定义菜单填写链接地址时请填写以"http://"开头，这样可以保证用户手机浏览的兼容性更好</p>
	                <p>撤销自定义菜单：撤销后，您的微信公众帐号上的自定义菜单将不存在；如果您想继续在微信公众帐号上使用自定义菜单，请点击“生成自定义菜单”按钮，将重新启用！</p>  -->
	            </div>
				<div class="rightinfo">
	    
				    <div class="tools">
				    	<ul class="toolbar" style="width: 594px;">
				    	<form id="queryForm" action="${ctx}/ml/imageTextList.do" method="post">
								<li style="cursor:default;">&nbsp;标题：<input type="text" name="TITLE" value="${record.TITLE }" style="height: 21px; width: 170px;"/></li>
								<li class="click" onclick="$('#queryForm').submit();"><span><img src="${ctx}/skin/default/images/search.png" style="width: 25px; height: 25px; margin-top: px;"/></span>搜索</li> 		
						</form>
				        <li id="forAddIT" class="click"><span><img src="${ctx}/skin/default/images/t01.png" /></span>添加</li>
				        
				        <%-- <li id="deleteChoseIT"><span><img src="${ctx}/skin/default/images/t03.png" /></span>删除</li> --%>
				        </ul>
				        
				        
				        <%-- <ul class="toolbar1">
				        <li id="deleteAll"><span><img src="${ctx}/skin/default/images/t03.png" /></span>删除全部</li>
				        </ul> --%>
				    
				    </div>
				    
				    
				
				    <ul class="classlist">
				    
				    <c:forEach var="r" items="${pageView.records}" varStatus="status">
				    <li id="li_id_${status.index}" >
				    <span><img src="${r.PIC_URL }" style="width: 106px; height: 126px;"/></span>
				    <div class="lright">
				    <h2 style="width: 160px;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;"><input class="formcheckbox" type="checkbox" name="check" style="vertical-align:text-bottom; margin-bottom:1.1px;" />${r.TITLE }</h2>
				    <p style="width: 160px;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;">
					    	作者：${r.AUTHOR }<br />
					    	时间：${r.CREATE_TIME }<br />
					    	数量：${r.IT_COUNT }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;发布：<c:if test="${r.PUBLISH == '1'}"><font color="green">已发布</font></c:if>
					    																	<c:if test="${r.PUBLISH != '1' }"><font color="red">未发布</font></c:if>
				    </p>
				    <a class="enter" onclick="updateIT('${r.IT_ID }','${r.IT_GROUP_ID }','${r.PUBLISH}')">编辑</a>
				    <a class="enter" onclick="deleteIT('${r.IT_GROUP_ID }','${r.MEDIA_ID}')">删除</a>
				    </div>
				    </li>
				    </c:forEach>

				    </ul>
				    <div class="clear"></div>
				   
				    <%-- <%@ include file="../../common/pagination_tail.jsp"%> --%>
				    
				    
				    </div>
				    
				    <!-- <div class="bottomNav"> -->
				    <%@ include file="../../common/pagination_tail.jsp"%>
				    <!-- </div> -->
				    
				    
				    </div>
			    </div>
                
    </div>
</body>
</html>
