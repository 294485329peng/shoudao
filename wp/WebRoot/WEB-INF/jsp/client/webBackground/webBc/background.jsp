<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
 <head>
<title>微网站信息</title>
<%@ include file="../../../common/common_header.jsp"%>
<link href="${ctx}/skin/autoresponse/css/ar_css.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/skin/webBase/home/css/addNavStyle.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${ctx}/skin/qqface/css/reset.css" />
<link rel="stylesheet" href="${ctx}/skin/qqface/css/style.css" />
<!--控件样式  -->
<link rel="stylesheet" href="${ctx}/skin/common/css/elementStyle.css"/>
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
 /**
	 *description：上传图片，选择图片。
	 *time：2015/12/2
	 *author：daiwk
	 */
	/* KindEditor.ready(function(K) {
		var editor = K.editor({
			uploadJson : '${ctx}/upload/fileUploadWeb.do',
			fileManagerJson : '${ctx}/upload/fileManagerWeb.do',
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
	}); */
 </script>
</head>
<body>
	<!-- <div class="youkuangjia"> -->
            <div class="modstitle">
                <h3>微网站信息</h3>
            </div>
            <div class="mcontent_no_border">
                <div class="alert">
                </div>
    <form action="" id="addForm" name="addForm" method="post" class="basic-grey registerform">
    <%-- <input type="hidden" id="GZH_ID" name="GZH_ID" value="${record.GZH_ID }" />
    <input type="hidden" id="PIC_ID" name="PIC_ID" value="${record.PIC_ID }" datatype="*" nullmsg="请选择图片！" />
	<input type="hidden" id="PIC_URL" name="PIC_URL" value="${record.PIC_URL }" /> --%>
    <label>
    <span>首页地址：</span>
    <input type="text" readonly="readonly" value="http://www.wxplatform.top${ctx }/TWeb/bs/home.htmls?store=${record.GZH_ID }" style="margin-bottom: 0px;" datatype="s1-12" nullmsg="请填写简介！" errormsg="名称至少1个字,最多12个字！"/>
    </label>
    <label style="margin-top: 10px;">
    <span>商品列表：</span>
    <input type="text" readonly="readonly"  value="http://www.wxplatform.top${ctx}/TWeb/goods/goodsList.htmls?store=${record.GZH_ID }" style="margin-bottom: 0px;" datatype="s1-12" nullmsg="请填写简介！" errormsg="名称至少1个字,最多12个字！"/>
    </label>
    <label style="margin-top: 10px;">
    <span>活动列表：</span>
    <input type="text"  readonly="readonly"  value="http://www.wxplatform.top${ctx}/TWeb/act/list.htmls?store=${record.GZH_ID }" style="margin-bottom: 0px;" datatype="s1-12" nullmsg="请填写简介！" errormsg="名称至少1个字,最多12个字！"/>
    </label>
    <label style="margin-top: 10px;">
    <span>会员中心：</span>
    <input type="text"  readonly="readonly"  value="http://www.wxplatform.top${ctx}/MemberCenter/memberInfo.htmls?store=${record.GZH_ID }" style="margin-bottom: 0px;" datatype="s1-12" nullmsg="请填写简介！" errormsg="名称至少1个字,最多12个字！"/>
    </label> 
    <label style="margin-top: 10px;">
    <span>会员登陆注册：</span>
    <input type="text"  readonly="readonly"  value="http://www.wxplatform.top${ctx}/TWebLogin/Member/login.htmls?store=${record.GZH_ID }" style="margin-bottom: 0px;" datatype="s1-12" nullmsg="请填写简介！" errormsg="名称至少1个字,最多12个字！"/>
    </label>
    <label style="margin-top: 10px;">
    <span>自定义宣传页面：</span>
    <input type="text"  readonly="readonly"  value="网址会在宣传管理中，用户添加成功后显示！" style="margin-bottom: 0px;" datatype="s1-12" nullmsg="请填写简介！" errormsg="名称至少1个字,最多12个字！"/>
    </label>    
    
    <%-- <label id="LABEL_IT" style="width: 475px;margin-top: 10px;">
    <span>上传图片 :</span>
    <input id="uploadPicture" type="button" class="zero_btn " value="上传图片" style="margin-top: 5px;font-family:​Arial ;"/>
    </label>
    <input type="hidden" name="PIC_URL" value="" />
    <label  style="width: auto;margin-top: 20px;">
    <span>缩略图 :</span>
    	<c:if test="${record.PIC_URL != '' && record.PIC_URL != null}">
	    	<img id="pic-src" src="${record.PIC_URL }"  style="max-width: 400px; max-height: 400px;border: 1px solid;"/>
	    </c:if>
	    <c:if test="${record.PIC_URL == '' || record.PIC_URL == null}">
	    	<img id="pic-src" src="${ctx }/skin/webBase/home/images/nopic.jpg"  style="max-width: 400px; max-height: 400px;border: 1px solid;"/>
	    </c:if>
    </label > --%>
    <!-- <div style="margin-top: 25px; margin-left: 155px;">
    <input type="button" class="zero_btn zero_btn_primary" id="save" value="保存"/>
    <input type="button" class="zero_btn" onclick="goback();" value="返回" style="margin-left: 15px;"/>
    <input type="button" class="zero_btn zero_btn_red" onclick="deleteNav();" value="删除并返回" style="margin-left: 15px;"/>
    </div> -->
    </form>
    
</div>
<!-- </div> -->
</body>
<script type="text/javascript">
var index;
/*通用验证框架  */
$("body").append("<!--验证的遮蔽层  -->"  
		+"<div id=\"mask\" class=\"mask\"></div>"
		+"<!-- end -->");
$(function(){
	//$(".registerform").Validform();  //就这一行代码！;
	$(".registerform:eq(0)").Validform({
		btnSubmit:"#save",
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
			index = layer.load(1, {
			    shade: [0.1,'#fff'] //0.1透明度的白色背景
			});
			
		},
		callback:function(data){
			layer.close(index);
				if(data.status=="y"){
					$("#GZH_ID").val(data.obj.GZH_ID);
					setTimeout(function(){
						
						$.Hidemsg(); //公用方法关闭信息提示框;显示方法是$.Showmsg("message goes here.");
					},2000);
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