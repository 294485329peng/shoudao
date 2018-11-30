<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>充值</title>
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
	<!--form 验证 -->
	<script type="text/javascript" src="${ctx }/Validform/js/Validform_v5.3.2.js"></script>
	<link rel="stylesheet" href="${ctx }/Validform/css/style.css" />
	<!--end  -->
	<script type="text/javascript">
	
	/**
 	 * 选择后返回数据调整
 	 */
 	 function setSelectRESPONSE(RESPONSE_JSON){
 		 
 	 }
	function goback(){
		window.location.href="${ctx}/acBC/activityList.do";
	}
	
 </script>
</head>
<body>
         <div class="mcontent_no_border">
			    <form action="${ctx}/memberBC/insterChongzhiMoney.do" id="activityForm" name="activityForm" method="post" class="basic-grey registerform">
			    <input type="hidden" id="OPEN_ID" name="OPEN_ID" value="${record.OPEN_ID }" />
			    <label style="margin-top: 10px; height: 50px;">
			    <span class="basic-grey-label-span">充值金额:</span>
			    <input  type="text" id="MONEY" name="MONEY" value="" datatype="money" ignore="ignore"  errormsg="格式错误，0~12，最多精确小数点两位。"/>
			    </label>
				<label style=" height: 50px;">
			    <span class="basic-grey-label-span">充值积分 :</span>
			    <input  type="text" id="POINT" name="POINT" value="" datatype="n0-12"  ignore="ignore" errormsg="最多12个位！"/>
			    </label>
			    <label style=" height: 50px;">
			    <span class="basic-grey-label-span">备注 :</span>
			    <input  type="text" name="REMARK" value="" datatype="s0-20"  errormsg="最多20个字！"/>
			    </label>
			    <input id="save" type="button" style="margin-top: 25px; margin-left: 150px;" class="zero_btn zero_btn_primary"  value="保存"/>&nbsp;&nbsp;
			    <!-- <input id="close" type="button" class="zero_btn" onclick="close();" value="关闭" /> -->
    
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
			var POINT = $("#POINT").val();
			var MONEY = $("#MONEY").val();
			if("" == POINT && "" == MONEY){
				$.Showmsg("充值金额和充值积分至少填写一项！");
				return false;
			}
			
		},
		callback:function(data){
				if(data.status=="y"){
					 var OPEN_ID = $("#OPEN_ID").val();
					 var MONEY = data.obj.MONEY;
					 var POINT = data.obj.POINT;
					 var RESPONSE_JSON = {"MONEY":MONEY,"POINT":POINT,"OPEN_ID":OPEN_ID};
					 parent.setSelectResponse(RESPONSE_JSON);
					setTimeout(function(){
						$.Hidemsg(); //公用方法关闭信息提示框;显示方法是$.Showmsg("message goes here.");
					},2000);
				}else{
					$.Showmsg("操作失败！");
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