<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
 <head>
 	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
  <title>微信单图消息</title>
  <%@ include file="../../common/common_header.jsp"%>
  <link type="text/css" rel="stylesheet" href="${ctx}/skin/newmeteriallibrary/css/appmsg_edit.css" />
  <link type="text/css" rel="stylesheet" href="${ctx}/skin/newmeteriallibrary/css/jquery.fileupload.css" />
  <link type="text/css" rel="stylesheet" href="${ctx}/skin/newmeteriallibrary/css/bootstrap.min.css" />
  <!-- <script type="text/javascript" src="plug-in/ckfinder/ckfinder.js"></script> -->
  
  <!--fileupload-->
  <!-- <script type="text/javascript" src="plug-in/weixin/js/vendor/jquery.ui.widget.js"></script>
  <script type="text/javascript" src="plug-in/weixin/js/load-image.min.js"></script>
  <script type="text/javascript" src="plug-in/weixin/js/jquery.fileupload.js"></script>
  <script type="text/javascript" src="plug-in/weixin/js/jquery.fileupload-process.js"></script>
  <script type="text/javascript" src="plug-in/weixin/js/jquery.fileupload-image.js"></script>
  <script type="text/javascript" src="plug-in/weixin/js/jquery.iframe-transport.js"></script> -->
  <!--UEditor-->
  	<link rel="stylesheet" href="${ctx }/editor/themes/default/default.css" />
	<link rel="stylesheet" href="${ctx }/editor/plugins/code/prettify.css" />
	<script charset="utf-8" src="${ctx }/editor/kindeditor.js"></script>
	<script charset="utf-8" src="${ctx }/editor/lang/zh_CN.js"></script>
	<script charset="utf-8" src="${ctx }/editor/plugins/code/prettify.js"></script>
	<script>
		KindEditor.ready(function(K) { 
			var editor1 = K.create('#editor_id', { 
				allowFileManager: true, 
				resizeType:1,//设置编辑器只高度可变
				minHeight: 50,//设置编辑器的最小高度
				minWidth:400,//设置编辑器的最小宽度
				}); 
			}); 
	</script> 
 </head>
 <body>
 	<div class="main_bd" style="padding-top: 9px;">
 		
 
 		<div class="media_edit_area" id="js_appmsg_editor">	
 			<div class="appmsg_editor" style="margin-top: 0px;">
	 			<div class="inner" style="padding-bottom: 0px;margin-bottom: 10px;">
		  		<form id="saveForm" action="${ctx}/acRole/forQueryPage.do" method="post">
							<input id="id" name="id" type="hidden" value="${weixinArticlePage.id }">
							<input id="templateId" name="templateId" type="hidden" value="${templateId}">
							<input id="createDate" name="createDate" type="hidden" value="${weixinArticlePage.createDate }">
				<table style="width: 500px;" cellpadding="0" cellspacing="1" class="formtable">
						<tr>
							<td align="right">
								<label class="Validform_label">
									标题:&nbsp;
								</label>
							</td>
							<td class="value">
							     	 <input id="title" name="title" type="text" style="width: 300px" class="inputxt"  datatype="*">
									<span class="Validform_checktip"></span>
									<label class="Validform_label" style="display: none;">标题</label>
								</td>
						</tr>
						<tr>
							<td align="right">
								<label class="Validform_label">
									作者:&nbsp;
								</label>
							</td>
							<td class="value">
							     	 <input id="author" name="author" type="text" style="width: 300px" class="inputxt" >
									<span class="Validform_checktip"></span>
									<label class="Validform_label" style="display: none;">作者</label>
								</td>
						</tr>
						<tr>
							<td align="right">
								<label class="Validform_label">
									图片链接:&nbsp;
								</label>
							</td>
							<td class="value">
								<span class="btn btn-success fileinput-button">
							        <i class="glyphicon glyphicon-plus"></i>
							        <span>浏览</span>
							        <!-- The file input field used as target for the file upload widget -->
							        <input id="fileupload" type="file" name="files[]" multiple>
							        <input id="imagePath" name=imagePath type="hidden"  datatype="*" nullmsg="请添加图片">
							    </span>
							    <span id="imgName"></span> 
									<span class="Validform_checktip"></span>
									<label class="Validform_label" style="display: none;">图片链接</label>
							</td>
						</tr>
						<tr>
							<td align="right">
								<label class="Validform_label">
									摘要:&nbsp;
								</label>
							</td>
							<td class="value">
							     	 <textarea id="description" name="description" style="width: 300px;margin-top: 9px;" class="inputxt" ></textarea>
									<span class="Validform_checktip"></span>
									<label class="Validform_label" style="display: none;">摘要</label>
								</td>
						</tr>
						<tr>
							<td align="right">
								<label class="Validform_label">
									外部链接:&nbsp;
								</label>
							</td>
							<td class="value">
							     	 <input id="url" name="url" type="text" style="width: 300px" class="inputxt" >
									<span class="Validform_checktip"></span>
									<label class="Validform_label" style="display: none;">外部链接</label>
								</td>
						</tr>
						<tr>
							<td align="right">
								<label class="Validform_label">
									正文:&nbsp;
								</label>
							</td>
							<td class="value">
								<textarea id="editor_id" name="editor_id" cols="100" rows="8" style="width:430px;height:200px;visibility:hidden;"></textarea>
								</td>
						</tr>
						<!-- <tr>
							<td align="right">
								<label class="Validform_label">
									顺序:
								</label>
							</td>
							<td class="value">
							     	 <input id="orders" name="orders" type="text" style="width: 150px" class="inputxt" datatype="*">
									<span class="Validform_checktip"></span>
									<label class="Validform_label" style="display: none;">顺序</label>
								</td>
						</tr> -->
					</table>			
				</form>
				</div>
				<input type="button" class="xinbutton"  onclick="saveMenu()"value="保存"  style="margin-left: 170px;"/>
				<input type="button" class="xinbutton"  onclick="repealMenu()"value="返回" style="margin-left: 60px;"/>
				<i class="arrow arrow_out" style="margin-top: 0px;"></i>
				<i class="arrow arrow_in" style="margin-top: 0px;"></i>
		</div>
	</div>
   </div>
 </body>
 
  <!-- <script src = "webpage/weixin/newstemplate/weixinArticle.js"></script> -->		
</html>
