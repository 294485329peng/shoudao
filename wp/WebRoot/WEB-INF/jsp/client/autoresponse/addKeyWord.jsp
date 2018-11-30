<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
 <head>
<title>添加关键词</title>
<%@ include file="../../common/common_header.jsp"%>
<link href="${ctx}/skin/qqface/css/bootstrap.min.css" rel="stylesheet" media="screen" />
<link href="${ctx}/skin/autoresponse/css/ar_css.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${ctx}/skin/qqface/css/reset.css" />
<link rel="stylesheet" href="${ctx}/skin/qqface/css/style.css" />
 <script type="text/javascript">
 document.onmouseup=function(){
	 layer.closeAll('tips');
	}
 $(document).ready(function(){
	 $("#CM").click(function(){
 		layer.tips('对方发送的内容与设置的关键字须完全一样，才会触发关键字回复，不能多一个字符也不能少一个字符。比如设置“123”，仅回复“123”才会触发关键字回复。', '#CM', {
 		    tips: [1, '#3595CC'],
 		    time: 6500,
 		});
 	});
	 $("#FM").click(function(){
 		layer.tips('只要对方发送内容包含设置的完整关键词，就会触发关键字回复给对方。比如设置“123”，回复“1234”会触发，但回复不完整的关键字“12”则不会触发关键字回复。', '#FM', {
 		    tips: [1, '#3595CC'],
 		    time: 6500,
 		});
 	});
	 
 });
 function selectIT() {
		layer.open({
			title : '选择图文信息',
			type : 2,
			area : [ '1000px', '500px' ],
			fix : false, //不固定
			offset : '50px',
			maxmin : true,
			shadeClose : true,
			shade : 0.8,
			content : '${ctx}/ar/selectIT.do'
		});
	}
	function selectLocalIT() {
		layer.open({
			title : '选择本地图文',
			type : 2,
			area : [ '1000px', '500px' ],
			fix : false, //不固定
			offset : '50px',
			maxmin : true,
			shadeClose : true,
			shade : 0.8,
			content : '${ctx}/localML/selectLocalITList.do'
		});
	}
 function setSelectIT(IT_JSON){
	 $("#IT").val(IT_JSON.TITLE);
	 $("#IT_TITLE").val(IT_JSON.TITLE);
	 $("#IT_ID").val(IT_JSON.IT_ID);
	 $("#IT_GROUP_ID").val(IT_JSON.IT_GROUP_ID);
 }
 function selectedLocalIT(LOCAL_IT_JSON){
	 $("#LOCAL_IT").val(LOCAL_IT_JSON.LOCAL_IT_TITLE);
	 $("#IT_TITLE").val(LOCAL_IT_JSON.LOCAL_IT_TITLE);
	 $("#IT_ID").val(LOCAL_IT_JSON.LOCAL_IT_ID);
	 $("#IT_GROUP_ID").val("");
	 
 }
 function replyType(){
	 $("#LOCAL_IT").val("");
	 $("#IT").val("");
	 $("#IT_ID").val("");
	 $("#IT_TITLE").val("");
 }
 $(document).ready(function(){
	 $("#GOBACK").click(function(){
		 window.location.href="${ctx}/ar/keyword.do";
	 });
	 $("#SAVEKEYWORD").click(function(){
		 var type = $("input[name='REPLY_TYPE'][type='radio']:checked").val();
	 	 if("1" == type){
			 var validateRule = [
			                    {id:"RULE_NAME",message:"规则名不能为空！"},
			        			{id:"KEYWORD_LIST",message:"关键词不能为空！"},
			        			{id:"SAYTEXT",message:"回复内容不能为空！"},
			              	];
			 if(!formValidationFun(validateRule)){
					return;
				}
	 	 }else if("2" == type){
	 		var validateRule = [
			                    {id:"RULE_NAME",message:"规则名不能为空！"},
			        			{id:"KEYWORD_LIST",message:"关键词不能为空！"},
			        			{id:"IT",message:"请选择图文信息！"},
			               	];
	 		if(!formValidationFun(validateRule)){
				return;
			}
	 	 }else if("3" == type){
		 		var validateRule = [
				                    {id:"RULE_NAME",message:"规则名不能为空！"},
				        			{id:"KEYWORD_LIST",message:"关键词不能为空！"},
				        			{id:"LOCAL_IT",message:"请选择本地图文！"},
				               	];
		 		if(!formValidationFun(validateRule)){
					return;
				}
		 	 }
			BaseUtils.showWaitMsg();
			
			
				$.ajax({
					url: $("#keywordForm").attr("action"),
					type:"post",
					data:  $("#keywordForm").serialize(),
					dataType:"json",
					success: function(data) {
						 BaseUtils.hideWaitMsg();
						var data = data;
						alert(data.msg);
						if (data.flag) {
							window.location.href="${ctx}/ar/keyword.do";
						} 
					},
				}); 
	 });
 });
 </script>
