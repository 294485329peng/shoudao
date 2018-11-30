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
<link rel="stylesheet" href="${ctx }/editor/themes/default/default.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/skin/newzdycd/css/style.css" />
<link href="${ctx}/skin/autoReply/css/Style.css" rel="stylesheet" type="text/css" />
<script charset="utf-8" src="${ctx }/editor/kindeditor.js"></script>
<script charset="utf-8" src="${ctx }/editor/lang/zh_CN.js"></script>
<script src="${ctx}/skin/newzdycd/js/jquery-1.11.0.min.js"></script>
<!--qq表情  -->
<link rel="stylesheet" href="${ctx}/skin/qqface/css/reset.css" />
<link rel="stylesheet" href="${ctx}/skin/qqface/css/style.css" />
<link href="${ctx}/skin/qqface/css/bootstrap.min.css" rel="stylesheet" media="screen" />
<!--end  -->
<script type="text/javascript">
	//三个状态，回来加上。
	/**
	 *description：定义三级子菜单
	 *time：2015/11/25
	 *author：daiwk
	 */
	var child0 = 0;
	var check0 = 0;
	var child1 = 0;
	var check1 = 0;
	var child2 = 0;
	var check2 = 0;
	/**
	 *description：页面初始化加载。
	 *time：2015/11/25
	 *author：daiwk
	 */
	$(document).ready(
			function() {
				BaseUtils.showWaitMsg();
				$.ajax({
					url : "${ctx}/zdycd/queryAdminMenu.do",
					type : "post",
					data : {},
					dataType : "json",
					success : function(data) {
						if (data.flag) {
							if ('0' == data.obj.length) {
								$('#menu00').css({
									'display' : 'display'
								});
							} else if ('1' == data.obj.length) {
								for (var i = 0; i < data.obj.length; i++) {
									$('#menu' + i + '0').attr('MENU_ID',data.obj[i].MENU_ID);
									$('#menu' + i + '0').attr('data_text',data.obj[i].MENU_NAME);
									$('#menu' + i + '0').attr('checkMenu','pass');
									$('#menu' + i + '0').attr('SCD_MENU',data.obj[i].SCD_MENU);
									$('#menu' + i + '0').attr('selectAction',data.obj[i].TRIGGER_ACTION);
									$('#menu' + i + '0').attr('RESPONSE_ACTION',data.obj[i].RESPONSE_ACTION);
									$('#menu' + i + '0').attr('SOURCE_URL',data.obj[i].SOURCE_URL);
									$('#menu' + i + '0').attr('PIC_URL',data.obj[i].PIC_URL);
									$('#menu' + i + '0').attr('PIC_ID',data.obj[i].PIC_ID);
									$('#menu' + i + '0').attr('SAYTEXT',data.obj[i].SAYTEXT);
									$('#menu' + i + '0').attr('SCD_MENU_GROUP_ID',data.obj[i].SCD_MENU_GROUP_ID);
									$('#menu' + i + '0').attr('saveState','yes');
									$('#menu' + i + '0').attr('IT_ID',data.obj[i].IT_ID);
									$('#menu' + i + '0').attr('LOCAL_IT_ID',data.obj[i].LOCAL_IT_ID);
									var menuid = "menu" + i + "0";
									getByITID(data.obj[i].IT_ID, menuid); //根据IT_ID查询图文信息
									getByLocalITID(data.obj[i].LOCAL_IT_ID, menuid);
									var id = i + "0";
									queryChildMenu(id,data.obj[i].SCD_MENU_GROUP_ID);

									$('#imgAdd' + i + '0').attr("style",
											"display:none");
									$('#aText' + i + '0').html(
											data.obj[i].MENU_NAME);
								}
								$('#menu00').css({
									'width' : '50%'
								});
								$('#menu10').css({
									'width' : '50%'
								});
								$('#menu10').attr('checkMenu', 'pass');
								$('#menu00').css({
									'display' : 'display'
								});
								$('#menu10').css({
									'display' : 'display'
								});
							} else if ('2' == data.obj.length) {
								for (var i = 0; i < data.obj.length; i++) {
									$('#menu' + i + '0').attr('MENU_ID',data.obj[i].MENU_ID);
									$('#menu' + i + '0').attr('data_text',data.obj[i].MENU_NAME);
									$('#menu' + i + '0').attr('checkMenu','pass');
									$('#menu' + i + '0').attr('SCD_MENU',data.obj[i].SCD_MENU);
									$('#menu' + i + '0').attr('selectAction',data.obj[i].TRIGGER_ACTION);
									$('#menu' + i + '0').attr('RESPONSE_ACTION',data.obj[i].RESPONSE_ACTION);
									$('#menu' + i + '0').attr('SOURCE_URL',data.obj[i].SOURCE_URL);
									$('#menu' + i + '0').attr('PIC_URL',data.obj[i].PIC_URL);
									$('#menu' + i + '0').attr('PIC_ID',data.obj[i].PIC_ID);
									$('#menu' + i + '0').attr('SAYTEXT',data.obj[i].SAYTEXT);
									$('#menu' + i + '0').attr('SCD_MENU_GROUP_ID',data.obj[i].SCD_MENU_GROUP_ID);
									$('#menu' + i + '0').attr('saveState','yes');
									$('#menu' + i + '0').attr('IT_ID',data.obj[i].IT_ID);
									$('#menu' + i + '0').attr('LOCAL_IT_ID',data.obj[i].LOCAL_IT_ID);

									var menuid = "menu" + i + "0";
									getByITID(data.obj[i].IT_ID, menuid); //根据IT_ID查询图文信息
									getByLocalITID(data.obj[i].LOCAL_IT_ID, menuid);
									var id = i + "0";
									queryChildMenu(id,data.obj[i].SCD_MENU_GROUP_ID);

									$('#imgAdd' + i + '0').attr("style",
											"display:none");
									$('#aText' + i + '0').html(
											data.obj[i].MENU_NAME);
								}
								$('#menu00').css({
									'width' : '33.3%'
								});
								$('#menu10').css({
									'width' : '33.33%'
								});
								$('#menu20').css({
									'width' : '33.33%'
								});
								$('#menu20').attr('checkMenu', 'pass');
								$('#menu00').css({
									'display' : 'display'
								});
								$('#menu10').css({
									'display' : 'display'
								});
								$('#menu20').css({
									'display' : 'display'
								});
							} else if ('3' <= data.obj.length) {
								for (var i = 0; i < 3; i++) {
									$('#menu' + i + '0').attr('MENU_ID',data.obj[i].MENU_ID);
									$('#menu' + i + '0').attr('data_text',data.obj[i].MENU_NAME);
									$('#menu' + i + '0').attr('checkMenu','pass');
									$('#menu' + i + '0').attr('SCD_MENU',data.obj[i].SCD_MENU);
									$('#menu' + i + '0').attr('selectAction',data.obj[i].TRIGGER_ACTION);
									$('#menu' + i + '0').attr('RESPONSE_ACTION',data.obj[i].RESPONSE_ACTION);
									$('#menu' + i + '0').attr('SOURCE_URL',data.obj[i].SOURCE_URL);
									$('#menu' + i + '0').attr('PIC_URL',data.obj[i].PIC_URL);
									$('#menu' + i + '0').attr('PIC_ID',data.obj[i].PIC_ID);
									$('#menu' + i + '0').attr('SAYTEXT',data.obj[i].SAYTEXT);
									$('#menu' + i + '0').attr('SCD_MENU_GROUP_ID',data.obj[i].SCD_MENU_GROUP_ID);
									$('#menu' + i + '0').attr('saveState','yes');
									$('#menu' + i + '0').attr('IT_ID',data.obj[i].IT_ID);
									$('#menu' + i + '0').attr('LOCAL_IT_ID',data.obj[i].LOCAL_IT_ID);

									var menuid = "menu" + i + "0";
									getByITID(data.obj[i].IT_ID, menuid); //根据IT_ID查询图文信息
									getByLocalITID(data.obj[i].LOCAL_IT_ID, menuid);
									var id = i + "0";
									queryChildMenu(id,data.obj[i].SCD_MENU_GROUP_ID);

									$('#imgAdd' + i + '0').attr("style",
											"display:none");
									$('#aText' + i + '0').html(
											data.obj[i].MENU_NAME);
								}
								$('#menu00').css({
									'width' : '33.3%'
								});
								$('#menu10').css({
									'width' : '33.33%'
								});
								$('#menu20').css({
									'width' : '33.33%'
								});
								$('#menu00').css({
									'display' : 'display'
								});
								$('#menu10').css({
									'display' : 'display'
								});
								$('#menu20').css({
									'display' : 'display'
								});
								
							}
							updateMenuRank();
						}
						
						BaseUtils.hideWaitMsg();
						if ('3' < data.obj.length){
							alert("数据异常，请删除所有，重新发布！");
						}
					}
				});

				
			});
	/**
	 *description：页面初始化加载,加载子菜单。
	 *time：2015/12/3
	 *author：daiwk
	 */
	function queryChildMenu(id, SCD_MENU_GROUP_ID) {
		$.ajax({
					url : "${ctx}/zdycd/queryChildMenu.do",
					type : "post",
					data : {
						"SCD_MENU_GROUP_ID" : SCD_MENU_GROUP_ID
					},
					dataType : "json",
					success : function(data) {
						if (data.flag) {
							if (id == "00") {
								for (var i = 0; i < data.obj.length; i++) {
									$('#menu00').attr('havechild', 'yes');
									$('#ul' + id).prepend("<li id=\"li0"+child0+"\" class=\"new-sub-li\" data_text=\""+data.obj[i].MENU_NAME+"\" saveState=\"yes\"  menu=\"child\" main_id=\"00\""
									+" MENU_ID=\""+data.obj[i].MENU_ID+"\" RANK=\""+child0+"\" selectAction=\""+data.obj[i].TRIGGER_ACTION+"\" RESPONSE_ACTION=\""+data.obj[i].RESPONSE_ACTION+"\" SOURCE_URL=\""+data.obj[i].SOURCE_URL+"\" PIC_ID=\""+data.obj[i].PIC_ID+"\" PIC_URL=\""+data.obj[i].PIC_URL+"\" SCD_MENU_GROUP_ID=\""+SCD_MENU_GROUP_ID+"\" "  
				    				+"LOCAL_IT_ID=\""+data.obj[i].LOCAL_IT_ID+"\" LOCAL_IT_TITLE=\"\" LOCAL_IT_PIC_URL=\"\" LOCAL_IT_CREATE_TIME=\"\" "
									+"IT_ID=\""+data.obj[i].IT_ID+"\" SAYTEXT=\""+data.obj[i].SAYTEXT+"\" IT_TITLE=\"\" IT_PIC_URL=\"\" IT_PIC_ID=\"\" IT_AUTHOR=\"\" IT_CREATE_TIME=\"\" IT_COUNT=\"\">"
									+ "<a id=\"childTsxt0"
									+ child0
									+ "\"  onclick=\"childMenu(\'00\',\'0"
									+ child0
									+ "\')\">"
									+ data.obj[i].MENU_NAME
									+ "</a></li>");
									var menuid = "li0" + child0;
									getByITID(data.obj[i].IT_ID, menuid); //根据IT_ID查询图文信息
									getByLocalITID(data.obj[i].LOCAL_IT_ID, menuid);
									child0++;
									check0++;
								}
							} else if (id == "10") {
								for (var i = 0; i < data.obj.length; i++) {
									$('#menu10').attr('havechild', 'yes');
									$('#ul' + id).prepend("<li id=\"li1"+child1+"\" class=\"new-sub-li\" data_text=\""+data.obj[i].MENU_NAME+"\" saveState=\"yes\"  menu=\"child\" main_id=\"10\""
									+" MENU_ID=\""+data.obj[i].MENU_ID+"\" RANK=\""+child1+"\" selectAction=\""+data.obj[i].TRIGGER_ACTION+"\" RESPONSE_ACTION=\""+data.obj[i].RESPONSE_ACTION+"\" SOURCE_URL=\""+data.obj[i].SOURCE_URL+"\" PIC_ID=\""+data.obj[i].PIC_ID+"\" PIC_URL=\""+data.obj[i].PIC_URL+"\" SCD_MENU_GROUP_ID=\""+SCD_MENU_GROUP_ID+"\" "  
									+"LOCAL_IT_ID=\""+data.obj[i].LOCAL_IT_ID+"\" LOCAL_IT_TITLE=\"\" LOCAL_IT_PIC_URL=\"\" LOCAL_IT_CREATE_TIME=\"\" "
									+"IT_ID=\""+data.obj[i].IT_ID+"\" SAYTEXT=\""+data.obj[i].SAYTEXT+"\" IT_TITLE=\"\" IT_PIC_URL=\"\" IT_PIC_ID=\"\" IT_AUTHOR=\"\" IT_CREATE_TIME=\"\" IT_COUNT=\"\">"
									+ "<a id=\"childTsxt0"
									+ child1
									+ "\"  onclick=\"childMenu(\'10\',\'1"
									+ child1
									+ "\')\">"
									+ data.obj[i].MENU_NAME
									+ "</a></li>");
									var menuid = "li1" + child1;
									getByITID(data.obj[i].IT_ID, menuid); //根据IT_ID查询图文信息
									getByLocalITID(data.obj[i].LOCAL_IT_ID, menuid);
									child1++;
									check1++;
								}
							} else if (id == "20") {
								for (var i = 0; i < data.obj.length; i++) {
									$('#menu20').attr('havechild', 'yes');
									$('#ul' + id).prepend("<li id=\"li2"+child2+"\" class=\"new-sub-li\" data_text=\""+data.obj[i].MENU_NAME+"\" saveState=\"yes\"  menu=\"child\" main_id=\"20\""
									+" MENU_ID=\""+data.obj[i].MENU_ID+"\" RANK=\""+child2+"\" selectAction=\""+data.obj[i].TRIGGER_ACTION+"\" RESPONSE_ACTION=\""+data.obj[i].RESPONSE_ACTION+"\" SOURCE_URL=\""+data.obj[i].SOURCE_URL+"\" PIC_ID=\""+data.obj[i].PIC_ID+"\" PIC_URL=\""+data.obj[i].PIC_URL+"\" SCD_MENU_GROUP_ID=\""+SCD_MENU_GROUP_ID+"\" "  
									+"LOCAL_IT_ID=\""+data.obj[i].LOCAL_IT_ID+"\" LOCAL_IT_TITLE=\"\" LOCAL_IT_PIC_URL=\"\" LOCAL_IT_CREATE_TIME=\"\" "
									+"IT_ID=\""+data.obj[i].IT_ID+"\" SAYTEXT=\""+data.obj[i].SAYTEXT+"\" IT_TITLE=\"\" IT_PIC_URL=\"\" IT_PIC_ID=\"\" IT_AUTHOR=\"\" IT_CREATE_TIME=\"\" IT_COUNT=\"\">"
									+ "<a id=\"childTsxt2"
									+ child2
									+ "\"  onclick=\"childMenu(\'20\',\'2"
									+ child2
									+ "\')\">"
									+ data.obj[i].MENU_NAME
									+ "</a></li>");
									var menuid = "li2" + child2;
									getByITID(data.obj[i].IT_ID, menuid); //根据IT_ID查询图文信息
									getByLocalITID(data.obj[i].LOCAL_IT_ID, menuid);
									child2++;
									check2++;
								}
							}

						}
					}
				});
	}
	/**
	 *description：动态点击主菜单样式
	 *time：2015/11/25
	 *author：daiwk
	 */
	function focusMenu(data_id) {
		var ticket = $('#menu' + data_id).attr('checkMenu');
		var id = data_id; //获得那个主菜单点击的
		var saveState = $('#menu' + id).attr('saveState'); //form编辑菜单是否保存
		var ticket = $('#menu' + id).attr('checkMenu'); //是否创建左侧菜单
		var havechild = $('#menu' + id).attr('havechild'); //是否有子菜单
		var menuid = "menu" + id;

		if (!checkSave(menuid)) { //检查是否保存
			return false;
		} else if ('no' == saveState) {
			$('#menu' + id).attr('saveState', 'editor');
			$('#menu_admin').attr('formState', 'no');
		}

		if ('00' == id) {
			var ticket = $('#menu10').attr('checkMenu');
			if ('stop' == ticket) {
				$('#menu10').attr('checkMenu', 'pass');
				$('#menu00').css({
					'width' : '50%'
				});
				$('#menu10').css({
					'width' : '50%'
				});
				$('#menu10').css({
					'display' : 'display'
				});
			}
		}
		if ('10' == id) {
			var ticket = $('#menu20').attr('checkMenu');
			if ('stop' == ticket) {
				$('#menu20').attr('checkMenu', 'pass');
				$('#menu00').css({
					'width' : '33.33%'
				});
				$('#menu10').css({
					'width' : '33.33%'
				});
				$('#menu20').css({
					'width' : '33.33%'
				});
				$('#menu10').css({
					'display' : 'display'
				});
				$('#menu20').css({
					'display' : 'display'
				});
			}
		}

		$('#menu_admin').attr('menu', 'admin');

		/*添加选择的id 判断那个 */
		focusAdminMenu(id);

		var MENU_NAME = $('#menu' + id).attr('data_text');
		$('#imgAdd' + id).attr("style", "display:none");
		$('#aText' + id).html(MENU_NAME);
		$('#MENU_NAME').val(MENU_NAME);
		$('#MENU_NAME').attr('check_menu', 'pass');
		$('#menu_admin').attr('editor_id', 'aText' + id);
		$('#menu_admin').attr('data_id', 'menu' + id);
		$('#menu_admin').css({
			'display' : 'display'
		});

		if ($('#menu' + id).hasClass("cura")) {
			//$('#menu'+id).children(".new-sub").hide(); //当前菜单下的二级菜单隐藏
			// $(".menu").removeClass("cura"); //同一级的菜单项
			$('#menu' + id).addClass("focuson");
			$("ul li").removeClass("focuson");
			$("li a").removeClass("focuson_a");
		} else {
			$("ul li").removeClass("focuson");
			$("li a").removeClass("focuson_a");
			$(".menu").removeClass("cura"); //移除所有的样式
			$(".menu").removeClass("focuson");
			$('#menu' + id).addClass("cura"); //给当前菜单添加特定样式
			$('#menu' + id).addClass("focuson");
			$(".menu").children(".new-sub").slideUp("fast"); //隐藏所有的二级菜单
			$('#menu' + id).children(".new-sub").slideDown("fast"); //展示当前的二级菜单

		}

	}
	/**
	 *description：主菜单为焦点。
	 *time：2015/11/25
	 *author：daiwk
	 */
	function focusAdminMenu(id) {
		var menuid = "menu" + id;
		var formMenuid = $('#menu_admin').attr('data_id');
		if (formMenuid == menuid) {
			return false;
		}
		var MENU_ID = $('#menu' + id).attr('MENU_ID'); //菜单主ID
		var havechild = $('#menu' + id).attr('havechild'); //是否有子菜单
		var MENU_NAME = $('#menu' + id).attr('data_text'); //菜单名称
		var SCD_MENU = $('#menu' + id).attr('SCD_MENU'); //是否有二级菜单 0否    1是
		var TRIGGER_ACTION = $('#menu' + id).attr('selectAction'); //触发动作  1发送图文    2 URL 3跳转微网站
		var RESPONSE_ACTION = $('#menu' + id).attr('RESPONSE_ACTION'); //响应动作  10发送图文    2 图片   1文本
		var SOURCE_URL = $('#menu' + id).attr('SOURCE_URL'); //URL地址
		var PIC_URL = $('#menu' + id).attr('PIC_URL'); //图片地址
		var PIC_ID = $('#menu' + id).attr('PIC_ID'); //图片ID
		var SAYTEXT = $('#menu' + id).attr('SAYTEXT'); //文字
		var RANK = $('#menu' + id).attr('RANK');
		var SCD_MENU_GROUP_ID = $('#menu' + id).attr('SCD_MENU_GROUP_ID');
		//var saveState = $('#menu'+id).attr('saveState');
		var IT_ID = $('#menu' + id).attr('IT_ID'); //图文ID
		var IT_TITLE = $('#menu' + id).attr('IT_TITLE');
		var IT_PIC_URL = $('#menu' + id).attr('IT_PIC_URL');
		var IT_PIC_ID = $('#menu' + id).attr('IT_PIC_ID');
		var IT_AUTHOR = $('#menu' + id).attr('IT_AUTHOR');
		var IT_CREATE_TIME = $('#menu' + id).attr('IT_CREATE_TIME');
		var IT_COUNT = $('#menu' + id).attr('IT_COUNT');
		
		var LOCAL_IT_ID = $('#menu' + id).attr('LOCAL_IT_ID'); //图文ID
		var LOCAL_IT_TITLE = $('#menu' + id).attr('LOCAL_IT_TITLE');
		var LOCAL_IT_PIC_URL = $('#menu' + id).attr('LOCAL_IT_PIC_URL');
		var LOCAL_IT_CREATE_TIME = $('#menu' + id).attr('LOCAL_IT_CREATE_TIME');

		$('#imgAdd' + id).attr("style", "display:none");
		$('#aText' + id).html(MENU_NAME);

		$('#menu_admin').attr('editor_id', 'aText' + id);
		$('#menu_admin').attr('data_id', 'menu' + id);
		//$('#menu_admin').attr('saveState',saveState);
		$('#menu_admin').css({'display' : 'display'});

		$('#MENU_ID').val(MENU_ID);
		$('#MENU_NAME').val(MENU_NAME);
		$('#RANK').val(RANK);
		$('#MENU_NAME').attr('check_menu', 'pass');
		$('#IT_ID').val(IT_ID);
		$('#LOCAL_IT_ID').val(LOCAL_IT_ID);
		$('#SCD_MENU_GROUP_ID').val(SCD_MENU_GROUP_ID);
		$('#RESPONSE_ACTION').val(RESPONSE_ACTION);
		$('#PIC_URL').val(PIC_URL);
		$('#PIC_ID').val(PIC_ID);
		$('#SAYTEXT').val(SAYTEXT);
		//$('#IT_ID').val(IT_ID);
		$('#selectImage').attr('src', IT_PIC_URL);
		/* $('#selectImage').attr('src', IT_PIC_ID); */
		$('#selectTitle').html(IT_TITLE);
		/* $('#selectContent').html("作者：" + IT_AUTHOR + "<br/>时间：" + IT_CREATE_TIME + "<br/>数量："+ IT_COUNT); */
		
		BaseUtils.showWaitMsg();
		/* 判断是否有子菜单，并控制显示   */
		if ('yes' == havechild) {
			$('#detailForm').attr("style", "display:none"); //控制是否作为主菜单的显示
			$('#selectAdminMenu').attr("style", "display:none");
		} else {
			if (SCD_MENU == '1') {
				$('#selectAdminMenu').removeAttr("style");
				$('#SCD_MENU1').prop("checked", true);
				$('#detailForm').attr("style", "display:none");
			} else {
				$('#SCD_MENU0').prop("checked", true);
				$('#detailForm').removeAttr("style");
				$('#selectAdminMenu').removeAttr("style");
				if ('1' == TRIGGER_ACTION) {
					$('#LocalML').attr("style", "display:none");
					$('#selectAction1').prop("checked", true);
					$('#MESSAGE').removeAttr("style");
					$('#URL').attr("style", "display:none");
					if ('10' == RESPONSE_ACTION) {
						if ("" == IT_ID || undefined == IT_ID || null == IT_ID) {
							selectContent_Menu(10);
							$('#imageText').removeAttr("style");
							$('#selectedIT').attr("style", "display:none");
							$('#image').attr("style", "display:none");
							$('#showImageDiv').attr("style", "display:none");
						} else {
							selectContent_Menu(10);
							//$('#imageText').attr("style","display:none");
							//$('#selectedIT').removeAttr("style");
							setSelectedIT(IT_ID, IT_TITLE, IT_PIC_URL,IT_AUTHOR, IT_CREATE_TIME, IT_COUNT); //图文的ID
							$('#image').attr("style", "display:none");
							$('#showImageDiv').attr("style", "display:none");
						}
					} else if ('2' == RESPONSE_ACTION) {
						if ("" == PIC_URL || undefined == PIC_URL || null == PIC_URL) {
							selectContent_Menu(2);
							$('#image').removeAttr("style");
							$('#selectedIT').attr("style", "display:none");
							$('#imageText').attr("style", "display:none");
							$('#showImageDiv').attr("style", "display:none");
						} else {
							selectContent_Menu(2);
							$('#image').attr("style", "display:none");
							$('#selectedIT').attr("style", "display:none");
							$('#imageText').attr("style", "display:none");
							$('#showImage').attr('src', PIC_URL);
							$('#showImageDiv').removeAttr("style");
						}
					} else if ('1' == RESPONSE_ACTION) {
							selectContent_Menu(1);
							$("#SAYTEXT").val(SAYTEXT);
							
					}
				} else if ('2' == TRIGGER_ACTION) {
					$('#LocalML').attr("style", "display:none");
					$('#selectAction2').prop("checked", true);
					$('#MESSAGE').attr("style", "display:none");
					$('#URL').removeAttr("style");
					$('#SOURCE_URL').val(SOURCE_URL);
				} else if ('3' == TRIGGER_ACTION) {
					$('#LocalML').attr("style", "display:none");
					$('#selectAction3').prop("checked", true);
					$('#MESSAGE').attr("style", "display:none");
					$('#URL').attr("style", "display:none");
					//$('#SOURCE_URL').val(SOURCE_URL);
				} else if ('4' == TRIGGER_ACTION) {
					if ("" == LOCAL_IT_ID || undefined == LOCAL_IT_ID || null == LOCAL_IT_ID) {
						$('#localIT_tab').removeAttr("style");
						$('#selectedLocalIT').attr("style", "display:none");
					}else{
						setSelectedLocalIT(LOCAL_IT_ID, LOCAL_IT_TITLE, LOCAL_IT_PIC_URL,LOCAL_IT_CREATE_TIME);
					}
					$('#LocalML').removeAttr("style");
					$('#selectAction4').prop("checked", true);
					$('#MESSAGE').attr("style", "display:none");
					$('#URL').attr("style", "display:none");
					//$('#SOURCE_URL').val(SOURCE_URL);
				}
			}

		}
		BaseUtils.hideWaitMsg();

	}
	/**
	 *description：根据图文ID返回相应的信息。
	 *time：2015/11/30
	 *author：daiwk
	 */
	function getByITID(IT_ID, id) {
		if (IT_ID == null || IT_ID == "" || IT_ID == undefined) {
			$('#' + id).attr('IT_TITLE', "");
			$('#' + id).attr('IT_PIC_URL', "");
			$('#' + id).attr('IT_PIC_ID', "");
			$('#' + id).attr('IT_AUTHOR', "");
			$('#' + id).attr('IT_CREATE_TIME', "");
			$('#' + id).attr('IT_COUNT', "");
		} else {
			$.ajax({
				url : "${ctx}/zdycd/getByITID.do",
				type : "post",
				data : {
					"IT_ID" : IT_ID
				},
				dataType : "json",
				success : function(data) {
					if (data.flag) {
						$('#' + id).attr('IT_TITLE', data.obj.TITLE);
						$('#' + id).attr('IT_PIC_URL', data.obj.PIC_URL);
						$('#' + id).attr('IT_PIC_ID', data.obj.PIC_ID);
						$('#' + id).attr('IT_AUTHOR', data.obj.AUTHOR);
						$('#' + id).attr('IT_CREATE_TIME', data.obj.CREATE_TIME);
						$('#' + id).attr('IT_COUNT', data.obj.IT_COUNT);
					}
				}
			});
		}

	}
	function getByLocalITID(LOCAL_IT_ID, id){
		if (LOCAL_IT_ID == null || LOCAL_IT_ID == "" || LOCAL_IT_ID == undefined) {
			$('#' + id).attr('LOCAL_IT_TITLE', "");
			$('#' + id).attr('LOCAL_IT_PIC_URL', "");
			$('#' + id).attr('LOCAL_IT_CREATE_TIME', "");
		} else {
			$.ajax({
				url : "${ctx}/localML/getLocalIT.do",
				type : "post",
				data : {"LOCAL_IT_ID" : LOCAL_IT_ID},
				dataType : "json",
				success : function(data) {
					if (data.flag) {
						$('#' + id).attr('LOCAL_IT_TITLE', data.obj.TITLE);
						$('#' + id).attr('LOCAL_IT_PIC_URL', data.obj.PIC_URL);
						$('#' + id).attr('LOCAL_IT_CREATE_TIME', data.obj.CREATE_TIME);
					}
				}
			});
		}

	}
	/**
	 *description：控制出现图文信息。
	 *time：2015/11/30
	 *author：daiwk
	 */
	function setSelectedIT(IT_ID, IT_TITLE, IT_PIC_URL, IT_AUTHOR,IT_CREATE_TIME, IT_COUNT) {
		$('#IT_ID').val(IT_ID);
		$('#selectImage').attr('src', IT_PIC_URL);
		$('#selectTitle').html(IT_TITLE);
		/* $('#selectContent').html(
				"作者：" + IT_AUTHOR + "<br/>时间：" + IT_CREATE_TIME + "<br/>数量："
						+ IT_COUNT); */
		$('#imageText').attr("style", "display:none");
		$('#selectedIT').removeAttr("style");
	}
	/**
	 *description：控制出现跳转图文信息。
	 *time：2015/11/30
	 *author：daiwk
	 */
	function setSelectedLocalIT(LOCAL_IT_ID, LOCAL_IT_TITLE, LOCAL_IT_PIC_URL,LOCAL_IT_CREATE_TIME) {
		$('#LOCAL_IT_ID').val(LOCAL_IT_ID);
		$('#selectLocalImage').attr('src', LOCAL_IT_PIC_URL);
		$('#selectLocalTitle').html(LOCAL_IT_TITLE);
		/* $('#selectContent').html(
				"作者：" + IT_AUTHOR + "<br/>时间：" + IT_CREATE_TIME + "<br/>数量："
						+ IT_COUNT); */
		$('#selectedLocalIT').removeAttr("style");
		$('#localIT_tab').attr("style", "display:none");
	}
	/**
	 *description：动态添加子菜单，添加样式。
	 *time：2015/11/25
	 *author：daiwk
	 */
	function addChildMenu(data_id, child_id) {
		//var saveState = $('#menu_admin').attr('saveState');
		var id = data_id;
		var formState = $('#menu_admin').attr('formState');
		if ('no' == formState) {
			alert("请保存之前编辑的菜单，保存后才能添加子菜单。");
			return false;
		}

		if (id == '00') {
			if (check0 > 4) {
				alert("最多添加5个子菜单！");
				return false;
			}
			addChildForm();
			var SCD_MENU_GROUP_ID = $('#menu00').attr('SCD_MENU_GROUP_ID');

			$('#ul' + id).prepend(
							"<li id=\"li0"+child0+"\" class=\"new-sub-li\" data_text=\"菜单名称\" saveState=\"editor\" menu=\"child\" main_id=\"00\""
									+" MENU_ID=\"\" RANK=\""+child0+"\" selectAction=\"1\" RESPONSE_ACTION=\"10\" SOURCE_URL=\"\" PIC_URL=\"\" PIC_ID=\"\" SCD_MENU_GROUP_ID=\""+SCD_MENU_GROUP_ID+"\" "  
									+"LOCAL_IT_ID=\"\" LOCAL_IT_TITLE=\"\" LOCAL_IT_PIC_URL=\"\" LOCAL_IT_CREATE_TIME=\"\" "
									+"IT_ID=\"\" SAYTEXT=\"\" IT_TITLE=\"\" IT_PIC_URL=\"\" IT_PIC_ID=\"\" IT_AUTHOR=\"\" IT_CREATE_TIME=\"\" IT_COUNT=\"\">"
									+ "<a id=\"childTsxt0"
									+ child0
									+ "\"  onclick=\"childMenu(\'00\',\'0"
									+ child0 + "\')\"></a></li>");
			$("ul li").removeClass("focuson");
			$("li a").removeClass("focuson_a");

			var MENU_NAME = $('#li0' + child0).attr('data_text');
			$('#childTsxt0' + child0).html(MENU_NAME);
			$('#MENU_ID').val("");
			$('#MENU_NAME').val(MENU_NAME);
			$('#MENU_NAME').attr('check_menu', 'pass');
			$('#RESPONSE_ACTION').val("10");
			$('#SOURCE_URL').val("");
			$('#IT_ID').val("");
			$('#LOCAL_IT_ID').val("");
			$('#PIC_URL').val("");
			$('#PIC_ID').val("");
			$('#SAYTEXT').val("");
			$('#SCD_MENU_GROUP_ID').val(SCD_MENU_GROUP_ID);
			$('#RANK').val(child0);

			$('#menu_admin').attr('editor_id', 'childTsxt0' + child0);
			$('#menu_admin').attr('data_id', 'li0' + child0);
			//$('#menu_admin').attr('saveState','no');
			$('#menu_admin').attr('menu', 'child');
			$('#menu_admin').attr('formState', 'no');

			$('#li0' + child0).addClass("focuson");
			$('#childTsxt0' + child0).addClass("focuson_a");

			$('#menu' + id).attr('havechild', 'yes');

			child0++;
			check0++;
		} else if (id == '10') {
			if (check1 > 4) {
				alert("最多添加5个子菜单！");
				return false;
			}
			addChildForm();
			var SCD_MENU_GROUP_ID = $('#menu10').attr('SCD_MENU_GROUP_ID');
			$('#ul' + id)
					.prepend(
							"<li id=\"li1"+child1+"\" class=\"new-sub-li\" data_text=\"菜单名称\" saveState=\"editor\" menu=\"child\" main_id=\"10\""
									+" MENU_ID=\"\" RANK=\""+child1+"\" selectAction=\"1\" RESPONSE_ACTION=\"10\" SOURCE_URL=\"\" PIC_URL=\"\" PIC_ID=\"\" SCD_MENU_GROUP_ID=\""+SCD_MENU_GROUP_ID+"\" "  
									+"LOCAL_IT_ID=\"\" LOCAL_IT_TITLE=\"\" LOCAL_IT_PIC_URL=\"\" LOCAL_IT_CREATE_TIME=\"\" "
									+"IT_ID=\"\" SAYTEXT=\"\" IT_TITLE=\"\" IT_PIC_URL=\"\" IT_PIC_ID=\"\" IT_AUTHOR=\"\" IT_CREATE_TIME=\"\" IT_COUNT=\"\">"
									+ "<a id=\"childTsxt1"
									+ child1
									+ "\"  onclick=\"childMenu(\'10\',\'1"
									+ child1 + "\')\"></a></li>");
			$("ul li").removeClass("focuson");
			$("li a").removeClass("focuson_a");

			var MENU_NAME = $('#li1' + child1).attr('data_text');
			$('#childTsxt1' + child1).html(MENU_NAME);
			$('#MENU_ID').val("");
			$('#MENU_NAME').val(MENU_NAME);
			$('#MENU_NAME').attr('check_menu', 'pass');
			$('#RESPONSE_ACTION').val("10");
			$('#SOURCE_URL').val("");
			$('#IT_ID').val("");
			$('#LOCAL_IT_ID').val("");
			$('#PIC_URL').val("");
			$('#PIC_ID').val("");
			$('#SAYTEXT').val("");
			$('#SCD_MENU_GROUP_ID').val(SCD_MENU_GROUP_ID);
			$('#RANK').val(child1);

			$('#menu_admin').attr('editor_id', 'childTsxt1' + child1);
			$('#menu_admin').attr('data_id', 'li1' + child1);
			//$('#menu_admin').attr('saveState','no');
			$('#menu_admin').attr('menu', 'child');
			$('#menu_admin').attr('formState', 'no');

			$('#li1' + child1).addClass("focuson");
			$('#childTsxt1' + child1).addClass("focuson_a");

			$('#menu' + id).attr('havechild', 'yes');

			child1++;
			check1++;
		} else if (id == '20') {
			if (check2 > 4) {
				alert("最多添加5个子菜单！");
				return false;
			}
			addChildForm();
			var SCD_MENU_GROUP_ID = $('#menu20').attr('SCD_MENU_GROUP_ID');

			$('#ul' + id)
					.prepend(
							"<li id=\"li2"+child2+"\" class=\"new-sub-li\"data_text=\"菜单名称\" saveState=\"editor\" menu=\"child\" main_id=\"20\""
									+" MENU_ID=\"\" RANK=\""+child2+"\" selectAction=\"1\" RESPONSE_ACTION=\"10\" SOURCE_URL=\"\" PIC_URL=\"\" PIC_ID=\"\" SCD_MENU_GROUP_ID=\""+SCD_MENU_GROUP_ID+"\" "  
									+"LOCAL_IT_ID=\"\" LOCAL_IT_TITLE=\"\" LOCAL_IT_PIC_URL=\"\" LOCAL_IT_CREATE_TIME=\"\" "
									+"IT_ID=\"\" SAYTEXT=\"\" IT_TITLE=\"\" IT_PIC_URL=\"\" IT_PIC_ID=\"\" IT_AUTHOR=\"\" IT_CREATE_TIME=\"\" IT_COUNT=\"\">"
									+ "<a id=\"childTsxt2"
									+ child2
									+ "\"  onclick=\"childMenu(\'20\',\'2"
									+ child2 + "\')\"></a></li>");
			$("ul li").removeClass("focuson");
			$("li a").removeClass("focuson_a");

			var MENU_NAME = $('#li2' + child2).attr('data_text');
			$('#childTsxt2' + child2).html(MENU_NAME);
			$('#MENU_ID').val("");
			$('#MENU_NAME').val(MENU_NAME);
			$('#MENU_NAME').attr('check_menu', 'pass');
			$('#RESPONSE_ACTION').val("10");
			$('#SOURCE_URL').val("");
			$('#IT_ID').val("");
			$('#LOCAL_IT_ID').val("");
			$('#PIC_URL').val("");
			$('#PIC_ID').val("");
			$('#SAYTEXT').val("");
			$('#SCD_MENU_GROUP_ID').val(SCD_MENU_GROUP_ID);
			$('#RANK').val(child2);

			$('#menu_admin').attr('editor_id', 'childTsxt2' + child0);
			$('#menu_admin').attr('data_id', 'li2' + child2);
			//$('#menu_admin').attr('saveState','no');
			$('#menu_admin').attr('menu', 'child');
			$('#menu_admin').attr('formState', 'no');

			$('#li2' + child2).addClass("focuson");
			$('#childTsxt2' + child2).addClass("focuson_a");

			$('#menu' + id).attr('havechild', 'yes');

			child2++;
			check2++;
		}
		selectContent_Menu(10);
	}
	/**
	 *description：动态添加子菜单，并修改form。
	 *time：2015/11/30
	 *author：daiwk
	 */
	function addChildForm() {
		$(".menu").removeClass("focuson");
		//$('#SCD_MENU_GROUP_ID').val("");
		$('#selectAdminMenu').attr("style", "display:none"); //控制是否作为主菜单的显示
		$('#detailForm').removeAttr("style");
		$('#selectAction1').prop("checked", true);
		$('#SOURCE_URL').val("");
		$('#PIC_URL').val("");
		$('#PIC_ID').val("");
		$('#IT_ID').val("");
		$('#LOCAL_IT_ID').val("");
		$('#SAYTEXT').val("");
		$('#URL').attr("style", "display:none");
		$('#MESSAGE').removeAttr("style");
		$('#imageText').removeAttr("style");
		$('#selectedIT').attr("style", "display:none");
		$('#image').attr("style", "display:none");
		$('#showImageDiv').attr("style", "display:none");
		$('#editor_text').attr("style", "display:none");
		$('#LocalML').attr("style", "display:none");
	}

	/**
	 *description：输入名称，当失去焦点，动态改变菜单名称
	 *time：2015/11/25
	 *author：daiwk
	 */
	function changeTitle() {
		var editor_id = $('#menu_admin').attr('editor_id');
		var data_id = $('#menu_admin').attr('data_id');
		var text = $('#MENU_NAME').val();
		var text_byte = $("#MENU_NAME").val().replace(/[^\u0000-\u00ff]/g, "aa").length;
		if (text == "" || text == undefined) {
			alert("名称不能为空！");
			$('#MENU_NAME').attr('check_menu', 'stop');
			return false;
		} else if (text_byte > 8) {
			alert("名称不能超过4个字或8个字母！");
			$('#MENU_NAME').attr('check_menu', 'stop');
			return false;
		}
		$('#MENU_NAME').attr('check_menu', 'pass');
		$('#' + editor_id).html(text);
		$('#' + data_id).attr('data_text', text);
	}
	/**
	 *description：子菜单选择并在右侧编辑子菜单内容。
	 *time：2015/11/25
	 *author：daiwk
	 */
	function childMenu(main_id, child_id) {
		var menuid = "li" + child_id;
		var formMenuid = $('#menu_admin').attr('data_id');
		if (formMenuid == menuid) {
			return false;
		}
		$('#menu_admin').attr('editor_id', 'childTsxt' + child_id);
		$('#menu_admin').attr('data_id', 'li' + child_id);

		$(".menu").removeClass("focuson");
		$("ul li").removeClass("focuson");
		$("li a").removeClass("focuson_a");
		$('#li' + child_id).addClass("focuson");
		$('#childTsxt' + child_id).addClass("focuson_a");

		$('#selectAdminMenu').attr("style", "display:none"); //控制是否作为主菜单的显示
		$('#detailForm').removeAttr("style");

		//var MENU_NAME = $('#li'+child_id).attr('data_text');
		var MENU_ID = $('#li' + child_id).attr('MENU_ID'); //菜单主ID
		//var havechild = $('#li'+child_id).attr('havechild');      					//是否有子菜单
		var MENU_NAME = $('#li' + child_id).attr('data_text'); //菜单名称
		//var SCD_MENU = $('#li'+child_id).attr('SCD_MENU');							//是否有二级菜单 0否    1是
		var TRIGGER_ACTION = $('#li' + child_id).attr('selectAction'); //触发动作  1发送图文    2 URL
		var RESPONSE_ACTION = $('#li' + child_id).attr('RESPONSE_ACTION'); //响应动作  10发送图文    2 图片  1文字
		var SOURCE_URL = $('#li' + child_id).attr('SOURCE_URL'); //URL地址
		var PIC_ID = $('#li' + child_id).attr('PIC_ID');
		var PIC_URL = $('#li' + child_id).attr('PIC_URL');//图片地址
		var SAYTEXT = $('#li' + child_id).attr('SAYTEXT');//文字
		var RANK = $('#li' + child_id).attr('RANK');
		//var saveState = $('#menu'+id).attr('saveState');
		var IT_ID = $('#li' + child_id).attr('IT_ID'); //图文ID
		var IT_TITLE = $('#li' + child_id).attr('IT_TITLE');
		var IT_PIC_URL = $('#li' + child_id).attr('IT_PIC_URL');
		var IT_PIC_ID = $('#li' + child_id).attr('IT_PIC_ID');
		var IT_AUTHOR = $('#li' + child_id).attr('IT_AUTHOR');
		var IT_CREATE_TIME = $('#li' + child_id).attr('IT_CREATE_TIME');
		var IT_COUNT = $('#li' + child_id).attr('IT_COUNT');
		
		var LOCAL_IT_ID = $('#li' + child_id).attr('LOCAL_IT_ID'); //本地图文ID
		var LOCAL_IT_TITLE = $('#li' + child_id).attr('LOCAL_IT_TITLE');
		var LOCAL_IT_PIC_URL = $('#li' + child_id).attr('LOCAL_IT_PIC_URL');
		var LOCAL_IT_CREATE_TIME = $('#li' + child_id).attr('LOCAL_IT_CREATE_TIME');

		//$('#imgAdd'+id).attr("style","display:none");
		$('#childTsxt' + child_id).html(MENU_NAME);
		$('#MENU_NAME').val(MENU_NAME);

		//$('#menu_admin').attr('editor_id','childTsxt'+child_id);
		//$('#selectAdminMenu').attr("style","display:none");
		$('#menu_admin').attr('menu', 'child');
		$('#menu_admin').css({'display' : 'display'});

		$('#MENU_ID').val(MENU_ID);
		$('#MENU_NAME').val(MENU_NAME);
		$('#RANK').val(RANK);
		$('#MENU_NAME').attr('check_menu', 'pass');
		$('#SCD_MENU_GROUP_ID').val(SCD_MENU_GROUP_ID);
		$('#SAYTEXT').val(SAYTEXT);
		/* $('#RESPONSE_ACTION').val(RESPONSE_ACTION);
		$('#PIC_URL').val(PIC_URL);
		$('#IT_ID').val(IT_ID);
		$('#selectImage').attr('src',IT_PIC_URL);
		$('#selectTitle').html(IT_TITLE);
		$('#selectContent').html("作者："+IT_AUTHOR+"<br/>时间："+IT_CREATE_TIME+"<br/>数量："+IT_COUNT); */

		$('#detailForm').removeAttr("style");
		if ('1' == TRIGGER_ACTION) {
			$('#selectAction1').prop("checked", true);
			$('#MESSAGE').removeAttr("style");
			$('#URL').attr("style", "display:none");
			$('#LocalML').attr("style", "display:none");
			if ('10' == RESPONSE_ACTION) {
				if ("" == IT_ID || undefined == IT_ID || null == IT_ID) {
					$('#IT_ID').val("");
					selectContent_Menu(10);
					$('#imageText').removeAttr("style");
					$('#selectedIT').attr("style", "display:none");
					$('#image').attr("style", "display:none");
					$('#showImageDiv').attr("style", "display:none");
					
				} else {
					selectContent_Menu(10);
					//$('#imageText').attr("style","display:none");
					//$('#selectedIT').removeAttr("style");
					setSelectedIT(IT_ID, IT_TITLE, IT_PIC_URL, IT_AUTHOR,IT_CREATE_TIME, IT_COUNT); //图文的ID
					$('#image').attr("style", "display:none");
					$('#showImageDiv').attr("style", "display:none");
				}
			} else if ('2' == RESPONSE_ACTION) {
				if ("" == PIC_URL || undefined == PIC_URL || null == PIC_URL) {
					selectContent_Menu(2);
					$('#PIC_URL').val("");
					$('#PIC_ID').val("");
					$('#image').removeAttr("style");
					$('#selectedIT').attr("style", "display:none");
					$('#imageText').attr("style", "display:none");
					$('#showImageDiv').attr("style", "display:none");
				} else {
					selectContent_Menu(2);
					$('#image').attr("style", "display:none");
					$('#selectedIT').attr("style", "display:none");
					$('#imageText').attr("style", "display:none");
					$('#showImageDiv').removeAttr("style");
					$('#showImage').attr('src', PIC_URL);
					$('#PIC_URL').val(PIC_URL);
					$('#PIC_ID').val(PIC_ID);
				}
			} else if ('1' == RESPONSE_ACTION) {
					selectContent_Menu(1);
					$('#SAYTEXT').val(SAYTEXT);
			}
		} else if ('2' == TRIGGER_ACTION) {
			$('#selectAction2').prop("checked", true);
			$('#MESSAGE').attr("style", "display:none");
			$('#URL').removeAttr("style");
			$('#LocalML').attr("style", "display:none");
			$('#SOURCE_URL').val(SOURCE_URL);
		} else if ('3' == TRIGGER_ACTION) {
			$('#selectAction3').prop("checked", true);
			$('#MESSAGE').attr("style", "display:none");
			$('#URL').attr("style", "display:none");
			$('#LocalML').attr("style", "display:none");
			//$('#SOURCE_URL').val(SOURCE_URL);
		} else if ('4' == TRIGGER_ACTION) {
			$('#selectAction4').prop("checked", true);
			$('#MESSAGE').attr("style", "display:none");
			$('#URL').attr("style", "display:none");
			$('#LocalML').removeAttr("style");
			//$('#SOURCE_URL').val(SOURCE_URL);
			if ("" == LOCAL_IT_ID || undefined == LOCAL_IT_ID || null == LOCAL_IT_ID) {
				$('#localIT_tab').removeAttr("style");
				$('#selectedLocalIT').attr("style", "display:none");
			}else{
				setSelectedLocalIT(LOCAL_IT_ID, LOCAL_IT_TITLE, LOCAL_IT_PIC_URL,LOCAL_IT_CREATE_TIME);
			}
		}

	}

	/**
	 *description：选择redio改变，1是图文信息，2是外部链接url。3是微网站
	 *time：2015/11/25
	 *author：daiwk
	 */
	function selectAction(option) {
		var ID = $('#menu_admin').attr('data_id');

		if ('1' == option) {
			$('#MESSAGE').removeAttr("style");
			$('#URL').attr("style", "display:none");
			$('#LocalML').attr("style", "display:none");
			$('#' + ID).attr('selectAction', '1');
		} else if ('2' == option) {
			$('#URL').removeAttr("style");
			$('#MESSAGE').attr("style", "display:none");
			$('#LocalML').attr("style", "display:none");
			$('#' + ID).attr('selectAction', '2');
		} else if ('3' == option) {
			$('#URL').attr("style", "display:none");
			$('#MESSAGE').attr("style", "display:none");
			$('#LocalML').attr("style", "display:none");
			$('#' + ID).attr('selectAction', '3');
		} else if ('4' == option) {
			$('#LocalML').removeAttr("style");
			$('#URL').attr("style", "display:none");
			$('#MESSAGE').attr("style", "display:none");
			$('#' + ID).attr('selectAction', '4');
		}
	}
	/**
	 *description：选择菜单是判断  1是图文信息，2是图片。
	 *time：2015/11/25
	 *author：daiwk
	 */
	function selectContent_Menu(option) {
			if ('10' == option) {
				$('#imageText_li').addClass("selected");
				$('#image_li').removeClass("selected");
				$('#text_li').removeClass("selected");
				
				$('#imageText').removeAttr("style");
				$('#imageText_tab').removeAttr("style");
				
				$('#image').attr("style", "display:none");
				$('#image_tab').attr("style", "display:none");
				
				$('#editor_text').attr("style", "display:none");
				
				$('#RESPONSE_ACTION').val('10');
			} else if ('2' == option) {
				$('#image_li').addClass("selected");
				$('#imageText_li').removeClass("selected");
				$('#text_li').removeClass("selected");
				
				$('#image').removeAttr("style");
				$('#image_tab').removeAttr("style");
				
				$('#imageText').attr("style", "display:none");
				$('#imageText_tab').attr("style", "display:none");
				
				$('#editor_text').attr("style", "display:none");
				
				$('#RESPONSE_ACTION').val('2');
			}else if('1' == option){
				$('#image_li').removeClass("selected");
				$('#imageText_li').removeClass("selected");
				$('#text_li').addClass("selected");
				
				$('#image').attr("style", "display:none");
				$('#image_tab').attr("style", "display:none");
				
				$('#imageText').attr("style", "display:none");
				$('#imageText_tab').attr("style", "display:none");
				
				$('#editor_text').removeAttr("style");
				
				$('#RESPONSE_ACTION').val('1');
			}

	}
	/**
	 *description：从网页上选择内容  10是图文信息，2是图片。
	 *time：2015/11/25
	 *author：daiwk
	 */
	function selectContent(option) {
		if ("" == $('#IT_ID').val() && "" == $('#PIC_URL').val()) {
			if ('10' == option) {
				$('#imageText_li').addClass("selected");
				$('#image_li').removeClass("selected");
				$('#text_li').removeClass("selected");
				
				$('#imageText').removeAttr("style");
				$('#imageText_tab').removeAttr("style");
				
				$('#image').attr("style", "display:none");
				$('#image_tab').attr("style", "display:none");
				
				$('#editor_text').attr("style", "display:none");
				
				$('#RESPONSE_ACTION').val('10');
			} else if ('2' == option) {
				$('#image_li').addClass("selected");
				$('#imageText_li').removeClass("selected");
				$('#text_li').removeClass("selected");
				
				$('#image').removeAttr("style");
				$('#image_tab').removeAttr("style");
				
				$('#imageText').attr("style", "display:none");
				$('#imageText_tab').attr("style", "display:none");
				
				$('#editor_text').attr("style", "display:none");
				
				$('#RESPONSE_ACTION').val('2');
			}else if('1' == option){
				$('#image_li').removeClass("selected");
				$('#imageText_li').removeClass("selected");
				$('#text_li').addClass("selected");
				
				$('#image').attr("style", "display:none");
				$('#image_tab').attr("style", "display:none");
				
				$('#imageText').attr("style", "display:none");
				$('#imageText_tab').attr("style", "display:none");
				
				$('#editor_text').removeAttr("style");
				
				$('#RESPONSE_ACTION').val('1');
			}
		}

	}
	/**
	 *description：弹出层，选择本地跳转图文信息。
	 *time：2016/3/6
	 *author：daiwk
	 */
	function selectLocalIT(id) {
		layer.open({
			title : '选择本地跳转图文',
			type : 2,
			area : [ '1000px', '500px' ],
			fix : false, //不固定
			offset : '50px',
			maxmin : true,
			shadeClose : true,
			shade : 0.8,
			content : '${ctx}/localML/selectLocalITList.do'
		});
	}
	/**
	 *description：弹出层，选择图文信息。
	 *time：2015/11/25
	 *author：daiwk
	 */
	function selectIT(id) {
		layer.open({
			title : '选择图文信息',
			type : 2,
			area : [ '1000px', '500px' ],
			fix : false, //不固定
			offset : '50px',
			maxmin : true,
			shadeClose : true,
			shade : 0.8,
			content : '${ctx}/zdycd/selectIT.do'
		});
	}
	/**
	 *description：上传图片，选择图片。
	 *time：2015/12/2
	 *author：daiwk
	 */
	KindEditor.ready(function(K) {
		var editor = K.editor({
			uploadJson : '${ctx}/upload/fileUpload.do',
			fileManagerJson : '${ctx}/upload/fileManager.do',
			allowFileManager : true,
		});
		/* K('#selectPicture').click(
				function() {
					editor.loadPlugin('image', function() {
						editor.plugin.imageDialog({
							showLocal : false,
							imageUrl : K('#PIC_URL').val(),
							clickFn : function(url, title, width, height,
									border, align) {
								
								K('#PIC_URL').val(url);
								$('#image').attr("style", "display:none");
								$('#selectedIT').attr("style", "display:none");
								$('#imageText').attr("style", "display:none");
								$('#showImageDiv').removeAttr("style");
								$('#showImage').attr('src', url);
								editor.hideDialog();
							}
						});
					});
				}); */
		K('#uploadPicture').click(
				function() {
					editor.loadPlugin('image', function() {
						editor.plugin.imageDialog({
							showRemote : false,
							imageUrl : K('#PIC_URL').val(),
							clickFn : function(url, title, width, height,
									border, align, PIC_ID) {
								alert(PIC_ID);
								K('#PIC_URL').val(url);
								K('#PIC_ID').val(PIC_ID);
								$('#image').attr("style", "display:none");
								$('#selectedIT').attr("style", "display:none");
								$('#imageText').attr("style", "display:none");
								
								$('#editor_text').attr("style", "display:none");
								$('#showImageDiv').removeAttr("style");
								$('#showImage').attr('src', url);
								editor.hideDialog();
							}
						});
					});
				});
	});
	/**
	 *description：选择是否作为主菜单。
	 *time：2015/12/3
	 *author：daiwk
	 */
	function AdminMenu(option) {
		var id = $('#menu_admin').attr('data_id');
		//var MENU_ID = $('#'+id).attr('MENU_ID');							//菜单主ID
		//var havechild = $('#li'+child_id).attr('havechild');      					//是否有子菜单
		//var MENU_NAME = $('#li'+child_id).attr('data_text');						//菜单名称
		//var SCD_MENU = $('#li'+child_id).attr('SCD_MENU');							//是否有二级菜单 0否    1是
		var TRIGGER_ACTION = $('#' + id).attr('selectAction'); //触发动作  1发送图文    2 URL 3跳转微首页
		var RESPONSE_ACTION = $('#' + id).attr('RESPONSE_ACTION'); //响应动作  10发送图文    2 图片
		var SOURCE_URL = $('#' + id).attr('SOURCE_URL'); //URL地址
		var PIC_URL = $('#' + id).attr('PIC_URL'); //图片地址
		var PIC_ID = $('#' + id).attr('PIC_ID'); //图片ID
		var SAYTEXT = $('#' + id).attr('SAYTEXT'); //文字
		var RANK = $('#' + id).attr('RANK');
		//var saveState = $('#menu'+id).attr('saveState');
		var IT_ID = $('#' + id).attr('IT_ID'); //图文ID
		var IT_TITLE = $('#' + id).attr('IT_TITLE');
		var IT_PIC_URL = $('#' + id).attr('IT_PIC_URL');
		var IT_PIC_ID = $('#' + id).attr('IT_PIC_ID');
		var IT_AUTHOR = $('#' + id).attr('IT_AUTHOR');
		var IT_CREATE_TIME = $('#' + id).attr('IT_CREATE_TIME');
		var IT_COUNT = $('#' + id).attr('IT_COUNT');
		var LOCAL_IT_ID = $('#' + id).attr('IT_ID'); //图文ID
		var LOCAL_IT_TITLE = $('#' + id).attr('IT_TITLE');
		var LOCAL_IT_PIC_URL = $('#' + id).attr('IT_PIC_URL');
		var LOCAL_IT_CREATE_TIME = $('#' + id).attr('IT_CREATE_TIME');
		
		if ('1' == option) {
			$('#detailForm').attr("style", "display:none");
			$('#' + id).attr('SCD_MENU', '1');
		} else if ('0' == option) {
			$('#detailForm').removeAttr("style");
			$('#' + id).attr('SCD_MENU', '0');
			if ('1' == TRIGGER_ACTION) {
				$('#selectAction1').prop("checked", true);
				$('#MESSAGE').removeAttr("style");
				$('#URL').attr("style", "display:none");
				$('#LocalML').attr("style", "display:none");
				if ('10' == RESPONSE_ACTION) {
					if ("" == IT_ID || undefined == IT_ID || null == IT_ID) {
						
						$('#imageText').removeAttr("style");
						$('#selectedIT').attr("style", "display:none");
						$('#image').attr("style", "display:none");
						$('#showImageDiv').attr("style", "display:none");
						$('#editor_text').attr("style", "display:none");
					} else {
						//$('#imageText').attr("style","display:none");
						//$('#selectedIT').removeAttr("style");
						setSelectedIT(IT_ID, IT_TITLE, IT_PIC_URL, IT_AUTHOR,IT_CREATE_TIME, IT_COUNT); //图文的ID
						$('#image').attr("style", "display:none");
						$('#showImageDiv').attr("style", "display:none");
						$('#editor_text').attr("style", "display:none");
					}
				} else if ('2' == RESPONSE_ACTION) {
					if ("" == PIC_URL || undefined == PIC_URL || null == PIC_URL) {
						$('#image').removeAttr("style");
						$('#selectedIT').attr("style", "display:none");
						$('#imageText').attr("style", "display:none");
						$('#showImageDiv').attr("style", "display:none");
						$('#editor_text').attr("style", "display:none");
					} else {
						$('#image').attr("style", "display:none");
						$('#selectedIT').attr("style", "display:none");
						$('#imageText').attr("style", "display:none");
						$('#showImageDiv').removeAttr("style");
						$('#showImage').attr('src', PIC_URL);
						$('#PIC_URL').val(PIC_URL);
						$('#PIC_ID').val(PIC_ID);
						
					}
				} else if ('1' == RESPONSE_ACTION) {
					$('#imageText').attr("style", "display:none");
					$('#selectedIT').attr("style", "display:none");
					$('#image').attr("style", "display:none");
					$('#showImageDiv').attr("style", "display:none");
					$('#editor_text').removeAttr("style");
					$('#SAYTEXT').val(SAYTEXT);
				}
			} else if ('2' == TRIGGER_ACTION) {
				$('#selectAction2').prop("checked", true);
				$('#MESSAGE').attr("style", "display:none");
				$('#URL').removeAttr("style");
				$('#LocalML').attr("style", "display:none");
				$('#SOURCE_URL').val(SOURCE_URL);
			} else if ('3' == TRIGGER_ACTION) {
				$('#selectAction3').prop("checked", true);
				$('#MESSAGE').attr("style", "display:none");
				$('#URL').attr("style", "display:none");
				$('#LocalML').attr("style", "display:none");
				//$('#SOURCE_URL').val(SOURCE_URL);
			} else if ('4' == TRIGGER_ACTION) {
				$('#selectAction4').prop("checked", true);
				$('#MESSAGE').attr("style", "display:none");
				$('#URL').attr("style", "display:none");
				$('#LocalML').removeAttr("style");
				//$('#SOURCE_URL').val(SOURCE_URL);
				if ("" == LOCAL_IT_ID || undefined == LOCAL_IT_ID || null == LOCAL_IT_ID) {
					$('#localIT_tab').removeAttr("style");
					$('#selectedLocalIT').attr("style", "display:none");
				}else{
					setSelectedLocalIT(LOCAL_IT_ID, LOCAL_IT_TITLE, LOCAL_IT_PIC_URL,LOCAL_IT_CREATE_TIME);
				}
			}
		}
	}
	/**
	 *description：弹出层选择图文信息后调用此方法。
	 *time：2015/11/25
	 *author：daiwk
	 */
	function selectedIT(IT_JSON) {
		var id = $('#menu_admin').attr('data_id');
		$('#' + id).attr('IT_ID', IT_JSON.IT_ID);
		$('#' + id).attr('IT_TITLE', IT_JSON.TITLE);
		$('#' + id).attr('IT_PIC_URL', IT_JSON.PIC_URL);
		$('#' + id).attr('IT_PIC_ID', IT_JSON.PIC_ID);
		$('#' + id).attr('IT_AUTHOR', IT_JSON.AUTHOR);
		$('#' + id).attr('IT_CREATE_TIME', IT_JSON.CREATE_TIME);
		$('#' + id).attr('IT_COUNT', IT_JSON.IT_COUNT);

		$('#IT_ID').val(IT_JSON.IT_ID);
		$('#selectImage').attr('src', IT_JSON.PIC_URL);
		$('#selectTitle').html(IT_JSON.TITLE);
		$('#selectContent').html(
				"作者：" + IT_JSON.AUTHOR + "<br/>时间：" + IT_JSON.CREATE_TIME
						+ "<br/>数量：" + IT_JSON.IT_COUNT);
		$('#imageText').attr("style", "display:none");
		$('#selectedIT').removeAttr("style");
	}
	/**
	 *description：弹出层选择跳转图文信息后调用此方法。
	 *time：2015/11/25
	 *author：daiwk
	 */
	function selectedLocalIT(LOCAL_IT_JSON) {
		var id = $('#menu_admin').attr('data_id');
		$('#' + id).attr('LOCAL_IT_ID', LOCAL_IT_JSON.LOCAL_IT_ID);
		$('#' + id).attr('LOCAL_IT_TITLE', LOCAL_IT_JSON.LOCAL_IT_TITLE);
		$('#' + id).attr('LOCAL_IT_PIC_URL', LOCAL_IT_JSON.LOCAL_IT_PIC_URL);
		$('#' + id).attr('LOCAL_IT_CREATE_TIME', LOCAL_IT_JSON.LOCAL_IT_CREATE_TIME);

		$('#LOCAL_IT_ID').val(LOCAL_IT_JSON.LOCAL_IT_ID);
		$('#selectLocalImage').attr('src', LOCAL_IT_JSON.LOCAL_IT_PIC_URL);
		$('#selectLocalTitle').html(LOCAL_IT_JSON.LOCAL_IT_TITLE);
		$('#selectLocalContent').html(
				"时间：" + LOCAL_IT_JSON.LOCAL_IT_CREATE_TIME
						+ "<br/>");
		$('#localIT_tab').attr("style", "display:none");
		$('#selectedLocalIT').removeAttr("style");
	}
	/**
	 *description：判断上次编辑的是否保存。
	 *time：2015/11/25
	 *author：daiwk
	 */
	function checkSave(id) {
		var formState = $('#menu_admin').attr('formState');
		var saveState = $('#' + id).attr('saveState');
		if ('no' == formState) {
			if ('no' == saveState) {
				alert("请先保存之前编辑的页面");
				return false;
			} else if ('yes' == saveState || 'editor' == saveState) {
				return true;
			}
			return true;
		} else {
			return true;
		}
	}
	/**
	 *description：删除图文信息，删除图片，删除菜单。
	 *time：2015/11/25
	 *author：daiwk
	 */
	$(document).ready(function() {
						$("#deleteIT").click(function() {
							$('#selectedIT').attr("style", "display:none");
							$('#imageText').removeAttr("style");
							$('#IT_ID').val("");
						});
						$("#deleteLocalIT").click(function() {
							$('#selectedLocalIT').attr("style", "display:none");
							$('#localIT_tab').removeAttr("style");
							$('#LOCAL_IT_ID').val("");
						});
						$("#deleteImage").click(function() {
							$('#image').removeAttr("style");
							$('#selectedIT').attr("style", "display:none");
							$('#imageText').attr("style", "display:none");
							$('#showImageDiv').attr("style", "display:none");
							$('#PIC_URL').val("");
							$('#PIC_ID').val("");
						});
						$("#jsDelBt").click(function() {
											var data_id = $('#menu_admin').attr('data_id');
											var MENU_ID = $('#' + data_id).attr('MENU_ID');
											var menuid = $('#menu_admin').attr('menu');
											var SCD_MENU_GROUP_ID = $('#' + data_id).attr('SCD_MENU_GROUP_ID');
											BaseUtils.showWaitMsg();
											if (menuid == 'child') {
												if (!window.confirm('你确认要删除吗？')) {
													BaseUtils.hideWaitMsg();
													return false;
												}
												if ("" == MENU_ID || null == MENU_ID || undefined == MENU_ID) {
													window.location.href = "${ctx}/zdycd/home.do";
													/* $('#'+data_id).attr("style","display:none");
													if("00" == $('#'+data_id).attr('main_id')){
													  check0 --;
													}else if("10" == $('#'+data_id).attr('main_id')){
													  check1 --;
													}else if("20" == $('#'+data_id).attr('main_id')){
													  check2 --;
													} */
													BaseUtils.hideWaitMsg();
												} else {
													$.ajax({
																url : "${ctx}/zdycd/deleteMenu.do",
																type : "post",
																data : {
																	"MENU_ID" : MENU_ID
																},
																dataType : "json",
																success : function(data) {
																	//alert(data.msg);
																	if (data.flag) {
																		/* $('#'+data_id).attr("style","display:none");
																		var saveState = $('#'+data_id).attr("saveState");
																		if(saveState == 'editor'){
																			$('#menu_admin').attr('formState',"yes");
																			$('#menu_admin').attr("style","display:none");
																		} */
																		window.location.href = "${ctx}/zdycd/home.do";
																		//BaseUtils.hideWaitMsg();
																	} else {
																		BaseUtils.hideWaitMsg();
																	}
																}
															});
												}
											} else {
												if (!window.confirm('其子菜单也将删除，你确认要删除吗？')) {
													BaseUtils.hideWaitMsg();
													return false;
												}
												/* if("menu00" == data_id){
												  $('#imgAdd00').removeAttr("style");
												  $('#aText00').html("");
												}else if("menu10" == data_id){
												  $('#imgAdd10').removeAttr("style");
												  $('#aText10').html("");
												}else if("menu20" == data_id){
												  $('#imgAdd20').removeAttr("style");
												  $('#aText20').html("");
												} */

												if ("" != SCD_MENU_GROUP_ID || null != SCD_MENU_GROUP_ID || undefined != SCD_MENU_GROUP_ID) {
													$.ajax({
																url : "${ctx}/zdycd/deleteMenuByGroupId.do",
																type : "post",
																data : {
																	"MENU_ID" : MENU_ID,
																	"SCD_MENU_GROUP_ID" : SCD_MENU_GROUP_ID
																},
																dataType : "json",
																success : function(data) {
																	//alert(data.msg);
																	if (data.flag) {
																		window.location.href = "${ctx}/zdycd/home.do";
																		//BaseUtils.hideWaitMsg();
																	} else {
																		BaseUtils.hideWaitMsg();
																	}
																}
															});
												}

											}
											//
											/* 
											$('#menu_admin').attr('formState',"yes");
											$('#menu_admin').attr("style","display:none");
											$('#'+data_id).attr('data_text',"菜单名称");
											$('#'+data_id).attr('saveState',"no");
											$('#'+data_id).attr('MENU_ID',"");
											//$('#'+data_id).attr('RANK',"");
											$('#'+data_id).attr('SCD_MENU',"0"); //主菜单还是子菜单
											$('#'+data_id).attr('selectAction',"1");
											$('#'+data_id).attr('RESPONSE_ACTION',"1");
											$('#'+data_id).attr('SOURCE_URL',"");
											$('#'+data_id).attr('PIC_URL',"");
											$('#'+data_id).attr('SCD_MENU_GROUP_ID',"");
											$('#'+data_id).attr('IT_ID',"");
											$('#'+data_id).attr('IT_TITLE',"");
											$('#'+data_id).attr('IT_PIC_URL',"");
											$('#'+data_id).attr('IT_AUTHOR',"");
											$('#'+data_id).attr('IT_CREATE_TIME',"");
											$('#'+data_id).attr('IT_COUNT',""); */

										});
					});
	/**
	 *description：保存修改，更新。
	 *time：2015/11/25
	 *author：daiwk
	 */
	$(document).ready(function() {
		$("#saveMenu").click(function() {
						var id = $('#menu_admin').attr('data_id');
						var MENU = $('#menu_admin').attr('menu');
						var MENU_ID = $('#MENU_ID').val();
						var SCD_MENU_GROUP_ID = $('#SCD_MENU_GROUP_ID').val();
						var MENU_NAME = $('#MENU_NAME').val();
						var SCD_MENU = $('input:radio[name=SCD_MENU]:checked').val();
						var TRIGGER_ACTION = $('input:radio[name=TRIGGER_ACTION]:checked').val(); //1 触发图文   2触发url
						var RESPONSE_ACTION = $('#RESPONSE_ACTION').val();
						var SOURCE_URL = $('#SOURCE_URL').val();
						var IT_ID = $('#IT_ID').val();
						var PIC_URL = $('#PIC_URL').val();
						var PIC_ID = $('#PIC_ID').val();
						var RANK = $('#RANK').val();
						var SAYTEXT = $('#SAYTEXT').val();
						var LOCAL_IT_ID = $('#LOCAL_IT_ID').val();
						
						var text = $('#MENU_NAME').val();
						var text_byte = $("#MENU_NAME").val().replace(/[^\u0000-\u00ff]/g, "aa").length;
						if (text == "" || text == undefined) {
							alert("名称不能为空！");
							$('#MENU_NAME').attr('check_menu', 'stop');
							return false;
						} else if (text_byte > 8) {
							alert("名称不能超过4个字或8个字母！");
							$('#MENU_NAME').attr('check_menu', 'stop');
							return false;
						}
						
						if ('0' == SCD_MENU) {
							if (TRIGGER_ACTION == '2') {
								var check = /((http|ftp|https):\/\/)[^\s]/;
								if (!check.test($('#SOURCE_URL').val())) {
									alert("您输入的网址格式不对，请重新输入!");
									return false;
								}
							} else if (TRIGGER_ACTION == '1') {
								if ('10' == RESPONSE_ACTION) {
									if ("" == IT_ID || undefined == IT_ID || null == IT_ID) {
										alert("请添加一个图文信息！");
										return false;
									}
								} else if ('2' == RESPONSE_ACTION) {
									if ("" == PIC_URL || undefined == PIC_URL || null == PIC_URL) {
										alert("请添加一个图文信息！");
										return false;
									}
								}else if ('1' == RESPONSE_ACTION) {
									if ("" == SAYTEXT || undefined == SAYTEXT || null == SAYTEXT) {
										alert("请填写文字！");
										return false;
									}
								}else if ('4' == RESPONSE_ACTION) {
									if ("" == LOCAL_IT_ID || undefined == LOCAL_IT_ID || null == LOCAL_IT_ID) {
										alert("请添加图文跳转！");
										return false;
									}
								}
							}
						}
						if("1" == TRIGGER_ACTION){
							SOURCE_URL = "";
							LOCAL_IT_ID = "";
							if("10" == RESPONSE_ACTION){
								PIC_URL = "";
								PIC_ID = "";
								SAYTEXT = "";
							}else if("1" == RESPONSE_ACTION){
								IT_ID = "";
								PIC_URL = "";
								PIC_ID = "";
							}else if("2" == RESPONSE_ACTION){
								IT_ID = "";
								SAYTEXT = "";
							}
						}else if("2" == TRIGGER_ACTION){
							IT_ID = "";
							PIC_URL = "";
							PIC_ID = "";
							SAYTEXT = "";
							LOCAL_IT_ID = "";
						}else if("3" == TRIGGER_ACTION){
							IT_ID = "";
							PIC_URL = "";
							PIC_ID = "";
							SOURCE_URL = "";
							LOCAL_IT_ID = "";
						}else if("4" == TRIGGER_ACTION){
							IT_ID = "";
							PIC_URL = "";
							PIC_ID = "";
							SOURCE_URL = "";
						}
						BaseUtils.showWaitMsg();
						if ('admin' == MENU) {
							
							if ("" == MENU_ID || null == MENU_ID || undefined == MENU_ID) {
								
								$.ajax({
											url : "${ctx}/zdycd/saveAdminMenu.do",
											type : "post",
											data : {
												"MENU_ID" : MENU_ID,
												"MENU_NAME" : MENU_NAME,
												"SCD_MENU" : SCD_MENU,
												"TRIGGER_ACTION" : TRIGGER_ACTION,
												"RESPONSE_ACTION" : RESPONSE_ACTION,
												"SOURCE_URL" : SOURCE_URL,
												"RANK" : RANK,
												"IT_ID" : IT_ID,
												"LOCAL_IT_ID" : LOCAL_IT_ID,
												"PIC_URL" : PIC_URL,
												"PIC_ID" : PIC_ID,
												"SCD_MENU_GROUP_ID" : SCD_MENU_GROUP_ID,
												"SAYTEXT":SAYTEXT
											},
											dataType : "json",
											success : function(data) {
												if (data.flag) {
													//$('#menu_admin').attr('data_id',id);
													$('#menu_admin').attr('formState','yes');
													$('#'+ id).attr('MENU_ID',data.obj.MENU_ID);
													$('#MENU_ID').val(data.obj.MENU_ID);
													$('#'+ id).attr('data_text',MENU_NAME);
													$('#'+ id).attr('saveState','yse');
													$('#'+ id).attr('RANK',RANK);
													$('#'+ id).attr('SCD_MENU',SCD_MENU);
													$('#'+ id).attr('selectAction',TRIGGER_ACTION);
													$('#'+ id).attr('RESPONSE_ACTION',RESPONSE_ACTION);
													$('#'+ id).attr('SOURCE_URL',SOURCE_URL);
													$('#'+ id).attr('PIC_URL',PIC_URL);
													$('#'+ id).attr('PIC_ID',PIC_ID);
													$('#'+ id).attr('SCD_MENU_GROUP_ID',data.obj.SCD_MENU_GROUP_ID);
													$('#'+ id).attr('checkMenu','pass');
													$('#'+ id).attr('havechild','no');
													$('#'+ id).attr('on_off','off');

												}
												BaseUtils.hideWaitMsg();
												alert(data.msg);
											}
										});
							} else {
								$.ajax({
											url : "${ctx}/zdycd/updateAdminMenu.do",
											type : "post",
											data : {
												"MENU_ID" : MENU_ID,
												"MENU_NAME" : MENU_NAME,
												"SCD_MENU" : SCD_MENU,
												"TRIGGER_ACTION" : TRIGGER_ACTION,
												"RESPONSE_ACTION" : RESPONSE_ACTION,
												"SOURCE_URL" : SOURCE_URL,
												"RANK" : RANK,
												"IT_ID" : IT_ID,
												"LOCAL_IT_ID" : LOCAL_IT_ID,
												"PIC_URL" : PIC_URL,
												"PIC_ID" : PIC_ID,
												"SCD_MENU_GROUP_ID" : SCD_MENU_GROUP_ID,
												"SAYTEXT":SAYTEXT
											},
											dataType : "json",
											success : function(data) {
												
												if (data.flag) {
													//$('#menu_admin').attr('data_id',id);
													$('#menu_admin').attr('formState','yes');
													$('#'+ id).attr('MENU_ID',data.obj.MENU_ID);
													$('#'+ id).attr('data_text',MENU_NAME);
													$('#'+ id).attr('saveState','yse');
													$('#'+ id).attr('RANK',RANK);
													$('#'+ id).attr('SCD_MENU',SCD_MENU);
													$('#'+ id).attr('selectAction',TRIGGER_ACTION);
													$('#'+ id).attr('RESPONSE_ACTION',RESPONSE_ACTION);
													$('#'+ id).attr('SOURCE_URL',SOURCE_URL);
													$('#'+ id).attr('PIC_URL',PIC_URL);
													$('#'+ id).attr('PIC_ID',PIC_ID);
													$('#'+ id).attr('SCD_MENU_GROUP_ID',data.obj.SCD_MENU_GROUP_ID);
													$('#'+ id).attr('checkMenu','pass');
													$('#'+ id).attr('havechild','no');
													$('#'+ id).attr('on_off','off');

												}
												BaseUtils.hideWaitMsg();
												alert(data.msg);
											}
										});
							}

						} else if ('child' == MENU) {
							if ("" == MENU_ID || null == MENU_ID || undefined == MENU_ID) {
								$.ajax({
											url : "${ctx}/zdycd/saveChildMenu.do",
											type : "post",
											data : {
												"MENU_ID" : MENU_ID,
												"MENU_NAME" : MENU_NAME,
												"TRIGGER_ACTION" : TRIGGER_ACTION,
												"RESPONSE_ACTION" : RESPONSE_ACTION,
												"SOURCE_URL" : SOURCE_URL,
												"RANK" : RANK,
												"IT_ID" : IT_ID,
												"LOCAL_IT_ID" : LOCAL_IT_ID,
												"PIC_URL" : PIC_URL,
												"PIC_ID" : PIC_ID,
												"SCD_MENU_GROUP_ID" : SCD_MENU_GROUP_ID,
												"SAYTEXT":SAYTEXT
											},
											dataType : "json",
											success : function(data) {
												if (data.flag) {
														$('#menu_admin').attr('formState','yes');
														$('#'+ id).attr('MENU_ID',data.obj.MENU_ID);
														$('#'+ id).attr('data_text',MENU_NAME);
														$('#'+ id).attr('saveState','yse');
														$('#'+ id).attr('RANK',RANK);
														$('#'+ id).attr('SCD_MENU',SCD_MENU);
														$('#'+ id).attr('selectAction',TRIGGER_ACTION);
														$('#'+ id).attr('RESPONSE_ACTION',RESPONSE_ACTION);
														$('#'+ id).attr('SOURCE_URL',SOURCE_URL);
														$('#'+ id).attr('PIC_URL',PIC_URL);
														$('#'+ id).attr('PIC_ID',PIC_ID);
														$('#'+ id).attr('SCD_MENU_GROUP_ID',SCD_MENU_GROUP_ID);
														$('#'+ id).attr('checkMenu','pass');
														$('#'+ id).attr('on_off','off');
												}
												BaseUtils.hideWaitMsg();
												alert(data.msg);
											}
										});
							} else {
								$.ajax({
											url : "${ctx}/zdycd/updateChildMenu.do",
											type : "post",
											data : {
												"MENU_ID" : MENU_ID,
												"MENU_NAME" : MENU_NAME,
												"TRIGGER_ACTION" : TRIGGER_ACTION,
												"RESPONSE_ACTION" : RESPONSE_ACTION,
												"SOURCE_URL" : SOURCE_URL,
												"RANK" : RANK,
												"IT_ID" : IT_ID,
												"LOCAL_IT_ID" : LOCAL_IT_ID,
												"PIC_URL" : PIC_URL,
												"PIC_ID" : PIC_ID,
												"SCD_MENU_GROUP_ID" : SCD_MENU_GROUP_ID,
												"SAYTEXT":SAYTEXT
											},
											dataType : "json",
											success : function(data) {
												if (data.flag) {
														$('#menu_admin').attr('formState','yes');
														$('#'+ id).attr('MENU_ID',data.obj.MENU_ID);
														$('#'+ id).attr('data_text',MENU_NAME);
														$('#'+ id).attr('saveState','yse');
														$('#'+ id).attr('RANK',RANK);
														$('#'+ id).attr('SCD_MENU',SCD_MENU);
														$('#'+ id).attr('selectAction',TRIGGER_ACTION);
														$('#'+ id).attr('RESPONSE_ACTION',RESPONSE_ACTION);
														$('#'+ id).attr('SOURCE_URL',SOURCE_URL);
														$('#'+ id).attr('PIC_URL',PIC_URL);
														$('#'+ id).attr('PIC_ID',PIC_ID);
														$('#'+ id).attr('SCD_MENU_GROUP_ID',SCD_MENU_GROUP_ID);
														$('#'+ id).attr('checkMenu','pass');
														$('#'+ id).attr('on_off','off');
												}
												BaseUtils.hideWaitMsg();
												alert(data.msg);
											}
										});
							}
						}
					});
});
	function addHyperlink(){
		
		 layer.open({
				title : '超链接',
				type : 2,
				area : [ '486px', '250px' ],
				fix : false, //不固定
				offset : '100px',
				maxmin : true,
				shadeClose : true,
				content: '${ctx}/massfunction/addHyperlink.do'
			});
	 }
	 function addLink(urlName,urlLink){
		 var SAYTEXT = $("#SAYTEXT").val();
		 SAYTEXT = SAYTEXT +"<a href='"+urlLink+"'>"+urlName+"</a>";
		 $("#SAYTEXT").val(SAYTEXT);
	 }
	 
