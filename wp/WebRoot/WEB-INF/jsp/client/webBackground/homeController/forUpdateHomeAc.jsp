<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
 <head>
<title>编辑首页活动</title>
<%@ include file="../../../common/common_header.jsp"%>
<link href="${ctx}/skin/autoresponse/css/ar_css.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/skin/webBase/home/css/addNavStyle.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${ctx}/skin/qqface/css/reset.css" />
<link rel="stylesheet" href="${ctx}/skin/qqface/css/style.css" />
<!--控件样式  -->
<link rel="stylesheet" href="${ctx}/skin/common/css/elementStyle.css"/>
<!--end  -->
<!--开关控件  -->
	<link rel="stylesheet" href="${ctx}/skin/switchery/css/newSwitchery.css" />
	<!--end  -->
	<!--上传图片  -->
	<link rel="stylesheet" href="${ctx }/editor/themes/default/default.css" />
	<script charset="utf-8" src="${ctx }/editor/kindeditor.js"></script>
	<script charset="utf-8" src="${ctx }/editor/lang/zh_CN.js"></script>
	<!--end  -->
 <script type="text/javascript">
 /**
	 *description：上传图片，选择图片。
	 *time：2015/12/2
	 *author：daiwk
	 */
	KindEditor.ready(function(K) {
		var editor = K.editor({
			uploadJson : '${ctx}/upload/fileUploadWeb.do',
			fileManagerJson : '${ctx}/upload/fileManager.do',
			allowFileManager : true,
		});
		K('#uploadPicture').click(function() {
			editor.loadPlugin('image', function() {
				editor.plugin.imageDialog({
					imageUrl : K('#PIC_URL').val(),
					clickFn : function(url, title, width, height, border, align,PIC_ID) {
						var id = url.substring(url.indexOf("&")+1,url.indexOf("&")+37);
						if(PIC_ID == undefined || PIC_ID == "" || PIC_ID == null){
							if(id.length == 36){
								$("#PIC_ID").val(id);
								$("#PIC_URL").val(url);
								$("#pic-src").attr("src",url);
							}else{
								alert("图片出错，请重新上传！");
							}
						}else{
							$("#PIC_ID").val(PIC_ID);
							$("#PIC_URL").val(url);
							$("#pic-src").attr("src",url);
						}
						
						editor.hideDialog();
					}
				});
			});
		});
	});
 	function selectResponse(){
 		var RESPONSE = $("#RESPONSE").val();
 		layer.open({
			title : '选择响应信息',
			type : 2,
			area : [ '1000px', '470px' ],
			fix : false, //不固定
			offset : '50px',
			maxmin : true,
			shadeClose : true,
			shade : 0.8,
			content : '${ctx}/webBgAc/selectResponse.do?RESPONSE='+RESPONSE
		});
 	}
 	/**
 	 * 选择后返回数据调整
 	 */
 	 function setSelectRESPONSE(RESPONSE_JSON){
 		 $("#RESPONSE_TITLE").val(RESPONSE_JSON.RESPONSE_TITLE);
 		 $("#RESPONSE_ID").val(RESPONSE_JSON.RESPONSE_ID);
 		 
 	 }
	function save() {
		var validateRule = [
		        			{id:"TITLE",message:"标题不能为空！"},
		        			{id:"PIC_URL",message:"请上传图片！"},
		               	];
		BaseUtils.showWaitMsg();
		if(!formValidationFun(validateRule)) return;
	    $.ajax({
					url : $("#updateHomeAcForm").attr("action"),
					type : "post",
					data : $("#updateHomeAcForm").serialize(),
					dataType : "json",
					success : function(data) {
						BaseUtils.hideWaitMsg();
						alert(data.msg);
						if (data.flag) {
							$("#HAC_ID").val(data.obj.HAC_ID);
						}
						
					}
				});
		
	}
	function switchery(){
		
		if($("#checkbox").is(':checked') == true){
			$("#PUBLISH").val("on");
		}else{
			$("#PUBLISH").val("");
		}
	}
	function goback(){
		window.location.href="${ctx}/webBgAc/homeAc.do";
	}
	
	function deleteHAc(id){
		defaultConfirm("你确定要删除吗？删除后不可恢复！",(function(){
			BaseUtils.showWaitMsg();
			$.ajax({
				type: "post",
				url:'${ctx}/webBgAc/delete.do',
				data : {"HAC_ID":id},
				dataType:"json",
				success : function(data) {
					//var ret = jQuery.parseJSON(data);
					
					if (data.flag) {
						window.location.href="${ctx}/webBgAc/homeAc.do";
					}else{
						BaseUtils.hideWaitMsg();
						alert("操作失败请稍后再试！");
						
					}
				}
			});
		}));
	}
 </script>
