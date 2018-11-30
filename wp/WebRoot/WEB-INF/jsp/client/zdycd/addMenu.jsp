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
        <script type="text/javascript">
        function cfAction(select){
        	$("#XYDZ").attr("readonly","true");
        	$("#XYDZ").attr("placeholder","");
    		$("#XYDZ").css("background-color","#F0F0F0");
        	if(select == '0'){
        		$("#XZDZ").attr("data-text","0");
        		$("#XZDZ").attr("value","请选择动作");
        	}else if(select == '1'){
        		$("#XZDZ").attr("data-text","1");
        		$("#XZDZ").attr("value","选择信息");
        	}else if(select == '2'){
        		$("#XZDZ").attr("data-text","2");
        		$("#XZDZ").attr("value","选择图文信息");
        	}else if(select == '3'){
        		$("#XZDZ").attr("data-text","3");
        		$("#XZDZ").attr("value","选择关键词");
        	}else if(select == '4'){
        		$("#XZDZ").attr("data-text","4");
        		$("#XZDZ").attr("value","填写URL");
        		$("#XYDZ").removeAttr("readonly");
        		$("#XYDZ").attr("placeholder","请输入正确的URL");
        		$("#XYDZ").css("background-color","#FFF");
        	}
        	
        }
        
       function xzAction(){
    	var data = document.getElementById("XZDZ").getAttribute("data-text");
    	if(data == "0"){
    		return false;
    	}
       //document.getElementById("respURL").style.display= "none";
		//$("#XYDZ").attr("readonly","readonly");
		//document.getElementById("XYDZ").style.background = "#F0F0F0";
		//var CFDZ=$("#CFDZ").val();
		var ZCDMC=$("#ZCDMC").val();
		layer.open({
			title:'响应动作',
		    type: 2,
		    area: ['700px', '320px'],
		    fix: false, //不固定
		    maxmin: true,
		    shadeClose: true,
		    shade: 0.8,
		    content: '${ctx}/zdycd/XYDZ.do?CFDZ='+data+'&ZCDMC='+ZCDMC,
		}); 
		
		}  
		function addMenuItem(){
			if($("#CFDZ").val()=="0")
			{
				alert("请选择触发动作!");
				return;
			}
			var validateRule = [
			        			{id:"ZCDMC",message:"菜单不能为空！"},
			        			{id:"XYDZ",message:"响应动作不能为空！"}
			               	];
			BaseUtils.showWaitMsg();
			if(!formValidationFun(validateRule)) return;
			$.ajax({
						url : $("#zdycdForm").attr("action"),
						type : "post",
						data : $("#zdycdForm").serialize(),
						dataType : "json",
						success : function(data) {
							//var ret = jQuery.parseJSON(data);
							BaseUtils.hideWaitMsg();
							alert(data.msg);
							if (data.flag) {
								window.location.href="${ctx}/zdycd/home.do";
							}
						}
					});
		}
		function cancel()
		{
			window.location.href="${ctx}/zdycd/home.do"; 
		}
        </script>
        <%-- <link href="${ctx}/skin/zdycd/css/zdycd.css"  rel="stylesheet" /> --%>

    </head>
    <body>
    <div style="height: 100%">
    <form id="zdycdForm" name="zdycdForm" action="${ctx }/zdycd/saveMenu.do" method="post">
        <div class="youkuangjia">
            <div class="modstitle">
                <h3>自定义菜单</h3>
            </div>
            <div class="mcontent">
                <div class="alert">
                    <p>注意：1级菜单最多只能开启3个，2级子菜单最多开启5个!</p>
                    <p>只有保存主菜单后才可以添加子菜单</p>
                    <p>生成自定义菜单,必须在已经保存的基础上进行,临时勾选启用点击生成是无效的! 第一步必须先修改保存状态！第二步点击生成!</p>
                    <p>当您为自定义菜单填写链接地址时请填写以"http://"开头，这样可以保证用户手机浏览的兼容性更好</p>
                    <p>撤销自定义菜单：撤销后，您的微信公众帐号上的自定义菜单将不存在；如果您想继续在微信公众帐号上使用自定义菜单，请点击“生成自定义菜单”按钮，将重新启用！</p> 
                </div>

                <table width="100%" class="xintable" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td align="right" style="width: 91px;" >主菜单名称：</td>
                        <td><input type="text" class="input_reg" name="ZCDMC" id="ZCDMC"  value="${record.ZCDMC }"></input></td>
                    </tr>
                    <tr>
                        <td align="right">触发动作：</td>
                        <td>	
                        	<select class="xininput" name="CFDZ" id="CFDZ" style="width: 170px;" onchange="cfAction(this.value)">
                        		<!-- <option  selected="" value="0" onclick="cfAction()">请选择</option>
                                <option  value="1" onclick="cfAction()">发送信息</option>
                                <option  value="2" onclick="cfAction()">跳转到图文信息页</option>
                                <option  value="3" onclick="cfAction()">触发关键词</option>
                                <option  value="4" onclick="cfURL()">跳转链接</option> -->
                                <option  selected="" value="0">请选择</option>
                                <option  value="1" >发送信息</option>
                                <option  value="2" >跳转到图文信息页</option>
                                <option  value="3" >触发关键词</option>
                                <option  value="4" >跳转链接</option>
                            </select> 
                       	</td>
                    </tr>
                    <tr>
                    	<td align="right">选择动作：</td>
                    	<td >
                    		<input name="XZDZ" id="XZDZ" type="button" data-text="0" class="ibtn" value="请选择动作" onclick="xzAction()"></input>                  			
                    	</td>
                    </tr>
                    <tr>
                    	<%-- <input type="hidden" name="OPERATOR_ID" value="${record.OPERATOR_ID }" /> --%>
                    	<td align="right">响应动作：</td>
                    	<td >
                    		<input name="XYDZ" id="XYDZ" type="text"   class="input_reg" readonly="readonly" style="background-color:#F0F0F0"></input>                  		
                    		<!-- <em id="respURL" style="display:none;">&nbsp;请输入正确URL</em> -->
                    		
                    	</td>
                    </tr>
                </table>
                <div class="axinsearch" >
                    <input  type="button" value="保存" class="xinbutton" onclick="addMenuItem()"></button>&nbsp;&nbsp;&nbsp;&nbsp;
                    <input  type="button" class="xinbutton"  value="取消" onclick="cancel();return false;"></button>
                </div>
            </div>
        </div>
    </form>
    </div>
    </body>
    </html>
