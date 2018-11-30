<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../common/common_header.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="${ctx}/skin/newmeteriallibrary/css/showmessage.css" type="text/css" rel="stylesheet"/>
<link type="text/css" rel="stylesheet" href="${ctx}/skin/newmeteriallibrary/css/appmsg_edit.css" />
<link type="text/css" rel="stylesheet" href="${ctx}/skin/newmeteriallibrary/css/jquery.fileupload.css" />
<link type="text/css" rel="stylesheet" href="${ctx}/skin/newmeteriallibrary/css/bootstrap.min.css" />
<link type="text/css" rel="stylesheet" href="${ctx}/skin/newmeteriallibrary/css/style.css" />
<!--UEditor-->
<link rel="stylesheet" href="${ctx }/editor/themes/default/default.css" />
<link rel="stylesheet" href="${ctx }/editor/plugins/code/prettify.css" />
<script charset="utf-8" src="${ctx }/editor/kindeditor.js"></script>
<script charset="utf-8" src="${ctx }/editor/editor/auto.js"></script>
<script charset="utf-8" src="${ctx }/editor/lang/zh_CN.js"></script>
<script charset="utf-8" src="${ctx }/editor/plugins/code/prettify.js"></script>
<!--form 验证 -->
<script type="text/javascript" src="${ctx }/Validform/js/Validform_v5.3.2_top5.js"></script>
<link rel="stylesheet" href="${ctx }/Validform/css/style.css" />
<!--end  -->
<script>
		KindEditor.ready(function(K) { 
			var editor = K.create('#CONTENT', { 
				uploadJson : '${ctx}/upload/fileUpload.do',
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
							var id = url.substring(url.indexOf("&")+1,url.indexOf("&")+37);
							if(PIC_ID == undefined || PIC_ID == "" || PIC_ID == null){
								K('#PIC_ID').val("");
								if(id.length == 36){
									$("#showPicUrl").attr("src",url);
									$("#PIC_URL").val(url);
									$("#PIC_ID").val(id);
								}else{
									alert("图片出错，请重新上传！");
								}
							}else{
								K('#PIC_ID').val(PIC_ID);
							}
							$("#PIC_URL").val(url);
							var data_id = K('#tab1').attr('data_id');
							if(data_id == '0'){
								K('#cover_image').attr("src", url);
							}else{
								K('#imageId_'+data_id).attr("src", url);
							}
							editor.hideDialog();
						}
						
					});
				});
			});
		});
		
</script>
<script type="text/javascript">

</script>
<title>更新图文信息</title>
<meta name="viewport" content="width=device-width,user-scalable=no,initial-scale=1, maximum-scale=1">
<meta http-equiv="cache-control" content="no-cache">
</head>
<!-- <style type="text/css">

    html{overflow:hidden;}//隐藏整个页面的滚动条；

</style> -->
<style type="text/css">
</style>
<body>
<div class="modstitle">
            <h3 style="margin-top: 0px; margin-bottom: 0px;">图文信息</h3>
