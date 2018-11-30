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
  var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
   /**
	 *description：上传图片，选择图片。
	 *time：2015/12/2
	 *author：daiwk
	 */
	/* KindEditor.ready(function(K) {
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
	   $.ajax({
			url:"${ctx}/picUpload/deletByMediaId.do",
			type:"post",
			data:{"MEDIA_ID":MEDIA_ID},
			dataType:"json",
			success:function(data){
				window.location.href="${ctx}/picUpload/forQueryPage.do";
				}
			});
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
   */
   function preview(pic_url){
	   layer.open({
		    type: 1,
		    title: false,
		    closeBtn: 0,
		    area: ['auto','auto'], 
		    skin: 'layui-layer-nobg', //没有背景色
		    shadeClose: true,
		    content: "<img src=\""+pic_url+"\" style=\"width:440px; \"/>"
		}); 
   }
   
   $(document).ready(function(){
	   $("a[name='transmit']").on('click', function(){
		   
		  	var PIC_MEDIA_ID = $(this).attr('PIC_MEDIA_ID');
		    var PIC_ID = $(this).attr('PIC_ID');
		    var PIC_URL_FWQ = $(this).attr('PIC_URL_FWQ');
		    var PIC_URL_WX = $(this).attr('PIC_URL_WX');
		  	var PIC_JSON = {"PIC_MEDIA_ID":PIC_MEDIA_ID,"PIC_URL_FWQ":PIC_URL_FWQ,"PIC_ID":PIC_ID,"PIC_URL_WX":PIC_URL_WX}; 
			//parent.$('#MATERIAL_ID').val(IT_ID);
			parent.selectedPIC(PIC_JSON);
		    //parent.demo('我是被主人拿来做测试用的。');
		    parent.layer.close(index);
		});
   });
 </script>  
 </head>
 <body style="min-width: 840px;">
 <div >
    <div class="youkuangjia" >
        <!-- <div class="modstitle">
            <h3>图片管理</h3>
        </div> -->
        <div class="mcontent_no_border">
            <!-- <div class="alert">
                <p>注意：1级菜单最多只能开启3个，2级子菜单最多开启5个!</p>
                <p>只有保存主菜单后才可以添加子菜单</p>
                <p>生成自定义菜单,必须在已经保存的基础上进行,临时勾选启用点击生成是无效的! 第一步必须先修改保存状态！第二步点击生成!</p>
                <p>当您为自定义菜单填写链接地址时请填写以"http://"开头，这样可以保证用户手机浏览的兼容性更好</p>
                <p>撤销自定义菜单：撤销后，您的微信公众帐号上的自定义菜单将不存在；如果您想继续在微信公众帐号上使用自定义菜单，请点击“生成自定义菜单”按钮，将重新启用！</p> 
            </div>
			<div class="rightinfo" style="padding-left: 0px; padding-right: 0px;"> -->
    
		    <%-- <div class="tools">
		    
		    	<ul class="toolbar">
		        <li class="click" id="uploadPicture"><span><img src="${ctx}/skin/default/images/t01.png" /></span>添加</li>
		        <!--<li class="click" onclick="queryGroup();"><span ><img style="width: 24px;height:24px" src="${ctx}/skin/default/images/icon16.png" /></span>分组查看</li>
		         <li><span><img src="images/t03.png" /></span>删除</li>
		        <li><span><img src="images/t04.png" /></span>统计</li> -->
		        </ul>
     
		        <ul class="toolbar1">
		        <li><span><img style="width: 24px;height:24px" src="${ctx}/skin/default/images/icon16.png" /></span>分组</li>
		        </ul> 
		    
		    </div> --%>
		    <form id="queryForm" action="${ctx}/picUpload/forSelectQueryPage.do" method="post">
		    </form>
		    <ul class="imglist">
		    
		    <c:forEach var="r" items="${pageView.records}" varStatus="status">
		    <li id="li_id_${status.index}" class="selected"  style="width: 150px; height: 150px;">
		    <span style="height:110px;"><img src="${r.PIC_URL_FWQ }" style="width: 135px;"/></span>
		    <%-- <h2><a href="#">时间：${r.CREATE_TIME }</a></h2> --%>
		    <p>
		    <a href="#" onclick="preview('${r.PIC_URL_FWQ }')">预览</a>&nbsp;&nbsp;&nbsp;&nbsp;
		    <a href="#" name="transmit" PIC_ID="${r.PIC_ID }" PIC_URL_WX="${r.PIC_URL_WX }" PIC_URL_FWQ="${r.PIC_URL_FWQ }" PIC_MEDIA_ID="${r.MEDIA_ID }">选择</a>
		    </p>
		    </li>
		    </c:forEach>
		    </ul>
		    <div>
		    <%@ include file="../../common/pagination_tail.jsp"%>
		    </div>	    
		    </div>
               	
		</div>
	</div>
</div>
</body>
</html>
