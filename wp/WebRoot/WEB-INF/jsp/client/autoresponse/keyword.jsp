<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>关键词</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<%@ include file="../../common/common_header.jsp"%>
<script type="text/javascript">
	function cfAction() {
		document.getElementById("respURL").style.display = "none";
		$("#xydz").attr("readonly", "readonly");
		document.getElementById("xydz").style.background = "#F0F0F0";
		var CFDZ = $("#CFDZ").val();
		var ZCDMC = $("#ZCDMC").val();
		layer.open({
			title : '响应动作',
			type : 2,
			area : [ '700px', '320px' ],
			fix : false, //不固定
			maxmin : true,
			shadeClose : true,
			shade : 0.8,
			content : '${ctx}/zdycd/xydz.do?CFDZ=' + CFDZ + '&ZCDMC=' + ZCDMC,
		});

	}
	function addKeyWord() {
		window.location.href = "${ctx}/ar/addKeyWord.do";
	}
	function updateRule(RULE_ID){
		window.location.href = "${ctx}/ar/forShowUpdateMessage.do?RULE_ID="+RULE_ID;
	}
	function deleteKeyword(RULE_ID){
		BaseUtils.showWaitMsg();
		if (!window.confirm('你确认要删除吗？')) {
			BaseUtils.hideWaitMsg();
			return false;
		}
		$.ajax({
			url:"${ctx}/ar/deleteKeyword.do",
			type:"post",
			data:{"RULE_ID":RULE_ID},
			dataType:"json",
			success:function(data){
				BaseUtils.hideWaitMsg();
				alert(data.msg);
				window.location.href="${ctx}/ar/keyword.do";
				}
			}); 
	}
</script>
<%-- <link href="${ctx}/skin/zdycd/css/zdycd.css"  rel="stylesheet" /> --%>

</head>
<body>
	<div style="height: 100%">
			<div class="youkuangjia">
				<div class="modstitle">
					<h3>关键词回复</h3>
				</div>
				<div class="mcontent">
					<div class="alert">
						<p>注意：关键词上限为40个，超出后可能造成服务不能正常使用</p>
						<p>可以添加、编辑、删除选中的关键词。</p>
					</div>
					
					<div style="margin-bottom: 10px;">
						<form id="queryForm" action="${ctx}/ar/keyword.do" method="post" >
							标题： <input type="text" name="RULE_NAME" value="${record.RULE_NAME }" style="height: 21px; width: 170px;" />&nbsp;
							<input onclick="$('#queryForm').submit();" id="search" type="button" class="xinbutton" value="查  询" />&nbsp; 
							<input onclick="addKeyWord()" id="add" type="button" class="xinbutton" value="添  加" />&nbsp;
						</form>
					</div>
					
					<div>
					 
						<table class="tablelist" style="table-layout: fixed;">
							<tr>
								<th width="3%"><input class="formcheckbox" type="checkbox"
									id="checkAll" /></th>
								<th width="7%" align="center">编号&nbsp;&nbsp;<i class="sort"><img
										src="${ctx}/skin/default/images/px.gif" /></i></th>
								<th width="10%" align="center">标题</th>
								<th width="20%" align="right">关键词</th>
								<th width="7%" align="center">匹配类型</th>
								<th width="7%" align="center">回复类型</th>
								<th width="18%" align="center">回复内容</th>
								<th width="12%" align="center">创建时间</th>
								<th width="10%" align="center">操作</th>
							</tr>
							<c:forEach var="r" items="${pageView.records}" varStatus="status">
								<tr>
									<td><input class="formcheckbox" type="checkbox"
										name="check" /></td>
									<td>${(pageView.pageNow - 1) * pageView.pageSize + status.index + 1}</td>
									<td style="width:auto;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;">${r.RULE_NAME }</td>
									<td style="white-space: nowrap;overflow: hidden;text-overflow: ellipsis;">${r.KEYWORD_LIST}</td>
									<td>${r.MATCHTYPE}</td>
									<td>
									<c:if test="${r.REPLY_TYPE=='1'}">
										文本信息
									</c:if>
									<c:if test="${r.REPLY_TYPE=='2'}">
										微信图文
									</c:if>
									<c:if test="${r.REPLY_TYPE=='3'}">
										本地图文
									</c:if>
									</td>
									<td style="white-space: nowrap;overflow: hidden;text-overflow: ellipsis;">
									<c:if test="${r.REPLY_TYPE=='1'}">
										${r.SAYTEXT}
									</c:if>
									<c:if test="${r.REPLY_TYPE=='2' || r.REPLY_TYPE == '3'}">
										${r.IT_TITLE}
									</c:if>
									</td>
									<td>${r.CREATE_TIME }</td>
									<td>&nbsp;<input id="choseKeyword" name="choseKeyword"
										type="button" value="编&nbsp辑" onclick="updateRule('${r.RULE_ID}')" /> &nbsp;&nbsp;<input
										id="choseKeyword" name="choseKeyword" type="button"
										value="删&nbsp除" onclick="deleteKeyword('${r.RULE_ID}')" /></td>
									<%-- <a href="javascript:forAcFuncCheckTree('${r.ROLE_ID}','${r.APP_ID}');"></a>  --%>
								</tr>
							</c:forEach>

						</table>
						<br>
						<%@ include file="../../common/pagination_tail.jsp"%>
					</div>
					<!--  <div class="axinsearch" >
                    <button class="xinbutton" onclick="addMenuItem()">保存</button>&nbsp;&nbsp;&nbsp;&nbsp;
                    <button class="xinbutton"  onclick="goBeck()">取消</button>
                </div> -->
				</div>
			</div>
	</div>
</body>
</html>