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

<title>消费记录</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<%@ include file="../../../common/common_header.jsp"%>
<script type="text/javascript">
	
</script>
<%-- <link href="${ctx}/skin/zdycd/css/zdycd.css"  rel="stylesheet" /> --%>

</head>
<body>
	<div style="height: 100%">
		
			<div class="youkuangjia">
				<div class="modstitle">
					<h3>消费记录</h3>
				</div>
				<div class="mcontent">
					<div class="alert">
						<!-- <p>注意：1级菜单最多只能开启3个，2级子菜单最多开启5个!</p>
                    <p>只有保存主菜单后才可以添加子菜单</p>
                    <p>生成自定义菜单,必须在已经保存的基础上进行,临时勾选启用点击生成是无效的! 第一步必须先修改保存状态！第二步点击生成!</p>
                    <p>当您为自定义菜单填写链接地址时请填写以"http://"开头，这样可以保证用户手机浏览的兼容性更好</p>
                    <p>撤销自定义菜单：撤销后，您的微信公众帐号上的自定义菜单将不存在；如果您想继续在微信公众帐号上使用自定义菜单，请点击“生成自定义菜单”按钮，将重新启用！</p>  -->
					</div>

					<form id="queryForm" action="${ctx}/memberBC/moneyRecord.do" method="post">
					<input type="hidden" value="${record.OPEN_ID }" name="OPEN_ID" />
					</form>
					<div>
					 
						<table class="tablelist" style="table-layout: fixed;">
							<tr>
								<th width="7%" align="center">编号&nbsp;&nbsp;<i class="sort"><img
										src="${ctx}/skin/default/images/px.gif" /></i></th>
								<th width="10%" align="center">操作类型</th>
								<th width="10%" align="right">金额</th>
								<th width="10%" align="center">积分</th>
								<th width="10%" align="center">获得积分</th>
								<th width="10%" align="center">创建时间</th>
								<th width="35%" align="center">备注</th>
							</tr>
							<c:forEach var="r" items="${pageView.records}" varStatus="status">
								<tr>
									<td>${(pageView.pageNow - 1) * pageView.pageSize + status.index + 1}</td>
									<td>
									<c:if test="${r.TYPE == '1'}"><a style="color:green">充值</a></c:if>
									<c:if test="${r.TYPE == '2'}"><a style="color:red">消费</a></c:if>
									</td>
									<td>￥${empty r.MONEY ? '0' : r.MONEY}</td>
									<td>${r.POINT}</td>
									<td>${r.GET_POINT }</td>
									<td>${r.CREATE_TIME }</td>
									<td>${r.REMARK }</td>
								</tr>
							</c:forEach>

						</table>
						<br>
						<%@ include file="../../../common/pagination_tail.jsp"%>
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