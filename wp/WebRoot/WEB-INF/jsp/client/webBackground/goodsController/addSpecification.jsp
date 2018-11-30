<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>添加商品</title>
<%@ include file="../../../common/common_header.jsp"%>
<link href="${ctx}/skin/qqface/css/bootstrap.min.css" rel="stylesheet" media="screen" />
<link href="${ctx}/skin/webBase/goods/css/addGoodsStyle.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${ctx}/skin/qqface/css/reset.css" />
<link rel="stylesheet" href="${ctx}/skin/qqface/css/style.css" />
<!--控件样式  -->
<link rel="stylesheet" href="${ctx}/skin/common/css/elementStyle.css"/>
<!--end  -->
<!--UEditor-->
<link rel="stylesheet" href="${ctx }/editor/themes/default/default.css" />
<link rel="stylesheet" href="${ctx }/editor/plugins/code/prettify.css" />
<script charset="utf-8" src="${ctx }/editor/kindeditor.js"></script>
<script charset="utf-8" src="${ctx }/editor/editor/auto.js"></script>
<script charset="utf-8" src="${ctx }/editor/lang/zh_CN.js"></script>
<script charset="utf-8" src="${ctx }/editor/plugins/code/prettify.js"></script>
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
	 
	
 </script>
</head>
<body>
            <div class="mDETAIL_no_border">
                <input type="hidden" id="trId" name="trId" value="${record.trId }" />
                <div>
			    <form action="${ctx}/goodsBC/insertGoodsDetail.do" id="goodsForm" name="goodsForm" method="post" class="basic-grey registerform"  style="padding-bottom: 0px;">
			    <input type="hidden" id="MAIN_SPECIFICATION_ID" name="MAIN_SPECIFICATION_ID" value="${record.MAIN_SPECIFICATION_ID }" />
			    <input type="hidden" id="GOODS_ID" name="GOODS_ID" value="${record.GOODS_ID }" />
			    <input type="hidden" id="IS_USE" name="IS_USE" value="${record.IS_USE }" />
				<label style="margin-top: 5px;">
			    <span class="basic-grey-label-span" style="width: 55px;">主规格:</span>
			    <input id="MAIN_SPECIFICATION" type="text" name="MAIN_SPECIFICATION" placeholder="比如衣服：M号" value="${record.MainGoodsDetail.MAIN_SPECIFICATION }" style="width: 150px;" datatype="s1-6" errormsg="最少1个，最多6个字！"/>
			       
			           库存：<input id="INVENTORY" type="text" name="INVENTORY" value="${record.MainGoodsDetail.INVENTORY }" style="width: 50px;" datatype="n1-8" errormsg="最多8位数字！"/>
			           价格：<input id="PRICE" type="text" name="PRICE" value="${record.MainGoodsDetail.PRICE }" style="width: 50px;" datatype="money" errormsg="请输入正确商品价格！"/>
			          <%--  促销价：<input id="PROMOTION_PRICE" type="text" name="PROMOTION_PRICE" value="${record.MainGoodsDetail.PROMOTION_PRICE }" style="width: 50px;" ignore="ignore" datatype="money" errormsg="请输入正确商品促销价格！"/> --%>
			   
			    <!-- <input  type="button" class="zero_btn " value="添加属性" onclick="addAttribute();" style="margin-top: 5px;font-family:​Arial;margin-bottom: 10px;"/> -->
			    <input  type="button" class="zero_btn " value="添加子规格" onclick="addChildAttribute('childAttributeDiv');" style="margin-top: 5px;font-family:​Arial;margin-bottom: 10px;"/>
			    </label>
			    <div id="childAttributeDiv">
			    <c:forEach var="r" items="${record.childGoodsDetialList}" varStatus="status">
			    	<div id="childAttributeDiv${status.index}">
					<label>
				    <span class="basic-grey-label-span" style="width: 40px;">&nbsp;</span>
				    <input id="CHILD_SPECIFICATION${status.index}" type="text" placeholder="白色" name="CHILD_SPECIFICATION${status.index}" value="${r.CHILD_SPECIFICATION }" style="margin-left: 50px;width: 150px;margin-right: 0px;"/>
				    	库存：<input id="INVENTORY${status.index}" type="text" name="INVENTORY${status.index}" value="${r.INVENTORY }" style="width: 50px;margin-right: 0px;" datatype="n1-8" errormsg="最多8位数字！"/>
				    	价格：<input id="PRICE${status.index}" type="text" name="PRICE${status.index}" value="${r.PRICE }" style="width: 50px;margin-right: 0px;" datatype="money" errormsg="请输入正确商品价格！"/>
			        	<%-- 促销价：<input id="PROMOTION_PRICE${status.index}" type="text" name="PROMOTION_PRICE${status.index}" value="${r.PROMOTION_PRICE }" style="width: 50px;margin-right: 0px;"  ignore="ignore" datatype="money" errormsg="请输入正确商品促销价格！"/> --%>
				    	<input  type="button" class="zero_btn" onclick="deleteAttribute('childAttributeDiv${status.index}');" value="删除" style="margin-top: 5px;font-family:​Arial;margin-bottom: 10px;"/> 
				    </label>
				    </div>
			    </c:forEach>
			    </div>
			    
			   <input style="margin-left: 70px;" id="SAVEKEYWORD" type="button" class="zero_btn zero_btn_primary" value="保存"/>&nbsp;&nbsp;
			    <input id="GOBACK" type="button" class="zero_btn" onclick="goback();" value="返回" /> 
    
    	</form>
   		</div>
   		
