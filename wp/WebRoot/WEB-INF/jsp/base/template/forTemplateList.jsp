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
  <title>模板管理</title>
  <script>
   function deleteTinyWeb(TEMPLATE_ID){
	   $.ajax({
			url:"${ctx}/picUpload/deletByMediaId.do",
			type:"post",
			data:{"TEMPLATE_ID":TEMPLATE_ID},
			dataType:"json",
			success:function(data){
				window.location.href="${ctx}/tinyWeb/tinyWebList.do";
				}
			});
   }
   function preview(pic_url){
	   layer.open({
		    type: 1,
		    title: false,
		    closeBtn: 0,
		    area: ['auto','auto'], 
		    skin: 'layui-layer-nobg', //没有背景色
		    shadeClose: true,
		    content: "<img src=\""+pic_url+"\" style=\"width:540px; \"/>"
		}); 
   }
   $(document).ready(function(){
	   $("#addTemplate").click(function(){
		   window.location.href="${ctx}/tinyWeb/addTemplate.do";
	   });
   });
 </script>  
 </head>
 <body>
 <div style="height: 100%">
    <div class="youkuangjia">
        <div class="modstitle">
            <h3>模板管理</h3>
        </div>
        <div class="mcontent_no_border">
            <div class="alert">
                <p>注意：1级菜单最多只能开启3个，2级子菜单最多开启5个!</p>
                <p>只有保存主菜单后才可以添加子菜单</p>
                <!--<p>生成自定义菜单,必须在已经保存的基础上进行,临时勾选启用点击生成是无效的! 第一步必须先修改保存状态！第二步点击生成!</p>
                <p>当您为自定义菜单填写链接地址时请填写以"http://"开头，这样可以保证用户手机浏览的兼容性更好</p>
                <p>撤销自定义菜单：撤销后，您的微信公众帐号上的自定义菜单将不存在；如果您想继续在微信公众帐号上使用自定义菜单，请点击“生成自定义菜单”按钮，将重新启用！</p>  -->
            </div>
			<div class="rightinfo" style="padding-left: 0px; padding-right: 0px;">
    
		    <div class="tools">
		    
		    	<ul class="toolbar">
		        <li class="click" id="addTemplate"><span><img src="${ctx}/skin/default/images/t01.png" /></span>添加</li>
		        <!--<li class="click" onclick="queryGroup();"><span ><img style="width: 24px;height:24px" src="${ctx}/skin/default/images/icon16.png" /></span>分组查看</li>
		         <li><span><img src="images/t03.png" /></span>删除</li>
		        <li><span><img src="images/t04.png" /></span>统计</li> -->
		        </ul>
     
		        <%-- <ul class="toolbar1">
		        <li><span><img style="width: 24px;height:24px" src="${ctx}/skin/default/images/icon16.png" /></span>分组</li>
		        </ul> --%> 
		    
		    </div>
		    <form id="queryForm" action="${ctx}/tinyWeb/tinyWebList.do" method="post">
		    </form>
		    <ul class="imglist">
		    
		    <c:forEach var="r" items="${pageView.records}" varStatus="status">
		    <li id="li_id_${status.index}" class="selected imglist_li">
		    <span><img src="${r.PIC_URL }" style="width: 188px;height:135px;"/></span>
		    <h2><a href="#">${r.NAME }</a></h2>
		    <p>
		    <a href="#" onclick="preview('${r.PIC_URL }')">预览</a>&nbsp;&nbsp;&nbsp;&nbsp;
		    <a href="#" onclick="deleteTinyWeb('${r.TEMPLATE_ID }')">删除</a>
		    </p>
		    </li>
		    </c:forEach>
		    </ul>
		    <%@ include file="../../common/pagination_tail.jsp"%>	    
		    </div>
               	
		</div>
	</div>
</div>
</body>
</html>
