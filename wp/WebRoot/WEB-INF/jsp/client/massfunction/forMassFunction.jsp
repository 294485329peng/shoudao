<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
 <head>
<title>群发回复</title>
<%@ include file="../../common/common_header.jsp"%>
<link href="${ctx}/skin/qqface/css/bootstrap.min.css" rel="stylesheet" media="screen" />
<link href="${ctx}/skin/autoReply/css/Style.css" rel="stylesheet" type="text/css" />
<!--上传图片  -->
<link rel="stylesheet" href="${ctx }/editor/themes/default/default.css" />
<script charset="utf-8" src="${ctx }/editor/kindeditor.js"></script>
<script charset="utf-8" src="${ctx }/editor/lang/zh_CN.js"></script>
<!--end  -->
<link rel="stylesheet" href="${ctx}/skin/qqface/css/reset.css" />
<link rel="stylesheet" href="${ctx}/skin/qqface/css/style.css" />
 <script type="text/javascript">
 function selectType(type){
	 if('1' == type){
		 $('#TYPE').val("1");
		 
		 $('#text').addClass("selected");
		 $('#image').removeClass("selected");
		 $('#imageText').removeClass("selected");
		 
		 $('#editor_text').removeAttr("style");
		 $('#editor_image').attr("style", "display:none");
		 $('#editor_imageText').attr("style", "display:none");
		 
	 }else if('2' == type){
		 $('#TYPE').val("2");
		 
		 $('#image').addClass("selected");
		 $('#text').removeClass("selected");
		 $('#imageText').removeClass("selected");
		 
		 $('#editor_image').removeAttr("style");
		 $('#editor_text').attr("style", "display:none");
		 $('#editor_imageText').attr("style", "display:none");
	 }else if('10' == type){
		 $('#TYPE').val("10");
		 
		 $('#imageText').addClass("selected");
		 $('#text').removeClass("selected");
		 $('#image').removeClass("selected");
		 
		 $('#editor_imageText').removeAttr("style");
		 $('#editor_text').attr("style", "display:none");
		 $('#editor_image').attr("style", "display:none");
	 }
 }
 
/**
 *选择图文素材 
 *
 */
 function selectIT(id) {
		layer.open({
			title : '选择图文信息',
			type : 2,
			area : [ '1000px', '500px' ],
			fix : false, //不固定
			offset : '50px',
			maxmin : true,
			shadeClose : true,
			shade : 0.8,
			content : '${ctx}/massfunction/selectIT.do'
		});
	}
