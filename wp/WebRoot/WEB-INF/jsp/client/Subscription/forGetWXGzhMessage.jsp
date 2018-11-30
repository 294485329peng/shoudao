<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
 <head>
 	<%@ include file="../../common/common_header.jsp"%>
 	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
 	<link href="${ctx}/skin/skinExample/css/defStyle.css" rel="stylesheet" type="text/css" />
 	<!--控件样式  -->
	<link rel="stylesheet" href="${ctx}/skin/common/css/elementStyle.css"/>
	<!--end  -->
 	<%-- <link href="${ctx}/skin/skinExample/css/select.css" rel="stylesheet" type="text/css" /> --%>
 	<script type="text/javascript" src="${ctx}/skin/skinExample/js/jquery.idTabs.min.js"></script>
	<script type="text/javascript" src="${ctx}/skin/skinExample/js/select-ui.min.js"></script>
	<link rel="stylesheet" href="${ctx}/skin/common/css/elementStyle.css"/>
	<script type="text/javascript">
	/* $(document).ready(function(e) {
	    $(".select1").uedSelect({
			width : 120			  
		});
		$(".select2").uedSelect({
			width : 167  
		});
		$(".select3").uedSelect({
			width : 100
		});
	}); */
	$(document).ready(function(){
		$('#addGZH').click(function(){
			var validateRule = [
			        			{id:"GZH_NAME",message:"公众号名称不能为空！",contentType:"length",size:"20"},
			        			{id:"GZH_ID",message:"公众号原始id不能为空！",contentType:"length",size:"40"},
			        			{id:"GZH_WECHAT_ID",message:"微信号不能为空！",contentType:"length",size:"30"},
			        			{id:"GZH_APPID",message:"AppID不能为空！",contentType:"length",size:"40"},
			        			{id:"GZH_APPSECRET",message:"AppSecret不能为空！",contentType:"length",size:"40"},
			        			{id:"GZH_TOKEN",message:"TOKEN不能为空！",contentType:"length",size:"40"},
			        			{id:"GZH_PASSWORD",message:"公众号密码不能为空！",contentType:"length",size:"20"},
			               	];
			BaseUtils.showWaitMsg();
			if(!formValidationFun(validateRule)) return;
			$.ajax({
		        url: $("#frm").attr("action"),
		        type:"post",
		        data:  $("#frm").serialize(),
		        success: function(data) {
		        	BaseUtils.hideWaitMsg();
					alert(data.msg);
		        }
		    });
		});
		$('#bonding').click(function(){
			var validateRule = [
			        			{id:"GZH_ID",message:"公众号原始id不能为空！",contentType:"length",size:"40"},
			        			{id:"GZH_PASSWORD",message:"公众号密码不能为空！",contentType:"length",size:"20"},
			               	];
			BaseUtils.showWaitMsg();
			$.ajax({
		        url: $("#bondingFrm").attr("action"),
		        type:"post",
		        data:  $("#bondingFrm").serialize(),
		        success: function(data) {
		        	BaseUtils.hideWaitMsg();
					alert(data.msg);
		        }
		    });
		});
	});
	function addNewGZH(){
		$("#newGZH").addClass("zero_btn_primary");
		$("#bondingGZH").removeClass("zero_btn_primary");
		$("#usual1").removeAttr("style");
		$("#usual2").attr("style", "display:none");
		
	}
	function bondingGZH(){
		$("#bondingGZH").addClass("zero_btn_primary");
		$("#newGZH").removeClass("zero_btn_primary");
		$("#usual2").removeAttr("style");
		$("#usual1").attr("style", "display:none");
	}
	</script>
  <title>公众号信息</title>  
 </head>
 <body>
 <div style="height: 100%">
    <div class="youkuangjia">
        <div class="modstitle">
            <h3>公众号信息</h3>
        </div>
        <div class="mcontent" style="border: 0px;">
            <!-- <div class="alert">
                <p>注意：1级菜单最多只能开启3个，2级子菜单最多开启5个!</p>
                <p>生成自定义菜单,必须在已经保存的基础上进行,临时勾选启用点击生成是无效的! 第一步必须先修改保存状态！第二步点击生成!</p>
                <p>当您为自定义菜单填写链接地址时请填写以"http://"开头，这样可以保证用户手机浏览的兼容性更好</p>
                <p>撤销自定义菜单：撤销后，您的微信公众帐号上的自定义菜单将不存在；如果您想继续在微信公众帐号上使用自定义菜单，请点击“生成自定义菜单”按钮，将重新启用！</p> 
            </div> -->
    
    		<div class="formbody"  style="padding-left: 0px;border:1px solid #e4e4e4; ">
				<!-- <div style="margin-top: 15px; margin-left: 28px; margin-bottom: 0px; border-bottom: 1px solid #e4e4e4; padding-bottom: 15px;">
    				<input id="newGZH" type="button" class="zero_btn zero_btn_primary" onclick="addNewGZH();" value="添加新公众号" />&nbsp;&nbsp;&nbsp;
   					<input id="bondingGZH" type="button" class="zero_btn " onclick="bondingGZH();" value="绑定已有公众号" />
    			</div> -->
			    <div id="usual1" class="usual"> 
   
				  	<div id="tab1" class="tabson">
					<form id="frm" name="frm" action="" method="post">
				    <ul class="forminfo">
					    <li><label><b>*</b>公众号名称：</label><input id="GZH_NAME" readonly="readonly" name="GZH_NAME" value="${record.GZH_NICK_NAME }" type="text" class="dfinput" style="width:518px;"/></li>
					   	<li><label><b>*</b>公众号原始id：</label><input id="GZH_ID" readonly="readonly" name="GZH_ID" value="${record.GZH_ID }" type="text" class="dfinput" style="width:518px;"/><i>请认真填写，错了不能修改。比如：gh_abf28c1d4f65</i></li>
					   	<li><label><b>*</b>微信号：</label><input id="GZH_WECHAT_ID" readonly="readonly" name="GZH_WECHAT_ID" value="${record.GZH_WECHAT_ID }" type="text" class="dfinput" style="width:518px;"/><i>比如：WeiqiMobile </i></li>
					   	<li><label><b>*</b>AppID（公众号）：</label><input id="GZH_APPID" readonly="readonly" name="GZH_APPID" value="${record.GZH_APPID }" type="text" class="dfinput" style="width:518px;"/><i>用于自定义菜单等高级功能，可以不填 </i></li>
					   	<li><label><b>*</b>AppSecret：</label><input id="GZH_APPSECRET" readonly="readonly" name="GZH_APPSECRET" value="${record.GZH_APPSECRET }" type="text" class="dfinput" style="width:518px;"/><i>用于自定义菜单等高级功能，可以不填 </i></li>
					   	<li><label><b>*</b>TOKEN：</label><input id="GZH_TOKEN" readonly="readonly" name="GZH_TOKEN" value="${record.GZH_APPSECRET }" type="text" class="dfinput" style="width:518px;"/><i>用于自定义菜单等高级功能，可以不填 </i></li>
					    <li><label><b>*</b>公众号密码：</label><input id="GZH_PASSWORD" readonly="readonly" name="GZH_PASSWORD" value="${record.GZH_PASSWORD }" type="password" class="dfinput" style="width:518px;"/><i>设定公众号密码 </i></li>
					    <li><label><b>*</b>微信号类型：</label>  
					
					    <div class="vocation"> 
						    <select id="GZH_AUTH_TYPE" name="GZH_AUTH_TYPE" class="zero-select-base zero-select" style="width:130px; margin-bottom: 2px;" onfocus="this.defaultIndex=this.selectedIndex;" onchange="this.selectedIndex=this.defaultIndex;">
							    <option value="1" ${record.GZH_AUTH_TYPE == '10'? 'selected="selected"': '' }>未认证订阅号</option>
							    <option value="1" ${record.GZH_AUTH_TYPE == '11'? 'selected="selected"': '' }>认证订阅号</option>
							    <option value="2" ${record.GZH_AUTH_TYPE == '20'? 'selected="selected"': '' }>未认证服务号</option>
							    <option value="3" ${record.GZH_AUTH_TYPE == '21'? 'selected="selected"': '' }>认证服务号</option>    
						    </select>
					    </div>
					    
					    </li>  
					  <!-- 	<li><label><b>&nbsp;</b>AppID（服务窗）:</label><input id="GZH_APPID" name="GZH_APPID" type="text" class="dfinput" style="width:518px;"/></li> -->
					    <!-- <li><label>&nbsp;</label><input id="addGZH" name="addGZH" type="button" class="btn" value="添加公众号" style="margin-top: 20px;"/></li> -->
				    </ul>
				    </form>
				    </div> 
  
				</div> 

    		</div>
         	
		</div>
	</div>
</div>
</body>
</html>