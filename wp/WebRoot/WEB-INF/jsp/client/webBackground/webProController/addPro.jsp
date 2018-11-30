<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>添加宣传页</title>
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
				fileManagerJson : '${ctx}/upload/fileManagerWeb.do',
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
							var id = url.substring(url.indexOf("&")+1,url.indexOf("&")+37);
							if(PIC_ID == undefined || PIC_ID == "" || PIC_ID == null){
								if(id.length == 36){
									K('#PIC_ID').val(id);
									K('#PIC_URL').val(url);
									$("#showPic").attr("src",url);
								}else{
									alert("图片出错，请重新上传！");
								}
							}else{
								K('#PIC_ID').val(PIC_ID);
								K('#PIC_URL').val(url);
								$("#showPic").attr("src",url);
							}
							
							editor.hideDialog();
						}
					});
				});
			});
		});
		
</script>
 <script type="text/javascript">
	
	function goback(){
		window.location.href="${ctx}/acBC/activityList.do";
	}
 </script>
</head>
<body>
	<!-- <div class="youkuangjia"> -->
            <div class="modstitle">
                <h3>添加宣传页</h3>
            </div>
            <div class="mcontent_no_border">
                <div class="alert">
                    <p>注意：编写您微网站的宣传页信息!</p>
                </div>
                
			    <form action="${ctx}/webPro/insertPro.do" id="activityForm" name="activityForm" method="post" class="basic-grey registerform">
			    <input type="hidden" id="PRO_ID" name="PRO_ID" value="${record.PRO_ID }" />
			    <label style="margin-top: 10px; height: 50px;">
			    <span class="basic-grey-label-span">标题 :</span>
			    <input id="PRO_TITLE" type="text" name="PRO_TITLE" value="${record.PRO_TITLE }" datatype="s1-12" nullmsg="请填写标题！" errormsg="标题至少1个字,最多12个字！"/>
			    </label>
			    <span class="basic-grey-label-span"> 详情:</span>
			    <!-- <textarea rows="" cols=""></textarea> -->
			    <textarea id="CONTENT" name="CONTENT" cols="100" rows="8" style="width:430px;height:360px;visibility:hidden;" datatype="*" nullmsg="请填写详情！"/>${record.CONTENT}</textarea>
			    <label id="label-url" style="margin-top: 10px; height: 50px; ${record.PRO_URL == '' || null == record.PRO_URL ? 'display:none ;' : 'display: ;'}">
			    <span class="basic-grey-label-span">网址:</span>
			    <input id="PRO_URL" type="text" style="width: 770px;" readonly="readonly" value="http://${record.PRO_URL }" />
			    </label>
			   <%--  <div style="margin-top: 10px;">
			    <span class="basic-grey-label-span"  style="margin-top: 6px;"> 发布:</span>
			    <section class="model-2">
			  		<div class="checkbox checkbox_normal" >
			    	<input id=checkbox name="PUBLISH" type="checkbox" ${record.PUBLISH eq 'on' ? 'checked=""' : ''} />
			    	<label style="width: 54px; height: 33px;" class="checkbox-lebal-normal"></label>
			  	</div></section>
				</div> --%>
			    <input id="savePro" type="button" style="margin-top: 25px; margin-left: 150px;" class="zero_btn zero_btn_primary"  value="保存"/>&nbsp;&nbsp;
			    <input id="GOBACK" type="button" class="zero_btn" onclick="goback();" value="返回" />
    
    	</form>
   		</div>


</body>
<script type="text/javascript">
/*通用验证框架  */
$("body").append("<!--验证的遮蔽层  -->"  
		+"<div id=\"mask\" class=\"mask\"></div>"
		+"<!-- end -->");
$(function(){
	//$(".registerform").Validform();  //就这一行代码！;
	$(".registerform:eq(0)").Validform({
		btnSubmit:"#savePro",
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
			
		},
		callback:function(data){
				if(data.status=="y"){
					$("#PRO_ID").val(data.obj.PRO_ID);
					$("#PRO_URL").val(data.obj.PRO_URL);
					$("#label-url").css('display','');
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