/**
 * 选择图文后返回数据调整
 */
 function setSelectIT(IT_JSON){
	 $("#IT_NAME").val(IT_JSON.TITLE);
	 $("#IT_MEDIA_ID").val(IT_JSON.IT_MEDIA_ID);
	 $("#IT_PIC_URL").attr("src",IT_JSON.PIC_URL);
	 $("#IT_CREATE_TIME").html("时间："+IT_JSON.CREATE_TIME);
	 $("#IT_TITLE").html("标题："+IT_JSON.TITLE);
	 $("#msgSender").attr("style", "display:none");
	 $("#msgSender_media").removeAttr("style");
	 
 }
 /**
 *新建图文
 */
 function addIT() {
	 window.open("${ctx}/ml/newMainAddMessage.do");
	}
 /**
 * 删除图文素材
 */
 function deleteIT(){
	 $("#IT_MEDIA_ID").val("");
	 $("#msgSender_media").attr("style", "display:none");
	 $("#msgSender").removeAttr("style");
 }
 /**
  * 选择图片
  */
 $(document).ready(function(){
	  $("#selectPicture").click(function(){
		  layer.open({
				title : '选择图片',
				type : 2,
				area : [ '840px', '480px' ],
				fix : false, //不固定
				offset : '50px',
				maxmin : true,
				shadeClose : true,
				shade : 0.8,
				content: '${ctx}/picUpload/forSelectQueryPage.do'
			});
	  
	  });
	  
});
function selectedPIC(PIC_JSON){
	$('#PIC_URL').val(PIC_JSON.PIC_URL_FWQ);
	$('#PIC_ID').val(PIC_JSON.PIC_ID);
	$('#selectImage').attr("style", "display:none");
	$('#editor_text').attr("style", "display:none");
	$('#showImageDiv').removeAttr("style");
	$('#showImage').attr('src', PIC_JSON.PIC_URL_FWQ);	  
}
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
		/* K('#selectPicture').click(
				function() {
					editor.loadPlugin('image', function() {
						editor.plugin.imageDialog({
							showLocal : false,
							imageUrl : K('#PIC_URL').val(),
							clickFn : function(url, title, width, height,
									border, align) {
								K('#PIC_URL').val(url);
								$('#selectImage').attr("style", "display:none");
								$('#editor_text').attr("style", "display:none");
								$('#showImageDiv').removeAttr("style");
								$('#showImage').attr('src', url);
								editor.hideDialog();
							}
						});
					});
				}); */
		K('#uploadPicture').click(
				function() {
					editor.loadPlugin('image', function() {
						editor.plugin.imageDialog({
							showRemote : false,
							imageUrl : K('#PIC_URL').val(),
							clickFn : function(url, title, width, height,
									border, align,PIC_ID) {
								K('#PIC_URL').val(url);
								K('#PIC_ID').val(url);
								$('#PIC_MEDIA_ID').val("");
								$('#selectImage').attr("style", "display:none");
								$('#editor_text').attr("style", "display:none");
								$('#showImageDiv').removeAttr("style");
								$('#showImage').attr('src', url);
								editor.hideDialog();
							}
						});
					});
				});
	});
 /*
 *删除选择的图片
 */
 function deleteImage(){
	 $('#PIC_URL').val("");
 	 $('#PIC_ID').val("");
 	 $('#PIC_MEDIA_ID').val("")
 	 $('#selectImage').removeAttr("style");
 	 $('#showImageDiv').attr("style", "display:none");
 }
 /**
 *群发按钮
 */
 var number = ${record.NUMBER};
 function massMessage(){
	 if(number == "100"){
		 alert("未认证的公众号无法群发！");
		 return false;
	 }
	 if(number == 1 || (number > 20 && number < 25)){
	 var TYPE = $("#TYPE").val();
	 var PIC_ID = $("#PIC_ID").val();
	 var IT_MEDIA_ID = $("#IT_MEDIA_ID").val();
	 var SAYTEXT = $("#SAYTEXT").val();
	 if(TYPE == 10){
		 if("" == IT_MEDIA_ID || undefined == IT_MEDIA_ID || null == IT_MEDIA_ID){
			 alert("请选择要发送的图文信息！");
			 return false
		 }
	 }else if(TYPE == 1 ){
		 if("" == SAYTEXT || undefined == SAYTEXT || null == SAYTEXT){
			 alert("请编辑文本内容！");
			 return false
		 }
	 }else if(TYPE == 2){
		 if("" == PIC_ID || undefined == PIC_ID || null == PIC_ID){
			 alert("请选择或上传图片！");
			 return false
		 }
	 }
	 BaseUtils.showWaitMsg();
	 $.ajax({
			url : $("#massForm").attr("action"),
			type : "post",
			data : $("#massForm").serialize(),
			dataType : "json",
			success : function(data) {
				BaseUtils.hideWaitMsg();
				alert(data.msg);
				if(data.flag){
					number = number - 1;
					$("#leftNum").html(number);
				}
			}
		});
	 }else{
		 if(number == 0){
			 alert("您今天群发已经用完，请明天再发！"); 
		 }else if(number == 20){
			 alert("您本月4条群发已经用完，请下月再发！");
		 }
		 
		 return false;
	 }
 }
 /**
 *添加超链接
 */
 function addHyperlink(){
	
	 layer.open({
			title : '超链接',
			type : 2,
			area : [ '486px', '250px' ],
			fix : false, //不固定
			offset : '100px',
			maxmin : true,
			shadeClose : true,
			content: '${ctx}/massfunction/addHyperlink.do'
		});
 }
 function addLink(urlName,urlLink){
	 var SAYTEXT = $("#SAYTEXT").val();
	 SAYTEXT = SAYTEXT +"<a href='"+urlLink+"'>"+urlName+"</a>";
	 $("#SAYTEXT").val(SAYTEXT);
 }
 </script>
