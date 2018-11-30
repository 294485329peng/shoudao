<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    
    <title>自定义菜单</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%@ include file="../../common/common_header.jsp"%>
	<link rel="stylesheet" type="text/css" href="${ctx}/skin/newzdycd/css/style.css" />
	<script src="${ctx}/skin/newzdycd/js/jquery-1.11.0.min.js"></script>
	<script type="text/javascript">
	/**
	*description：定义三级子菜单
	*time：2015/11/25
	*author：daiwk
	*/ 
	var child0 = 0;
	var child1 = 0;
	var child2 = 0;
	
	$(document).ready(function(){
	<%
	List<Map> list = (List)request.getAttribute("list");
	list.size();
	%>
	var a = '<%=list.size()%>' ;
	alert(a);
	});
	/**
	*description：动态添加主菜单，跟form联动
	*time：2015/11/25
	*author：daiwk
	*/
	function focusMenu(data_id){
		var saveState = $('#menu_admin').attr('saveState');    //form编辑菜单是否保存
		var id = data_id;										//获得那个主菜单点击的
		var ticket = $('#menu'+id).attr('checkMenu');          //是否创建左侧菜单
		var MENU_NAME = $('#menu'+id).attr('data_text');
		var havechild = $('#menu'+id).attr('havechild');       //是否有子菜单
		if('stop' == ticket ){
			alert("抱歉，请先创建此菜单左侧的菜单！");
			return false;
		}
		/* if(id != '00'){
			if('no'== saveState ){
				alert("请先保存上次菜单的修改，才能创建新菜单！");
				return false;
			}
		} */			
		if('00' == id){
			$('#menu10').attr('checkMenu','pass');
		}else if('10' == id ){
			$('#menu20').attr('checkMenu','pass');
		}
		
		$('#menu_admin').attr('menu','admin');
		
		/*添加选择的id 判断那个 */
		
		if('yes' == havechild){	
			$('#detailForm').attr("style","display:none");  //控制是否作为主菜单的显示
			$('#selecAdminMenu').attr("style","display:none");
		}else{
			var scdMenu = $('#menu'+id).attr('scdMenu');
			if(scdMenu == 'yes'){
				$('#selecAdminMenu').removeAttr("style");
				$('#SCD_MENU1').prop("checked",true);
				$('#detailForm').attr("style","display:none"); 
			}else{
				$('#SCD_MENU0').prop("checked",true);
				$('#detailForm').removeAttr("style");
				$('#selecAdminMenu').removeAttr("style");
			}
			var selectAction = $('#menu'+id).attr('selectAction');
			if('1' == selectAction){
				$('#selectAction1').prop("checked",true);
				$('#MESSAGE').removeAttr("style");
				$('#URL').attr("style","display:none");
			}else{
				$('#selectAction2').prop("checked",true);
				$('#MESSAGE').removeAttr("style");
				$('#URL').attr("style","display:none");
			}
		}
		
		$('#imgAdd'+id).attr("style","display:none");
		$('#aText'+id).html(MENU_NAME);
		$('#MENU_NAME').val(MENU_NAME);
		$('#MENU_NAME').attr('check_menu','pass');
		$('#menu_admin').attr('editor_id','aText'+id);
		$('#menu_admin').attr('data_id','menu'+id);
		$('#menu_admin').css({'display': 'display'});
		
		if ($('#menu'+id).hasClass("cura")) {
	        //$('#menu'+id).children(".new-sub").hide(); //当前菜单下的二级菜单隐藏
	       // $(".menu").removeClass("cura"); //同一级的菜单项
			$('#menu'+id).addClass("focuson");
			$("ul li").removeClass("focuson");
			$("li a").removeClass("focuson_a");
	    } else {
	    	$("ul li").removeClass("focuson");
			$("li a").removeClass("focuson_a");
	        $(".menu").removeClass("cura"); //移除所有的样式
	        $(".menu").removeClass("focuson");
	        $('#menu'+id).addClass("cura"); //给当前菜单添加特定样式
	        $('#menu'+id).addClass("focuson");
	        $(".menu").children(".new-sub").slideUp("fast"); //隐藏所有的二级菜单
	        $('#menu'+id).children(".new-sub").slideDown("fast"); //展示当前的二级菜单
	
	    }
		
	}
	/**
	*description：动态添加子菜单，添加样式。
	*time：2015/11/25
	*author：daiwk
	*/
	function addChildMenu(data_id,child_id){
		var saveState = $('#menu_admin').attr('saveState');
		var id = data_id;
		
		/* if('no'== saveState){
			alert("请先保存上次菜单的修改，才能创建新菜单！");
			return false;
		} */
		$(".menu").removeClass("focuson");
		
		$('#MENU_ID').val("");
		$('#SCD_MENU_GROUP_ID').val("");
		$('#selecAdminMenu').attr("style","display:none");   //控制是否作为主菜单的显示
		$('#detailForm').removeAttr("style");
		$('#selectAction1').prop("checked",true);        
		$('#SOURCE_URL').val("");
		$('#URL').attr("style","display:none");
		$('#MESSAGE').removeAttr("style");
		$('#imageText').removeAttr("style");
		$('#selectedIT').attr("style","display:none");
		//添加图片的
		$('#image').attr("style","display:none");
		
		if(id == '00'){
			$('#ul'+id).prepend("<li id=\"li0"+child0+"\" class=\"new-sub-li\" data_text=\"菜单名称\" selectAction=\"1\"><a id=\"childTsxt0"+child0+"\"  onclick=\"childMenu(\'00\',\'0"+child0+"\')\"></a></li>");
			$("ul li").removeClass("focuson");
			$("li a").removeClass("focuson_a");
		
			var MENU_NAME = $('#li0'+child0).attr('data_text');
			$('#childTsxt0'+child0).html(MENU_NAME);
			$('#MENU_NAME').val(MENU_NAME);
			$('#MENU_NAME').attr('check_menu','pass');
			
			$('#menu_admin').attr('editor_id','childTsxt0'+child0);
			$('#menu_admin').attr('data_id','li0'+child0);
			$('#menu_admin').attr('saveState','no');
			$('#menu_admin').attr('menu','child');
			
			$('#li0'+child0).addClass("focuson");
			$('#childTsxt0'+child0).addClass("focuson_a");
			
			$('#menu'+id).attr('havechild','yes');
		
			child0 ++;
		}else if(id == '10'){
			$('#ul'+id).prepend("<li id=\"li1"+child1+"\" class=\"new-sub-li\" data_text=\"菜单名称\" selectAction=\"1\"><a id=\"childTsxt1"+child1+"\"  onclick=\"childMenu(\'10\',\'1"+child1+"\')\"></a></li>");
			$("ul li").removeClass("focuson");
			$("li a").removeClass("focuson_a");
			
			var MENU_NAME = $('#li1'+child1).attr('data_text');
			$('#childTsxt1'+child1).html(MENU_NAME);
			$('#MENU_NAME').val(MENU_NAME);
			$('#MENU_NAME').attr('check_menu','pass');
			
			$('#menu_admin').attr('editor_id','childTsxt1'+child1);
			$('#menu_admin').attr('data_id','li1'+child1);
			$('#menu_admin').attr('saveState','no');
			$('#menu_admin').attr('menu','child');
			
			$('#li1'+child1).addClass("focuson");
			$('#childTsxt1'+child1).addClass("focuson_a");
			
			$('#menu'+id).attr('havechild','yes');
			
			child1 ++;
		}else if(id == '20'){
			$('#ul'+id).prepend("<li id=\"li2"+child2+"\" class=\"new-sub-li\"data_text=\"菜单名称\" selectAction=\"1\"><a id=\"childTsxt2"+child2+"\"  onclick=\"childMenu(\'20\',\'2"+child2+"\')\"></a></li>");
			$("ul li").removeClass("focuson");
			$("li a").removeClass("focuson_a");
			
			var MENU_NAME = $('#li2'+child2).attr('data_text');
			$('#childTsxt2'+child2).html(MENU_NAME);
			$('#MENU_NAME').val(MENU_NAME);
			$('#MENU_NAME').attr('check_menu','pass');
			
			$('#menu_admin').attr('editor_id','childTsxt2'+child0);
			$('#menu_admin').attr('data_id','li2'+child2);
			$('#menu_admin').attr('saveState','no');
			$('#menu_admin').attr('menu','child');
			
			$('#li2'+child2).addClass("focuson");
			$('#childTsxt2'+child2).addClass("focuson_a");
			
			$('#menu'+id).attr('havechild','yes');
			
			child2 ++;
		}
	}
	/**
	*description：输入名称，当失去焦点，动态改变菜单名称
	*time：2015/11/25
	*author：daiwk
	*/
	function changeTitle(){
		var editor_id = $('#menu_admin').attr('editor_id');
		var data_id = $('#menu_admin').attr('data_id');
		var text = $('#MENU_NAME').val();
		var text_byte =  $("#MENU_NAME").val().replace(/[^\u0000-\u00ff]/g,"aa").length;
		if (text == ""||text == undefined) {
            alert("名称不能为空！");
            $('#MENU_NAME').attr('check_menu','stop');
            return false;
        }else if (text_byte > 8) {
            alert("名称不能超过4个字或8个字母！");
            $('#MENU_NAME').attr('check_menu','stop');
            return false;
        }
		$('#MENU_NAME').attr('check_menu','pass');
		$('#'+editor_id).html(text);
		$('#'+data_id).attr('data_text',text);
	}
	/**
	*description：选择并在右侧编辑子菜单内容。
	*time：2015/11/25
	*author：daiwk
	*/
	function childMenu(main_id,child_id){
		$('#menu_admin').attr('editor_id','childTsxt'+child_id);
		$('#menu_admin').attr('data_id','li'+child_id);
		

		$(".menu").removeClass("focuson");
		$("ul li").removeClass("focuson");
		$("li a").removeClass("focuson_a");
		$('#li'+child_id).addClass("focuson");
		$('#childTsxt'+child_id).addClass("focuson_a");
		
		$('#selecAdminMenu').attr("style","display:none");   //控制是否作为主菜单的显示
		$('#detailForm').removeAttr("style");
		
		var MENU_NAME = $('#li'+child_id).attr('data_text');
		$('#MENU_NAME').val(MENU_NAME);
		$('#MENU_NAME').attr('check_menu','pass');
		
	}
	/**
	*description：选择redio改变。
	*time：2015/11/25
	*author：daiwk
	*/
	function selectAction(option){
		var ID = $('#menu_admin').attr('data_id');
		
		if('1' == option){
			$('#MESSAGE').removeAttr("style");
			$('#URL').attr("style","display:none");
			$('#'+ID).attr('selectAction','1');
		}else if('2' == option){
			$('#URL').removeAttr("style");
			$('#MESSAGE').attr("style","display:none");
			$('#'+ID).attr('selectAction','2');
		}
	}
	/**
	*description：选择内容。
	*time：2015/11/25
	*author：daiwk
	*/
	function selectContent(option){
		if('1' == option){
			$('#imageText').removeAttr("style");
			$('#image').attr("style","display:none");
		}else if('2' == option){
			$('#image').removeAttr("style");
			$('#imageText').attr("style","display:none");
		}
	}
	
	function selectIT(id){
		layer.open({
			title:'选择图文信息',
		    type: 2,
		    area: ['1000px', '470px'],
		    fix: false, //不固定
		    offset: '50px',
		    maxmin: true,
		    shadeClose: true,
		    shade: 0.8,
		    content: '${ctx}/zdycd/selectIT.do'
		});
	}
	
	function AdminMenu(option){
		var id = $('#menu_admin').attr('data_id');
		if('1' == option){
			$('#detailForm').attr("style","display:none");
			$('#'+id).attr('scdMenu','yes');
		}else if('0' == option){
			$('#detailForm').removeAttr("style");
			$('#'+id).attr('scdMenu','no');
		}
	}
	
	function selectedIT(IT_JSON){
		$('#selectImage').attr('src',IT_JSON.PIC_URL);
		$('#selectTitle').html(IT_JSON.TITLE);
		$('#selectContent').html("作者："+IT_JSON.AUTHOR+"<br/>时间："+IT_JSON.CREATE_TIME+"<br/>数量："+IT_JSON.IT_COUNT);
		$('#imageText').attr("style","display:none");
		$('#selectedIT').removeAttr("style");
	}
	$(document).ready(function(){
		  $("#deleteIT").click(function(){
			  $('#selectedIT').attr("style","display:none");
			  $('#imageText').removeAttr("style");
			  $('#MATERIAL_ID').val("");
		  });
	});
	/**
	*description：保存修改。
	*time：2015/11/25
	*author：daiwk
	*/
	$(document).ready(function(){
		  $("#saveMenu").click(function(){
			  var MENU = $('#menu_admin').attr('menu');
			  var MENU_ID = $('#MENU_ID').val();
			  var SCD_MENU_GROUP_ID = $('#SCD_MENU_GROUP_ID').val();
			  var MENU_NAME = $('#MENU_NAME').val();
			  var SCD_MENU = $('input:radio[name=SCD_MENU]:checked').val();
			  var TRIGGER_ACTION = $('input:radio[name=TRIGGER_ACTION]:checked').val();    //1 触发图文   2触发url
			  var SOURCE_URL = $('#SOURCE_URL').val();
			  var MATERIAL_ID = $('#MATERIAL_ID').val();
			  var PIC_URL = $('#PIC_URL').val();
			  
			  if(TRIGGER_ACTION == '2'){
				  var check = /((http|ftp|https):\/\/)[^\s]/;
				  if(!check.test($('#SOURCE_URL').val())){
					  alert("您输入的网址格式不对，请重新输入!");
					  return false;
				  }
			  }else if(TRIGGER_ACTION == '1'){
				  var MATERIAL_ID = $('#MATERIAL_ID').val();
				  if("" == MATERIAL_ID || undefined == MATERIAL_ID || null == MATERIAL_ID){
					  alert("请添加一个图文信息！");
					  return false;
				  }
			  }
			  
			  BaseUtils.showWaitMsg();
			  if('admin' == MENU){
				  $.ajax({
						url : "${ctx}/zdycd/saveAdminMenu.do",
						type : "post",
						data : {"MENU_ID":MENU_ID,"MENU_NAME":MENU_NAME,"SCD_MENU":SCD_MENU,
								"TRIGGER_ACTION":TRIGGER_ACTION,"SOURCE_URL":SOURCE_URL,
								"MATERIAL_ID":MATERIAL_ID,"PIC_URL":PIC_URL,"SCD_MENU_GROUP_ID":SCD_MENU_GROUP_ID},
						dataType : "json",
						success : function(data) {
							//var ret = jQuery.parseJSON(data);
							
							BaseUtils.hideWaitMsg();
							alert(data.msg);
							if(data.flag){
								
							}					
						}
					});
			  }
			  
		  });
	});
	</script>
