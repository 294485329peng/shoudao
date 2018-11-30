<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">
$(function(){
	//pageNow('1');
	loadOddCss()
});
function loadOddCss(){
	$("tr:odd").addClass("odd");
	$("tr").mouseover(function(){
		$(this).addClass("color1");
	}).mouseout(function(){
		$(this).removeClass("color1");
	});
}
function pageNow(pageNow){
	 var fy=$("#queryForm").serialize(); //对表彰数据进行序列化
	 var f=$("#queryForm").attr("action");//获取表单action的属性值
	 var pCount = parseInt("${pageView.pageCount}");
	if(pageNow < 1){
		alert(" 已 经 是 第 一 页 啦  ！");
		return false ;
	}else if(pCount < pageNow){
		alert(" 没 有 下 一 页 啦 ！");
		return false ;
	}else{
		//window.location.href=f+"?pageNow="+pageNow+"&"+fy;
		var url="";
		if(f.indexOf('?')>0){
			url = f+"&pageNow="+pageNow;
		} else {
			url = f+"?pageNow="+pageNow;
		}
		document.forms[0].action=url;
		document.forms[0].submit();
		return false;
	};
}
</script>
<div class="pagediv clearfix">
	<a href="javascript:void(0);" onclick="return pageNow('1');" aria-label="Previous">首页</a>
	<a href="javascript:void(0);" onclick="return pageNow('${pageView.pageNow - 1}');">上页</a>
	<a href="javascript:void(0);" onclick="return pageNow('${pageView.pageNow + 1}');">下页</a>
	<a href="javascript:void(0);" onclick="return pageNow('${pageView.pageCount}');" aria-label="Next">尾页</a>
</div>