<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>选择图文</title>
<meta http-equiv="X-UA-Compatible" content="IE=8" />
<%@ include file="../../common/common_header.jsp"%>
<script type="text/javascript" src="${ctx}/script/common/formValidation.js"></script>
<script type="text/javascript">
$(document).ready(function(){
$("#forAddIT").click(function(){
	  window.open("${ctx}/zdycd/newMainAddMessage.do","_blank") 
});
$("a[name='transmit']").on('click', function(){
	    var IT_ID = $(this).attr('IT_ID');
	    var PIC_URL = $(this).attr('PIC_URL');
	    var TITLE = $(this).attr('TITLE');
	    var IT_MEDIA_ID = $(this).attr('IT_MEDIA_ID');
	    var AUTHOR = $(this).attr('AUTHOR');
	    var CREATE_TIME = $(this).attr('CREATE_TIME');
	    var IT_COUNT = $(this).attr('IT_COUNT');
	  	var IT_JSON = {"IT_MEDIA_ID":IT_MEDIA_ID,"IT_ID":IT_ID,"PIC_URL":PIC_URL,"TITLE":TITLE,"AUTHOR":AUTHOR,"CREATE_TIME":CREATE_TIME,"IT_COUNT":IT_COUNT};
		
		parent.window.selectIT(IT_JSON);
	    //parent.demo('我是被主人拿来做测试用的。');
	});
}); 
	

</script>
</head>
<body>
	<div class="rightinfo">
	    <div class="tools">
	    	<%-- <ul class="toolbar" style="width: 594px;">
	    	<form id="queryForm1" action="${ctx}/massfunction/selectITFream.do" method="post">
					<li style="cursor:default;">&nbsp;标题：<input type="text" name="ROLE_NAME" value="${record.ROLE_NAME }" style="height: 21px; width: 170px;"/></li>
						<li class="click"><span><img src="${ctx}/skin/default/images/search.png" style="width: 25px; height: 25px; margin-top: px;"/></span>搜索</li> 		
			</form>
	        <li id="formSelect" class="click"><span><img src="${ctx}/skin/default/images/t01.png" /></span>选择</li>
	        
	        </ul> --%>
	        
	        
	        <ul class="toolbar1">
	        <a href="${ctx}/ml/forShowAddMessage.do" target="_blank"><li id="forAddIT"><span><img src="${ctx}/skin/default/images/t01.png" /></span>新建图文信息</li><!-- </a> -->
	        </ul>
	    
	    </div>
	    <form id="queryForm" action="${ctx}/massfunction/selectITFream.do" method="post">
	    
	
	    <ul class="classlist">
	    
	    <c:forEach var="r" items="${pageView.records}" varStatus="status">
	    <li id="li_id_${status.index}" >
	    <span><img src="${r.PIC_URL }" style="width: 106px; height: 126px;"/></span>
	    <div class="lright">
	    <h2 style="width: 160px;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;">${r.TITLE }</h2>
	    <p style="width: 160px;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;">
		    	作者：${r.AUTHOR }<br />
		    	时间： ${r.CREATE_TIME }<br />
		    	数量：${r.IT_COUNT }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;发布：<c:if test="${r.PUBLISH == '1'}"><font color="green">已发布</font></c:if>
					    																	<c:if test="${r.PUBLISH != '1' }"><font color="red">未发布</font></c:if>
	    </p>
	    <a class="enter" onclick="updateIT(${r.IT_ID })">编辑</a>
	    <a name="transmit" onclick="selectIT();" class="enter" IT_MEDIA_ID="${r.MEDIA_ID }" IT_ID="${r.IT_ID }" PIC_URL="${r.PIC_URL }" TITLE="${r.TITLE }" AUTHOR="${r.AUTHOR }" CREATE_TIME="${r.CREATE_TIME }" IT_COUNT="${r.IT_COUNT }">选择</a>
	    </div>
	    </li>
	    </c:forEach>

	    </ul>
	    </form>
	    <div class="clear"></div>
	   
	    <%@ include file="../../common/pagination_tail.jsp"%>
	    
	    
    </div>
</body>
</html>