</head>
<body>
<div>
    <div class="modstitle">
        <h3>群发回复</h3>
    </div>
    <div class="mcontent" style="border-bottom: 0px;border-left: 0px;border-right: 0px;">
        <div class="alert">
            <p>注意：本功能只适用于已认证的订阅号和认证的服务号。</p>
            <p>群发文本内容不得超过500字，超出后发送失败！图文消息只能选择已发布的素材！</p> 
        </div>
    	<div>
		   <div class="main_bd">
		   		<form id="massForm" name="massForm" action="${ctx }/massfunction/massMessage.do" method="post">
		   		<input id="IT_NAME" type="hidden" value=""/>
		   		<input id="IT_MEDIA_ID" name="IT_MEDIA_ID" type="hidden" value=""/>
           		<input id="TYPE" name="TYPE" type="hidden"  value="10"/>
           		<input id="PIC_URL" name="PIC_URL" type="hidden" value=""/>
           		<input id="PIC_ID"  name="PIC_ID" type="hidden" value=""/>
           		<input id="PIC_MEDIA_ID" name="PIC_MEDIA_ID" type="hidden" value="" />
		       <!-- <div class="grid_line send_filter">
		           <div class="grid_item target">
		               <label class="label">群发对象</label>
		               <div class="filter_content">
		                   <div class="dropdown_menu" id="js_sendObj">
		                       <select name="TARGET" class="btn dropdown_switch jsDropdownBt" style="width: 95px;">
		                           <option  selected="" value="0">全部用户</option>
		                           <option  value="1" >按分组选择</option>
		                       </select>
		
		                   </div>
		               </div>
		           </div>
		           <div class="grid_item sex">
		               <label class="label">性别</label>
		               <div class="filter_content">
		                   <div class="dropdown_menu" id="3">
		                       <select name="SEX" class="btn dropdown_switch jsDropdownBt" style="width: 95px;">
		                           <option  selected="" value="0">全部</option>
		                           <option  value="1" >男</option>
		                           <option  value="2" >女</option>
		                       </select>
		
		                   </div>
		               </div>
		               <div class="filter_content">
		                   <div class="dropdown_menu" id="js_sex"><a href="javascript:;"class="btn dropdown_switch jsDropdownBt"><label
		                           class="jsBtLabel">全部</label><i class="arrow"></i></a>
		
		                       <div style="display: none;" class="dropdown_data_container jsDropdownList">
		                           <ul class="dropdown_data_list">
		                               <li class="dropdown_data_item ">
		                                   <a onclick="return false;" href="javascript:;" class="jsDropdownItem" data-value="0"
		                                      data-index="0" data-name="全部">全部</a>
		                               </li>
		
		                               <li class="dropdown_data_item ">
		                                   <a onclick="return false;" href="javascript:;" class="jsDropdownItem" data-value="1"
		                                      data-index="1" data-name="男">男</a>
		                               </li>
		
		                               <li class="dropdown_data_item ">
		                                   <a onclick="return false;" href="javascript:;" class="jsDropdownItem" data-value="2"
		                                      data-index="2" data-name="女">女</a>
		                               </li>
		
		
		                           </ul>
		                       </div>
		                   </div>
		               </div>
		           </div>
		           <div class="grid_item area">
		               <label class="label">群发地区</label>
		               <div class="filter_content">
		                   <div class="dropdown_menu" id="12">
		                       <select name="AREA" class="btn dropdown_switch jsDropdownBt" style="width: 95px;">
		                           <option  selected="" value="0">全部</option>
		                           <option  value="1" >中国</option>
		                           <option  value="2" >天下</option>
		                       </select>
		
		                   </div>
		               </div>
		               <div id="js_region" class="filter_content">
		                   <div class="dropdown_menu" id="js_country4425" style=""><a href="javascript:;"
		                                                                              class="btn dropdown_switch jsDropdownBt"><label
		                           class="jsBtLabel">国家</label><i class="arrow"></i></a>
		
		                       <div style="display: none;" class="dropdown_data_container jsDropdownList">
		                           <ul class="dropdown_data_list"></ul>
		                       </div>
		                   </div>
		                   <div id="js_province9448" style="display:none"></div>
		                   <div id="js_city8599" style="display:none"></div>
		               </div>
		           </div>
		           
		       </div> -->
		       <div id="js_msgSender" class="msg_sender">
		           <div class="msg_tab">
		               <div class="tab_navs_panel">
		       <span class="tab_navs_switch_wrp switch_prev js_switch_prev">
		           <span class="tab_navs_switch"></span>
		       </span>
		       <span class="tab_navs_switch_wrp switch_next js_switch_next">
		           <span class="tab_navs_switch"></span>
		       </span>
		
		                   <div class="tab_navs_wrp">
		                       <ul class="tab_navs js_tab_navs" style="margin-left:0;">
								       
		                           <li id="imageText" name="imageText" class="tab_nav tab_appmsg width5 selected" data-type="10" data-tab=""
		                               data-tooltip="图文消息">
		                               <a href="javascript:void(0);" onclick="selectType('10');">&nbsp;<i
		                                       class="icon_msg_sender"></i><span class="msg_tab_title">图文消息</span></a>
		                           </li>
		
		                           <li id="text" name="text" class="tab_nav tab_text width5" data-type="1" data-tab="" data-tooltip="文字">
		                               <a href="javascript:void(0);" onclick="selectType('1');">&nbsp;<i
		                                       class="icon_msg_sender"></i><span class="msg_tab_title">文字</span></a>
		                           </li>
		
		                           <li id="image" name="image" class="tab_nav tab_img width5" data-type="2" data-tab="" data-tooltip="图片">
		                               <a href="javascript:void(0);" onclick="selectType('2');">&nbsp;<i
		                                       class="icon_msg_sender"></i><span class="msg_tab_title">图片</span></a>
		                           </li>
		
		                           <!-- <li class="tab_nav tab_audio width5" data-type="3" data-tab=".js_audioArea"
		                               data-tooltip="语音">
		                               <a href="javascript:void(0);" onclick="return false;">&nbsp;<i
		                                       class="icon_msg_sender"></i><span class="msg_tab_title">语音</span></a>
		                           </li>
		
		                           <li class="tab_nav tab_video width5 no_extra" data-type="15" data-tab=".js_videoArea"
		                               data-tooltip="视频">
		                               <a href="javascript:void(0);" onclick="return false;">&nbsp;<i
		                                       class="icon_msg_sender"></i><span class="msg_tab_title">视频</span></a>
		                           </li> -->
		
		                       </ul>
		                   </div>
		               </div>
		               <div class="tab_panel">
		
		                   <div id="editor_imageText" class="tab_content">
		                       <div class="js_appmsgArea inner ">
		                           <!-- type 10图文 2图片  3语音 15视频 11商品消息 -->
											
		                           <div id="msgSender" class="tab_cont_cover jsMsgSendTab" data-index="0">
		                               <div class="media_cover" style="">
				            <span class="create_access">
				                <a class="add_gray_wrp jsMsgSenderPopBt" href="javascript:;" onclick="selectIT();" data-type="10" data-index="0">
		                               <i class="icon36_common add_gray"></i>
		                               <strong>从素材库中选择</strong>
		                           </a>
				            </span>
		                               </div>
		                               <div class="media_cover" style="">
				            <span class="create_access">
		                           <a  class="add_gray_wrp"
		                              href="javascript:;" onclick="addIT()">
		                               <i class="icon36_common add_gray"></i>
		                               <strong>新建图文消息</strong>
		                           </a>
		                           
				                <!-- <a target="_blank" href="/cgi-bin/appmsg?t=media/appmsg_edit&action=edit&type=10&isMul=0&isNew=1&lang=zh_CN&token=1074094956"><i class="icon_shopmsg_create"></i><strong>单图文消息</strong></a>
				                <a target="_blank" href="/cgi-bin/appmsg?t=media/appmsg_edit&action=edit&type=10&isMul=1&isNew=1&lang=zh_CN&token=1074094956"><i class="icon_shopmsg_create multi"></i><strong>多图文消息</strong></a> -->
		                          
				            </span>
		                               </div>
		                               </div>
		                               <div id="msgSender_media" style="display: none;">
		                                   <div class="appmsg " data-fileid="401548948" data-id="401548957">
		                                       <div class="appmsg_content">
		                                           <h4 class="appmsg_title js_title">
		                                               <a id="IT_TITLE" target="_blank"
		                                                  href=""></a>
		                                           </h4>
		
		                                           <div class="appmsg_info">
		                                               <em id="IT_CREATE_TIME" class="appmsg_date"></em>
		                                           </div>
		                                           <div class="appmsg_thumb_wrp" style="margin-bottom: 10px;">
		                                               <img id="IT_PIC_URL" class="appmsg_thumb" alt=""
		                                                    src="">
		                                           </div>
		                                       </div>
		                                   </div>
		                                   <a class="jsmsgSenderDelBt link_dele" onclick="deleteIT();" data-type="10"
		                                      href="javascript:;">删除</a>
		                               </div>
		                           
		
		                       </div>
		                   </div> 
		
		                   <div id="editor_text" class="tab_content" style="${record.TYPE eq '1' ? 'display:block;' : 'display:none;'}">
		                       <div class="js_textArea inner no_extra">
		                           <div class="emotion_editor">
		                               <div style="display: none;" class="edit_area js_editorArea"></div>
		                               <!-- <div style="overflow-y: auto; overflow-x: hidden;" class="edit_area js_editorArea1"
		                                     contenteditable="true"> -->
                                     <div style="overflow-y: auto; overflow-x: hidden;" class="edit_area js_editorArea1"> 
		                                   <textarea id="SAYTEXT" name="SAYTEXT" class="textarea" rows="" cols="" style="border: 0px"></textarea>
		                               </div>
		                                <div class="editor_toolbar">
											<span class="emotion" style="margin-left: 151px;">
		                                    <a href="javascript:void(0);" class="icon_emotion emotion_switch js_switch">表情</a>
		                                    </span>
		                                    <span class="" style="margin-left: 151px;">
		                                    <a href="javascript:void(0);" style="margin-left: 20px;" onclick="addHyperlink()" class="icon88_common emotion_switch js_switch">超链接</a>
											</span>
		
		                                    <!-- <p class="editor_tip opr_tips">，按下Shift+Enter键换行</p> -->
		
		                                    <p class="editor_tip js_editorTip">最多<em>600</em>字</p>
		
		                                    <div class="emotion_wrp js_emotionArea">
		                                    	<span class="hook">
													<span class="hook_dec hook_top"></span>
													<span class="hook_dec hook_btm"></span>
												</span>
		                                        <ul class="emotions" onselectstart="return false;"></ul>
		                                        <span class="emotions_preview js_emotionPreviewArea"></span>
		                                    </div>
		                                </div>
		                            </div>
		
		                        </div>
		                    </div>
		
		                    <div id="editor_image" style="${record.TYPE eq '2' ? '' : 'display:none;'}" class="tab_content">
		                       <div id="selectImage" class="js_imgArea inner" style="${record.TYPE eq '2' ? 'display:none;' : ''}">
		                           <!--type 10图文 2图片  3语音 15视频 11商品消息-->
		
		                           <div class="tab_cont_cover jsMsgSendTab" data-index="2" data-type="2">
		                               <div class="media_cover">
				            <span class="create_access">
				                <a id="selectPicture" class="add_gray_wrp jsMsgSenderPopBt" href="javascript:;" data-type="2" data-index="2">
		                               <i class="icon36_common add_gray"></i>
		                               <strong>从素材库中选择</strong>
		                           </a>
				            </span>
		                               </div>
		                               <div class="media_cover">
				            <span class="create_access">
				                <a id="uploadPicture" class="add_gray_wrp" id="msgSendImgUploadBt" data-type="2" href="javascript:;">
		                               <i class="icon36_common add_gray"></i>
		                               <strong>上传图片</strong>
		                           </a>
				            </span>
		                               </div>
		                           </div>
									
		                       </div>
		                       <div id="showImageDiv" style="${record.TYPE eq '2' ? '' : 'display:none;'}">
                                   <div class="appmsg " data-fileid="" data-id="">
                                       <div class="appmsg_content" style="padding: 14px;">
                                           <div class="appmsg_thumb_wrp">
                                               <img id="showImage" style="width:100%;height:100%;" class="appmsg_thumb" alt=""
                                                    src="${record.PIC_URL }">
                                           </div>
                                       </div>
                                   </div>
                                   <a class="jsmsgSenderDelBt link_dele" data-type="10"
                                      href="javascript:;" onclick="deleteImage()">删除</a>
                               </div>
		                   </div>
		
		                   <!-- <div style="display: none;" class="tab_content">
		                       <div class="js_audioArea inner ">
		                           type 10图文 2图片  3语音 15视频 11商品消息
		
		                           <div class="tab_cont_cover jsMsgSendTab" data-index="3" data-type="3">
		                               <div class="media_cover">
				            <span class="create_access">
				                <a class="add_gray_wrp jsMsgSenderPopBt" href="javascript:;" data-type="3" data-index="3">
		                               <i class="icon36_common add_gray"></i>
		                               <strong>从素材库中选择</strong>
		                           </a>
				            </span>
		                               </div>
		                               <div class="media_cover">
				            <span class="create_access">
				                <a class="add_gray_wrp " id="msgSendAudioUploadBt" href="javascript:;">
		                               <i class="icon36_common add_gray"></i>
		                               <strong>新建语音</strong>
		                           </a>
				            </span>
		                               </div>
		                           </div>
		
		                       </div>
		                   </div> -->
		
		                   <!-- <div style="display: none;" class="tab_content">
		                       <div class="js_videoArea inner ">
		                           type 10图文 2图片  3语音 15视频 11商品消息
		
		                           <div class="tab_cont_cover jsMsgSendTab" data-index="4">
		                               <div class="media_cover">
				            <span class="create_access">
				                <a class="add_gray_wrp jsMsgSenderPopBt" href="javascript:;" data-type="15" data-index="4">
		                               <i class="icon36_common add_gray"></i>
		                               <strong>从素材库中选择</strong>
		                           </a>
				            </span>
		                               </div>
		                               <div class="media_cover">
				            <span class="create_access">
				                <a target="_blank" class="add_gray_wrp"
		                              href="https://mp.weixin.qq.com/cgi-bin/appmsg?t=media/videomsg_edit&amp;action=video_edit&amp;type=15&amp;lang=zh_CN&amp;token=1074094956">
		                               <i class="icon36_common add_gray"></i>
		                               <strong>新建视频</strong>
		                           </a>
				            </span>
		                               </div>
		                           </div>
		
		                       </div>
		                   </div> -->
		
		               </div>
		           </div>
		       </div>
		       <div class="tool_area">
		           <ul class="mass_send_function">
		
		
		           </ul>
		       </div>
		       </form>
		       
		       <div class="tool_bar">
		           <div id="verifycode"></div>
		           <span id="js_submit" class="btn btn_input btn_primary"><button type="button" onclick="massMessage()">群发</button></span>
		           
		           <div class="bubble_tips bubble_left warn">
		               <div class="bubble_tips_inner">
		               		<c:if test="${record.GZH_AUTH_TYPE == '21' || record.GZH_AUTH_TYPE == '20'}">
		               		<p class="mass_send_tips" id="js_masssend_tips">你本月还能群发 <em id="leftNum" class="send_num">${record.NUMBER == '100' ? '0' : record.NUMBER-20}</em> 条消息</p>
		               		</c:if>
		               	   <c:if test="${record.GZH_AUTH_TYPE == '11' || record.GZH_AUTH_TYPE == '10'}">
		                   <p class="mass_send_tips" id="js_masssend_tips">你今天还能群发 <em id="leftNum" class="send_num">${record.NUMBER == '100' ? '0' : record.NUMBER}</em> 条消息</p>
		              		</c:if>
		               </div>
		               <i class="bubble_tips_arrow out"></i>
		               <i class="bubble_tips_arrow in"></i>
		           </div> 
		       </div>
		
		   </div>
		   		
    	</div>
    
	</div>
</div>
</body>
<script  src="${ctx}/skin/qqface/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/skin/qqface/js/jquery.qqFace.js"></script>
<script type="text/javascript">
$(function(){
	$('.emotion').qqFace({
		id : 'facebox', 
		assign:'SAYTEXT', 
		path:'${ctx}/skin/qqface/arclist/'	//表情存放的路径
	});
	/* $(".sub_btn").click(function(){
		var str = $("#saytext").val();
		$("#show").html(replace_em(str));
	}); */
});
//查看结果
/* function replace_em(str){
	str = str.replace(/\</g,'&lt;');
	str = str.replace(/\>/g,'&gt;');
	str = str.replace(/\n/g,'<br/>');
	str = str.replace(/\[em_([0-9]*)\]/g,'<img src="${ctx}/skin/qqface/arclist/$1.gif" border="0" />');
	return str;
} */
</script>

</html>