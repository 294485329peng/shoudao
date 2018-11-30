<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>微网站模板</title>
<%@ include file="../../../common/common_header.jsp"%>
<link href="${ctx}/skin/qqface/css/bootstrap.min.css" rel="stylesheet" media="screen" />
<link href="${ctx}/skin/webBase/goods/css/addGoodsStyle.css" rel="stylesheet" type="text/css" />
<!--控件样式  -->
<link rel="stylesheet" href="${ctx}/skin/common/css/elementStyle.css"/>
<!--end  -->
<!--form 验证 -->
<script type="text/javascript" src="${ctx }/Validform/js/Validform_v5.3.2.js"></script>
<link rel="stylesheet" href="${ctx }/Validform/css/style.css" />
<!--end  -->
<link rel="stylesheet" href="${ctx }/skin/webBase/webBc/css/template.css" />
<script type="text/javascript">

	/* function goback(){
		window.location.href="${ctx}/goodsBC/goodsList.do";
	} */
	$(document).ready(function(){
		$(":radio").click(function(){
			  var WAP_ID =  $(this).val();
			  var URL = $(this).attr("URL");
			  $("#WAP_ID").val(WAP_ID);
			  $("#URL").val(URL);
			  alert(URL+"__"+WAP_ID);
		  });
		});
	
 </script>
</head>
<body>
	<!-- <div class="youkuangjia"> -->
<div class="modstitle">
    <h3>微网站模板</h3>
</div>
<div class="mDETAIL_no_border">
    <div class="alert"  style="margin-left: 10px; margin-right: 10px; margin-top: 10px;">
        <p>注意：1级菜单最多只能开启3个，2级子菜单最多开启5个!</p>
        <p>只有保存主菜单后才可以添加子菜单</p>
        <p>撤销自定义菜单：撤销后，您的微信公众帐号上的自定义菜单将不存在；如果您想继续在微信公众帐号上使用自定义菜单，请点击“生成自定义菜单”按钮，将重新启用！</p> 
    </div>
    <div class="tem-border" style="margin-left: 10px; margin-right: 10px; margin-top: 10px;">
    <ul id="grid" class="cateradio g grid" >
	<li class="mix mix thumb focu bg filt slip mix_all" style=" opacity: 1;">
	<!-- <div class="mbtip">小图标为正方形300x300px。不支持更换颜色风格</div> -->
	<label>
	<img data-original="/tpl/User/default/common/images/cate1330.png" src="${ctx }/skin/webBase/webBc/images/01.png" style="display: inline;">
	<input class="radio" type="radio" URL="111" value="330" name="WAP_ID" >
	模板330
	</label>
	</li> 
	<li class="mix mix thumb focu bg filt slip mix_all" style=" opacity: 1;">
	<!-- <div class="mbtip">小图标为正方形300x300px。不支持更换颜色风格</div> -->
	<label>
	<img data-original="/tpl/User/default/common/images/cate1330.png" src="${ctx }/skin/webBase/webBc/images/01.png" style="display: inline;">
	<input class="radio" type="radio" URL="113" value="331" name="WAP_ID" >
	模板330
	</label>
	</li>
	</ul>
	 <form action="${ctx}/WebBc/update.do" id="addForm" name="addForm" method="post" class="registerform" style="margin-bottom: 20px;">
	 <input type="hidden" id="WAP_ID" name="WAP_ID" value="${record.WAP_ID }" datatype="*" nullmsg="请选择模板！"/>
	 <input type="hidden" id="URL" name="URL" value="${record.URL }" />
	 <input id="save" type="button" class="zero_btn zero_btn_primary" style="margin-left: 70px;" value="保存"/>&nbsp;&nbsp;
	 </form>
	<!-- <input id="GOBACK" type="button" class="zero_btn" onclick="goback();" value="返回" />  -->
	</div>          
</div> 
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
</body>

</html>