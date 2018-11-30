<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>编辑活动</title>
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
	<!--form 验证 -->
	<script type="text/javascript" src="${ctx }/Validform/js/Validform_v5.3.2.js"></script>
	<link rel="stylesheet" href="${ctx }/Validform/css/style.css" />
	<!--end  -->
	<script type="text/javascript">
		KindEditor.ready(function(K) { 
			var editor = K.create('#CONTENT', { 
				uploadJson : '${ctx}/upload/fileUploadWeb.do',
				fileManagerJson : '${ctx}/upload/fileManager.do',
				allowFileManager: true,
                afterBlur: function () { this.sync(); },//数据同步
				resizeType:1,//设置编辑器只高度可变
				minHeight: 350,//设置编辑器的最小高度
				minWidth:400,//设置编辑器的最小宽度
				afterBlur: function () {
					/* K('#CONTENT_HTML').val(editor.html()); */
					this.sync();
					//alert(editor.html());
				}
				}); 
			
			K('#updateImage').click(function() {
				editor.loadPlugin('image', function() {
					editor.plugin.imageDialog({
						imageUrl : K('#PIC_URL').val(),
						clickFn : function(url, title, width, height, border, align,PIC_ID) {
							
							if(PIC_ID == undefined || PIC_ID == "" || PIC_ID == null){
								K('#PIC_ID').val("");
							}else{
								K('#PIC_ID').val(PIC_ID);
							}
							K('#PIC_URL').val(url);
							$("#showPic").attr("src",url);
							editor.hideDialog();
						}
					});
				});
			});
		});
		
</script>
 <script type="text/javascript">
 
/* 	function save() {
		var validateRule = [
		        			{id:"TITLE",message:"标题不能为空！"},
		        			{id:"CONTENT",message:"活动详情不能为空！"},
		        			{id:"RANK",message:"排序不能为空！"},
		        			{id:"DESCRIPTION",message:"栏目为空或超出20个字符！",contentType:"lengthCh",size:"20"},
		        			{id:"PIC_URL",message:"图片不能为空！"}
		               	];
		BaseUtils.showWaitMsg();
		
		if(!formValidationFun(validateRule)) return;
		
	 	$.ajax({
					url : $("#activityForm").attr("action"),
					type : "post",
					data : $("#activityForm").serialize(),
					dataType : "json",
					success : function(data) {
						//var ret = jQuery.parseJSON(data);
						BaseUtils.hideWaitMsg();
						alert(data.msg);
					
					}
				}); 
		BaseUtils.hideWaitMsg();
	} */
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
			content : '${ctx}/acBC/selectResponse.do?RESPONSE='+RESPONSE
		});
 	}
	/**
 	 * 选择后返回数据调整
 	 */
 	 function setSelectRESPONSE(RESPONSE_JSON){
 		 $("#RESPONSE_TITLE").val(RESPONSE_JSON.RESPONSE_TITLE);
 		 $("#RESPONSE_ID").val(RESPONSE_JSON.RESPONSE_ID);
 		 
 	 }
	function goback(){
		window.location.href="${ctx}/acBC/activityList.do";
	}
	function switchRs(){
		var rs = $("#RESPONSE").val();
		if(rs == '2'){
			$("#goodsRs").attr("style", "display:none");
			$("#activityRs").removeAttr("style");
		}else{
			$("#activityRs").attr("style", "display:none");
			$("#goodsRs").removeAttr("style");
		}
	}
 </script>