<script type="text/javascript">
 
</script>
    <%-- <link href="${ctx}/skin/zdycd/css/zdycd.css"  rel="stylesheet" /> --%>
    <%List<Map> toposJson = (List)request.getAttribute("list");%>
	</head>
	<body >
	<form id="#" name="fenye" action="" method="post">
	    <div class="youkuangjia">
	        <div class="modstitle">
	            <h3>自定义菜单</h3>
	        </div>
	        <div class="mcontent">
	        <div class="alert">
			<p>注意：1级菜单最多只能开启3个，2级子菜单最多开启5个!</p>
			<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;只有保存主菜单后才可以添加子菜单</p>
			<!-- <p>生成自定义菜单,必须在已经保存的基础上进行,临时勾选启用点击生成是无效的! 第一步必须先修改保存状态！第二步点击生成!</p>
			<p>当您为自定义菜单填写链接地址时请填写以"http://"开头，这样可以保证用户手机浏览的兼容性更好</p> -->
			<p>撤销自定义菜单：撤销后，您的微信公众帐号上的自定义菜单将不存在；如果您想继续在微信公众帐号上使用自定义菜单，请点击“生成自定义菜单”按钮，将重新启用！</p>
			</div>
	            <div>
	            <div class="mobile_menu_preview" style="height: 500px;">
                    <!--↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓3列菜单开始↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓-->
					<div class="btn3 clearfix"> 
					<!-- <div class="clearfix"> -->
					    <div id="menu00" class="menu " data_text="${menu00.MENU_NAME }" checkMenu="pass" havechild="no" scdMenu="no" on_off="off" selectAction="1">
					        <div id="mainMuen00" class="bt-name" align="center" onclick="focusMenu('00')">
					        	<img id="imgAdd00" class="imageMainAdd"  src="${ctx}/skin/newzdycd/images/add_002.png" >
					        	<a id="aText00"></a>
					        </div>
					       <!--  <div id="childMenu00"> -->
					        	<div id="triangle00" class="sanjiao"></div>
					      		<div id="child00" class="new-sub">
						            <ul id="ul00">
						                <li id="addChildMenu00" class="new-sub-li" onclick="addChildMenu('00','00')">
						                	<img class="imageChildAdd"  src="${ctx}/skin/newzdycd/images/add_002.png">					                	
					                	</li>
						                
						            </ul>
						            <div class="tiggle"></div>
						            <div class="innertiggle"></div>
					        	</div>
					        <!-- </div> -->
					    </div><!--menu-->
					
					
					    <div id="menu10" class="menu" data_text="菜单名称" checkMenu="stop" havechild="no" scdMenu="no" on_off="off" selectAction="1">
					        <div id="mainMuen10" class="bt-name" align="center" onclick="focusMenu('10')">
					        	<img id="imgAdd10" class="imageMainAdd"  src="${ctx}/skin/newzdycd/images/add_002.png" >
					        	<a id="aText10"></a>
					        </div>
					     
					        	<div id="triangle10" class="sanjiao"></div>
					      		<div id="child10" class="new-sub">
						            <ul id="ul10">
						                <li id="addChildMenu10" class="new-sub-li" onclick="addChildMenu('10','10')">
						                	<img class="imageChildAdd"   src="${ctx}/skin/newzdycd/images/add_002.png">					                	
					                	</li>
						                
						            </ul>
						            <div class="tiggle"></div>
						            <div class="innertiggle"></div>
					        	</div>
					       
					    </div><!--menu-->
					
					    <div id="menu20" class="menu" data_text="菜单名称" checkMenu="stop" havechild="no" scdMenu="no" on_off="off" selectAction="1">
					        <div id="mainMuen20" class="bt-name" align="center" onclick="focusMenu('20')">
					        	<img id="imgAdd20" class="imageMainAdd"  src="${ctx}/skin/newzdycd/images/add_002.png" >
					        	<a id="aText20"></a>
					        </div>
					        
					        	<div id="triangle20" class="sanjiao"></div>
					      		<div id="child20" class="new-sub">
						            <ul id="ul20">
						                <li id="addChildMenu20" class="new-sub-li" onclick="addChildMenu('20','20')">
						                	<img class="imageChildAdd"   src="${ctx}/skin/newzdycd/images/add_002.png">					                	
					                	</li>
						                
						            </ul>
						            <div class="tiggle"></div>
						            <div class="innertiggle"></div>
					        	</div>
					        
					    </div><!--menu-->
					</div><!--btn3-->
                </div>
                <div class="menu_form_area"  style="height: 500px;">
                	<div id="menu_admin" class="portable_editor" style="display:none;" menu="" editor_id="" data_id="" saveState="no">
                		<div >
                			<div class="menu_form_hd">
                			<div class="global_info">
							<h4 >菜单名称</h4>
							</div>
							<div class="global_extra">
							<a id="jsDelBt" href="javascript:void(0);" style="margin-right: 6px;">删除菜单</a>
							</div> 
							</div>
               			</div>
                	<form id="saveMenuForm" action="" method="post">
                		<input id="MENU_ID" name="MENU_ID" type="hidden" value="">
                		<input id="SCD_MENU_GROUP_ID" name="SCD_MENU_GROUP_ID" type="hidden" value="">
		               	<div class="frm_control" style="margin-bottom: 10px;">
		                	<label class="frm_label">
								<span class="frm_span" >菜单名称 :</span>
								<input id="MENU_NAME"  name="MENU_NAME" check_menu="stop" class="frm_input" onblur="changeTitle()" type="text">
								<p class="frm_tips">字数不超过4个汉字8个字母</p>
							</label>
						</div>
						<div id="selecAdminMenu">
							<label class="frm_label">
								 <span class="frm_span">作为主菜单 :</span>
								<label style="margin-right: 22px;">
								<input id="SCD_MENU1" class="frm_radio" type="radio" name="SCD_MENU"  value="1" onclick="AdminMenu('1')"> 
								<span class="lbl_content">是</span>
								</label>
								<label>
								<input id="SCD_MENU0" class="frm_radio" type="radio" name="SCD_MENU" checked="checked" value="0" onclick="AdminMenu('0')"> 
								<span class="lbl_content">否</span>
								</label>
							</label>	
						</div>
						<div id="detailForm">
						<div  class="frm_control" style="margin-top: 10px;">
						<div style="margin-bottom: 10px;">
						<label class="frm_label">
								<span class="frm_span">菜单内容 :</span>
								<label style="margin-right: 22px;">
								<input id="selectAction1" class="frm_radio" type="radio" name="TRIGGER_ACTION" checked="checked" value="1" onclick="selectAction('1')"> 
								<span class="lbl_content">发送消息</span>
								</label>
								<label>
								<input id="selectAction2" class="frm_radio" type="radio" name="TRIGGER_ACTION" value="2" onclick="selectAction('2')"> 
								<span class="lbl_content">跳转网页</span>
								</label>
						</label>
						</div>
						<div id="URL" class="menu_content" style="display:none;">
							<label class="frm_label">
								<span class="frm_span" >URL地址:</span>
								<input id="SOURCE_URL" name="SOURCE_URL" class="frm_input" type="text" value="">
								<p class="frm_tips">请按照格式输入，如：http://www.baidu.com</p>
							</label>
						</div>
						<div id="MESSAGE" class="menu_content">
							<div class="menu_form_hd">
							<div>
							<a href="javascript:selectContent(1);"><img alt="" src="${ctx}/skin/zdycd/images/style/imagetext.jpg" style="width: 120px; height: 29px; margin-right: 52px;"></a>
							<a href="javascript:selectContent(2);"><img alt="" src="${ctx}/skin/zdycd/images/style/image.jpg" style="padding-bottom: 1px;"></a>
							</div>
							</div>
							<div id="imageText" class="select_a_image">
							<a href="javascript:selectIT('id');"><img alt="" class="select_image" src="${ctx}/skin/zdycd/images/style/select_it.jpg"></a>
							<a href="javascript:addIT('id');"><img alt="" class="select_new" src="${ctx}/skin/zdycd/images/style/new_it.jpg" ></a>
							<input id="MATERIAL_ID" name="MATERIAL_ID" type="hidden" value="">
							</div>
							<div id="selectedIT"  style="display:none;">
								<ul class="classlist">
								    <li id="li_id_" style="margin-top: 12px;">
								    <span><img id="selectImage" src="" style="width: 106px; height: 126px;"/></span>
								    <div class="lright">
								    <h2 id="selectTitle" style="width: 160px;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;"></h2>
								    <p id="selectContent" style="width: 160px;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;">
									    	
								    </p>
								    <a id="deleteIT" name="transmit" class="enter">删除</a>
								    </div>
								    </li>
							    </ul>
							</div>
							<div id="image" class="select_a_image" style="display:none;">
							<a href="javascript:void(0);"><img class="select_image" src="${ctx}/skin/zdycd/images/style/select_image.jpg"></a>
							<a href="javascript:void(0);"><img alt="" class="select_new" src="${ctx}/skin/zdycd/images/style/new_image.jpg" ></a>
							<input id="PIC_URL" name="PIC_URL" type="hidden" value="">
							</div>
						</div>
						</div>
						</div>
						<div class="bottom_button">
							<input id="saveMenu" type="button" class="xinbutton"  value="保存修改" />&nbsp;&nbsp;&nbsp;&nbsp;
							<!-- <input type="button" class="xinbutton" onclick="setMenu()" value="删除菜单" /> -->
						</div> 
					</form>
					</div>	
                </div>
                </div>
	            <div class="save_del_button" >
	                <!--<div class="xinsearchleft">-->
	                <input type="button" class="xinbutton" onclick="setMenu()" value="生成自定义菜单" />&nbsp;&nbsp;&nbsp;&nbsp;
	                <!--</div>-->
	                <input type="button" class="xinbutton"  onclick="repealMenu()"value="撤销自定义菜单" />
	            </div>
	        </div>
	    </div>
	</form>
	<c:forEach var="r" items="${list}" varStatus="status">
				    <li id="li_id_${status.index}" >
				    <span><img src="${r.PIC_URL }" style="width: 106px; height: 126px;"/></span>
				    <div class="lright">
				    <h2 style="width: 160px;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;"><input class="formcheckbox" type="checkbox" name="check" style="vertical-align:text-bottom; margin-bottom:1.1px;" />${r.MENU_NAME }</h2>
				    <p style="width: 160px;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;">
					    	作者：${r.MENU_NAME }<br />
					    	
				    </p>
				    <a class="enter" onclick="updateIT(${r.MENU_ID })">编辑</a>
				    <a class="enter" >删除</a>
				    </div>
				    </li>
	</c:forEach>
	</body>
<script type="text/javascript">
$(document).ready(function(){
	  $("#addItemIT").click(function(){
		  
	  });
});


</script>
</html>
