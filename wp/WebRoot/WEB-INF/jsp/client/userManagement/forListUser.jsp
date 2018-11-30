<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
 <head>
 	<%@ include file="../../common/common_header.jsp"%>
 	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
 	<link href="${ctx}/skin/skinExample/css/select.css" rel="stylesheet" type="text/css" />
 	<link rel="stylesheet" type="text/css" href="${ctx}/skin/userManagement/css/umStyle.css">
 	<script type="text/javascript" src="${ctx}/skin/skinExample/js/jquery.idTabs.min.js"></script>
	<script type="text/javascript" src="${ctx}/skin/skinExample/js/select-ui.min.js"></script>
	<script type="text/javascript">
	function openSelectDiv(id){
		alert("抱歉，功能还在添加！");
		/* $("#"+id).attr("style", "display:block"); */
		//alert("1");
	}
	document.onmouseup=function(){
		//alert("2");
		$(".jsDropdownList").attr("style", "display:none");
	}
	function selectGroup(id,name){
		var oldName = $("#"+id).html();
		if(oldName == name){
			return false;
		}
		$("#"+id).html(name);
		$(".jsDropdownList").attr("style", "display:none");
	}
	$(document).ready(function(){
		$('#addGZH').click(function(){
			$.ajax({
		        url: $("#frm").attr("action"),
		        type:"post",
		        data:  $("#frm").serialize(),
		        success: function(data) {
		        	alert("操作完成!");
		        }
		    });
		});
	});
	function addGroupLayer() {
		layer.open({
		    type: 1,
		    title: false,
		    closeBtn: 0,
		    area : [ '400px', '180px' ],
		    shadeClose: true,
		    skin: 'yourclass',
		    content: $('#group')
		}); 
	}
	function closeLayer(){
		layer.closeAll();
		$("#addGroupText").val("");
	}
	function addGroup(){
		var addGroupText = $("#addGroupText").val();
		var addGroupTextLength = $("#addGroupText").val().length;
		if (addGroupTextLength > 6) {
			alert("请在6个字符以内");
			return false;
		}
		$("#addGroupDl").append(
				"<dd class=\"inner_menu_item \" id=\"\">"
					
                +"<a href=\"\" class=\"inner_menu_link\" title=\""+addGroupText+"\">"

                   + "<strong>"+addGroupText+"</strong><em class=\"num\">(0)</em>"
                +"</a>"
            +"</dd>"
				);
		layer.closeAll();
		$("#addGroupText").val("");
	}
	$(document).ready(function(){
		var t1;
		$(".imgselectjquery").mouseenter(function(){
			window.clearInterval(t1); 
			var top = $(this).offset().top;
			var left = $(this).offset().left;
			left = left + 53;
			$("#userInfo_display").css({"top":top,"left":left});
			$("#userInfo_display").css("display","");
			/* 执行一个ajax
			$("#info_loading").css("display","none");
			$("#info_show").css("display","block"); */
		});
		$(".imgselectjquery").mouseleave(function(){
			t1 = window.setInterval("$('#userInfo_display').css('display','none');",2000); 
				
		});
	});
	</script>
  <title>用户管理</title>  
 </head>
 <body>
 <div style="height: 100%">
    <div class="youkuangjia">
        <div class="modstitle">
            <h3>用户管理</h3>
        </div>
        <div class="mcontent" style="border: 0px;">
            <div class="alert">
                <p>注意：对您的粉丝进行分组管理。</p>
                <!-- <p>生成自定义菜单,必须在已经保存的基础上进行,临时勾选启用点击生成是无效的! 第一步必须先修改保存状态！第二步点击生成!</p>
                <p>当您为自定义菜单填写链接地址时请填写以"http://"开头，这样可以保证用户手机浏览的兼容性更好</p>
                <p>撤销自定义菜单：撤销后，您的微信公众帐号上的自定义菜单将不存在；如果您想继续在微信公众帐号上使用自定义菜单，请点击“生成自定义菜单”按钮，将重新启用！</p>  -->
            </div>
    		
		    <div class = "main_bd">
		        <div class="global_mod user_global_opr float_layout">
		            <div class="global_info">
		                <div class="search_bar" id="searchBar">
		                    <input placeholder="用户昵称" class="frm_input_box search with_del append" type="text">
		                    <a href="javascript:;" style="padding-left: 0px; padding-right: 0px;" class="btn btn_primary btn_add">搜索</a>
		                 </div>
		            </div>
		            <div class="global_extra">
		                <a onclick="addGroupLayer();" href="javascript:;" data-y="3" class="btn btn_primary btn_add" id="js_groupAdd"><i class="icon14_common add_white"></i>新建分组</a>
		            </div>
		        </div>
		
		
		        <div class="inner_container_box side_r cell_layout ">
		            <div class="inner_main">
		                <div class="bd">
		
		                    <div class="global_mod user_group_opr">
		                        <span class="group_name" id="js_groupName">全部用户</span>
		                    </div>
		                    <div class="table_wrp user_list">
		                        <table class="table" cellspacing="0">
		                            <thead class="thead">
		                            <tr >
		                                <th class="table_cell user no_extra" colspan="2">
		                                    <div class="group_select">
		                                        <label for="selectAll" class="group_select_label frm_checkbox_label">
		                                            <input type="checkbox" style="vertical-align: text-bottom; margin-bottom: 2.5px; margin-right: 8px;"/>
		                                            <input class="frm_checkbox" id="selectAll" type="checkbox">全选
		                                        </label>&nbsp;
		                                        <div id="allGroup" class="dropdown_wrp dropdown_menu disabled"><a href="javascript:;" onclick="openSelectDiv('selectFZ');" class="btn dropdown_switch jsDropdownBt"><label class="jsBtLabel" id="select_label">添加到</label><i class="arrow"></i></a>
		                                            <div id="selectFZ" style="display: none;" class="dropdown_data_container jsDropdownList">
		                                                <ul class="dropdown_data_list">
		
		
		                                                    <li class="dropdown_data_item ">
		                                                        <a onclick="selectGroup('select_label','默认组');" href="javascript:;" class="jsDropdownItem" data-name="默认组">默认组</a>
		                                                    </li>
		
		                                                    <li class="dropdown_data_item ">
		                                                        <a onclick="selectGroup('select_label','星标组');" href="javascript:;" class="jsDropdownItem" data-value="2" data-index="1" data-name="星标组">星标组</a>
		                                                    </li>
		
		                                                    <li class="dropdown_data_item ">
		                                                        <a onclick="selectGroup('select_label','234');" href="javascript:;" class="jsDropdownItem" data-value="100" data-index="2" data-name="234">234</a>
		                                                    </li>
		
		
		                                                </ul>
		                                            </div>
		                                        </div>
		                                        <a class="btn btn_default btn_disabled js_allToBlackList_btn" data-gid="0" href="javascript:;">加入黑名单</a>
		                                    </div>
		                                </th>
		                            </tr>
		                            </thead>
		                            <tbody class="tbody" id="userGroups">
		
		                            <c:forEach var="r" items="${pageView.records}" varStatus="status">
		                            <tr id="tr_id_${status.index}">
		                                <td class="table_cell user">
		                                    <div class="user_info" user-info="">  <!--个人信息区-->
		
		                                        <a href="" class="remark_name">${r.NICKNAME }</a>
		                                        <span class="nick_name" ></span>
		                                        <a target="_blank" href="" class="avatar">
		                                            <img id="img_user_${status.index}" NICKNAME= "${r.NICKNAME }" 
		                                            onclick="userChat('${r.OPEN_ID}');"  src="${r.HEADIMGURL }" class="js_msgSenderAvatar imgselectjquery">
		                                        </a>
		                                        <label  class="frm_checkbox_label"><input type="checkbox"/><input class="frm_checkbox js_select" value="" id="" type="checkbox"></label>
		                                    </div>
		                                </td>
		
		                                <td class="table_cell user_opr">
		                                    <div id="div_id_${status.index}" class="js_selectArea dropdown_menu" ><a onclick="openSelectDiv('selectFZ_${status.index}');" href="javascript:;" class="btn dropdown_switch jsDropdownBt"><label id="select_label_${status.index}" class="jsBtLabel">默认组</label><i class="arrow"></i></a>
		                                        <div id="selectFZ_${status.index}" style="display: none;" class="dropdown_data_container jsDropdownList">
		                                            <ul class="dropdown_data_list">
		
		
		                                                <li class="dropdown_data_item ">
		                                                    <a onclick="selectGroup('select_label_${status.index}','默认组');" href="javascript:;" class="jsDropdownItem" data-value="0" data-index="0" data-name="默认组">默认组</a>
		                                                </li>
		
		                                                <li class="dropdown_data_item ">
		                                                    <a onclick="selectGroup('select_label_${status.index}','星标组');" href="javascript:;" class="jsDropdownItem" data-value="2" data-index="1" data-name="星标组">星标组</a>
		                                                </li>
		
		                                                <li class="dropdown_data_item ">
		                                                    <a onclick="selectGroup('select_label_${status.index}','234');" href="javascript:;" class="jsDropdownItem" data-value="100" data-index="2" data-name="234">234</a>
		                                                </li>
		
		
		                                            </ul>
		                                        </div>
		                                    </div>
		
		                                    <!-- <a class="btn btn_default dn js_deleteToBlackList_btn" data-gid="1" data-fakeid="oxVgHw_CDI5d9ryPAxULCBf8gCkQ" href="javascript:;" style="display:none;">移出黑名单</a> -->
		                                    <a class="btn remark js_msgSenderRemark" >修改备注</a>
		                                </td>
		                            </tr>
		                            </c:forEach>
		                            
		                            <!-- <tr >
		                                <td class="table_cell user">
		                                    <div class="user_info">  个人信息区
		
		                                        <a target="_blank" href="https://mp.weixin.qq.com/cgi-bin/singlesendpage?t=message/send&amp;action=index&amp;tofakeid=oxVgHw_CDI5d9ryPAxULCBf8gCkQ&amp;token=2097602769&amp;lang=zh_CN" class="remark_name" data-fakeid="oxVgHw_CDI5d9ryPAxULCBf8gCkQ">DiZero</a>
		                                        <span class="nick_name" data-fakeid="oxVgHw_CDI5d9ryPAxULCBf8gCkQ"></span>
		
		                                        <a target="_blank" href="https://mp.weixin.qq.com/cgi-bin/singlesendpage?t=message/send&amp;action=index&amp;tofakeid=oxVgHw_CDI5d9ryPAxULCBf8gCkQ&amp;token=2097602769&amp;lang=zh_CN" class="avatar">
		                                            <img src="user_files/getheadimg" data-fakeid="oxVgHw_CDI5d9ryPAxULCBf8gCkQ" class="js_msgSenderAvatar">
		                                        </a>
		                                        <label for="checkoxVgHw_CDI5d9ryPAxULCBf8gCkQ" class="frm_checkbox_label"><i class="icon_checkbox"></i><input class="frm_checkbox js_select" value="oxVgHw_CDI5d9ryPAxULCBf8gCkQ" id="checkoxVgHw_CDI5d9ryPAxULCBf8gCkQ" type="checkbox"></label>
		                                    </div>
		                                </td>
		
		                                <td class="table_cell user_opr">
		                                    <div id="selectAreaoxVgHw_CDI5d9ryPAxULCBf8gCkQ" class="js_selectArea dropdown_menu" data-gid="0" data-fid="oxVgHw_CDI5d9ryPAxULCBf8gCkQ"><a href="javascript:;" class="btn dropdown_switch jsDropdownBt"><label class="jsBtLabel">默认组</label><i class="arrow"></i></a>
		                                        <div style="display: none;" class="dropdown_data_container jsDropdownList">
		                                            <ul class="dropdown_data_list">
		
		
		                                                <li class="dropdown_data_item ">
		                                                    <a onclick="return false;" href="javascript:;" class="jsDropdownItem" data-value="0" data-index="0" data-name="默认组">默认组</a>
		                                                </li>
		
		                                                <li class="dropdown_data_item ">
		                                                    <a onclick="return false;" href="javascript:;" class="jsDropdownItem" data-value="2" data-index="1" data-name="星标组">星标组</a>
		                                                </li>
		
		                                                <li class="dropdown_data_item ">
		                                                    <a onclick="return false;" href="javascript:;" class="jsDropdownItem" data-value="100" data-index="2" data-name="234">234</a>
		                                                </li>
		
		
		                                            </ul>
		                                        </div>
		                                    </div>
		
		                                    <a class="btn btn_default dn js_deleteToBlackList_btn" data-gid="1" data-fakeid="oxVgHw_CDI5d9ryPAxULCBf8gCkQ" href="javascript:;" style="display:none;">移出黑名单</a>
		                                    <a class="btn remark js_msgSenderRemark" data-fakeid="oxVgHw_CDI5d9ryPAxULCBf8gCkQ">修改备注</a>
		                                </td>
		                            </tr> -->
		                            
		                            
		                           
		
		                            </tbody>
		                            
		                        </table>
		                        
		                        
		                        <%-- <div style="cursor: pointer;vertical-align: bottom;bottom: 5px;">
							    	<%@ include file="../../common/pagination_tail.jsp"%>
							    </div> --%>
							    
		                    </div>     
		                </div>
		                <div style="border-top:1px solid #e7e7eb; width:100%; height:auto;">
							<%@ include file="../../common/pagination_tail.jsp"%>		
						</div>
		            </div>
		            <div class="inner_side">
		                <div class="bd">
		                    <div class="group_list">
		                        <div class="inner_menu_box" id="groupsList"><dl id="addGroupDl" class="inner_menu">
		                            <dt class="inner_menu_item">
		                                <a href="" class="inner_menu_link" title="全部用户">
		                                    <strong>全部用户</strong><em class="num">(1)</em>
		                                </a>
		                            </dt>
		
		
		
		                            <dd class="inner_menu_item selected">
		
		
		                                <a href="" class="inner_menu_link" title="默认组">
		
		                                    <strong>默认组</strong><em class="num">(1)</em>
		                                </a>
		                            </dd>
		
		
		                            <dd class="inner_menu_item " id="group2">
		
		
		                                <a href="" class="inner_menu_link" title="加入该分组中的用户仅作为更重要的用户归类标识">
		
		                                    <strong>星标组</strong><em class="num">(0)</em>
		                                </a>
		                            </dd>
		
		
		                            <dd class="inner_menu_item " id="group100">
		
		
		                                <a href="" class="inner_menu_link" title="234">
		
		                                    <strong>234</strong><em class="num">(0)</em>
		                                </a>
		                            </dd>
		
		
		                        </dl>
		
		
		                            <dl class="inner_menu no_extra">
		                                <dt class="inner_menu_item">
		                                    <a href="https://mp.weixin.qq.com/cgi-bin/contactmanage?t=user/index&amp;pagesize=20&amp;pageidx=0&amp;type=0&amp;groupid=1&amp;token=2097602769&amp;lang=zh_CN" class="inner_menu_link" title="黑名单">
		                                        <strong>黑名单</strong><em class="num">(0)</em>
		                                    </a>
		                                </dt>
		                            </dl>
		                        </div>
		                    </div>
		                </div>
		            </div>
		        </div>
		
		    </div>
    		
    		
  <!--  -->       	
		</div>
	</div>
