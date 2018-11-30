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
   
    
    function addMenu(){
    	window.location.href="${ctx}/zdycd/addMenu.do";
    }
    function changeMenu(){
    	
    }
    function saveMenu(){
    	
    }
    function deleteMenu(msgId){
		if(window.confirm("您确定要删除此菜单吗？")){
			$.post(
				'${ctx}/deleteMsg.html',
				{msgId:msgId},
				function(data){
					if(data == 'success'){
						window.location.href='${ctx}/msgSendList.html?msgSendtype=1';
					}
				},
				"text"
			);
			return true;
		}else{
			return false;
		}
	}
       function selectAllCheckBox(){
           var chose;
           if(document.getElementById("chose").checked){
               chose = document.getElementById("chose").checked;
           }
           var checkboxArray = document.getElementsByName("check");
           if(checkboxArray != null){
               for(var i=0; i<checkboxArray.length; i++){
                   checkboxArray[i].checked = chose;
               }
           }
       } 
      </script>
    <%-- <link href="${ctx}/skin/zdycd/css/zdycd.css"  rel="stylesheet" /> --%>
	</head>
	<body>
	<form id="#" name="fenye" action="" method="post">
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
	       		<!-- <div>请在微信公众平台开启自定义菜单！</div> -->
	            <div class="xinsearch">
	                <div class="xinsearchleft">
	                    <!--)主题：<input name="msgTitle" class="xininput" style="width:200px" type="text" value="${msgDto.msgTitle}" />&nbsp;&nbsp;-->
	                    <button class="xinbutton" onclick="addMenu();return false;" >添加主菜单</button>&nbsp;&nbsp;&nbsp;&nbsp;<!-- 请在微信公众平台开启自定义菜单！ -->
	                    <!--<input type="button" class="xinbutton" value="重置" onclick="clearText(" />-->
	                </div>
	                <div class="xinsearchright">
	                    <!-- <input type="button" class="xinbutton" value="全部删除" onclick="deleteAllCheck()" /> -->
	                </div>
	                <div class="clearboth"></div>
	            </div>
	            <table width="100%" class="xintable" border="0" cellspacing="0" cellpadding="0">
	                <tr>
	                    <td width="10" align="center" class="xintablebg">显示排序  </td>
	                    <td width="22%" align="center" class="xintablebg">菜单名称</td>
	                    <td width="18%" align="center" class="xintablebg">触发动作</td>
	                    <td width="22%" align="center" class="xintablebg">相应动作</td>
	                    <td width="7%" align="center" class="xintablebg">
	                        <!--<input id="chose" type="checkbox" name="checkbox" onclick="selectAllCheckBox()" />-->
	                       	 启用
	                    </td>
	                    <td width="21%" align="center" class="xintablebg">操作</td>
	                </tr>
	         
	               <%--  <c:forEach var="msg" items="${pageView.records}" varStatus="vs"> --%>
	                    <tr>
	                        <td align="center">
	                            <!-- <input class="xininput" type="text" ata-rule-number="true" value="0" style="width:80%;" name="new[sort][1]"> -->
	                            <select class="xininput" name="new[action][1]" style="width: 80%;">
	                            	<option data-url="/news/list?aid=55614007" data-text="选择图文信息" data-val="1" selected="" value="1">1</option>
	                                <option data-url="/news/list?aid=55614007" data-text="跳转到图文信息页" data-val="2" value="2">2</option>
	                                <option data-url="/news/keyword?aid=55614007" data-text="选择关键词" data-val="3" value="3">3</option>
	                            </select>
	                        </td>
	                        <td align="center">
	                            <input class="xininput" type="text" name=""  value="${msg.msgId}"  style="width:80%;"/>
	                            <!--<a href="javascript:void(0)" title="${msg.msgTitle}">${msg.msgTitle}</a>-->
	                        </td>
	                        <td align="center">
	                            <select class="xininput" name="new[action][1]" style="width: 90%; background-color:#F0F0F0;">
	                                <option data-url="/news/list?aid=55614007" data-text="选择图文信息" data-val="1" selected="" value="1">发送信息</option>
	                                <option data-url="/news/list?aid=55614007" data-text="跳转到图文信息页" data-val="2" value="2">跳转到图文信息页</option>
	                                <option data-url="/news/keyword?aid=55614007" data-text="选择关键词" data-val="3" value="3">触发关键词</option>
	                                <option data-info="new" data-val="4" value="4">跳转链接</option>
	                            </select> 
	                            <%-- <input class="xininput2" type="text" name=""  readonly= "true " value="${msg.msgId}"  style="width:80%;"/> --%>
	                        </td>
	                        <td align="center">
	                        	<input class="xininput2" type="text" name=""  readonly= "true " value="${msg.msgId}"  style="width:90%;"/>
	                        </td>
	                        <td align="center">
	                            <input type="checkbox" name="check" value="${msg.msgId}" />
	                        </td>
	                        <td align="center">
	                            <%-- <a href="javascript:void(0)" style="color:blue" onclick="saveMenu('${id}')">保&nbsp;存 </a> |
	                            <a href="javascript:void(0)" style="color:blue" onclick="changeMenu('${id}')">修&nbsp;改</a> |
	                            <a href="javascript:void(0)" style="color:blue">生成二级菜单</a> |
	                            <!--<a href="${ctx}/deleteMsg.html?msgId=${msg.msgId}" style="color:blue" onclick='if(confirm("您确定要删除此封邮件吗？")){return true;}else{return false;}'>删除</a>-->
	                            <a href="javascript:void(0);" style="color:blue" onclick="deleteMenu('${msg.msgId}');">删&nbsp;除</a> --%>
	                            <button >保&nbsp;存</button>&nbsp;&nbsp;
	                            <button>生成二级菜单</button>&nbsp;&nbsp;
	                            <button>删&nbsp;除</button>
	                            
	                        </td>
	                    </tr>
	                <%-- </c:forEach> --%>
	             
	            </table>
	            <div class="axinsearch" >
	                <!--<div class="xinsearchleft">-->
	                <button class="xinbutton" onclick="setMenu()">生成自定义菜单</button>&nbsp;&nbsp;&nbsp;&nbsp;
	                <!--</div>-->
	                <button class="xinbutton"  onclick="repealMenu()">撤销自定义菜单</button>
	            </div>
	        </div>
	    </div>
	</form>
	</body>
</html>
