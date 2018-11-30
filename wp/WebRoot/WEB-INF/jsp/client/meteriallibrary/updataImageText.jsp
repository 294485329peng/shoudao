<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
 <head>
 	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
  <title>微信单图消息</title>
  <%@ include file="../../common/common_header.jsp"%>
   <link type="text/css" rel="stylesheet" href="${ctx}/skin/newmeteriallibrary/css/appmsg_edit.css" />
  <link type="text/css" rel="stylesheet" href="${ctx}/skin/newmeteriallibrary/css/jquery.fileupload.css" />
  <%-- <link type="text/css" rel="stylesheet" href="${ctx}/skin/newmeteriallibrary/css/bootstrap.min.css" /> --%>
  <link href="${ctx}/skin/height/style.css" type="text/css" rel="stylesheet">
  <link href="${ctx}/skin/newmeteriallibrary/css/showmessage.css" type="text/css" rel="stylesheet"/>

  <!--UEditor-->
  	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    
    <script type="text/javascript" src="${ctx}/ueditor/third-party/jquery.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="${ctx}/ueditor/umeditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="${ctx}/ueditor/umeditor.js"></script>
    <script type="text/javascript" src="${ctx}/ueditor/lang/zh-cn/zh-cn.js"></script>

 </head>
 <body>
 <div >
    <div class="youkuangjia">
        <div class="modstitle">
            <h3>图文信息</h3>
        </div>
        <div class="mcontent_padding">
            <div class="alert" style="margin-bottom: 3px;">
                <p>注意：1级菜单最多只能开启3个，2级子菜单最多开启5个!</p>
                <!-- <p>只有保存主菜单后才可以添加子菜单</p>
                <p>生成自定义菜单,必须在已经保存的基础上进行,临时勾选启用点击生成是无效的! 第一步必须先修改保存状态！第二步点击生成!</p>
                <p>当您为自定义菜单填写链接地址时请填写以"http://"开头，这样可以保证用户手机浏览的兼容性更好</p>
                <p>撤销自定义菜单：撤销后，您的微信公众帐号上的自定义菜单将不存在；如果您想继续在微信公众帐号上使用自定义菜单，请点击“生成自定义菜单”按钮，将重新启用！</p>  -->
            </div>
			<div class="main_bd" style="padding-top: 1px;">
		 		<div style="overflow:hidden;clear:both;">
					<div style="float:left;width:25%;">
						<div id="appmsg200159594" class="pp">
							<div class="appmsg multi" data-fileid="200159570" data-id="200159594">
							<div class="appmsg_content">
							<c:if test=" ">
							<div>
								<div class="appmsg_info">
									<em class="appmsg_date">${GZH_ID}</em>
								</div>								
								<div class="cover_appmsg_item" onmouseover="mouseover('header')" onmouseout="mouseout('header')">
									<h4 class="appmsg_title">
										<a target="_blank" href="#">${headerNews.title}</a>
									</h4>
									<div class="appmsg_thumb_wrp">
										<%-- <img class="appmsg_thumb" alt="" src="${headerNews.imagePath}"> --%>
										<img class="appmsg_thumb" alt="" src="${ctx }/skin/default/images/i03.png">
									</div>
									<div class="fe" style="display: none">
										<a class="edit1" href="#" onclick="goUpate('${headerNews.id}')"></a>
									</div>
								</div>
							</div>
							<%-- <c:forEach items="${newsList}" var="news"> --%>
							<div class="appmsg_item" onmouseover="mouseover('item')" onmouseout="mouseout('item')">
								<div class="fd" style="display: none">
									<a class="edit" id="edit" href="#" onclick="goUpate('${news.id}')" ></a>
									<a class="dete" id="delete"  href="#" onclick="goDelete('${news.id}')"></a>
								</div>
								<img class="appmsg_thumb" alt="" src="${news.imagePath}">
								<h4 class="appmsg_title">
									<a target="_blank" href="#">${news.title}1</a>
								</h4>
								</div>
							</c:if>
							<%-- </c:forEach> --%>
								</div>
							</div>
						
						</div>
					<input type="button" class="xinbutton"  onclick="repealMenu()" value="添加图文" style="margin-left: 115px;"/>
					
					</div>
		
					<div style="float:right;width:75%;height:100%">
						<iframe scrolling="yes" id="showframe" src="" frameborder="0" style="width:100%;" onLoad="iFrameHeight()"></iframe></div>
					</div>
		   		</div>
               	
		</div>
	</div>
</div>
</body>
<script type="text/javascript">
	function mouseover(symbol){
		if(symbol=='header'){
			$(".fe").removeAttr("style");
			$(".fd").attr("style","display:none");
		}else if(symbol=='item'){
		    $(".fe").attr("style","display:none");
			$(".fd").removeAttr("style");
		}
	}
	
	function mouseout(symbol){
		if(symbol=='header'){
			$(".fe").attr("style","display:none");
		}else if(symbol=='item'){
			$(".fd").attr("style","display:none");
		}
	}
	
	
	function goUpate(newsId){
		var  url = '${ctx}/ml/demo1.do';
		$("#showframe").attr("src",url);
	}
	
	function goDelete(newsId){
	
		var url = "weixinArticleController.do?doDel&id="+newsId;
		$.ajax({
			url:url,
			dataType:"JSON",
			method:"Get",
			success:function(data){
			    if(data.success){
					tip("删除成功！");
				}
			    location.reload(); 
			}
		});
	}
	
	function refresh(){
		 location.reload(); 
	}
	
</script>
 <script type="text/javascript" language="javascript">   
function iFrameHeight() {   
var ifm= document.getElementById("showframe");   
var subWeb = document.frames ? document.frames["showframe"].document : ifm.contentDocument;   
if(ifm != null && subWeb != null) {
   ifm.height = subWeb.body.scrollHeight;
   ifm.width = subWeb.body.scrollWidth;
}   
}   
</script>	
</html>