</div>
<div id="group" style="display:none;">
		<div  class="popover_inner">
		    <div class="popover_content jsPopOverContent">
		    <h4 style="margin-top: 20px; margin-left: 30px;">分组名称 </h4>
		    <input id="addGroupText" class="frm_input js_name" type="text" style="margin-left: 30px; height: 25px; margin-top: 10px;" value="" placeholder="">
		    </div>
		    <div class="popover_bar" style="margin-top: 30px; margin-left: 30px;">
		    <a onclick="addGroup();" class="btn btn_primary jsPopoverBt" href="javascript:;">确定</a>
		    <a onclick="closeLayer();" class="btn btn_default jsPopoverBt" href="javascript:;" style="margin-left: 20px;">取消</a>
		    </div>
		    </div>
		
</div>
<div id="userInfo_display" class="rich_buddy popover arrow_left" style="display:none;opacity: 1; ">
	<div class="popover_inner">
		<div class="popover_content">
			<div class="rich_buddy_hd">详细资料</div>
			<div id="info_loading" class="loadingArea rich_buddy_loading" style="display: ;">
				<span class="vm_box"></span>
				<i class="icon_loading_small white"></i>
			</div>
			<div id="info_show" class="rich_buddy_bd buddyRichContent" style="display: none;">
				<div class="frm_control_group nickName">
					<label class="frm_label">在维护</label>
					<div class="frm_controls frm_vertical_pt">
						<span class="icon18_common man_blue"></span>
					</div>
				</div>
				<div class="frm_control_group remark">
					<label class="frm_label">备注名</label>
					<div class="frm_controls frm_vertical_pt"> 无备注</div>
					
				</div>
				<div class="frm_control_group location">
					<label class="frm_label">地区</label>
					<div class="frm_controls frm_vertical_pt"> 西班牙 巴塞罗那 </div>
				</div>
				<div class="frm_control_group sign">
					<label class="frm_label">签名</label>
					<div class="frm_controls frm_vertical_pt">　在维护 </div>
				</div>
				<div class="frm_control_group sign">
					<label class="frm_label">标签</label>
					<div class="frm_controls frm_vertical_pt"> 无标签 </div>
				</div>
				<div class="extra_btn_group">
					<a class="btn btn_default js_popAddToBlackList" href="javascript:;" data-id="o686owUKjX3GxBoZFwY7PZOoTTrA">加入黑名单</a>
				</div>
			
			</div>
		</div>
	</div>
	<i class="popover_arrow popover_arrow_out"></i>
	<i class="popover_arrow popover_arrow_in"></i>
</div>

</body>
</html>