</div>
</body>
<script type="text/javascript">
var ci = ${record.ListSize };
var cj = ${record.ListSize };

function goback(){
	//window.location.href="${ctx}/goodsBC/goodsList.do";
	parent.layer.closeAll();
}

function deleteAttribute(id){
	document.getElementById(id).parentNode.removeChild(document.getElementById(id)); 
	cj--;
		
}

function addChildAttribute(id){
	if(cj >= 6){
		alert("最多创建6个子规格！");
		return false;
	}
	//+"促销价：<input id=\"PROMOTION_PRICE"+ci+"\" type=\"text\" name=\"PROMOTION_PRICE"+ci+"\" value=\"\" style=\"width: 50px;\" ignore=\"ignore\" datatype=\"money\" errormsg=\"请输入正确商品促销价格！\"/>"
	$("#"+id).append("<div id=\"childAttributeDiv"+ci+"\">"
			+"<label >"
	    +"<span class=\"basic-grey-label-span\" style=\"width: 40px;\">&nbsp;</span>"
	    +"<input id=\"CHILD_SPECIFICATION"+ci+"\" type=\"text\" placeholder=\"白色\" name=\"CHILD_SPECIFICATION"+ci+"\" value=\"\" style=\" margin-left: 50px;width: 150px;\" datatype=\"s1-6\" errormsg=\"最少1个，最多6个字！\"/>"
	    	+"库存&nbsp;:&nbsp;"
	    +"<input id=\"INVENTORY"+ci+"\" type=\"text\" name=\"INVENTORY"+ci+"\" value=\"\" style=\"width: 50px;\" datatype=\"n0-8\" errormsg=\"最多8位数字！\"/>"
	    +"价格：<input id=\"PRICE"+ci+"\" type=\"text\" name=\"PRICE"+ci+"\" value=\"\" style=\"width: 50px;\" datatype=\"money\" errormsg=\"请输入正确商品价格！\"/>"
	    +"<input  type=\"button\" class=\"zero_btn\" onclick=\"deleteAttribute('childAttributeDiv"+ci+"');\" value=\"删除\" style=\"margin-top: 5px;font-family:​Arial;margin-bottom: 10px;\" />" 
	    +"</label>"
	    +"</div>");
	ci++;
	cj++;
}


var index;
/*通用验证框架  */
$("body").append("<!--验证的遮蔽层  -->"  
		+"<div id=\"mask\" class=\"mask\"></div>"
		+"<!-- end -->");
$(function(){
	
	//$(".registerform").Validform();  //就这一行代码！;
	$(".registerform:eq(0)").Validform({
		btnSubmit:"#SAVEKEYWORD",
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
			if(cj>0){
				$("#INVENTORY").removeAttr("datatype");
				$("#PRICE").removeAttr("datatype");
				$("#PROMOTION_PRICE").removeAttr("datatype");
			}else{
				$("#INVENTORY").attr("datatype","n0-8");
				$("#PRICE").attr("datatype","money");
				$("#PROMOTION_PRICE").attr("datatype","money");
			}
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
			    shade: [0.5,'#fff'] //0.1透明度的白色背景
			});
			
		},
		callback:function(data){
			
				if(data.status=="y"){
					layer.close(index);
					var trId = $("#trId").val();
					var GOODS_ID = data.obj.GOODS_ID;
					$("#GOODS_ID").val(data.obj.GOODS_ID);
					$("#MAIN_SPECIFICATION_ID").val(data.obj.MAIN_SPECIFICATION_ID);
				    var MAIN_SPECIFICATION = data.obj.MAIN_SPECIFICATION;
				    var MAIN_SPECIFICATION_ID = data.obj.MAIN_SPECIFICATION_ID;
				  	var GOODS_JSON = {"GOODS_ID":GOODS_ID,"MAIN_SPECIFICATION":MAIN_SPECIFICATION,"MAIN_SPECIFICATION_ID":MAIN_SPECIFICATION_ID,"trId":trId};
					trId = parent.setGoodsDetail(GOODS_JSON);
					$("#trId").val(trId);
					layer.closeAll();
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