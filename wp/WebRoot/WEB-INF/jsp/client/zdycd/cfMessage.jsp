<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>发送信息</title>
<meta http-equiv="X-UA-Compatible" content="IE=8" />
<%@ include file="../../common/common_header.jsp"%>
<script type="text/javascript" src="${ctx}/script/common/formValidation.js"></script>
<script type="text/javascript">
	var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
	function formSave() {
		var validateRule = [
		        			
		        			{id:"CDURL",message:"URL不能为空！"}
		               	];
		BaseUtils.showWaitMsg(); 
		if(!formValidationFun(validateRule)) return;
		$.ajax({
					url : $("#saveForm").attr("action"),
					type : "post",
					data : $("#saveForm").serialize(),
					dataType : "json",
					success : function(data) {
						
						var ZCDMC = $("#ZCDMC").val();
						BaseUtils.hideWaitMsg();
						alert(data.msg);
						//alert(data.obj.ZCDMC);
						if (data.flag) {
							parent.window.location.href="${ctx}/zdycd/addMenu.do?ZCDMC"+ZCDMC;
							//parent.pageNow('${pageNow}');
							parent.layer.close(index);
						}
					}
				}); 
	}
	function addMessage(){
		parent.window.location.href="${ctx}/zdycd/home.do";
		//parent.pageNow('${pageNow}');
		parent.layer.close(index);
	}
</script>
<style>

</style>
</head>
<body>
<div class="right_con">
	<div>
			<form id="queryForm" action="${ctx}/acRole/forQueryPage.do" method="post">
				
						名称：
						<input type="text" name="ROLE_NAME" value="${record.ROLE_NAME }" style="height: 21px; width: 170px;"/>&nbsp;
						
					
							<input onclick="$('#queryForm').submit();" id="search" type="button" class="xinbutton" value="查  询" />&nbsp; 
							<input onclick="addMessage()" id="add" type="button" class="xinbutton" value="添  加" />&nbsp; 
							
				
			</form>
	</div>	
	<div>
	<table class="tablelist">
				<tr>
					<th width="5%"><input class="formcheckbox" type="checkbox" id="checkAll" /></th>
					<th width="10%" align="center">编号&nbsp;&nbsp;<i class="sort"><img src="${ctx}/skin/default/images/px.gif" /></i></th>
					<th width="55%" align="center">信息名称</th>
					
					<th width="20%" align="center">创建时间</th>
					<th width="10%" align="center">操作</th>
				</tr>
				<%-- <c:forEach var="r" items="${pageView.records}" varStatus="status"> --%>
					<tr>
						<td ><input class="formcheckbox" type="checkbox" name="check"  /></td>
						<td >${(pageView.pageNow - 1) * pageView.pageSize + status.index + 1}</td>
						<td >${r.ROLE_NAME }</td>
						
						<td >${r.CREATE_TIME }</td>
						<td > &nbsp;<input id="choseKeyword" name="choseKeyword" type="button" value="选&nbsp;择" onclick=""/>
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
</div>
</body>
</html>