</script>

</head>
<body>
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
					<c:if test="${ exception.flag}">
					<p style="color: red; font-size: 16px !important">${exception.instruction }   <a onclick="deleteAllMenu();" style="font-size: 16px !important" href="">删除全部</a></p>
					</c:if>
				</div>
				<c:if test="${ exception.flag == null || !exception.flag}">
				<div>
					<div class="mobile_menu_preview" style="height: 560px;">
						<!--↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓3列菜单开始↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓-->
						<div class="btn3 clearfix">
							<!-- <div class="clearfix"> -->
							<div id="menu00" class="menu " data_text="菜单名称" saveState="no"
								MENU_ID="" RANK="0" SCD_MENU="0" selectAction="1"
								RESPONSE_ACTION="10" SOURCE_URL="" PIC_URL="" PIC_ID="" 
								LOCAL_IT_ID="" LOCAL_IT_TITLE="" LOCAL_IT_PIC_URL="" LOCAL_IT_CREATE_TIME=""
								SCD_MENU_GROUP_ID="" IT_ID="" IT_TITLE="" IT_PIC_URL="" IT_PIC_ID=""
								IT_AUTHOR="" IT_CREATE_TIME="" IT_COUNT="" checkMenu="pass"
								havechild="no" on_off="off" style="width:100%;display:none;">
								<div id="mainMuen00" class="bt-name" align="center"
									onclick="focusMenu('00')">
									<img id="imgAdd00" class="imageMainAdd"
										src="${ctx}/skin/newzdycd/images/add_002.png"> <a
										id="aText00"></a>
								</div>
								<!--  <div id="childMenu00"> -->
								<div id="triangle00" class="sanjiao"></div>
								<div id="child00" class="new-sub">
									<ul id="ul00">
										<li id="addChildMenu00" class="new-sub-li"
											onclick="addChildMenu('00','00')"><img
											class="imageChildAdd"
											src="${ctx}/skin/newzdycd/images/add_002.png"></li>

									</ul>
									<div class="tiggle"></div>
									<div class="innertiggle"></div>
								</div>
								<!-- </div> -->
							</div>
							<!--menu-->


							<div id="menu10" class="menu" data_text="菜单名称" saveState="no"
								MENU_ID="" RANK="1" SCD_MENU="0" selectAction="1"
								RESPONSE_ACTION="10" SOURCE_URL="" PIC_URL="" PIC_ID=""
								LOCAL_IT_ID="" LOCAL_IT_TITLE="" LOCAL_IT_PIC_URL="" LOCAL_IT_CREATE_TIME=""
								SCD_MENU_GROUP_ID="" IT_ID="" IT_TITLE="" IT_PIC_URL="" IT_PIC_ID=""
								IT_AUTHOR="" IT_CREATE_TIME="" IT_COUNT="" checkMenu="stop"
								havechild="no" on_off="off" style="display:none;">
								<div id="mainMuen10" class="bt-name" align="center"
									onclick="focusMenu('10')">
									<img id="imgAdd10" class="imageMainAdd"
										src="${ctx}/skin/newzdycd/images/add_002.png"> <a
										id="aText10"></a>
								</div>

								<div id="triangle10" class="sanjiao"></div>
								<div id="child10" class="new-sub">
									<ul id="ul10">
										<li id="addChildMenu10" class="new-sub-li"
											onclick="addChildMenu('10','10')"><img
											class="imageChildAdd"
											src="${ctx}/skin/newzdycd/images/add_002.png"></li>

									</ul>
									<div class="tiggle"></div>
									<div class="innertiggle"></div>
								</div>

							</div>
							<!--menu-->

							<div id="menu20" class="menu" data_text="菜单名称" saveState="no"
								MENU_ID="" RANK="2" SCD_MENU="0" selectAction="1"
								RESPONSE_ACTION="10" SOURCE_URL="" PIC_URL="" PIC_ID=""
								LOCAL_IT_ID="" LOCAL_IT_TITLE="" LOCAL_IT_PIC_URL="" LOCAL_IT_CREATE_TIME=""
								SCD_MENU_GROUP_ID="" IT_ID="" IT_TITLE="" IT_PIC_URL="" IT_PIC_ID=""
								IT_AUTHOR="" IT_CREATE_TIME="" IT_COUNT="" checkMenu="stop"
								havechild="no" on_off="off" style="display:none;">
								<div id="mainMuen20" class="bt-name" align="center"
									onclick="focusMenu('20')">
									<img id="imgAdd20" class="imageMainAdd"
										src="${ctx}/skin/newzdycd/images/add_002.png"> <a
										id="aText20"></a>
								</div>

								<div id="triangle20" class="sanjiao"></div>
								<div id="child20" class="new-sub">
									<ul id="ul20">
										<li id="addChildMenu20" class="new-sub-li"
											onclick="addChildMenu('20','20')"><img
											class="imageChildAdd"
											src="${ctx}/skin/newzdycd/images/add_002.png"></li>

									</ul>
									<div class="tiggle"></div>
									<div class="innertiggle"></div>
								</div>

							</div>
							<!--menu-->
						</div>
						<!--btn3-->
					</div>
					<div class="menu_form_area" style="height: 560px;">
						<div id="menu_admin" class="portable_editor" style="display:none;"
							menu="" editor_id="" data_id="" saveState="yes" formState="yse">
							<div>
								<div class="menu_form_hd">
									<div class="global_info">
										<h4>菜单名称</h4>
									</div>
									<div class="global_extra">
										<a id="jsDelBt" href="javascript:void(0);"
											style="margin-right: 6px;">删除菜单</a>
									</div>
								</div>
							</div>
							<form id="saveMenuForm" action="" method="post">
								<input id="MENU_ID" name="MENU_ID" type="hidden" value="">
								<input id="SCD_MENU_GROUP_ID" name="SCD_MENU_GROUP_ID" type="hidden" value=""> 
								<input id="RANK" name="RANK" type="hidden" value="">
								<input id="RESPONSE_ACTION" name="RESPONSE_ACTION" type="hidden" value="1">
								<div class="frm_control" style="margin-bottom: 10px;">
									<label class="frm_label"> <span class="frm_span">菜单名称
											:</span> <input id="MENU_NAME" name="MENU_NAME" check_menu="stop"
										class="frm_input" onblur="changeTitle()" type="text">
										<p class="frm_tips">字数不超过4个汉字8个字母</p>
									</label>
								</div>
								<div id="selectAdminMenu">
									<label class="frm_label"> <span class="frm_span">作为主菜单
											:</span> <label style="margin-right: 22px;"> <input
											id="SCD_MENU1" class="frm_radio" type="radio" name="SCD_MENU"
											value="1" onclick="AdminMenu('1')"> <span
											class="lbl_content">是</span>
									</label> <label> <input id="SCD_MENU0" class="frm_radio"
											type="radio" name="SCD_MENU" checked="checked" value="0"
											onclick="AdminMenu('0')"> <span class="lbl_content">否</span>
									</label>
									</label>
								</div>
								<div id="detailForm">
									<div class="frm_control" style="margin-top: 10px;">
										<div style="margin-bottom: 10px;">
											<div class="frm_label"> 
												<span class="frm_span">菜单内容:</span>
													<%-- <c:if test="${Authentication == '1'}">  --%>
													<label style="margin-right: 22px;"> 
														<input id="selectAction1" class="frm_radio" type="radio" name="TRIGGER_ACTION" checked="checked" value="1" onclick="selectAction('1')" /> 
														<span class="lbl_content">发送消息</span>
													</label> 
													<mytag:JspSecurity elementType="authentication">
													<label style="margin-right: 22px;"> 
														<input id="selectAction2" class="frm_radio" type="radio" name="TRIGGER_ACTION" value="2" onclick="selectAction('2')"> <span class="lbl_content">跳转网页</span>
													</label>
													<!-- <label style="margin-right: 22px;"> 
														<input id="selectAction3" class="frm_radio" type="radio" name="TRIGGER_ACTION" value="3" onclick="selectAction('3')"> <span class="lbl_content">跳转微网站</span>
													</label> -->
													<label> 
														<input id="selectAction4" class="frm_radio" type="radio" name="TRIGGER_ACTION" value="4" onclick="selectAction('4')"> <span class="lbl_content">本地图文跳转</span>
													</label>
													</mytag:JspSecurity>
													<%-- </c:if>
													<c:if test="${Authentication != '1'}">
													<label style="margin-right: 22px;"> 
														<input id="selectAction1" class="frm_radio" type="radio" name="TRIGGER_ACTION" checked="checked" value="1" onclick="selectAction('1')" /> 
														<span class="lbl_content">发送消息</span>
													</label>
													</c:if> --%>
											</div>
										</div>
										<div id="URL" class="menu_content" style="display:none;">
											<label class="frm_label"> <span class="frm_span">URL地址:</span>
												<input id="SOURCE_URL" name="SOURCE_URL" class="frm_input"
												type="text" value="">
												<p class="frm_tips">请按照格式输入，如：http://www.baidu.com</p>
											</label>
										</div>
										<!-- <div id="WAP" class="menu_content" style="display:none;">
											<label class="frm_label"> <span class="frm_span">URL地址:</span>
												<input id="SOURCE_URL" name="SOURCE_URL" class="frm_input"
												type="text" value="">
												<p class="frm_tips">请按照格式输入，如：http://www.baidu.com</p>
											</label>
										</div> -->
										<div id="MESSAGE" class="msg_sender">
								           <div class="msg_tab">
								               <div class="tab_navs_panel">
											       <span class="tab_navs_switch_wrp switch_prev js_switch_prev">
											           <span class="tab_navs_switch"></span>
											       </span>
											       <span class="tab_navs_switch_wrp switch_next js_switch_next">
											           <span class="tab_navs_switch"></span>
											       </span>
								
								                   <div class="tab_navs_wrp">
								                       <ul class="tab_navs js_tab_navs" style="margin-left:0;">
														       
								                           <li id="imageText_li" name="imageText" class="tab_nav tab_appmsg width5 selected" data-type="10" data-tab=""
								                               data-tooltip="图文消息">
								                               <a href="javascript:void(0);" onclick="selectContent(10)">&nbsp;<i
								                                       class="icon_msg_sender"></i><span class="msg_tab_title">图文消息</span></a>
								                           </li>
															<mytag:JspSecurity elementType="authentication">
								                           <li id="text_li" name="text_li" class="tab_nav tab_text width5" data-type="1" data-tab="" data-tooltip="文字">
								                               <a href="javascript:void(0);" onclick="selectContent(1);">&nbsp;<i
								                                       class="icon_msg_sender"></i><span class="msg_tab_title">文字</span></a>
								                           </li>
															</mytag:JspSecurity>
								                           <li id="image_li" name="image" class="tab_nav tab_img width5" data-type="2" data-tab="" data-tooltip="图片">
								                               <a href="javascript:void(0);" onclick="selectContent(2)">&nbsp;<i
								                                       class="icon_msg_sender"></i><span class="msg_tab_title">图片</span></a>
								                           </li>
								
								                           <!-- <li class="tab_nav tab_audio width5" data-type="3" data-tab=".js_audioArea"
								                               data-tooltip="语音">
								                               <a href="javascript:void(0);" onclick="return false;">&nbsp;<i
								                                       class="icon_msg_sender"></i><span class="msg_tab_title">语音</span></a>
								                           </li>
								
								                           <li class="tab_nav tab_video width5 no_extra" data-type="15" data-tab=".js_videoArea"
								                               data-tooltip="视频">
								                               <a href="javascript:void(0);" onclick="return false;">&nbsp;<i
								                                       class="icon_msg_sender"></i><span class="msg_tab_title">视频</span></a>
								                           </li> -->
								
								                       </ul>
								                   </div>
								               </div>
								               <div class="tab_panel">
								
								                   <div id="imageText_tab" class="tab_content">
								                       <div class="js_appmsgArea inner ">
								                           <!-- type 10图文 2图片  3语音 15视频 11商品消息 -->
															<input id="IT_ID" name="IT_ID" type="hidden" value="">		
								                           <div id="imageText" class="tab_cont_cover jsMsgSendTab" data-index="0">
								                               <div class="media_cover" style="">
											           				 <span class="create_access">
											               				 <a class="add_gray_wrp jsMsgSenderPopBt" href="javascript:;" onclick="selectIT('id')" data-type="10" data-index="0">
									                               			<i class="icon36_common add_gray"></i>
									                             			<strong>从素材库中选择</strong>
									                           			 </a>
											            			</span>
								                               </div>
								                               <div class="media_cover" style="">
														            <span class="create_access">
											                           <a  class="add_gray_wrp" onclick="addIT('id')"
											                              href="javascript:;">
											                               <i class="icon36_common add_gray"></i>
											                               <strong>新建图文消息</strong>
											                           </a>
								                           
														                <!-- <a target="_blank" href="/cgi-bin/appmsg?t=media/appmsg_edit&action=edit&type=10&isMul=0&isNew=1&lang=zh_CN&token=1074094956"><i class="icon_shopmsg_create"></i><strong>单图文消息</strong></a>
														                <a target="_blank" href="/cgi-bin/appmsg?t=media/appmsg_edit&action=edit&type=10&isMul=1&isNew=1&lang=zh_CN&token=1074094956"><i class="icon_shopmsg_create multi"></i><strong>多图文消息</strong></a> -->
												                          
														            </span>
								                               </div>
								                           </div>
							                               <div id="selectedIT" style="display: none;">
							                                   <div class="appmsg " >
							                                       <div class="appmsg_content">
							                                           <h4 class="appmsg_title js_title">
							                                               <a id="selectTitle" target="_blank"
							                                                  href=""></a>
							                                           </h4>
							
							                                           <!-- <div class="appmsg_info">
							                                               <em class="appmsg_date">20:13</em>
							                                           </div>  -->
							                                           <div class="appmsg_thumb_wrp">
							                                               <img id="selectImage"  class="appmsg_thumb" style="height: 100%;width: 100%;" alt="" src="">
							                                           </div>
							                                           <!-- <p class="appmsg_desc">123123</p> -->
							                                       </div>
							                                   </div>
							                                   <a class="jsmsgSenderDelBt link_dele" id="deleteIT" data-type="10"
							                                      href="javascript:;">删除</a>
							                               </div>
								                           
								
								                       </div>
								                   </div> 
												   <div id="editor_text" class="tab_content" style="display:none;">
								                       <div class="js_textArea inner no_extra">
								                           <div class="emotion_editor">
								                               <div style="display: none;" class="edit_area js_editorArea"></div>
								                               <!-- <div style="overflow-y: auto; overflow-x: hidden;" class="edit_area js_editorArea1"
								                                     contenteditable="true"> -->
						                                     <div style="overflow-y: auto; overflow-x: hidden;" class="edit_area js_editorArea1"> 
								                                   <textarea id="SAYTEXT" name="SAYTEXT" class="textarea" rows="" cols="" style="border: 0px"></textarea>
								                               </div>
								                                <div class="editor_toolbar" style="height: 37px;">
																	<span class="emotion" style="margin-left: 151px;">
								                                    <a href="javascript:void(0);" class="icon_emotion emotion_switch js_switch">表情</a>
								                                    </span>
								                                    <span class="" style="margin-left: 151px;">
								                                    <a href="javascript:void(0);" style="margin-left: 20px;" onclick="addHyperlink()" class="icon88_common emotion_switch js_switch">超链接</a>
																	</span>
								
								                                    <!-- <p class="editor_tip opr_tips">，按下Shift+Enter键换行</p> -->
								
								                                    <p class="editor_tip js_editorTip">最多<em>600</em>字</p>
								
								                                    <div class="emotion_wrp js_emotionArea">
								                                    	<span class="hook">
																			<span class="hook_dec hook_top"></span>
																			<span class="hook_dec hook_btm"></span>
																		</span>
								                                        <ul class="emotions" onselectstart="return false;"></ul>
								                                        <span class="emotions_preview js_emotionPreviewArea"></span>
								                                    </div>
								                                </div>
								                            </div>
								
								                        </div>
								                    </div>
								                   
								
								                    <div id="image_tab" class="tab_content">
								                    	<input id="PIC_URL" name="PIC_URL" type="hidden" value="">
								                    	<input id="PIC_ID" name="PIC_ID" type="hidden" value="">
								                       <div id="image" class="js_imgArea inner" style="display:none;">
								                           <!--type 10图文 2图片  3语音 15视频 11商品消息-->
								
								                           <div class="tab_cont_cover jsMsgSendTab" data-index="2" data-type="2">
								                               <div class="media_cover">
										            <span class="create_access">
										                <a id="selectPicture" class="add_gray_wrp jsMsgSenderPopBt" href="javascript:;" data-type="2" data-index="2">
								                               <i class="icon36_common add_gray"></i>
								                               <strong>从素材库中选择</strong>
								                           </a>
										            </span>
								                               </div>
								                               <div class="media_cover">
										            <span class="create_access">
										                <a id="uploadPicture" class="add_gray_wrp"  data-type="2" href="javascript:;">
								                               <i class="icon36_common add_gray"></i>
								                               <strong>上传图片</strong>
								                           </a>
										            </span>
								                               </div>
								                           </div>
															
								                       </div>
								                       <div id="showImageDiv" style="display:none;">
						                                   <div class="appmsg " data-fileid="" data-id="">
						                                       <div class="appmsg_content" style="padding: 14px;">
						                                           <div class="appmsg_thumb_wrp">
						                                               <img id="showImage" style="width:100%;height:100%;" class="appmsg_thumb" alt=""
						                                                    src="">
						                                           </div>
						                                       </div>
						                                   </div>
						                                   <a class="jsmsgSenderDelBt link_dele" data-type="10"
						                                      href="javascript:;" id="deleteImage">删除</a>
						                               </div>
								                   </div>
								
								                   <!-- <div style="display: none;" class="tab_content">
								                       <div class="js_audioArea inner ">
								                           type 10图文 2图片  3语音 15视频 11商品消息
								
								                           <div class="tab_cont_cover jsMsgSendTab" data-index="3" data-type="3">
								                               <div class="media_cover">
										            <span class="create_access">
										                <a class="add_gray_wrp jsMsgSenderPopBt" href="javascript:;" data-type="3" data-index="3">
								                               <i class="icon36_common add_gray"></i>
								                               <strong>从素材库中选择</strong>
								                           </a>
										            </span>
								                               </div>
								                               <div class="media_cover">
										            <span class="create_access">
										                <a class="add_gray_wrp " id="msgSendAudioUploadBt" href="javascript:;">
								                               <i class="icon36_common add_gray"></i>
								                               <strong>新建语音</strong>
								                           </a>
										            </span>
								                               </div>
								                           </div>
								
								                       </div>
								                   </div> -->
								
								                   <!-- <div style="display: none;" class="tab_content">
								                       <div class="js_videoArea inner ">
								                           type 10图文 2图片  3语音 15视频 11商品消息
								
								                           <div class="tab_cont_cover jsMsgSendTab" data-index="4">
								                               <div class="media_cover">
										            <span class="create_access">
										                <a class="add_gray_wrp jsMsgSenderPopBt" href="javascript:;" data-type="15" data-index="4">
								                               <i class="icon36_common add_gray"></i>
								                               <strong>从素材库中选择</strong>
								                           </a>
										            </span>
								                               </div>
								                               <div class="media_cover">
										            <span class="create_access">
										                <a target="_blank" class="add_gray_wrp"
								                              href="https://mp.weixin.qq.com/cgi-bin/appmsg?t=media/videomsg_edit&amp;action=video_edit&amp;type=15&amp;lang=zh_CN&amp;token=1074094956">
								                               <i class="icon36_common add_gray"></i>
								                               <strong>新建视频</strong>
								                           </a>
										            </span>
								                               </div>
								                           </div>
								
								                       </div>
								                   </div> -->
								
								               </div>
								           </div>
								       </div>
								       <div id="LocalML" class="msg_sender" style="display: none;">
								           <div class="msg_tab">
								               <div class="tab_panel">
								                   <div  class="tab_content">
								                       <div class="js_appmsgArea inner ">
								                           <!-- type 10图文 2图片  3语音 15视频 11商品消息 -->
															<input id="LOCAL_IT_ID" name="LOCAL_IT_ID" type="hidden" value="">		
								                           <div id="localIT_tab" class="tab_cont_cover jsMsgSendTab" data-index="0">
								                               <div class="media_cover" style="">
											           				 <span class="create_access">
											               				 <a class="add_gray_wrp jsMsgSenderPopBt" href="javascript:;" onclick="selectLocalIT('id')" data-type="10" data-index="0">
									                               			<i class="icon36_common add_gray"></i>
									                             			<strong>从本地素材库中选择</strong>
									                           			 </a>
											            			</span>
								                               </div>
								                               <div class="media_cover" style="">
														            <span class="create_access">
											                           <a  class="add_gray_wrp" onclick="addLocalIT('id')"
											                              href="javascript:;">
											                               <i class="icon36_common add_gray"></i>
											                               <strong>新建图文消息</strong>
											                           </a>
														            </span>
								                               </div>
								                           </div>
							                               <div id="selectedLocalIT" style="display: none;">
							                                   <div class="appmsg " >
							                                       <div class="appmsg_content">
							                                           <h4 class="appmsg_title js_title">
							                                               <a id="selectLocalTitle" target="_blank"
							                                                  href=""></a>
							                                           </h4>
							
							                                           <!-- <div class="appmsg_info">
							                                               <em class="appmsg_date">20:13</em>
							                                           </div>  -->
							                                           <div class="appmsg_thumb_wrp">
							                                               <img id="selectLocalImage"  class="appmsg_thumb" style="height: 100%;width: 100%;" alt="" src="">
							                                           </div>
							                                           <!-- <p class="appmsg_desc">123123</p> -->
							                                       </div>
							                                   </div>
							                                   <a class="jsmsgSenderDelBt link_dele" id="deleteLocalIT" href="javascript:;">删除</a>
							                               </div>
								                       </div>
								                   </div> 
								               </div>
								           </div>
								       </div>
									</div>
								</div>
								<div class="bottom_button">
									<input id="saveMenu" type="button" class="xinbutton"
										value="保存修改" />&nbsp;&nbsp;&nbsp;&nbsp;
									<!-- <input type="button" class="xinbutton" onclick="setMenu()" value="删除菜单" /> -->
								</div>
							</form>
						</div>
					</div>
				</div>
				<div class="save_del_button">
					<!--<div class="xinsearchleft">-->
					<input type="button" class="xinbutton" onclick="publishMenu()"
						value="生成自定义菜单" />&nbsp;&nbsp;&nbsp;&nbsp;
					<!--</div>-->
					<input type="button" class="xinbutton" onclick="repealMenu()"
						value="撤销自定义菜单" />
				</div>
				</c:if>
			</div>
		</div>
	
