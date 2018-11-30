
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- 导航 必须要引入 -->
    <%-- <link rel="stylesheet" type="text/css" href="${ctx }/skin/tinyWebsite/css/DHstyle.css" /> --%>
    <!--end  -->
<!--↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓导航开始↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓-->
  <div class="v_nav">
		<div class="vf_nav">
			<ul>
			<li>
			<a href="${ctx}/TWeb/bs/home.htmls?store=${seTicket.gzhId}">
			<i class="vf_1"></i>
			<span>首页</span>
			</a>
			</li>
			<li>
			<!-- <a href="tel:00000"> -->
			<a id="tel" href="tel:00000">
			<i class="vf_2"></i>
			<span>客服</span>
			</a>
			</li>
			<li>
			<a href="${ctx }/TWeb/goods/goodsList.htmls?store=${seTicket.gzhId}">
			<i class="vf_3"></i>
			<span>商品	</span>
			</a>
			</li>
			<li>
			<a href="${ctx }/TWeb/act/list.htmls?store=${seTicket.gzhId}">
			<!-- <em id="ECS_CARTINFO" class="global-nav__nav-shop-cart-num" style="right:9px;"> 10 </em> -->
			<i class="vf_6"></i>
			<span>活动</span>
			</a>
			</li>
			<li>
			<a href="${ctx }/MemberCenter/memberInfo.htmls?store=${seTicket.gzhId}">
			<i class="vf_5"></i>
			<span>我的</span>
			</a>
			</li>
			</ul>
		</div>
	</div>
  <!--↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑导航end↑↑↑↑↑↑↑↑↑↑↑↑↑↑-->
<script type="text/javascript">
function servicePhone(){
	$.ajax({
		url : "${ctx}/TWeb/bs/getServicePhone.htmls",
		type : "post",
		data :{},
		dataType : "json",
		success : function(data) {
			$("#tel").attr("href","tel:" + data.obj.SERVICE_PHONE);
			
		}
	});
}
window.onload=servicePhone;
</script>