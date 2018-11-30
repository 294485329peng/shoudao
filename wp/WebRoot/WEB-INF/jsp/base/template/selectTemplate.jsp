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
  var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
  
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
		    var ADMIN_ID = $("#ADMIN_ID").val();
		  	var TEMPLATE_ID = $(this).attr('TEMPLATE_ID');
		  	$.ajax({
				type: "post",
				url:'${ctx}/tinyWeb/updateGzhTemp.do',
				data : {"ADMIN_ID":ADMIN_ID,"TEMPLATE_ID":TEMPLATE_ID},
				dataType:"json",
				success : function(data) {
					alert(data.msg);
				}
			});
		    //parent.demo('我是被主人拿来做测试用的。');
		    
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
           <input type="hidden" id="ADMIN_ID" value="${record.ADMIN_ID }" />
		    <form id="queryForm" action="${ctx}/tinyWeb/tinyWebList.do" method="post">
		    </form>
		    <ul class="imglist" style="height: 172px;">
		    
		    <c:forEach var="r" items="${pageView.records}" varStatus="status">
		    <li id="li_id_${status.index}" class="selected"  style="width: 150px; height: 150px;">
		    <span style="height:110px;"><img src="${r.PIC_URL }" style="width: 135px;"/></span>
		    <h2><a href="#">${r.NAME }</a></h2>
		    <p>
		    <a href="#" onclick="preview('${r.PIC_URL}')">预览</a>&nbsp;&nbsp;&nbsp;&nbsp;
		    <c:if test="${record.TEMPLATE_ID == r.TEMPLATE_ID}">
		    <a style="color:red;" name="transmit" TEMPLATE_ID="${r.TEMPLATE_ID }" PIC_URL="${r.PIC_URL}" TEMP_NAME="${r.TEMP_NAME }" NUMBER="${r.NUMBER }">已选择</a>
		    </c:if>
		    <c:if test="${record.TEMPLATE_ID != r.TEMPLATE_ID}">
		    <a href="#" name="transmit" TEMPLATE_ID="${r.TEMPLATE_ID }" PIC_URL="${r.PIC_URL}" TEMP_NAME="${r.TEMP_NAME }" NUMBER="${r.NUMBER }">选择</a>
		    </c:if>
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