</head>
<body>
	<!-- <div class="youkuangjia"> -->
            <div class="modstitle">
                <h3>活动信息</h3>
            </div>
            <div class="mcontent_no_border">
                <div class="alert">
                     <p>注意：修改公司活动宣传页，详细填写信息后保存!</p>
                </div>
                <div>
			    <form action="${ctx}/acBC/update.do" id="registerform" name="registerform" method="post" class="basic-grey registerform">
			    <input type="hidden" id="ACTIVITY_ID" name="ACTIVITY_ID" value="${record.ACTIVITY_ID }" />
			    <input type="hidden" id="PIC_ID" name="PIC_ID" value="${record.PIC_ID }" datatype="*" nullmsg="请选择图片！" AUTOCOMPLETE="off"/>
			    <input type="hidden" id="PIC_URL" name="PIC_URL" value="${record.PIC_URL }" />
			    <input type="hidden" id="RESPONSE_ID" name="RESPONSE_ID" value="${record.RESPONSE_ID}"/>
			    <label  style="width: auto;margin-top: 20px;">
			    <span class="basic-grey-label-span" >封面图片 :</span>
			    <c:if test="${record.PIC_URL != '' && record.PIC_URL != null}">
			    	<img id="showPic" src="${record.PIC_URL }" alt=""  style="max-width: 400px; max-height: 400px;border: 1px solid;"/>
			    </c:if>
			    <c:if test="${record.PIC_URL == '' || record.PIC_URL == null}">
			    	<img id="showPic" src="${ctx }/skin/webBase/home/images/nopic.jpg" alt=""  style="max-width: 400px; max-height: 400px;border: 1px solid;"/>
			    </c:if>	
			    </label >
			    
			    <label id="LABEL_IT" style="width: 475px;margin-top: 10px;">
			    <span class="basic-grey-label-span">上传图片 :</span>
			    <input id="updateImage" type="button" class="zero_btn " value="上传图片" style="margin-top: 5px;font-family:​Arial ;"/>
			    </label>
			    
			    <label style="margin-top: 10px; height: 50px;">
			    <span class="basic-grey-label-span">标题 :</span>
			    <input id="TITLE" type="text" name="TITLE" value="${record.TITLE }" datatype="s1-12" nullmsg="请填写标题！" errormsg="名称至少1个字,最多12个字！"/>
			    </label>
				<label style=" height: 50px;">
			    <span class="basic-grey-label-span">简介 :</span>
			    <input id="DESCRIPTION" type="text" style="width: 350px;" name="DESCRIPTION" value="${record.DESCRIPTION }" datatype="s1-35" nullmsg="请简介栏目！" errormsg="简介至少1个字,最多35个字！"/>
			    </label>
			    <label  style="width: 387px; height: 45px;"">
			    <span class="basic-grey-label-span">响应 :</span>
			    <select id="RESPONSE" AUTOCOMPLETE="off"   class="formselect" name="RESPONSE" onchange="switchRs();">
					<option ${record.RESPONSE == '2' ? "checked='checked'" : ''} value="2">跳转活动详情页面</option>
					<option ${record.RESPONSE == '1' ? "checked='checked'" : ''}value="1">跳转商品详情页面</option>				
				</select>
			    </label >
			    <div id="goodsRs" style="${record.RESPONSE == '1' ? '' : 'display: none;'}">
			    <label>
			    <span class="basic-grey-label-span"> 选择详情:</span>
			    <input type="button" onclick="selectResponse();" class="zero_btn " value="选择响应详情" style="margin-top: 5px;font-family:​Arial ;"/>
			    </label>
			    <label style="margin-top: 10px;">
				 <span class="basic-grey-label-span"> 商品名:</span>
				 <input id="RESPONSE_TITLE" type="text" readonly="readonly" name="RESPONSE_TITLE" value="" style="margin-bottom: 0px;"  datatype="*" nullmsg="请选择响应详情！"/>
				 </label>
				 <label style="margin-top: 10px;">
				 <span class="basic-grey-label-span"> 首页展示价格:</span>
				 <input id="SHOW_PRICE" type="text" readonly="readonly" name="SHOW_PRICE" value="" style="margin-bottom: 0px;width: 115px;"  datatype="money" errormsg="请输入正确商品价格！"/>
				 </label>
				 </div>
				 <div id="activityRs" style="${record.RESPONSE == '2' ? '' : 'display: none;'}">
			    <label>
			    <span class="basic-grey-label-span"> 详情:</span>
			    <!-- <textarea rows="" cols=""></textarea> -->
			    <textarea id="CONTENT" name="CONTENT" cols="100" rows="8" style="width:430px;height:360px;visibility:hidden;"  datatype="*" nullmsg="请填写详情！"/>${record.CONTENT}</textarea>
			    </label>
			    </div>
			    <label style="margin-top: 15px;">
			    <span class="basic-grey-label-span">显示排序 :</span>
			    <input id="RANK" type="text" name="RANK" style="width: 95px;" value="${record.RANK == '' || record.RANK==null ? '0' : record.RANK }" datatype="n0-8" errormsg="最多8位数字！" />
			    </label>
			    <div>
			    <span class="basic-grey-label-span"  style="margin-top: 6px;"> 发布:</span>
			    <section class="model-2">
			  		<div class="checkbox checkbox_normal" >
			    	<input id=checkbox name="PUBLISH" type="checkbox" ${record.PUBLISH eq 'on' ? 'checked=""' : ''} />
			    	<label style="width: 54px; height: 33px;" class="checkbox-lebal-normal"></label>
			  	</div></section>
				</div>
			    <input id="saveActivity" type="button" style="margin-top: 25px; margin-left: 150px;" class="zero_btn zero_btn_primary"  value="保存"/>&nbsp;&nbsp;
			    <input id="GOBACK" type="button" class="zero_btn" onclick="goback();" value="返回" />
    
    	</form>
   		</div>
