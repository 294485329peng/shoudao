<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>选择商品</title>
<meta http-equiv="X-UA-Compatible" content="IE=8" />
<%@ include file="../../common/common_header.jsp"%>
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
			    var LOCAL_IT_ID = $(this).attr('LOCAL_IT_ID');
			    var LOCAL_IT_TITLE = $(this).attr('LOCAL_IT_TITLE');
			    var LOCAL_IT_PIC_URL = $(this).attr('LOCAL_IT_PIC_URL');
			    var LOCAL_IT_PIC_ID = $(this).attr('LOCAL_IT_PIC_ID');
			    var LOCAL_IT_CREATE_TIME = $(this).attr('LOCAL_IT_CREATE_TIME');
			  	var LOCAL_IT_JSON = {"LOCAL_IT_ID":LOCAL_IT_ID,"LOCAL_IT_TITLE":LOCAL_IT_TITLE,"LOCAL_IT_PIC_URL":LOCAL_IT_PIC_URL,"LOCAL_IT_PIC_ID":LOCAL_IT_PIC_ID,"LOCAL_IT_CREATE_TIME":LOCAL_IT_CREATE_TIME};
				parent.selectedLocalIT(LOCAL_IT_JSON);
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
	    <ul class="toolbar toolbar-ul" style="width:100%;margin-bottom: 15px;">
    	<form id="queryForm" action="${ctx}/localML/selectLocalITList.do" method="post">
    			<input name="pageNow" type="hidden" value="${pageView.pageNow}" />
				<li style="cursor:default;">&nbsp;标题：<input type="text" name="TITLE" value="${record.TITLE }" class="search-input" />
				<span style="float:right"><img src="${ctx}/skin/default/images/search.png" class="search-img" style="width: 25px; height: 25px;margin-top: -1.5px;"/></span></li> 		
		</form>
        <%-- <li style="padding-left: 10px; width: 273px;">
        	商品类别：
        <select class="zero-select-base zero-select select-class" style="width: 200px;">
        	<option value="">请选择...</option>
        	<c:forEach var="c" items="${classList}" varStatus="status">
       		<option value="${c.GOODS_CLASSIFY_ID }">${c.CLASSIFY_NAME }</option>
       		</c:forEach>
			
        </select>
        </li> --%>
        <%-- <li id="addGoods" class="click"><span><img src="${ctx}/skin/default/images/t01.png" /></span>添加商品</li>
    				<li class="click" onclick="addGroupLayer();"><span><img src="${ctx}/skin/default/images/t02.png" /></span>添加类别</li> --%>
        <!-- li><span><img src="images/t03.png" /></span>删除</li>
        <li><span><img src="images/t04.png" /></span>统计</li> -->
        </ul>
	    
	    <ul class="classlist">
	    
	    <c:forEach var="r" items="${pageView.records}" varStatus="status">
	    <li id="li_id_${status.index}" >
	    <span><img src="${r.PIC_URL }" style="width: 106px; height: 126px;"/></span>
	    <div class="lright">
	    <h2 style="width: 160px;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;">${r.TITLE }</h2>
	    <p style="width: 160px;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;">
		    	
		    	时间： ${r.CREATE_TIME }<br /><%-- 
		    	发布：<c:if test="${r.PUBLISH == 'on'}"><font color="green">已发布</font></c:if>
					<c:if test="${r.PUBLISH != 'on' }"><font color="red">未发布</font></c:if> --%>
	    </p>
	    <%-- <a class="enter" onclick="updateIT(${r.IT_ID })">编辑</a> --%>
	    <a name="transmit" class="enter" LOCAL_IT_ID="${r.LOCAL_IT_ID }" LOCAL_IT_PIC_URL="${r.PIC_URL }" LOCAL_IT_PIC_ID="${r.PIC_ID }" LOCAL_IT_CREATE_TIME="${r.CREATE_TIME }" LOCAL_IT_TITLE="${r.TITLE }"  >选择</a>
	    </div>
	    </li>
	    </c:forEach>

	    </ul>
	    
	    <div class="clear"></div>
	   
	    <%@ include file="../../common/pagination_tail.jsp"%>
	    
	    
    </div>
<!-- <noframes> -->
</body>
<!-- </body></noframes> -->
</html>