</div>
<div class="mcontent_padding">
            <!-- <div class="alert">
                <p>注意：1级菜单最多只能开启3个，2级子菜单最多开启5个!</p>
                <p>只有保存主菜单后才可以添加子菜单</p>
            </div>   -->            	
	<div id="admin_k" style="overflow:hidden;clear:both;">
		<div style="float:left;width:25%;">
			<c:forEach var="ad" end="1" items="${itList}" varStatus="adstatus">
			<c:if test="${adstatus.index == 0}">
			<div id=display0 class="pp" PUBLISH="${record.PUBLISH }" data_id="0" ImageText_ID="${ad.IT_ID }" IT_GROUP_ID="${record.IT_GROUP_ID }" MEDIA_ID="${ad.MEDIA_ID }">
				<div class="appmsg multi" >
					<div class="">
						
						<div class="cover_appmsg_item" onmouseover="mouseover('0')" onmouseout="mouseout('0')">
						
							<h4 class="appmsg_title" style="top: 0px; margin-top: 130px; margin-bottom: 0px;">
								<p id="title_p" style="color:white;margin-bottom: 0px;">标题：${ad.TITLE }</p>
							</h4>
							<div class="appmsg_thumb_wrp">
								<!-- <i id="cover" class="appmsg_thumb default">封面图片</i> -->
								<img id="cover_image" src="${ad.PIC_URL }" style="width:100%;height:100%;"></img>								
							</div>
							<div id="shadow0" class="fe" style="display: none">
								<a class="edit1" style="cursor:pointer;" onclick="goUpdate('0')"></a>
							</div>
						
						</div>
						
						<div id="display_parent">
						<c:forEach var="r" begin="1" items="${itList}" varStatus="status">
												
							<div id="display${status.index}" class="appmsg_item" data_id="${status.index}" ImageText_ID="${r.IT_ID}" onmouseover="mouseover('${status.index}')" onmouseout="mouseout('${status.index}')" >
								<div id="shadow${status.index}" class="fd" style="display:none">
									<a class="edit" id="edit${status.index}" data_id="${status.index}"  onclick="goUpdate('${status.index}')" style="margin-top: 40px;"></a>
									<c:if test="${record.PUBLISH != '1' }">
									<a class="dete" id="delete${status.index}" data_id=""  onclick="goDelete('${status.index}')"></a>
									</c:if>
								</div>
								<img id="imageId_${status.index}" class="appmsg_thumb" src="${r.PIC_URL}">
								<h4 class="appmsg_title">
									<a id="childtitle${status.index}" target="_blank" href="#">标题：${r.TITLE }</a>
								</h4>
							</div>
						</c:forEach>
						</div>
						
					</div>
				</div>
			</div>
			</c:if>
			</c:forEach>
			<c:if test="${record.PUBLISH != '1' }">
			<input id="addItemIT" type="button" class="xinbutton" value="添加图文" style="margin-left: 70px;"/> 
			<input id="deleteALLIT"type="button" class="xinbutton" value="删除所有" style="margin-left: 10px;"/>
			</c:if>
			<c:if test="${record.PUBLISH == '1' }">
			<input id="deleteALLIT"type="button" class="xinbutton" value="删除所有" style="margin-left: 115px;"/>
			</c:if>
		
		<div style="display: block;">
			<span id="js_submit" >
			<c:if test="${record.PUBLISH != '1' }">
			<button id="publishIT" class="btn1 btn_input1 btn_primary1"  style="margin-left: 90px;" type="button">发布到微信</button>
			</c:if>
			</span>
		</div>
		</div>
	
		<div id="addForm" style="float:right;width:75%;" hidden="hidden">
			<!-- <iframe id="bIframe" src="" frameborder="0" style="width:100%;" scrolling="no"></iframe> -->
			<%-- <%@ include file="../meteriallibrary/addIM.jsp"%> --%>
			<div id="main_height" style="padding-top: 9px;">
 			<div id="tab1" class="appmsg_editor" style="margin-top: 0px;" editor_type="" data_id="" save_type="save">
 			<form id="saveITForm" method="post" action="${ctx}/ml/addIT.do" method="post" class="registerform">
	 			<div class="inner" style="padding-bottom: 0px;margin-bottom: 10px;Width:650PX;">
		  			
		  					<input id="IT_ID" name="IT_ID" type="hidden" value="">
							<input id="IT_TYPE" name="IT_TYPE" type="hidden" value="">
							<input id="IT_GROUP_ID" name="IT_GROUP_ID" type="hidden" value="${record.IT_GROUP_ID }">
							<input id="SOURCE_URL_TYPE" name="SOURCE_URL_TYPE" type="hidden" value="0">
							<input id="IT_ORDER" name="IT_ORDER" type="hidden" value="0">
							<input id="IT_INDEX" name="IT_INDEX" type="hidden" value="">
							<input id="MEDIA_ID" name="MEDIA_ID" type="hidden" value="">
					<table style="width: 640px;" cellpadding="0" cellspacing="1" class="formtable">
						<tr>
							<td align="right">
								<label class="Validform_label">
									标题:&nbsp;
								</label>
							</td>
							<td class="value">
							     	 <input id="TITLE" name="TITLE" type="text" class="inputtext"  onblur="changeTitle()" style="height:30px" datatype="*1-60" nullmsg="请填写标题！" errormsg="标题至少1个字,最多60个字！" placeholder="请输入标题，60个字符以内！">
								</td>
						</tr>
						<tr>
							<td align="right">
								<label class="Validform_label">
									作者:&nbsp;
								</label>
							</td>
							<td class="value">
							     	 <input id="AUTHOR" name="AUTHOR" type="text" class="inputtext" style="height:30px" maxlength="16" placeholder="请输入作者，16个字符以内！" datatype="*1-16" nullmsg="请填写作者！" errormsg="作者至少1个字,最多16个字！">
								</td>
						</tr>
						<tr>
							<td align="right">
								<label class="Validform_label">
									图片链接:&nbsp;
								</label>
							</td>
							<td class="value">
								<input type="hidden" id="PIC_ID" name="PIC_ID" value=""/>
								<input type="hidden" id="PIC_MEDIA_ID" name="PIC_MEDIA_ID" value=""/>
								<input type="text" readonly="readonly" id="PIC_URL" name="PIC_URL" style="height:30px" datatype="*" nullmsg="请选择图片！"/>
								<input type="button" class="ibtn" id="updateImage" value="选择图片" style="margin-bottom: 10px; margin-left: 5px;"/>
								
							</td>
						</tr>
						<tr>
							<td align="right">
								<label class="Validform_label">
									摘要:&nbsp;
								</label>
							</td>
							<td class="value">
							     	 <textarea id="DESCRIPTION" name="DESCRIPTION" style="width: 300px; margin-top: 0px;" class="inputxt" placeholder="请输入摘要，120个字符以内！" datatype="*1-120" nullmsg="请填写摘要！" errormsg="摘要至少1个字,最多120个字！"></textarea>
								</td>
						</tr>
						<tr>
							<td align="right">
								<label class="Validform_label">
									<input class="formcheckbox" type="checkbox" id="CHECK_URL" onchange="changeValue();"  style="vertical-align:text-bottom; margin-bottom:2.5px;;" />&nbsp原文链接:&nbsp;
								</label>
							</td>
							<td class="value">
							     	 <input id="SOURCE_URL" name="SOURCE_URL" type="text" readonly="readonly" class="inputtext" style="height:30px;" datatype="url" errormsg="格式：http://www.baidu.com">
								</td>
						</tr>
						<tr>
							<td align="right">
								<label class="Validform_label">
									正文:&nbsp;
								</label>
							</td>
							<td class="value">
								<textarea id="CONTENT" name="CONTENT" cols="100" rows="8" style="width:460px;height:360px;visibility:hidden;"  datatype="s1-12000" nullmsg="请填写正文！" errormsg="正文至少1个字,最多12000个字！"></textarea>
								</td>
						</tr>
					</table>			
				
				</div>
				<input type="button" class="xinbutton" id="saveIT"value="保存"  style="margin-left: 170px;"/>
				<input type="button" class="xinbutton"  id="goback"value="返回" style="margin-left: 60px;"/>
				</form>
				<i class="arrow arrow_out" style="margin-top: 0px;"></i>
				<i class="arrow arrow_in" style="margin-top: 0px;"></i>
			</div>
  	 		</div>
		</div>
	</div>
