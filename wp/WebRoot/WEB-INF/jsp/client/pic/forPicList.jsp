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
  <title>图片管理</title>
  <script>
   /**
	 *description：上传图片，选择图片。
	 *time：2015/12/2
	 *author：daiwk
	 */
	KindEditor.ready(function(K) {
		var editor = K.editor({
			uploadJson : '${ctx}/upload/fileUpload.do',
			fileManagerJson : '${ctx}/upload/fileManager.do',
			allowFileManager : true,
		});
		K('#uploadPicture').click(
				function() {
					editor.loadPlugin('image', function() {
						editor.plugin.imageDialog({
							showRemote : false,
							imageUrl : K('#PIC_URL').val(),
							clickFn : function(url, title, width, height,
									border, align) {
								editor.hideDialog();
								window.location = "${ctx}/picUpload/forQueryPage.do";
							}
						});
					});
				});
	});
   function deletePic(MEDIA_ID){
	   defaultConfirm("你确定要删除吗？删除后不可恢复！",(function(){
			BaseUtils.showWaitMsg();
	   $.ajax({
			url:"${ctx}/picUpload/deletByMediaId.do",
			type:"post",
			data:{"MEDIA_ID":MEDIA_ID},
			dataType:"json",
			success:function(data){
				BaseUtils.hideWaitMsg();
				window.location.href="${ctx}/picUpload/forQueryPage.do";
			}
				
			});
	   }));
   }
   function queryGroup(){
	   layer.open({
		    type: 1,
		    skin: 'layui-layer-demo', //样式类名
		    closeBtn: 0, //不显示关闭按钮
		    shift: 2,
		    shadeClose: true, //开启遮罩关闭
		    content: '内容'
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
   
 </script>  
 </head>
 <body>
 <div style="height: 100%">
    <div class="youkuangjia">
        <div class="modstitle">
            <h3>图片管理</h3>
        </div>
        <div class="mcontent_no_border">
            <div class="alert">
                <p>注意：删除的图片可能与微信图文素材关联，造成图文无法正常显示!</p>
                <p>图片素材最多200张</p>
                
            </div>
			<div class="rightinfo" style="padding-left: 0px; padding-right: 0px;">
    
		    <div class="tools">
		    
		    	<ul class="toolbar">
		        <li class="click"  id="uploadPicture"><span><img src="${ctx}/skin/default/images/t01.png" /></span>添加</li>
		        <!--<li class="click" onclick="queryGroup();"><span ><img style="width: 24px;height:24px" src="${ctx}/skin/default/images/icon16.png" /></span>分组查看</li>
		         <li><span><img src="images/t03.png" /></span>删除</li>
		        <li><span><img src="images/t04.png" /></span>统计</li> -->
		        </ul>
     
		        <%-- <ul class="toolbar1">
		        <li><span><img style="width: 24px;height:24px" src="${ctx}/skin/default/images/icon16.png" /></span>分组</li>
		        </ul> --%> 
		    
		    </div>
		    <form id="queryForm" action="${ctx}/picUpload/forQueryPage.do" method="post">
		    </form>
		    <ul class="imglist">
		    
		    <c:forEach var="r" items="${pageView.records}" varStatus="status">
		    <li id="li_id_${status.index}" class="selected imglist_li">
		    <span><img src="${r.PIC_URL_FWQ }" style="width: 188px;height:135px;"/></span>
		    <h2><a href="#">时间：${r.CREATE_TIME }</a></h2>
		    <p>
		    <a href="#" onclick="preview('${r.PIC_URL_WX }')">预览</a>&nbsp;&nbsp;&nbsp;&nbsp;
		    <a href="#" onclick="deletePic('${r.MEDIA_ID }')">删除</a>
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