</head>
<body>
	<!-- <div class="youkuangjia"> -->
            <div class="modstitle">
                <h3>编辑首页活动</h3>
            </div>
            <div class="mcontent_no_border">
                <div class="alert">
                    <p>注意：编写微网站首页的活动信息!</p>
                </div>
    <form action="${ctx}/webBgAc/update.do" id="updateHomeAcForm" name="addNavForm" method="post" class="basic-grey">
    <input type="hidden" id="HAC_ID" name="HAC_ID" value="${record.HAC_ID }" />
    <input type="hidden" id="RESPONSE_ID" name="RESPONSE_ID" value="${record.RESPONSE_ID }"/>
    <input type="hidden" id="PIC_ID" name="PIC_ID" value="${record.PIC_ID }" />
	<input type="hidden" id="PIC_URL" name="PIC_URL" value="${record.PIC_URL }" />
	<input type="hidden" id="PUBLISH" name="PUBLISH" value="${record.PUBLISH }" />
    <label>
    <span>标题 :</span>
    <input id="TITLE" type="text" name="TITLE" value="${record.TITLE }" />
    </label>

    <label>
    <span>栏目 :</span>
    <input id="CATEGORY" name="CATEGORY" type="text"  style="width: 110px;" readonly="readonly" name="KEYWORD_LIST"  value="首页底部活动"/>
    </label>
    <label>
    <span>简介 :</span>
    <input id="INTRO" name="INTRO" type="text"  value="${record.INTRO }"/>
    </label>
    <label  style="width: 387px;">
    <span>响应 :</span>
    <select id="RESPONSE"  class="formselect" name="RESPONSE">
		<option value="1" ${record.RESPONSE=='1'?'selected':''}>跳转商品详情页面</option>
		<option value="2" ${record.RESPONSE=='2'?'selected':''}>跳转活动详情页面</option>
	</select>
    </label >
    
    <label>
    <span> 选择详情:</span>
    <input type="button" onclick="selectResponse();" class="zero_btn " value="选择响应详情" style="margin-top: 5px;font-family:​Arial ;"/>
    </label>
    <label style="margin-top: 10px;">
    <span> 详情标题</span>
    <input id="RESPONSE_TITLE" type="text" readonly="readonly" name="RESPONSE_TITLE" value="${record.RESPONSE_TITLE }" style="margin-bottom: 0px;"/>
    </label>  
    
    <label id="LABEL_IT" style="width: 475px;margin-top: 10px;">
    <span>上传图片 :</span>
    <input id="uploadPicture" type="button" class="zero_btn " value="上传图片" style="margin-top: 5px;font-family:​Arial ;"/>
    </label>
    <input type="hidden" name="PIC_URL" value="${record.PIC_URL }" />
    <label  style="width: auto;margin-top: 20px;">
    <span>缩略图 :</span>
    		<img id="pic-src" src="${record.PIC_URL }" style="min-width:80px;min-height:60px;max-width: 400px; max-height: 400px;border: 1px solid;"/>
    	
    </label >
    <div style="margin-top: 10px;">
			    <span class="basic-grey-label-span"  style="margin-top: 6px;"> 发布:</span>
			    <section class="model-2">
			  		<div class="checkbox checkbox_normal">
			    	<input id=checkbox type="checkbox" ${record.PUBLISH eq 'on' ? 'checked=""' : ''} onchange="switchery();" />
			    	<label style="width: 54px; height: 33px;" class="checkbox-lebal-normal"></label>
			  	</div></section>
				</div>
    <div style="margin-top: 25px; margin-left: 155px;">
    <input  type="button" class="zero_btn zero_btn_primary" onclick="save();" value="保存"/>
    <input  type="button" class="zero_btn" onclick="goback();" value="返回" style="margin-left: 15px;"/>
    <input  type="button" class="zero_btn zero_btn_red" onclick="deleteHAc('${record.HAC_ID }');" value="删除并返回" style="margin-left: 15px;"/>
    </div>
    </form>
    
</div>
<!-- </div> -->
</body>
<script type="text/javascript">

    </script>
</html>