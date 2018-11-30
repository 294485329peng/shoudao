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
<script>
		KindEditor.ready(function(K) { 
			var editor = K.create('#DETAIL', { 
				uploadJson : '${ctx}/upload/fileUploadWeb.do',
				fileManagerJson : '${ctx}/upload/fileManagerWeb.do',
				allowFileManager: true,
                afterBlur: function () { this.sync(); },//数据同步
				resizeType:1,//设置编辑器只高度可变
				minHeight: 350,//设置编辑器的最小高度
				minWidth:400,//设置编辑器的最小宽度
				afterBlur: function () {
					/* K('#DETAIL_HTML').val(editor.html()); */
					this.sync();
					//alert(editor.html());
				}
				}); 
			
			K('#uploadPicture').click(function() {
				editor.loadPlugin('image', function() {
					editor.plugin.imageDialog({
						imageUrl : K('#PIC_URL').val(),
						clickFn : function(url, title, width, height, border, align,PIC_ID) {
							var id = url.substring(url.indexOf("&")+1,url.indexOf("&")+37);
							if(PIC_ID == undefined || PIC_ID == "" || PIC_ID == null){
								if(id.length == 36){
									$("#showPicUrl").attr("src",url);
									$("#PIC_URL1").val(url);
									$("#PIC_URL_ID1").val(id);
								}else{
									alert("图片出错，请重新上传！");
								}
							}else{
								$("#showPicUrl").attr("src",url);
								$("#PIC_URL1").val(url);
								$("#PIC_URL_ID1").val(PIC_ID);;
							}
							
							editor.hideDialog();
						}
					});
				});
			});
		});
		