</head>
<body>
	<!-- <div class="youkuangjia"> -->
            <div class="modstitle">
                <h3>添加关键词</h3>
            </div>
            <div class="mcontent">
                <div class="alert">
                    <p>注意：添加关键词，只能选择一种响应。</p>
                    <p>回复文本内容不得超过500字，超出后造成回复异常！</p>
                    <p>请勿重复点保存，造成规则重复！</p>
                </div>
    <form action="${ctx}/ar/insertKeyword.do" id="keywordForm" name="keywordForm" method="post" class="basic-grey">
    <input id="IT_GROUP_ID" name="IT_GROUP_ID" type="hidden" value="" />
    <input id="IT_ID" name="IT_ID" type="hidden" value="" />
    <input id="IT_TITLE" name="IT_TITLE" type="hidden" value="" />
    <label>
    <span>规则名 :</span>
    <input id="RULE_NAME" type="text" name="RULE_NAME" placeholder="用于区分规则的名称" />
    </label>

    <label>
    <span>关键词 :</span>
    <input id="KEYWORD_LIST" type="text" name="KEYWORD_LIST" placeholder="多个关键词请用空格隔开：例如：美丽 漂亮 好看" />
    </label>
    
    <label id="LABEL_CM" >
    <span>关键词类型 :</span>
    <input type="radio" checked="checked" name="MATCHTYPE" value="1"/>&nbsp;<em>完全匹配</em> &nbsp; &nbsp;<a id="CM"  href="javascript:;" style="padding-left: 4px;">[什么是完全匹配]</a>
    </label >
    <label id="LABEL_FM">
    	<input type="radio" name="MATCHTYPE" value="2"/>&nbsp;模糊匹配&nbsp; &nbsp; &nbsp;<a id="FM"  href="javascript:;">[什么是模糊匹配]</a>
	
	</label>
    <label>
    <span><input type="radio" checked="checked" name="REPLY_TYPE" value="1" onchange="replyType();"/>&nbsp;自动回复内容 :</span>
    <textarea id="SAYTEXT" name="SAYTEXT" placeholder="添加自动回复内容" style="margin-bottom: 6px;"></textarea>
    </label>
	
    <span class="emotion" style="margin-left: 151px;"><a href="javascript:void(0)"><img src="${ctx}/skin/qqface/arclist/ico01.png" style="width: 35px; height: 23px;"/></a></span>

    <label id="LABEL_IT">
    <span><input type="radio" name="REPLY_TYPE" value="2" onchange="replyType();"/>&nbsp;自动回复图文内容 :</span>
    <input id="SELECT_IT" name="SELECT_IT" type="button" class="xinbutton" onclick="selectIT()" value="选择图文信息" style="margin-top: 5px;font-family:​Arial ;"/>
    </label>
    <label >
    <span>&nbsp;</span>
    <input id="IT" type="text" class="readonly-it"  readonly="readonly" placeholder="显示选择后的图文信息标题" value=""/>
    </label>
    
    <label >
    <span><input type="radio"name="REPLY_TYPE" value="3" onchange="replyType();" />&nbsp;回复本地图文跳转 :</span>
    <input id="SELECT_LOCAL_IT" name="SELECT_LOCAL_IT" type="button" class="xinbutton" onclick="selectLocalIT()" value="选择本地图文" style="margin-top: 5px;font-family:​Arial ;"/>
    </label>
    <label >
    <span>&nbsp;</span>
    <input id="LOCAL_IT" class="readonly-it" type="text" readonly="readonly" placeholder="显示选择后的跳转图文标题" value=""/>
    </label>
    
    <input id="SAVEKEYWORD" type="button" class="xinbutton" value="保存"/>&nbsp;&nbsp;
    <input id="GOBACK" type="button" class="xinbutton" value="返回" />
    
    </form>
    
</div>
<!-- </div> -->
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