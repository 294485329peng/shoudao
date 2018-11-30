<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>公司信息修改</title>
<%@ include file="../../common/common_header.jsp"%>
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
<!-- 	<script type="text/javascript">
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
		
</script> -->
 <script type="text/javascript">
 
 </script>
</head>
<body>
	<!-- <div class="youkuangjia"> -->
            <div class="modstitle">
                <h3>公司信息修改</h3>
            </div>
            <div class="mcontent_no_border">
                <!-- <div class="alert">
                    <p>注意：1级菜单最多只能开启3个，2级子菜单最多开启5个!</p>
                    <p>只有保存主菜单后才可以添加子菜单</p>
                    <p>撤销自定义菜单：撤销后，您的微信公众帐号上的自定义菜单将不存在；如果您想继续在微信公众帐号上使用自定义菜单，请点击“生成自定义菜单”按钮，将重新启用！</p> 
                </div> -->
                <div>
			    <form action="${ctx}/userInfo/insert.do" id="Form" name="Form" method="post" class="basic-grey registerform">
			    <input type="hidden" id="GZH_ID" name="GZH_ID" value="${record.GZH_ID }" />
			   
			    
			    <label style="margin-top: 10px; height: 50px;">
			    <span class="basic-grey-label-span">公司名称 :</span>
			    <input id="COMPANY_NAME" type="text" name="COMPANY_NAME" value="${record.COMPANY_NAME }" datatype="s1-20" nullmsg="请填写名称！" errormsg="名称至少1个字,最多20个字！"/>
			    </label>
				<label style=" height: 50px;">
			    <span class="basic-grey-label-span">客服电话 :</span>
			    <input id="SERVICE_PHONE" type="text" style="width: 350px;" name="SERVICE_PHONE" value="${record.SERVICE_PHONE }" datatype="s0-20" nullmsg="请填写客服电话！" errormsg="最多20位客服电话"/>
			    </label>
			    <%-- <label  style="width: 387px; height: 45px;"">
			    <span class="basic-grey-label-span">响应 :</span>
			    <select id="RESPONSE" AUTOCOMPLETE="off"   class="formselect" name="RESPONSE" onchange="switchRs();">
					<option ${record.RESPONSE == '2' ? "checked='checked'" : ''} value="2">跳转活动详情页面</option>
					<option ${record.RESPONSE == '1' ? "checked='checked'" : ''}value="1">跳转商品详情页面</option>				
				</select>
			    </label > --%>
			    
			    <label style="margin-top: 10px;">
				 <span class="basic-grey-label-span"> 店面地址:</span>
				 <input id="COMPANY_ADDRESS" type="text" name="COMPANY_ADDRESS" value="${record.COMPANY_ADDRESS }" style="margin-bottom: 0px;" datatype="s0-40" errormsg="店面地址最多40字符！"/>
				 </label>
			    <input id="save" type="button" style="margin-top: 25px; margin-left: 150px;" class="zero_btn zero_btn_primary"  value="保存"/>&nbsp;&nbsp;
			    <input id="GOBACK" type="button" class="zero_btn" onclick="goback();" value="返回" />
    
    	</form>
   		</div>
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