</script>
<script type="text/javascript">
 var ai = ${record.ListSize };
 var aj = ${record.ListSize };
 var ci = 0;
 var cj = 0;

	function goback(){
		window.location.href="${ctx}/goodsBC/goodsList.do";
	}
	/**
	*添加分组
	*/
	
	function addGroupLayer() {
		window.location.href="${ctx}/goodsClassBC/addGoodsClass.do"; 
	}
			function deleteAttribute(id){
				document.getElementById(id).parentNode.removeChild(document.getElementById(id));  
		}
			
		/* 
			function addAttribute(){
			$("#attributeList").append("<div id=\"attributeDiv"+ai+"\">"
					+"<label >"
			    +"<span class=\"basic-grey-label-span\">属性 :</span>"
			    +"<input id=\"ATTRIBUTE"+ai+"\" type=\"text\" name=\"ATTRIBUTE"+ai+"\" value=\"\" style=\"width: 150px;\"/>"
			    	+"库存&nbsp;:&nbsp;"
			    +"<input id=\"INVENTORY"+ai+"\" type=\"text\" name=\"INVENTORY"+ai+"\" value=\"\" style=\"width: 50px;\"/>"
			    +"原价：<input id=\"PRICE"+ai+"\" type=\"text\" name=\"PRICE"+ai+"\" value=\"\" style=\"width: 50px;\"/>"
		        +"促销价：<input id=\"PROMOTION_PRICE"+ai+"\" type=\"text\" name=\"PROMOTION_PRICE"+ai+"\" value=\"\" style=\"width: 50px;\"/>"
			    +"<input  type=\"button\" class=\"zero_btn\" onclick=\"deleteAttribute('attributeDiv"+ai+"');\" value=\"删除\" style=\"margin-top: 5px;font-family:​Arial;margin-bottom: 10px;\" />" 
			    +"<input  type=\"button\" class=\"zero_btn\" onclick=\"addChildAttribute('childAttributeDiv"+ai+"','"+ai+"');\" value=\"添加子属性\" style=\" margin-left: 5px;margin-top: 5px;font-family:​Arial;margin-bottom: 10px;\" />" 
			    +"</label>"
			    +"<div id=\"childAttributeDiv"+ai+"\">"
			    +"</div>"
			    +"</div>");
			ai++;
			aj++;
		}
			function addChildAttribute(id,adid){
				$("#"+id).append("<div id=\"childAttributeDiv"+adid+ci+"\">"
						+"<label >"
				    +"<span class=\"basic-grey-label-span\">&nbsp;</span>"
				    +"<input id=\"ATTRIBUTE"+adid+ci+"\" type=\"text\" name=\"ATTRIBUTE"+adid+ci+"\" value=\"\" style=\" margin-left: 50px;width: 150px;\"/>"
				    	+"库存&nbsp;:&nbsp;"
				    +"<input id=\"INVENTORY"+adid+ci+"\" type=\"text\" name=\"INVENTORY"+adid+ci+"\" value=\"\" style=\"width: 50px;\"/>"
				    +"原价：<input id=\"PRICE"+adid+ci+"\" type=\"text\" name=\"PRICE"+adid+ci+"\" value=\"\" style=\"width: 50px;\"/>"
			        +"促销价：<input id=\"PROMOTION_PRICE"+adid+ci+"\" type=\"text\" name=\"PROMOTION_PRICE"+adid+ci+"\" value=\"\" style=\"width: 50px;\"/>"
				    +"<input  type=\"button\" class=\"zero_btn\" onclick=\"deleteAttribute('childAttributeDiv"+adid+ci+"');\" value=\"删除\" style=\"margin-top: 5px;font-family:​Arial;margin-bottom: 10px;\" />" 
				    +"</label>"
				    +"</div>");
				ci++;
				cj++;
			} */
			function addSpecification() {
				if(aj >= 6){
					alert("最多创建6个主规格！");
					return false;
				}
				var GOODS_ID = $("#GOODS_ID").val();
				layer.open({
				    type: 2,
				    area: ['800px', '430px'],
				    fix: false, //不固定
				    maxmin: true,
				    content: '${ctx}/goodsBC/addSpecification.do?GOODS_ID='+GOODS_ID,
				}); 
			}
			function forDelete(id,trid){
				
				defaultConfirm("确定要删除？<font color='red'>该操作不可逆，并删除所有关联项！</font> ",(function(){
					BaseUtils.showWaitMsg(); 
					$.ajax({
							url : '${ctx}/goodsBC/deleteGoodsDetailByMainId.do',
							type : "post",
							data : {"MAIN_SPECIFICATION_ID":id},
							dataType : "json",
							success : function(data) {
								//var ret = jQuery.parseJSON(data);
								BaseUtils.hideWaitMsg();
								alert(data.msg);
								if (data.flag) {
									ai--;
									aj--;
									document.getElementById(trid).parentNode.removeChild(document.getElementById(trid));
								}
							}
						});
				}));

			}
			function forDetail(id,trId){
				var GOODS_ID = $("#GOODS_ID").val();
				layer.open({
				    type: 2,
				    area: ['800px', '430px'],
				    fix: false, //不固定
				    maxmin: true,
				    content: '${ctx}/goodsBC/addSpecification.do?GOODS_ID='+GOODS_ID+'&MAIN_SPECIFICATION_ID='+id+'&trId='+trId,
				});
			}
			
			function setGoodsDetail(GOODS_JSON){
				if("" == GOODS_JSON.trId || undefined == GOODS_JSON.trId || null == GOODS_JSON.trId){
					var trId = "tr"+ai;
					$("#goodsDetailBody").append("<tr id=\"tr"+ai+"\" style=\"border-top:1px solid #cbcbcb ;\">"
							+"<td id=\"tr"+ai+"-td\">"+GOODS_JSON.MAIN_SPECIFICATION+"</td>"
							+"<td><a href=\"javascript:forDelete('"+GOODS_JSON.MAIN_SPECIFICATION_ID+"','tr"+ai+"');\">删除</a>&nbsp;&nbsp;"
							+"<a href=\"javascript:forDetail('"+GOODS_JSON.MAIN_SPECIFICATION_ID+"','tr"+ai+"');\">查看子项</a> "
							+"</td>"
						+"</tr>");
					ai++;
					aj++;
					$("#GOODS_ID").val(GOODS_JSON.GOODS_ID);
					layer.closeAll();
					return trId;
					
				}else{
					$("#"+GOODS_JSON.trId+"-td").html(GOODS_JSON.MAIN_SPECIFICATION);
					$("#GOODS_ID").val(GOODS_JSON.GOODS_ID);
				}
				
			}
 </script>