</body>
<!-- <script language="javascript" for="window" event="onload"> -->
<script type="text/javascript">
	function updateMenuRank() {
		for (var i = 0; i <= 2; i++) {
			var MENU_ID = $('#menu' + i + '0').attr('MENU_ID');
			//alert(MENU_ID);
			var RANK = $('#menu' + i + '0').attr('RANK');
			if ("" != MENU_ID && null != MENU_ID && undefined != MENU_ID) {
				$.ajax({
					url : "${ctx}/zdycd/updateMenuRank.do",
					type : "post",
					data : {
						"MENU_ID" : MENU_ID,
						"RANK" : RANK
					},
					dataType : "json",
					success : function(data) {
					}
				});
			}
		}
	};
	function addIT() {
		window.open("${ctx}/ml/newMainAddMessage.do");
	}
	function addLocalIT() {
		//window.open("${ctx}/ml/newMainAddMessage.do");
	}
	function publishMenu(){
		BaseUtils.showWaitMsg();
		$.ajax({
			url : "${ctx}/zdycd/publishMenu.do",
			type : "post",
			data : {},
			dataType : "json",
			success : function(data) {
				BaseUtils.hideWaitMsg();
				if (data.flag) {
					alert(data.msg);
				}else{
					alert("操作失败，请稍后再试！");
				}
			}
			
		});
	}
	function repealMenu(){
		BaseUtils.showWaitMsg();
		$.ajax({
			url : "${ctx}/zdycd/repealMenu.do",
			type : "post",
			data : {},
			dataType : "json",
			success : function(data) {
				BaseUtils.hideWaitMsg();
				if (data.flag) {
					alert(data.msg);
				}else{
					alert("操作失败，请稍后再试！");
				}
			}
			
		});
	}
	function deleteAllMenu(){
		BaseUtils.showWaitMsg();
		$.ajax({
			url : "${ctx}/zdycd/deleteAllMenu.do",
			type : "post",
			data : {},
			dataType : "json",
			success : function(data) {
				//alert(data.msg);
				if (data.flag) {
					window.location.href = "${ctx}/zdycd/home.do";
					//BaseUtils.hideWaitMsg();
				} else {
					BaseUtils.hideWaitMsg();
				}
			}
		});
	}
	$(document).ready(function(){
		  $("#selectPicture").click(function(){
			  layer.open({
					title : '选择图文信息',
					type : 2,
					area : [ '840px', '480px' ],
					fix : false, //不固定
					offset : '50px',
					maxmin : true,
					shadeClose : true,
					shade : 0.8,
					content: '${ctx}/picUpload/forSelectQueryPage.do'
				});
		  
		  });
		  
	});
	function selectedPIC(PIC_JSON){
		$('#PIC_URL').val(PIC_JSON.PIC_URL_FWQ);
		$('#PIC_ID').val(PIC_JSON.PIC_ID);
		$('#image').attr("style", "display:none");
		$('#selectedIT').attr("style", "display:none");
		$('#imageText').attr("style", "display:none");
		$('#showImageDiv').removeAttr("style");
		$('#showImage').attr('src', PIC_JSON.PIC_URL_FWQ);	  
	}
	/* document.onreadystatechange = function()
	{
	   
	        if (document.readyState == "complete")
	        {
	        	updateMenuRank();
	        }
	}
	 */
</script>
<!--qq表情  -->
<script  src="${ctx}/skin/common/js/browser.js"></script>
<script type="text/javascript" src="${ctx}/skin/qqface/js/jquery.qqFace.js"></script>
<script type="text/javascript" >
$(function(){
	$('.emotion').qqFace({
		id : 'facebox', 
		assign:'SAYTEXT', 
		path:'${ctx}/skin/qqface/arclist/'	//表情存放的路径
	});
	/* $(".sub_btn").click(function(){
		var str = $("#saytext").val();
		$("#show").html(replace_em(str));
	}); */
});
//查看结果
/* function replace_em(str){
	str = str.replace(/\</g,'&lt;');
	str = str.replace(/\>/g,'&gt;');
	str = str.replace(/\n/g,'<br/>');
	str = str.replace(/\[em_([0-9]*)\]/g,'<img src="${ctx}/skin/qqface/arclist/$1.gif" border="0" />');
	return str;
} */
</script>
<!--end  -->
</html>
