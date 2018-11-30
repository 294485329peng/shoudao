<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../common/common_header.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="${ctx}/skin/newmeteriallibrary/css/showmessage.css" type="text/css" rel="stylesheet"/>
<link type="text/css" rel="stylesheet" href="${ctx}/skin/newmeteriallibrary/css/appmsg_edit.css" />
<link type="text/css" rel="stylesheet" href="${ctx}/skin/newmeteriallibrary/css/jquery.fileupload.css" />
<link type="text/css" rel="stylesheet" href="${ctx}/skin/newmeteriallibrary/css/bootstrap.min.css" />
<link type="text/css" rel="stylesheet" href="${ctx}/skin/newmeteriallibrary/css/style.css">
<!--UEditor-->
<link rel="stylesheet" href="${ctx }/editor/themes/default/default.css" />
<link rel="stylesheet" href="${ctx }/editor/plugins/code/prettify.css" />
<script charset="utf-8" src="${ctx }/editor/kindeditor.js"></script>
<script charset="utf-8" src="${ctx }/editor/editor/auto.js"></script>
<script charset="utf-8" src="${ctx }/editor/lang/zh_CN.js"></script>
<script charset="utf-8" src="${ctx }/editor/plugins/code/prettify.js"></script>
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
				maxWidth:400,//设置编辑器的最小宽度
				urlType:'domain',
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
						clickFn : function(url, title, width, height, border, align, PIC_ID) {
							if(PIC_ID == undefined || PIC_ID == "" || PIC_ID == null){
								K('#PIC_ID').val("");
							}else{
								K('#PIC_ID').val(PIC_ID);
							}
							K('#PIC_URL').val(url);
							
							var data_id = K('#tab1').attr('data_id');
							if(data_id == '0'){
								K('#cover').attr("style","display:none");
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
<title>添加图文信息</title>
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
            <div class="alert">
                <p>注意：1级菜单最多只能开启3个，2级子菜单最多开启5个!</p>
                <p>只有保存主菜单后才可以添加子菜单</p>
              <!--   <p>生成自定义菜单,必须在已经保存的基础上进行,临时勾选启用点击生成是无效的! 第一步必须先修改保存状态！第二步点击生成!</p>
                <p>当您为自定义菜单填写链接地址时请填写以"http://"开头，这样可以保证用户手机浏览的兼容性更好</p>
                <p>撤销自定义菜单：撤销后，您的微信公众帐号上的自定义菜单将不存在；如果您想继续在微信公众帐号上使用自定义菜单，请点击“生成自定义菜单”按钮，将重新启用！</p>  -->
            </div>              	
	<div id="admin_k" style="overflow:hidden;clear:both;">
		<div style="float:left;width:25%;">
			<div id=display0 class="pp" data-fileid="display0" data_id="0" ImageText_ID="" PUBLISH="" IT_GROUP_ID="">
				<div class="appmsg multi" >
					<div class="">
						<div class="cover_appmsg_item" onmouseover="mouseover('header')" onmouseout="mouseout('header')">
							<h4 class="appmsg_title" style="top: 0px; margin-top: 130px; margin-bottom: 0px;">
								<p id="title_p" style="color:white;margin-bottom: 0px;">标题：</p>
							</h4>
							<div class="appmsg_thumb_wrp">
								<i id="cover" class="appmsg_thumb default">封面图片</i>
								<img id="cover_image" src="" style="width:100%;height:100%;"/>							
							</div>
							<div class="fe" style="display: none">
								<a class="edit1" href="#" onclick="goUpdate('header','0','${headerNews.id}')"></a>
							</div>
						</div>
						<div id="display_parent">						
						
						</div>
						
					</div>
				</div>
			</div>
		<input id="addItemIT" type="button" class="xinbutton" value="添加图文" style="margin-left: 70px;"/>
		<input id="deleteALLIT"type="button" class="xinbutton" value="删除所有" style="margin-left: 10px;"/>
		<div style="display: block;">
			<span id="js_submit" >
			<button id="publishIT" class="btn1 btn_input1 btn_primary1" type="button">发布到微信</button>
			</span>
		</div>
		</div>
	
		<div id="addForm" style="float:right;width:75%;">
			<!-- <iframe id="bIframe" src="" frameborder="0" style="width:100%;" scrolling="no"></iframe> -->
			<%-- <%@ include file="../meteriallibrary/addIM.jsp"%> --%>
			<div id="main_height" style="padding-top: 9px;">
 			<div id="tab1" class="appmsg_editor" style="margin-top: 0px;" editor_type="header" data_id="0" save_type="not_save");>
	 			<div class="inner" style="padding-bottom: 0px;margin-bottom: 10px;Width:650PX;">
		  			<form id="saveITForm" action="" method="post">
		  					<input id="IT_ID" name="IT_ID" type="hidden" value="">
							<input id="IT_TYPE" name="IT_TYPE" type="hidden" value="1">
							<input id="IT_GROUP_ID" name="IT_GROUP_ID" type="hidden" value="">
							<input id="SOURCE_URL_TYPE" name="SOURCE_URL_TYPE" type="hidden" value="0">
							<input id="IT_ORDER" name="IT_ORDER" type="hidden" value="0">
							
							
					<table style="width: 640px;" cellpadding="0" cellspacing="1" class="formtable">
						<tr>
							<td align="right">
								<label class="Validform_label">
									标题:&nbsp;
								</label>
							</td>
							<td class="value">
							     	 <input id="TITLE" name="TITLE" type="text" class="inputtext"  onblur="changeTitle()" style="height:30px" maxlength="60" placeholder="请输入标题，60个字符以内！">
								</td>
						</tr>
						<tr>
							<td align="right">
								<label class="Validform_label">
									作者:&nbsp;
								</label>
							</td>
							<td class="value">
							     	 <input id="AUTHOR" name="AUTHOR" type="text" class="inputtext" style="height:30px" maxlength="16" placeholder="请输入作者，16个字符以内！">
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
								<input type="text" readonly="readonly" id="PIC_URL" name="PIC_URL" style="height:30px"/>
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
							     	 <textarea id="DESCRIPTION" name="DESCRIPTION" style="width: 300px; margin-top: 0px;" class="inputxt"  maxlength="120" placeholder="请输入摘要，120个字符以内！"></textarea>
								</td>
						</tr>
						<tr>
							<td align="right">
								<label class="Validform_label">
									<input class="formcheckbox" type="checkbox" id="CHECK_URL" onchange="changeValue();"  style="vertical-align:text-bottom; margin-bottom:2.5px;;" />&nbsp原文链接:&nbsp;
								</label>
							</td>
							<td class="value">
							     	 <input id="SOURCE_URL" name="SOURCE_URL" type="text" readonly="readonly" class="inputtext" style="height:30px;">
								</td>
						</tr>
						<tr>
							<td align="right">
								<label class="Validform_label">
									正文:&nbsp;
								</label>
							</td>
							<td class="value">
								<textarea id="CONTENT" name="CONTENT" cols="100" rows="8" style="width:460px;height:360px;visibility:hidden;"></textarea>
								</td>
						</tr>
					</table>			
				</form>
				</div>
				<input type="button" class="xinbutton" id="saveIT"value="保存"  style="margin-left: 170px;"/>
				<input type="button" class="xinbutton"  id="goback"value="返回" style="margin-left: 60px;"/>
				<i class="arrow arrow_out" style="margin-top: 0px;"></i>
				<i class="arrow arrow_in" style="margin-top: 0px;"></i>
			</div>
  	 		</div>
		</div>
	</div>
	
</div>
</body>
<script type="text/javascript">
	var index = 0;
	
	function mouseover(symbol,show){
		if(symbol=='header'){
			$(".fe").removeAttr("style");
			/* $(".fd").attr("style","display:none"); */
		}else if(symbol=='item'){
		    /* $('#'+show).attr("style","display:none"); */
			$('#'+show).removeAttr("style");
		}
	}
	
	function mouseout(symbol,show){
		if(symbol=='header'){
			$(".fe").attr("style","display:none");
		}else if(symbol=='item'){
			$('#'+show).attr("style","display:none");
		}
	}
	
	function changeValue(){
		var checkbox = document.getElementById('CHECK_URL');//

       if(checkbox.checked)
       {
           $('#SOURCE_URL').removeAttr("readonly");
           $('#SOURCE_URL_TYPE').val("1");
       }
       else{
    	   $('#SOURCE_URL').attr('readonly','readonly');
       		$('#SOURCE_URL').val("");
      	   $('#SOURCE_URL_TYPE').val("0");
       }
   		
	}
	
	function changeTitle(){
		var symbol = $('#tab1').attr('editor_type');
		var data_id = $('#tab1').attr('data_id');
		var title_p = $('#TITLE').val();
		if(symbol == 'header'){		
			$('#title_p').html("标题："+title_p);
		}else{
			$('#childtitle'+data_id).html("标题："+title_p);
		}
		
	}
	
	function refresh(){
		 location.reload(); 
	}
</script>
<script type="text/javascript">
	var id =  1;
	var count = 1;

	$(document).ready(function(){
	  $("#addItemIT").click(function(){
		  var save_type = $('#tab1').attr('save_type');
		  if(save_type == 'not_save'){
		  //if(1  == 2){
			  alert("请先保存当前编辑，才能添加新图文信息！");
			  return false;
		  }else if(count < 8){
		 	 $("#display_parent").append("<div id=\"display"+id+"\" class=\"appmsg_item\" data_id=\""+id+"\" ImageText_ID=\"\" onmouseover=\"mouseover(\'item\',\'show"+id+"\')\" onmouseout=\"mouseout(\'item\',\'show"+id+"\')\" >"
											+"<div id=\"show"+id+"\" class=\"fd\" style=\"display:none\">"
												+"<a class=\"edit\" id=\"edit"+id+"\" data_id=\""+id+"\" href=\"#\" onclick=\"goUpdate(\'display"+id+"\',"+id+",\'${news.id}\')\" style=\"margin-top: 40px;\"></a>"
												+"<a class=\"dete\" id=\"delete"+id+"\" data_id=\""+id+"\" href=\"#\" onclick=\"goDelete(\'display"+id+"\',"+id+",\'${news.id}\')\"></a>"
											+"</div>"
											+"<img id=\"imageId_"+id+"\" class=\"appmsg_thumb\" alt=\"\" src=\"${news.imagePath}\">"
											+"<h4 class=\"appmsg_title\">"
												+"<a id=\"childtitle"+id+"\" target=\"_blank\" href=\"#\">标题：</a>"
											+"</h4>"
										+"</div>");
		 	 /*动态设置tab1的高度  */
		 	var divid = "display"+id;
		 	var top = $('#'+divid).offset().top;
		 	
		 	var Y = $('#display0').offset().top;
		 	top = top - Y;
		 	//根据位置设置顺序
		 	//var IT_ORDER = parseInt((top-65)/100);
		 	$('#tab1').css({'margin-top': top+'px'});
		 	
		 	$('IT_GROUP_ID').val("");
		 	$('#IT_ID').val("");
		 	$('#IT_TYPE').val("2");
		 	$('#TITLE').val("");
		 	$('#AUTHOR').val("");
		 	$('#IT_ORDER').val(id);
		 	$('#PIC_URL').val("");
		 	$('#PIC_ID').val("");
		 	$('#DESCRIPTION').val("");
		 	$('#SOURCE_URL_TYPE').val("0");
		 	$('#SOURCE_URL').val("");
		 	$('#CHECK_URL').prop("checked",false);
		 	$('#SOURCE_URL').attr('readonly','readonly');
		 	$('#CONTENT').val("");
		 	
		 	KindEditor.instances[0].html("");
		 	$('#addForm').show();
		 	$('#tab1').attr('data_id',id);
		 	$('#tab1').attr('editor_type',divid);
		 	$('#tab1').attr('save_type','not_save');
		 	
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
	  $("#saveIT").click(function(){
		  var flag = "error";
		  var data_id = $('#tab1').attr('data_id');
		  var divid = "display"+data_id;
		  
		  /* //获取index
		  var top = $('#'+divid).offset().top;
	 	  var Y = $('#display0').offset().top;
	 	  top = top - Y;
	 	  //根据位置设置顺序
	 	  var IT_INDEX = parseInt((top-65)/100);
	 	  $("#IT_INDEX").val(IT_INDEX); */  
			
		  var IT_ID = $('#IT_ID').val();
		  var MEDIA_ID = $("#display0").attr('MEDIA_ID');
		  $("#MEDIA_ID").val(MEDIA_ID);
		  var validateRule = [
			        			{id:"TITLE",message:"标题不能为空！"},
			        			{id:"AUTHOR",message:"作者不能为空！"},
			        			{id:"PIC_URL",message:"请选择图片！"},
			        			{id:"CONTENT",message:"内容不能为空！"}	        			
			               	];
		  
		  var URL_TYPE = $('#SOURCE_URL_TYPE').val();
		  if(URL_TYPE == '1'){
			  var check = /((http|ftp|https):\/\/)[^\s]/;
			  if(!check.test($('#SOURCE_URL').val())){
				  alert("您输入的网址格式不对，请重新输入!");
				  return false;
			  }
		  }
		  BaseUtils.showWaitMsg();
			if(!formValidationFun(validateRule)) return;
			if("" == IT_ID || undefined == IT_ID){
				$.ajax({
							//url : $("#saveITForm").attr("action"),
							url : "${ctx}/ml/addIT.do",
							type : "post",
							data : $("#saveITForm").serialize(),
							dataType : "json",
							success : function(data) {
								//var ret = jQuery.parseJSON(data);
								
								BaseUtils.hideWaitMsg();
								alert(data.msg);
								if(data.flag){
									$('#tab1').attr('save_type','save');
									$('#IT_ID').val(data.obj.IT_ID);
									if("" == $('#display0').attr('IT_GROUP_ID')){
										$('#display0').attr('IT_GROUP_ID',data.obj.IT_GROUP_ID);
										$('#IT_GROUP_ID').val(data.obj.IT_GROUP_ID);
									}
									$('#'+divid).attr('ImageText_ID',data.obj.IT_ID);
								}
							}
						});
			}else{
				$.ajax({
					//url : $("#saveITForm").attr("action"),
					url : "${ctx}/ml/updateIT.do",
					type : "post",
					data : $("#saveITForm").serialize(),
					dataType : "json",
					success : function(data) {
						//var ret = jQuery.parseJSON(data);
						
						BaseUtils.hideWaitMsg();
						alert(data.msg);
						if(data.flag){
							$('#tab1').attr('save_type','save');
							$('#IT_ID').val(data.obj.IT_ID);
						}					
					}
				});
			}
	  });
	  
	  /**
	  *发布到微信，并排序
	  */
	  $("#publishIT").click(function() {
		  var save_type = $('#tab1').attr('save_type');
		  var IT_GROUP_ID = $('#display0').attr('IT_GROUP_ID');
		 /*  if($("#display0").attr("PUBLISH") == "1"){
			  layer.msg('当前图文已经发布，无需重复发布!', {
				  	offset: '100px',
				    time: 0 //不自动关闭
				    ,btn: ['确定', '关闭']
				    ,yes: function(index){
				        layer.close(index);
				        return false;
				    }
				});
		  }else{ */
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
											//var ret = jQuery.parseJSON(data);
											BaseUtils.hideWaitMsg();
											//alert(data.msg);
											if(data.flag){
												//$("#display0").attr("PUBLISH",data.obj.PUBLISH);
												//$("#display0").attr("MEDIA_ID",data.obj.MEDIA_ID);
												window.location.href="${ctx}/ml/imageTextList.do";
												//BaseUtils.hideWaitMsg();
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
							//var ret = jQuery.parseJSON(data);
							
							
							if(data.flag){
								//$("#display0").attr("PUBLISH",data.obj.PUBLISH);
								//$("#display0").attr("MEDIA_ID",data.obj.MEDIA_ID);
								window.location.href="${ctx}/ml/imageTextList.do";
								//BaseUtils.hideWaitMsg();
							}else{
								BaseUtils.hideWaitMsg();
								alert(data.msg);
							}
							
						}
					});		 
			  } 
		  //} 
	  });
	  /***
		  *更新发布图文
		  */
	  /* function rePublish(){
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
									url:"${ctx}/ml/rePublishIT.do",
									type:"post",
									data:{"IT_GROUP_ID":IT_GROUP_ID},
									dataType:"json",
									success:function(data){
										//var ret = jQuery.parseJSON(data);
										BaseUtils.hideWaitMsg();
										alert(data.msg);
									}
								});	
					    }
					});
		 }else {
			 BaseUtils.showWaitMsg();
			  $.ajax({
					url:"${ctx}/ml/rePublishIT.do",
					type:"post",
					data:{"IT_GROUP_ID":IT_GROUP_ID},
					dataType:"json",
					success:function(data){
						//var ret = jQuery.parseJSON(data);
						BaseUtils.hideWaitMsg();
						alert(data.msg);
					}
				});		 
		  }
	  }  */
		 
	  /***
	  *删除全部图文
	  */
	  $("#deleteALLIT").click(function() {
		  var IT_GROUP_ID = $('#display0').attr('IT_GROUP_ID');
		  if("" == IT_GROUP_ID || undefined == IT_GROUP_ID){
			  alert("删除成功！");
			  //location.reload();
			  window.location.href="${ctx}/ml/forShowAddMessage.do"
			}else{
				if(window.confirm('删除是不可恢复的，你确认要删除吗？')){
					BaseUtils.showWaitMsg();
					$.ajax({
						url:"${ctx}/ml/deletByGroupId.do",
						type:"post",
						data:{"IT_GROUP_ID":IT_GROUP_ID},
						dataType:"json",
						success:function(data){
							//var ret = jQuery.parseJSON(data);
							BaseUtils.hideWaitMsg();
							alert(data.msg);
							if (data.flag) {
								//location.reload();
								window.location.href="${ctx}/ml/forShowAddMessage.do"
							}
						}
					});
				}
			}
		});
	});
	
	function goUpdate(symbol,data_id,newsId){
		var displayid = "display"+data_id;
		var divid = symbol;
		var id = $('#tab1').attr('data_id');
		var ImageText_ID = $('#'+displayid).attr('ImageText_ID');
		/* if("" == $('#IT_ID').val() || null == $('#IT_ID').val()){
			return false;
		} */
		if(symbol=='header'){
			$('#tab1').css({'margin-top':'0px'});
			$('#tab1').attr('editor_type','header');
			$('#addForm').show();
		}else{
			
		 	var top = $('#'+divid).offset().top;
		 	var Y = $('#display0').offset().top;
		 	top = top - Y;
		 	$('#tab1').css({'margin-top': top+'px'});
		 	
		 	$('#tab1').attr('data_id',data_id);
		 	$('#tab1').attr('editor_type',divid);
		 	$('#addForm').show();
		}
		if(('' == ImageText_ID || undefined == ImageText_ID) && id != data_id){
			$('IT_GROUP_ID').val("");
			$('#IT_ID').val("");
		 	$('#IT_TYPE').val("2");
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
		 	$('#addForm').show();
		 	$('#imageId_'+data_id).attr("src", "");
		 	$('#tab1').attr('data_id',data_id);
		 	$('#tab1').attr('editor_type',divid);
		 	$('#tab1').attr('save_type','not_save');
			return false;
		}
		if("" == ImageText_ID || null == ImageText_ID || undefined == ImageText_ID){
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
				}
			});
	}
	
	function goDelete(symbol,data_id,newsId){
		var divid = symbol;
		var ImageText_ID = $('#'+divid).attr('ImageText_ID');
		if("" == ImageText_ID || undefined == ImageText_ID){
			if(window.confirm('删除是不可恢复的，你确认要删除吗？')){
			//if(event.returnValue = confirm("删除是不可恢复的，你确认要删除吗？")){
				$('#'+divid).attr("style","display:none");
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
							$('#'+divid).attr("style","display:none");
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
			//}));
			}
			return false;
		}
		/* $('#'+divid).attr("style","display:none");
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
		}	 */
	}
</script>
</html>