</head>
<body>
	<!-- <div class="youkuangjia"> -->
            <div class="modstitle">
                <h3>添加商品</h3>
            </div>
            <div class="mDETAIL_no_border">
                <div class="alert"  style="margin-left: 10px; margin-right: 10px; margin-top: 10px;">
                    <p>注意：添加您需要宣传的商品信息后保存!</p>
                </div>
                <div>
			    <form action="${ctx}/goodsBC/insertGoods.do" id="goodsForm" name="goodsForm" method="post" class="basic-grey registerform">
			    <input type="hidden" id="GOODS_ID" name="GOODS_ID" value="${record.GOODS_ID }" autocomplete="off" datatype="*" nullmsg="请添加商品的规格！"/>
			    <input type="hidden" id="PIC_URL_ID1" name="PIC_URL_ID1" value="${record.PIC_URL_ID1 }" autocomplete="off"  datatype="*" nullmsg="请添加商品图片！"/>
			    <input type="hidden" id="PIC_URL1" name="PIC_URL1" value="${record.PIC_URL1 }"/>
			    <label  style="width: auto;margin-top: 20px;">
			    <span class="basic-grey-label-span" >商品图片 :</span>
			    		<c:if test="${record.PIC_URL1 eq '' || record.PIC_URL1 eq null}">
			    			<img id="showPicUrl" src="${ctx }/skin/webBase/home/images/nopic.jpg"  style="max-width: 250px; max-height: 250px;border: 1px solid;"/>
			    		</c:if>
			    		<c:if test="${record.PIC_URL1 != '' && record.PIC_URL1 != null}">
			    			<img id="showPicUrl" src="${record.PIC_URL1}"  style="max-width: 250px; max-height: 250px;border: 1px solid;"/>
			    		</c:if>
			    		<%-- <a>删除</a>&nbsp;&nbsp;
			    		<img id="PIC_URL" src="${ctx }/skin/webBase/home/images/nopic.jpg"  style="max-width: 250px; max-height: 250px;border: 1px solid;"/>
			    		<a>删除</a>&nbsp;&nbsp;
			    		<img id="PIC_URL" src="${ctx }/skin/webBase/home/images/nopic.jpg" style="max-width: 250px; max-height: 250px;border: 1px solid;"/>
			    		<a>删除</a> --%>
			    </label >
			    
			    <label id="LABEL_IT" style="width: 475px;margin-top: 10px;">
			    <span class="basic-grey-label-span">上传图片 :</span>
			    <input id="uploadPicture" type="button" class="zero_btn " value="上传图片" style="margin-top: 5px;font-family:​Arial ;"/>
			    </label>
			    
			    <label style="margin-top: 15px; height: 50px;">
			    <span class="basic-grey-label-span">名称 :</span>
			    <input id="GOODS_NAME" type="text" name="GOODS_NAME" value="${record.GOODS_NAME }" datatype="s1-20" nullmsg="请填写名称！" errormsg="名称至少1个字,最多20个字！"/>
			    </label>
			    <label style="margin-top: 10px; height: 50px;" >
			    <span class="basic-grey-label-span">简介 :</span>
			    <input id="INTRODUCTION" type="text" name="INTRODUCTION" value="${record.INTRODUCTION }" datatype="s0-50" errormsg="最多50个字！"/>
			    </label>
			    <label style="margin-top: 10px; height: 50px;">
			    <span class="basic-grey-label-span">价格 :</span>
			    <input id="SHOW_PRICE" type="text" name="SHOW_PRICE" style="width: 95px;" value="${record.SHOW_PRICE }" datatype="money" errormsg="请输入正确商品价格！"/>
			          积分：<input id="SHOW_POINT" type="text" name="SHOW_POINT" style="width: 95px;" value="${record.SHOW_POINT }" datatype="n0-8" errormsg="最多8位数字！"/>
			    </label>
			    <label style="margin-top: 10px; height: 50px;">
			    <span class="basic-grey-label-span">运费简介 :</span>
			    <input id="TRANSPORTATION_INFO" type="text" name="TRANSPORTATION_INFO" value="${record.TRANSPORTATION_INFO }" datatype="s0-30" errormsg="最多30个字！"  style="width: 445px;"/>
			           运费价格：<input id="TRANSPORTATION_PICE" type="text" name="TRANSPORTATION_PICE" style="width: 95px;" value="${record.TRANSPORTATION_PICE }" ignore="ignore" datatype="money" errormsg="请输入正确运费价格！"/>
			    </label>
			    <label style="margin-top: 5px;">
				<span class="basic-grey-label-span" style="margin-top: 5px;">商品规格 :</span>
				<input class="zero_btn " type="button" style="margin-top: 0px; font-family: ​Arial;" value="添加规格" onclick="addSpecification();">
				<div style="display: inline; margin-top: 0px;">
				<span style="margin-top: 0px;">&nbsp;&nbsp;点击填写商品的具体内容。下面“查看子项”将查看或修改具体内容，比如：价格，库存，子规格名！</span>
				</div>
				</label>
				<table class="tablelist" style="width: 356px; margin-top: 15px; margin-left: 150px;">
				<thead>
				<tr>
					<th width="13%">主规格名称</th>
					<th width="8%" align="center">操作</th>
				</tr>
				</thead>
				<tbody id="goodsDetailBody">
				<c:forEach var="r" items="${goodsDetailList}" varStatus="status">
				<tr id="tr${status.index}" style="border-top:1px solid #cbcbcb ;">
					<td id="tr${status.index}-td">${r.MAIN_SPECIFICATION }</td>
					<td><a href="javascript:forDelete('${r.MAIN_SPECIFICATION_ID}','tr${status.index}');">删除</a>&nbsp;&nbsp;
					<a href="javascript:forDetail('${r.MAIN_SPECIFICATION_ID}','tr${status.index}');">查看子项</a> 
					</td>
				</tr>
				</c:forEach>
					<%-- <tr>
						<td></td>
						<td><a href="javascript:forUpdate('${r.DIC_TYPE_ID}');">删除</a>&nbsp;&nbsp;
						<a href="javascript:forDetail('${r.DIC_TYPE_ID}');">查看子项</a> 
						</td>
					</tr> --%>
				</tbody>
				</table>
				<%-- <table class="tablelist" style="width: 906px; margin-top: 15px; margin-left: 150px;">
				<thead>
				<tr>
					<th width="13%">主规格名称</th>
					<th width="13%">子规格名称</th>
					<th width="8%" align="center">价格</th>
					<th width="8%" align="center">库存</th>
					<th width="8%" align="center">促销价</th>
					<th width="8%" align="center">操作</th>
				</tr>
				</thead>
				<tbody>
				<c:forEach var="r" items="${pageView.records}" varStatus="status">
					<tr style="border-top: 1px solid #dadada;">
						<td rowspan=2></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td><a href="javascript:forUpdate('${r.DIC_TYPE_ID}');">删除</a>&nbsp;&nbsp;
						<a href="javascript:forDetail('${r.DIC_TYPE_ID}');">修改子项</a> 
						</td>
					</tr>
					<tr style="border-top: 1px solid #dadada;">
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td><a href="javascript:forUpdate('${r.DIC_TYPE_ID}');">删除</a>&nbsp;&nbsp;
						<a href="javascript:forDetail('${r.DIC_TYPE_ID}');">修改子项</a> 
						</td>
					</tr>
					<tr style="border-top: 1px solid #dadada;">
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td><a href="javascript:forUpdate('${r.DIC_TYPE_ID}');">删除</a>&nbsp;&nbsp;
						<a href="javascript:forDetail('${r.DIC_TYPE_ID}');">修改子项</a> 
						</td>
					</tr>
					</tbody>
				</c:forEach>
			</table> --%>
				<!-- <label style="margin-top: 5px;">
			    <span class="basic-grey-label-span">属性 :</span>
			    <input id="ATTRIBUTE0" type="text" name="ATTRIBUTE0" placeholder="比如衣服：M号" value="" style="width: 150px;" datatype="s1-6" errormsg="最少1个，最多6个字！"/>
			       
			           库存：<input id="INVENTORY0" type="text" name="INVENTORY0" value="" style="width: 50px;" datatype="n0-8" errormsg="最多8位数字！"/>
			           原价：<input id="PRICE0" type="text" name="PRICE0" value="" style="width: 50px;" datatype="money" errormsg="请输入正确商品价格！"/>
			           促销价：<input id="PROMOTION_PRICE0" type="text" name="PROMOTION_PRICE0" value="" style="width: 50px;" datatype="money" errormsg="请输入正确商品促销价格！"/>
			   
			    <input  type="button" class="zero_btn " value="添加属性" onclick="addAttribute();" style="margin-top: 5px;font-family:​Arial;margin-bottom: 10px;"/>
			    <input  type="button" class="zero_btn " value="添加子属性" onclick="addChildAttribute('childAttributeDiv0','0');" style="margin-top: 5px;font-family:​Arial;margin-bottom: 10px;"/>
			    </label> -->
			    <!-- <div id="childAttributeDiv0">
			    </div>
			    </div>
			    <div id="attributeList">
			    
			    </div> -->
			    <!-- <label>
			    <span>栏目 :</span>
			    <input name="CLASSIFY" type="text"  style="width: 110px;" readonly="readonly" name="KEYWORD_LIST"  value="首页导航图"/>
			    </label> -->
			    
			    <label  style="width: 580px;margin-top: 15px;">
			    <span class="basic-grey-label-span">商品分类 :</span>
			    <select id="CLASSIFY1"  class="formselect" name="CLASSIFY1"  datatype="*" nullmsg="请选择商品分类！">
					<option >默认全部</option>
					<c:forEach var="r" items="${classList}" varStatus="status">
					<option ${record.CLASSIFY1 eq r.GOODS_CLASSIFY_ID ? 'selected':'' }selected="" value="${r.GOODS_CLASSIFY_ID }">${r.CLASSIFY_NAME }</option>
					</c:forEach>
				</select>
				 <input onclick="addGroupLayer();" type="button" class="zero_btn " value="添加分类" style=" margin-bottom: 5px;font-family:​Arial ;"/>
			    </label >
			    <!-- <label  style="width: 580px;">
			    <span class="basic-grey-label-span">商品分类2 :</span>
			    <select id="GOODSCLASS1"  class="formselect" name="GOODSCLASS1">
					<option value="0">二级分类可选</option>
					<option value="2">商品分类1</option>
				</select>
			    </label >
			    <label  style="width: 580px;">
			    <span class="basic-grey-label-span">商品分类3 :</span>
			    <select id="GOODSCLASS2"  class="formselect" name="GOODSCLASS2">
					<option value="0">二级分类可选</option>
					<option value="2">商品分类1</option>
				</select>
			    </label > -->
			    
			    <label>
			    <span class="basic-grey-label-span"> 详情:</span>
			    <!-- <textarea rows="" cols=""></textarea> -->
			    <textarea id="DETAIL" name="DETAIL" cols="100" rows="8" style="width:430px;height:360px;visibility:hidden;">${record.DETAIL }</textarea>
			    </label> 
			    
			    <label style="margin-top: 15px;">
			    <span class="basic-grey-label-span">显示排序 :</span>
			    <input id="RANK" type="text" name="RANK" style="width: 95px;" value="${record.RANK }" datatype="n0-8" errormsg="最多8位数字！"/>
			    </label>
			    
			    <span class="basic-grey-label-span"> 发布:</span>
			    <section class="model-2">
			  		<div class="checkbox checkbox_normal" style="margin-top: 6px;">
			    	<input id=checkbox name="PUBLISH" type="checkbox" ${record.PUBLISH eq 'on' ? 'checked=""' : ''} onchange="switchery();" />
			    	<label style="width: 54px; height: 33px;" class="checkbox-lebal-normal"></label>
			  	</div></section>
				
			    <input id="SAVEKEYWORD" type="button" class="zero_btn zero_btn_primary" value="保存"/>&nbsp;&nbsp;
			    <input id="GOBACK" type="button" class="zero_btn" onclick="goback();" value="返回" />
    
    	</form>
   		</div>
</div> 
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
					$("#IS_USE").val("yes");
					/* setTimeout(function(){
						$.Hidemsg(); //公用方法关闭信息提示框;显示方法是$.Showmsg("message goes here.");
					},2000); */
					window.location.href = document.referrer;//返回上一页并刷新
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