</div>
</body>
<script type="text/javascript">
/*鼠标移动上去反应*/
function mouseover(data_id){
	if(data_id=="0"){
		$("#shadow0").removeAttr("style");
	}else{
		$("#shadow"+data_id).removeAttr("style");
	}
}
/*鼠标移除反应*/
function mouseout(data_id){
	if(data_id=="display0"){
		$("shadow0").attr("style","display:none");
	}else{
		$("#shadow"+data_id).attr("style","display:none");
	}
}
/*是否有原文链接*/
function changeValue(){
	var checkbox = document.getElementById('CHECK_URL');

   if(checkbox.checked)
   {
       $("#SOURCE_URL").removeAttr('readonly');
       $("#SOURCE_URL_TYPE").val('1');
   }
   else{
	   $("#SOURCE_URL").attr('readonly','readonly');
   	   $("#SOURCE_URL").val('');
  	   $("#SOURCE_URL_TYPE").val('0');
   }
		
}
/*鼠标移出时更新标题*/
function changeTitle(){
	var data_id = $("#tab1").attr('data_id');
	var title_p = $("#TITLE").val();
	if(data_id == '0'){		
		$("#title_p").html("标题："+title_p);
	}else{
		$("#childtitle"+data_id).html("标题："+title_p);
	}
	
}

