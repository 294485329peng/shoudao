<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html >
  <head>
    <base href="<%=basePath%>">
    
    <title>图文信息管理</title>

        <meta http-equiv="pragma" content="no-cache">
        <meta http-equiv="cache-control" content="no-cache">
        <meta http-equiv="expires" content="0">
        <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
        <meta http-equiv="description" content="This is my page">
  		<%@ include file="../../common/common_header.jsp"%>
        <script type="text/javascript">
        function cfAction(){
       	document.getElementById("respURL").style.display= "none";
		$("#xydz").attr("readonly","readonly");
		document.getElementById("xydz").style.background = "#F0F0F0";
		var CFDZ=$("#CFDZ").val();
		var ZCDMC=$("#ZCDMC").val();
		layer.open({
			title:'响应动作',
		    type: 2,
		    area: ['700px', '320px'],
		    fix: false, //不固定
		    maxmin: true,
		    shadeClose: true,
		    shade: 0.8,
		    content: '${ctx}/zdycd/xydz.do?CFDZ='+CFDZ+'&ZCDMC='+ZCDMC,
		}); 
		
		} 
        function forUpdateIT(IM_ID){
			window.location.href="${ctx}/ml/forUpdateIT.do?IM_ID="+IM_ID;
        }
		function forAddIT(){
				window.location.href="${ctx}/ml/forShowAddMessage.do";		
		}
		/* function updata(){
			window.location.href="${ctx}/ml/updataImageText.do";
		} */
        </script>
        <%-- <link href="${ctx}/skin/zdycd/css/zdycd.css"  rel="stylesheet" /> --%>

    </head>
    <body>
    <div>
        <div class="youkuangjia">
            <div class="modstitle">
                <h3>图文信息列表</h3>
            </div>
            <div class="mcontent" >
                <div class="alert" >
                    <!-- <p>注意：1级菜单最多只能开启3个，2级子菜单最多开启5个!</p>
                    <p>只有保存主菜单后才可以添加子菜单</p>
                    <p>生成自定义菜单,必须在已经保存的基础上进行,临时勾选启用点击生成是无效的! 第一步必须先修改保存状态！第二步点击生成!</p>
                    <p>当您为自定义菜单填写链接地址时请填写以"http://"开头，这样可以保证用户手机浏览的兼容性更好</p>
                    <p>撤销自定义菜单：撤销后，您的微信公众帐号上的自定义菜单将不存在；如果您想继续在微信公众帐号上使用自定义菜单，请点击“生成自定义菜单”按钮，将重新启用！</p>  -->
                </div>

                <div style="margin-bottom: 7px;">
			<form id="queryForm" action="${ctx}/acRole/forQueryPage.do" method="post">
				
						名称：
						<input type="text" name="ROLE_NAME" value="${record.ROLE_NAME }" style="height: 21px; width: 170px;"/>&nbsp;
						
					
							<input onclick="$('#queryForm').submit();" id="search" type="button" class="xinbutton" value="查  询" />&nbsp; 
							<input onclick="forAddIT()" id="add" type="button" class="xinbutton" value="添  加" />&nbsp; 
							
				
			</form>
	</div>	
	<div>
	<table class="tablelist">
				<tr>
					<th width="5%"><input class="formcheckbox" type="checkbox" id="checkAll" /></th>
					<th width="10%" align="center">编号&nbsp;&nbsp;<i class="sort"><img src="${ctx}/skin/default/images/px.gif" /></i></th>
					<th width="35%" align="center">标题</th>
					<th width="20%" align="center">作者</th>
					<th width="20%" align="center">创建时间</th>
					<th width="10%" align="center">操作</th>
				</tr>
				<%-- <c:forEach var="r" items="${pageView.records}" varStatus="status"> --%>
					<tr>
						<td ><input class="formcheckbox" type="checkbox" name="check"  /></td>
						<td >${(pageView.pageNow - 1) * pageView.pageSize + status.index + 1}</td>
						<td >${r.ROLE_NAME }</td>
						
						<td >${r.CREATE_TIME }</td>
						<td > &nbsp;<input id="choseKeyword" name="choseKeyword" type="button" value="编&nbsp辑" onclick="update('editor','${r.IM_ID}')"/>
							&nbsp;&nbsp;<input id="choseKeyword" name="choseKeyword" type="button" value="删&nbsp除" onclick="delete('${r.IM_ID}')"/></td>
						<%-- <a href="javascript:forAcFuncCheckTree('${r.ROLE_ID}','${r.APP_ID}');"></a>  --%>
					</tr>
					<tr>
						<td>1111</td>
						<td>1111</td>
						<td>1111</td>
						<td>1111</td>
						<td>1111</td>
					</tr>
					<tr>
						<td>1111</td>
						<td>1111</td>
						<td>1111</td>
						<td>1111</td>
						<td>1111</td>
					</tr>
					<tr>
						<td>1111</td>
						<td>1111</td>
						<td>1111</td>
						<td>1111</td>
						<td>1111</td>
					</tr>
					<tr>
						<td>1111</td>
						<td>1111</td>
						<td>1111</td>
						<td>1111</td>
						<td>1111</td>
					</tr>
				
			</table>
			<%@ include file="../../common/pagination_tail.jsp"%>
	</div>
                <div class="axinsearch" >
                    <button class="xinbutton" onclick="addMenuItem()">保存</button>&nbsp;&nbsp;&nbsp;&nbsp;
                    <button class="xinbutton"  onclick="goBeck()">取消</button>
                </div>
            </div>
        </div>
    </div>
    </body>
    </html>
