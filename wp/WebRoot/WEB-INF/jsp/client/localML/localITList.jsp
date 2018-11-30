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
    
    <title>本地图文管理</title>

        <meta http-equiv="pragma" content="no-cache">
        <meta http-equiv="cache-control" content="no-cache">
        <meta http-equiv="expires" content="0">
        <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
        <meta http-equiv="description" content="This is my page">
  		<%@ include file="../../common/common_header.jsp"%>
  		
        <script type="text/javascript">
        /* function forUpdateIT(IM_ID){
			window.location.href="${ctx}/ml/forUpdateIT.do?IM_ID="+IM_ID;
        }
		function forAddIT(){
			var IT_TYPE = 1;
			window.location.href="${ctx}/ml/forShowAddMessage.do?IT_TYPE="+IT_TYPE;		
		} */
		function updateLocalIT(LOCAL_IT_ID,GROUP_ID){
			window.location.href="${ctx}/localML/get.do?LOCAL_IT_ID="+LOCAL_IT_ID+"&GROUP_ID="+GROUP_ID;
		}
		function deleteLocalIT(LOCAL_IT_ID){
			//window.location.href="${ctx}/ml/deleteIT.do?IT_GROUP_ID="+IT_GROUP_ID;
			$.ajax({
				url:"${ctx}/localML/deleteById.do",
				type:"post",
				data:{"LOCAL_IT_ID":LOCAL_IT_ID},
				dataType:"json",
				success:function(data){
					window.location.href="${ctx}/localML/localITList.do";
					}
				});
		}
        </script>
       <script type="text/javascript">
			$(document).ready(function(){
			  $("#forAddLocalIT").click(function(){
				  window.location.href="${ctx}/localML/forAdd.do";
			  });
			  $("#forSearchLocalIT").click(function(){
				  alert("胖子程序猿太懒了，此功能还没维护");
				  //window.location.href="${ctx}/ml/forShowAddMessage.do";
			  });
			  $("#deleteChoseLocalIT").click(function(){
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
                <h3>本地图文列表</h3>
            </div>
            <div class="mcontent_no_border">
	            <!-- <div class="alert" >
	                <p>注意：1级菜单最多只能开启3个，2级子菜单最多开启5个!</p>
	                <p>只有保存主菜单后才可以添加子菜单</p>
	                <p>生成自定义菜单,必须在已经保存的基础上进行,临时勾选启用点击生成是无效的! 第一步必须先修改保存状态！第二步点击生成!</p>
	                <p>当您为自定义菜单填写链接地址时请填写以"http://"开头，这样可以保证用户手机浏览的兼容性更好</p>
	                <p>撤销自定义菜单：撤销后，您的微信公众帐号上的自定义菜单将不存在；如果您想继续在微信公众帐号上使用自定义菜单，请点击“生成自定义菜单”按钮，将重新启用！</p> 
	            </div> -->
				<div class="rightinfo">
	    
				    <div class="tools">
				    	<ul class="toolbar" style="width: 594px;">
				    	<form id="queryForm" action="${ctx}/localML/localITList.do" method="post">
								<li style="cursor:default;">&nbsp;标题：<input type="text" name="TITLE" value="${record.TITLE }" style="height: 21px; width: 170px;"/></li>
								<li id="forSearchIT" class="click" onclick="$('#queryForm').submit();"><span><img src="${ctx}/skin/default/images/search.png" style="width: 25px; height: 25px; margin-top: px;"/></span>搜索</li> 		
						</form>
				        <li id="forAddLocalIT" class="click"><span><img src="${ctx}/skin/default/images/t01.png" /></span>添加</li>
				        
				        <%-- <li id="deleteChoseLocalIT"><span><img src="${ctx}/skin/default/images/t03.png" /></span>删除</li> --%>
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
					    	<%-- 作者：${r.AUTHOR }<br /> --%>
					    	时间：${r.CREATE_TIME }<br />
					    	<%-- 数量：${r.IT_COUNT }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;发布：<c:if test="${r.PUBLISH == '1'}"><font color="green">已发布</font></c:if>
					    																	<c:if test="${r.PUBLISH != '1' }"><font color="red">未发布</font></c:if> --%>
				    </p>
				    <a class="enter" onclick="updateLocalIT('${r.LOCAL_IT_ID }','${r.GROUP_ID }')">编辑</a>
				    <a class="enter" onclick="deleteLocalIT('${r.LOCAL_IT_ID }')">删除</a>
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