</div>

</body>
<script type="text/javascript">
/*通用验证框架  */
$(function(){
	//$(".registerform").Validform();  //就这一行代码！;
	$(".registerform:eq(0)").Validform({
		btnSubmit:"#saveActivity",
		tipSweep:true,
		tiptype:1,
		/* tiptype:function(msg,o,cssctl){
			o.obj.attr("ok","ok");
			alert(msg+"___"+o.obj+"______"+o.type+"___"+o.conform);
			
		    //msg：提示信息;
		    //o:{obj:*,type:*,curform:*},
		    //obj指向的是当前验证的表单元素（或表单对象，验证全部验证通过，提交表单时o.obj为该表单对象），
		    //type指示提示的状态，值为1、2、3、4， 1：正在检测/提交数据，2：通过验证，3：验证失败，4：提示ignore状态, 
		    //curform为当前form对象;
		    //cssctl:内置的提示信息样式控制函数，该函数需传入两个参数：显示提示信息的对象 和 当前提示的状态（既形参o中的type）;
		}, */
		ajaxPost:true,
		beforeCheck:function(curform){
			//在表单提交执行验证之前执行的函数，curform参数是当前表单对象。
			//这里明确return false的话将不会继续执行验证操作;	
			var RESPONSE = $("#RESPONSE").val();
			if(RESPONSE == '1'){
				$("#RESPONSE_TITLE").attr("datatype","*");
				$("#SHOW_PRICE").attr("datatype","money");
				$("#CONTENT").removeAttr("datatype");
			}else if(RESPONSE == '2'){
				$("#RESPONSE_TITLE").removeAttr("datatype");
				$("#SHOW_PRICE").removeAttr("datatype");
				$("#CONTENT").attr("datatype","*");
			}
		},
		beforeSubmit:function(curform){
			//在验证成功后，表单提交前执行的函数，curform参数是当前表单对象。
			//这里明确return false的话表单将不会提交;
			/* BaseUtils.showWaitMsg();
			$.ajax({
				url : $("#goodsForm").attr("action"),
				type : "post",
				data : $("#goodsForm").serialize(),
				dataType : "json",
				success : function(data) {
					//var ret = jQuery.parseJSON(data);
					
					//alert(data.msg);
					if (data.flag) {
						BaseUtils.hideWaitMsg();
					}
				}
			}); */
			
		},
		callback:function(data){
				if(data.status=="y"){
					$("#ACTIVITY_ID").val(data.obj.ACTIVITY_ID);
					window.location.href = document.referrer;//返回上一页并刷新
					/* setTimeout(function(){
						$.Hidemsg(); //公用方法关闭信息提示框;显示方法是$.Showmsg("message goes here.");
						history.go(-1);
					},2000); */
				}
			//返回数据data是json对象，{"info":"demo info","status":"y"}
			//info: 输出提示信息;
			//status: 返回提交数据的状态,是否提交成功。如可以用"y"表示提交成功，"n"表示提交失败，在ajax_post.php文件返回数据里自定字符，主要用在callback函数里根据该值执行相应的回调操作;
			//你也可以在ajax_post.php文件返回更多信息在这里获取，进行相应操作；
			//ajax遇到服务端错误时也会执行回调，这时的data是{ status:**, statusText:**, readyState:**, responseText:** }；
	 
			//这里执行回调操作;
			//注意：如果不是ajax方式提交表单，传入callback，这时data参数是当前表单对象，回调函数会在表单验证全部通过后执行，然后判断是否提交表单，如果callback里明确return false，则表单不会提交，如果return true或没有return，则会提交表单。
		}
	});
})
</script>
</html>