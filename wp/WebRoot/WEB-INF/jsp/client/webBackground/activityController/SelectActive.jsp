<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>选择图文</title>
<meta http-equiv="X-UA-Compatible" content="IE=8" />
<%@ include file="../../../common/common_header.jsp"%>
<script type="text/javascript" src="${ctx}/script/common/formValidation.js"></script>
<script type="text/javascript">
	var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
	/* function formSelect() {
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
	} */
	
	//给父页面传值
	/* function transmit(IT_ID){
		parent.$('#MATERIAL_ID').val(IT_ID);
	    
	    parent.layer.close(index);
	} */
	/* function selectIT(IT_JSON){
		parent.setSelectIT(IT_JSON);
	    //parent.demo('我是被主人拿来做测试用的。');
	    parent.layer.close(index); 
	} */
	 $(document).ready(function(){
		  /* $("#forAddIT").click(function(){
			  window.open("${ctx}/zdycd/newMainAddMessage.do","_blank") 
		  }); */
		  $("a[name='transmit']").on('click', function(){
			 	var PUBLISH = $(this).attr('PUBLISH');
			 	if(PUBLISH != "on"){
			 		alert("请回到活动信息页，发布后才能选择！");
			 		return false;
			 	}
			    var ACTIVITY_ID = $(this).attr('ACTIVITY_ID');
			    var TITLE = $(this).attr('TITLE');
			    
			  	var RESPONSE_JSON = {"RESPONSE_ID":ACTIVITY_ID,"RESPONSE_TITLE":TITLE};
				parent.setSelectRESPONSE(RESPONSE_JSON);
			    //parent.demo('我是被主人拿来做测试用的。');
			    parent.layer.close(index);
			});
		});
</script>
</head>

<%-- <frameset  frameborder="no" border="0" framespacing="0">
<frame src="${ctx }/massfunction/selectITFream.do"   scrolling="No" noresize="noresize" id="topFrame" title="topFrame" />
</frameset> --%>
<body>
	<div class="rightinfo">
	    <!-- <div class="tools"> -->
	    	<%-- <ul class="toolbar" style="width: 594px;">
	    	<form id="queryForm1" action="${ctx}/massfunction/selectIT.do" method="post">
					<li style="cursor:default;">&nbsp;标题：<input type="text" name="ROLE_NAME" value="" style="height: 21px; width: 170px;"/></li>
						<li class="click"><span><img src="${ctx}/skin/default/images/search.png" style="width: 25px; height: 25px; margin-top: px;"/></span>搜索</li> 		
			</form>
	        <li id="formSelect" class="click"><span><img src="${ctx}/skin/default/images/t01.png" /></span>选择</li>
	        
	        </ul> --%>
	        
	        <%-- 
	        <ul class="toolbar1">
	        <a href="${ctx}/ml/forShowAddMessage.do" target="_blank"><li id="forAddIT"><span><img src="${ctx}/skin/default/images/t01.png" /></span>新建图文信息</li><!-- </a> -->
	        </ul> --%>
	    
	    <!-- </div> -->
	    <form id="queryForm" action="${ctx}/webBgNav/selectResponse.do?RESPONSE=2" method="post">
	    
		</form>
	    <ul class="classlist">
	    
	    <c:forEach var="r" items="${pageView.records}" varStatus="status">
	    <li id="li_id_${status.index}" >
	    <span><img src="${r.PIC_URL }" style="width: 106px; height: 126px;"/></span>
	    <div class="lright">
	    <h2 style="width: 160px;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;">${r.TITLE }</h2>
	    <p style="width: 160px;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;">
		    	
		    	时间： ${r.CREATE_TIME }<br />
		    	发布：<c:if test="${r.PUBLISH == 'on'}"><font color="green">已发布</font></c:if>
					<c:if test="${r.PUBLISH != 'on' }"><font color="red">未发布</font></c:if>
	    </p>
	    <%-- <a class="enter" onclick="updateIT(${r.IT_ID })">编辑</a> --%>
	    <a name="transmit" class="enter" PUBLISH="${r.PUBLISH}" ACTIVITY_ID="${r.ACTIVITY_ID }" TITLE="${r.TITLE }" >选择</a>
	    </div>
	    </li>
	    </c:forEach>

	    </ul>
	    
	    <div class="clear"></div>
	   
	    <%@ include file="../../../common/pagination_tail.jsp"%>
	    
	    
    </div>
<!-- <noframes> -->
</body>
<!-- </body></noframes> -->
</html>