function refresh(){
	 location.reload(); 
}
var index;
/*通用验证框架  */
$("body").append("<!--验证的遮蔽层  -->"  
		+"<div id=\"mask\" class=\"mask\"></div>"
		+"<!-- end -->");
$(function(){
		//$(".registerform").Validform();  //就这一行代码！;
		$(".registerform:eq(0)").Validform({
			btnSubmit:"#saveIT",
			tipSweep:true,
			tiptype:1,
			ajaxPost:true,
			beforeCheck:function(curform){
				//在表单提交执行验证之前执行的函数，curform参数是当前表单对象。
				//这里明确return false的话将不会继续执行验证操作;	
				//获取index
				var URL_TYPE = $('#SOURCE_URL_TYPE').val();
				  if(URL_TYPE == '1'){
					  $("#SOURCE_URL").attr('datatype','url');
				  }else{
					  $("#SOURCE_URL").removeAttr('datatype');
				  }
				var data_id = $('#tab1').attr('data_id');
		  		var divid = "display"+data_id;
				var top = $('#'+divid).offset().top;
			 	var Y = $('#display0').offset().top;
			 	top = top - Y;
			 	//根据位置设置顺序
			 	var IT_INDEX = parseInt((top-65)/100);
			 	$("#IT_INDEX").val(IT_INDEX);
			 	var MEDIA_ID = $("#display0").attr('MEDIA_ID');
				$("#MEDIA_ID").val(MEDIA_ID);
			},
			beforeSubmit:function(curform){
				//在验证成功后，表单提交前执行的函数，curform参数是当前表单对象。
				//这里明确return false的话表单将不会提交;
				
				var IT_ID = $('#IT_ID').val();
				if("" != IT_ID && undefined != IT_ID){
					BaseUtils.showWaitMsg();
					$.ajax({
						url : "${ctx}/ml/updateIT.do",
						type : "post",
						data : $("#saveITForm").serialize(),
						dataType : "json",
						success : function(data) {
							BaseUtils.hideWaitMsg();
							alert(data.msg);
							
						}
					});
					return false;
				}else{
					index = layer.load(1, {
					    shade: [0.1,'#fff'] //0.1透明度的白色背景
					});
				}
				
				
			},
			callback:function(data){
				layer.close(index);
					if(data.status=="y"){
						var data_id = $("#tab1").attr('data_id');
						var divid = "display"+data_id;
			
						$("#tab1").attr('save_type','save');
						$("#IT_ID").val(data.obj.IT_ID);
						if("" == $("#display0").attr('IT_GROUP_ID')){
							$("#display0").attr('IT_GROUP_ID',data.obj.IT_GROUP_ID);
							$("#IT_GROUP_ID").val(data.obj.IT_GROUP_ID);
						}
						$("#"+divid).attr('ImageText_ID',data.obj.IT_ID);
						setTimeout(function(){
							$.Hidemsg(); //公用方法关闭信息提示框;显示方法是$.Showmsg("message goes here.");
						},1000);
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
<script type="text/javascript">
	var id =  ${fn:length(itList)};
	var count = ${fn:length(itList)};
	
	$(document).ready(function(){
		$("#addItemIT").click(function(){
			  var save_type = $("#tab1").attr('save_type');
			  if(save_type == 'not_save'){
			  //if(1  == 2){
				  alert("请先保存当前编辑，才能添加新图文信息！");
				  return false;
			  }else if(count < 8){
			 	 $("#display_parent").append("<div id=\"display"+id+"\" class=\"appmsg_item\" data_id=\""+id+"\" ImageText_ID=\"\" onmouseover=\"mouseover(\'"+id+"\')\" onmouseout=\"mouseout(\'"+id+"\')\" >"
												+"<div id=\"shadow"+id+"\" class=\"fd\" style=\"display:none\">"
													+"<a class=\"edit\" id=\"edit"+id+"\" data_id=\""+id+"\" onclick=\"goUpdate("+id+")\" style=\"margin-top: 40px;\"></a>"
													+"<a class=\"dete\" id=\"delete"+id+"\" data_id=\""+id+"\" onclick=\"goDelete("+id+")\"></a>"
												+"</div>"
												+"<img id=\"imageId_"+id+"\" class=\"appmsg_thumb\" src=\"\">"
												+"<h4 class=\"appmsg_title\">"
													+"<a id=\"childtitle"+id+"\">标题：</a>"
												+"</h4>"
											+"</div>");
			 	 /*动态设置tab1的高度  */
			 	var divid = "display"+id;
			 	var top = $("#"+divid).offset().top;
			 	
			 	var Y = $("#display0").offset().top;
			 	top = top - Y;
			 	//根据位置设置顺序
			 	//var IT_ORDER = parseInt((top-65)/100);
			 	$("#tab1").css({'margin-top': top+'px'});
			 	
			 	//$('IT_GROUP_ID').val("");
			 	$("#IT_ID").val("");
			 	$("#IT_TYPE").val("2");
			 	$("#TITLE").val("");
			 	$("#AUTHOR").val("");
			 	$("#IT_ORDER").val(id);
			 	$("#PIC_URL").val("");
			 	$("#PIC_ID").val("");
			 	$("#DESCRIPTION").val("");
			 	$("#SOURCE_URL_TYPE").val("0");
			 	$("#SOURCE_URL").val("");
			 	$("#CHECK_URL").prop("checked",false);
			 	$("#SOURCE_URL").attr('readonly','readonly');
			 	$("#CONTENT").val("");
			 	
			 	KindEditor.instances[0].html("");
			 	$("#addForm").show();
			 	$("#tab1").attr('data_id',id);
			 	$("#tab1").attr('editor_type',divid);
			 	$("#tab1").attr('save_type','not_save');
			 	
			 	id++;
			 	count++;
			  }else{
				  alert("最多添加8个信息！");
			  }
		  });
	  $("#goback").click(function(){
		  var save_type = $('#tab1').attr('save_type');
		  if("not_save" == save_type){
			  if(window.confirm('注意：您正在编辑的图文信息未保存，“确定”后将继续退出！')){
				  window.location.href="${ctx}/ml/imageTextList.do";
			  }else{
				  return false;
			  }
		  }else{
			  if(window.confirm('您确定要返回吗？')){
				  	window.location.href="${ctx}/ml/imageTextList.do";
				  }else{
					  return false;
				  }
		  } 
	  });
	  /**
		  *发布到微信，并排序
		  */
		  $("#publishIT").click(function() {
			  var save_type = $('#tab1').attr('save_type');
			  var IT_GROUP_ID = $('#display0').attr('IT_GROUP_ID');
				  if("" == IT_GROUP_ID || undefined == IT_GROUP_ID){
					  alert("请先保存主图文，再发布到微信！");
					  return false;
					} else if(save_type == 'not_save'){
						  layer.msg('您当前还有未保存的，是否继续？', {
							  	offset: '100px',
							    time: 0 //不自动关闭
							    ,btn: ['继续', '关闭']
							    ,yes: function(index){
							        layer.close(index);
							        BaseUtils.showWaitMsg();
									  $.ajax({
											url:"${ctx}/ml/publishIT.do",
											type:"post",
											data:{"IT_GROUP_ID":IT_GROUP_ID},
											dataType:"json",
											success:function(data){
												if(data.flag){
													window.location.href="${ctx}/ml/imageTextList.do";
												}else{
													BaseUtils.hideWaitMsg();
													alert(data.msg);
												}
											}
										});	
							    }
							});
				 }else {
					 BaseUtils.showWaitMsg();
					  $.ajax({
							url:"${ctx}/ml/publishIT.do",
							type:"post",
							data:{"IT_GROUP_ID":IT_GROUP_ID},
							dataType:"json",
							success:function(data){
								if(data.flag){
									window.location.href="${ctx}/ml/imageTextList.do";
								}else{
									BaseUtils.hideWaitMsg();
									alert(data.msg);
								}
								
							}
						});		 
				  } 
		  });
	  $("#deleteALLIT").click(function() {
		  var IT_GROUP_ID = $('#display0').attr('IT_GROUP_ID');
		  var MEDIA_ID = $("#display0").attr('MEDIA_ID');
		  if("" == IT_GROUP_ID || undefined == IT_GROUP_ID){
			  window.location.href="${ctx}/ml/imageTextList.do";
			}else{
				if(window.confirm('删除是不可恢复的，你确认要删除吗？')){
					BaseUtils.showWaitMsg();
					$.ajax({
						url:"${ctx}/ml/deletByGroupId.do",
						type:"post",
						data:{"IT_GROUP_ID":IT_GROUP_ID,"MEDIA_ID":MEDIA_ID},
						dataType:"json",
						success:function(data){
							//var ret = jQuery.parseJSON(data);
							BaseUtils.hideWaitMsg();
							alert(data.msg);
							if (data.flag) {
								//location.reload();
								window.location.href="${ctx}/ml/imageTextList.do";
							}
						}
					});
				}
			}
		});
	});
	
	 function goUpdate(data_id){
			var id = $("#tab1").attr('data_id');
			if(data_id == id){
				return false;
			}
			var divid = "display"+data_id;
			var ImageText_ID = $("#"+divid).attr('ImageText_ID');
			
			BaseUtils.showWaitMsg();
			if(divid=='display0'){
				$("#tab1").css({'margin-top':'0px'});
				$("#tab1").attr('data_id',data_id);
			 	$("#tab1").attr('editor_type',divid);
				$("#addForm").show();
			}else{
				
			 	var top = $("#"+divid).offset().top;
			 	var Y = $("#display0").offset().top;
			 	top = top - Y;
			 	$("#tab1").css({'margin-top': top+'px'});
			 	
			 	$("#tab1").attr('data_id',data_id);
			 	$("#tab1").attr('editor_type',divid);
			 	$("#addForm").show();
			}
			if('' == ImageText_ID || undefined == ImageText_ID ){
				$('IT_GROUP_ID').val("");
				$('#IT_ID').val("");
				if("0" == data_id){
					$('#IT_TYPE').val("1");
				}else{
					$('#IT_TYPE').val("2");
				}
			 	
			 	$('#TITLE').val("");
			 	$('#IT_ORDER').val(data_id);
			 	$('#AUTHOR').val(""); 
			 	$('#PIC_URL').val("");
			 	$('#PIC_ID').val("");
			 	$('#DESCRIPTION').val("");
			 	$('#SOURCE_URL_TYPE').val("0");
			 	$('#SOURCE_URL').val("");
			 	$('#CHECK_URL').prop("checked",false);
			 	$('#SOURCE_URL').attr('readonly','readonly');
			 	$('#CONTENT').val("");
			 	
			 	$('#childtitle'+data_id).html("标题：");
			 	KindEditor.instances[0].html("");
			 	$('#imageId_'+data_id).attr("src", "");
			 	$('#tab1').attr('data_id',data_id);
			 	$('#tab1').attr('editor_type',divid);
			 	$('#tab1').attr('save_type','not_save');
			 	BaseUtils.hideWaitMsg();
				return false;
			}
			$('#tab1').attr('data_id',data_id);
		 	$('#tab1').attr('editor_type',divid);
			$.ajax({
				url:"${ctx}/ml/queryById.do",
				type:"post",
				data:{"ImageText_ID":ImageText_ID},
				dataType:"json",
				success:function(data){
						$('#IT_ID').val(data.obj.IT_ID);
						$('#TITLE').val(data.obj.TITLE);
						$('#AUTHOR').val(data.obj.AUTHOR);
						$('#IT_ORDER').val(data.obj.IT_ORDER);
						$('SOURCE_URL_TYPE').val(data.obj.SOURCE_URL_TYPE);
						if('0' == data.obj.SOURCE_URL_TYPE){
							$('SOURCE_URL').val("");
							$('#CHECK_URL').prop("checked",false);
							$('#SOURCE_URL').attr('readonly','readonly');
						}else{
							$('SOURCE_URL').val(data.obj.SOURCE_URL);
							$('#CHECK_URL').prop("checked",true);
							$('#SOURCE_URL').removeAttr("readonly");
						}
						
						$('#IT_TYPE').val(data.obj.IT_TYPE); 
					 	$('#PIC_URL').val(data.obj.PIC_URL);
					 	$('#PIC_ID').val(data.obj.PIC_ID);
					 	$('#DESCRIPTION').val(data.obj.DESCRIPTION); 
					 	$('#SOURCE_URL').val(data.obj.SOURCE_URL);	
					 	$('#CONTENT').val(data.obj.CONTENT);
					 	KindEditor.instances[0].html(data.obj.CONTENT);
					 	BaseUtils.hideWaitMsg();
					}
				});
		}
	
	 function goDelete(data_id){
			var divid = "dispaly"+data_id;
			var ImageText_ID = $('#'+divid).attr('ImageText_ID');
			if("" == ImageText_ID || undefined == ImageText_ID){
				if(window.confirm('删除是不可恢复的，你确认要删除吗？')){
				//if(event.returnValue = confirm("删除是不可恢复的，你确认要删除吗？")){
					$('#'+divid).remove();
					var editor_type = $('#tab1').attr('editor_type');
					if(editor_type == divid){
						$('#addForm').hide();
						$('#tab1').attr('save_type','save');
					}else{
						var divid = editor_type;
						var top = $('#'+divid).offset().top;
					 	var Y = $('#display0').offset().top;
					 	top = top - Y;
					 	$('#tab1').css({'margin-top': top+'px'});
					}
					alert("操作成功！");
					count = count - 1;
				}else{
					return false;
				}
				
			}else{
				if(window.confirm('删除是不可恢复的，你确认要删除吗？')){
				//defaultConfirm("你确定要删除吗？删除后不可恢复！",(function(){
					BaseUtils.showWaitMsg();
					$.ajax({
						url:"${ctx}/ml/deleteById.do",
						type:"post",
						data:{"ImageText_ID":ImageText_ID,"divid":divid},
						dataType:"json",
						success:function(data){
							//var ret = jQuery.parseJSON(data);
							BaseUtils.hideWaitMsg();
							if (data.flag) {
								var divid = data.obj.divid;
								$('#'+divid).remove();
								var editor_type = $('#tab1').attr('editor_type');
								if(editor_type == divid){
									$('#addForm').hide();
									$('#tab1').attr('save_type','save');
								}else{
									var divid = editor_type;
									var top = $('#'+divid).offset().top;
								 	var Y = $('#display0').offset().top;
								 	top = top - Y;
								 	$('#tab1').css({'margin-top': top+'px'});
								}	
							}
							alert(data.msg);
						}
					});
					count = count - 1;
				}
				return false;
			}
			
		}
</script>
</html>
