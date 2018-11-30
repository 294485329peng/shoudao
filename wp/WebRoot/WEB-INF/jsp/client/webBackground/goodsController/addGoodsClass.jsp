<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
 <head>
<title>添加分类</title>
<%@ include file="../../../common/common_header.jsp"%>
<link href="${ctx}/skin/qqface/css/bootstrap.min.css" rel="stylesheet" media="screen" />
<link href="${ctx}/skin/webBase/goods/css/addGoodsStyle.css" rel="stylesheet" type="text/css" />
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
	function save() {
		var id = $("#GOODS_CLASSIFY_ID").val();
		var validateRule = [
		        			{id:"CLASSIFY_NAME",message:"标题为空或超出12字！",contentType:"lengthCh",size:"12"},
		        			{id:"DETAIL",message:"详情为空或超出30字！",contentType:"lengthCh",size:"30"},
		        			{id:"RANK",message:"请合理填写排序！",contentType:"number"},
		        			{id:"RANK",message:"请合理填写排序！",contentType:"lengthCh",size:"10"},
		               	];
		BaseUtils.showWaitMsg();
		if(!formValidationFun(validateRule)) return;
		if(id=="" || id == null){
			$.ajax({
				url : $("#goodsClassForm").attr("action"),
				type : "post",
				data : $("#goodsClassForm").serialize(),
				dataType : "json",
				success : function(data) {
					//var ret = jQuery.parseJSON(data);
					BaseUtils.hideWaitMsg();
					alert(data.msg);
					if (data.flag) {
						$("#GOODS_CLASSIFY_ID").val(data.obj.GOODS_CLASSIFY_ID);
						$("#classUrl").val(data.obj.classUrl);
					} 
					
				}
			}); 
		}else{
			$.ajax({
				url : '${ctx}/goodsClassBC/updateClass.do',
				type : "post",
				data : $("#goodsClassForm").serialize(),
				dataType : "json",
				success : function(data) {
					//var ret = jQuery.parseJSON(data);
					BaseUtils.hideWaitMsg();
					alert(data.msg);
					/* if (data.flag) {
						parent.$('#queryForm').submit();
						//parent.pageNow('${pageNow}');
						parent.layer.close(index);
					} */
				}
			}); 
		} 
	}
	function goback(){
		window.location.href="${ctx}/goodsClassBC/goodsClass.do";
	}
	function deleteClass(){
		var id = $("#GOODS_CLASSIFY_ID").val();
		
			if(id == null || id == ""){
				window.location.href="${ctx}/goodsClassBC/goodsClass.do";
			}else{
				defaultConfirm("你确定要删除吗？删除后不可恢复！",(function(){
					BaseUtils.showWaitMsg();
				$.ajax({
					type: "post",
					url:'${ctx}/goodsClassBC/deleteClass.do',
					data : {"GOODS_CLASSIFY_ID":id},
					dataType:"json",
					success : function(data) {
						//var ret = jQuery.parseJSON(data);
						
						if (data.flag) {
							window.location.href="${ctx}/goodsClassBC/goodsClass.do";
						}else{
							BaseUtils.hideWaitMsg();
							alert("操作失败请稍后再试！");
							
						}
					}
				});
				}));
			}
			
			
	}
	
 </script>
</head>
<body>
	<!-- <div class="youkuangjia"> -->
            <div class="modstitle">
                <h3>添加分类</h3>
            </div>
            <div class="mcontent_no_border">
                <div class="alert">
                    <p>注意：添加商品的类别用于添加商品时选择分类!</p>
                    <p>保存后将显示该分类的url地址</p>
                </div>
                <div class="basic-grey" style="padding-top: 0px;">
			    <form action="${ctx}/goodsClassBC/insertGoodsClass.do" id="goodsClassForm" name="goodsClassForm" method="post" >
			    
			    <input type="hidden" id="GOODS_CLASSIFY_ID" name="GOODS_CLASSIFY_ID" value="${record.GOODS_CLASSIFY_ID}" />
			    <label style="margin-top: 15px;">
			    <span class="basic-grey-label-span">名称 :</span>
			    <input id="CLASSIFY_NAME" type="text" name="CLASSIFY_NAME" value="${record.CLASSIFY_NAME}" />
			    </label>
			
			    <!-- <label>
			    <span>栏目 :</span>
			    <input name="CLASSIFY" type="text"  style="width: 110px;" readonly="readonly" name="KEYWORD_LIST"  value="首页导航图"/>
			    </label> -->
			    
			    <!-- <label  style="width: 580px;">
			    <span class="basic-grey-label-span">分类1 :</span>
			    <select id="RESPONSE"  class="formselect" name="RESPONSE">
					<option value="0">必选分类</option>
					<option value="2">商品分类1</option>
				</select>
				 <input onclick="addGroupLayer();" type="button" class="zero_btn " value="添加类别" style=" margin-bottom: 5px;font-family:​Arial ;"/>
			    </label > -->
			    
			    
			    <label>
			    <span class="basic-grey-label-span"> 详情:</span>
			    <textarea id="DETAIL"  name="DETAIL" rows="" cols="" >${record.DETAIL}</textarea>
			    </label> 
			    
			    <label style="margin-top: 10px;">
			    <span class="basic-grey-label-span">显示排序 :</span>
			    <input id="RANK" type="text" name="RANK" style="width: 95px;" value="${record.RANK}" />
			    </label>
			    
			    <label style="margin-top: 10px;">
			    <span class="basic-grey-label-span">URL地址 :</span>
			    <textarea id="classUrl" readonly="readonly" style="resize: none;height: 35px;" placeholder="商品类别保存成功后将显示地址！">${record.classUrl}</textarea>
			    </label>
			    
			    <span class="basic-grey-label-span"> 开启:</span>
        		<section class="model-2">
			  		<div class="checkbox checkbox_normal" style="margin-top: 6px;">
			    	<input id=checkbox name="PUBLISH" type="checkbox" ${record.PUBLISH eq 'on' ? 'checked=""' : ''} onchange="switchery();" />
			    	<label style="width: 54px; height: 33px;" class="checkbox-lebal-normal"></label>
			  	</div></section>
				
			    <input id="SAVEKEYWORD" type="button" class="zero_btn zero_btn_primary" onclick="save();" value="保存"/>&nbsp;&nbsp;
			    <input id="GOBACK" type="button" class="zero_btn" onclick="goback();" value="返回" />&nbsp;&nbsp;
			    <input type="button" class="zero_btn zero_btn_red"  style="margin-left: 20px; margin-top: 25px;" onclick="deleteClass();" value="删除并返回" />
    
    	</form>
   		</div>
</div>
<!-- </div> -->
<div id="group" style="display:none;">
		<div  class="popover_inner">
		    <div class="popover_content jsPopOverContent">
		    <h4 style="margin-top: 20px; margin-left: 30px;">分组名称 </h4>
		    <input id="addGroupText" class="frm_input js_name" type="text" style="margin-left: 30px; height: 25px; margin-top: 10px;" value="" placeholder="">
		    </div>
		    <div class="popover_bar" style="margin-top: 30px; margin-left: 30px;">
		    <input  type="button" class="zero_btn zero_btn_primary" onclick="addGroup();" value="保存"/>&nbsp;&nbsp;
			<input  type="button" class="zero_btn" onclick="closeLayer();" value="返回" />
		    </div>
		</div>	
</div>
</body>
<script type="text/javascript">

    </script>
</html>