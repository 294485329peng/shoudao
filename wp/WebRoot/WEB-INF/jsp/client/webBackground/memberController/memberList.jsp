<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
 <head>
 	<%@ include file="../../../common/common_header.jsp"%>
 	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
 	<link href="${ctx}/skin/skinExample/css/style.css" rel="stylesheet" type="text/css" />
 	
 	<!--共同控件  -->
	<link rel="stylesheet" href="${ctx}/skin/common/css/elementStyle.css"/>
	<!--end  -->
	<!--开关控件  -->
	<link rel="stylesheet" href="${ctx}/skin/switchery/css/switchery.css" />
	<script src="${ctx}/skin/switchery/js/switchery.js"></script>
	<!--end  -->
	<!--本页专属css  -->
	<link rel="stylesheet" href="${ctx}/skin/webBase/member/css/memberStyle.css"/>
	<!--end  -->
	<title>无标题文档</title>

<script language="javascript">
$(function(){	
	//导航切换
	$(".imglist li").click(function(){
		$(".imglist li.selected").removeClass("selected")
		$(this).addClass("selected");
	})	
})	
</script>
<script type="text/javascript">
$(document).ready(function(){
  $("#addMember").click(function(){
	  window.location.href="${ctx}/memberBC/insertMember.do";
  });
});
function memberDetail(w_id,m_id){
	window.location.href="${ctx}/memberBC/memberDetail.do?OPEN_ID="+w_id;
}
function moneyRecord(w_id,m_id){
	window.location.href="${ctx}/memberBC/moneyRecord.do?OPEN_ID="+w_id;
}
/* function deleteMember(w_id,m_id){
	//window.location.href="${ctx}/memberBC/delete.do?OPEN_ID="+w_id+"&MEMBER_ID="+m_id;
} */
/**
*充值
*/
function chongzhi(w_id,m_id) {
	layer.open({
		title : '充值',
	    type: 2,
	    area: ['700px', '330px'],
	    fix: false, //不固定
	    maxmin: true,
	    content: '${ctx}/memberBC/chongzhi.do?OPEN_ID='+w_id
	});
}
/**
*消费
*/
function xiaofei(w_id,m_id) {
	layer.open({
		title : '消费',
	    type: 2,
	    area: ['700px', '330px'],
	    fix: false, //不固定
	    maxmin: true,
	    content: '${ctx}/memberBC/xiaofei.do?OPEN_ID='+w_id
	});
}
function setSelectResponse(json){
	$("#"+json.OPEN_ID+"_m").html("￥"+json.MONEY);
	$("#"+json.OPEN_ID+"_p").html(json.POINT);
	layer.closeAll(); //疯狂模式，关闭所有层
}
</script>
</head>


<body>

	<div class="modstitle">
                <h3>会员列表</h3>
     </div>
    
    <div class="rightinfo">
    <div class="alert">
                <!-- <p>生成自定义菜单,必须在已经保存的基础上进行,临时勾选启用点击生成是无效的! 第一步必须先修改保存状态！第二步点击生成!</p>
                <p>当您为自定义菜单填写链接地址时请填写以"http://"开头，这样可以保证用户手机浏览的兼容性更好</p>
                <p>撤销自定义菜单：撤销后，您的微信公众帐号上的自定义菜单将不存在；如果您想继续在微信公众帐号上使用自定义菜单，请点击“生成自定义菜单”按钮，将重新启用！</p>  -->
            </div>
    <div class="form_box" style="padding-left: 0px; margin-top: 10px;">
			<div class="tools">
    
    	<ul class="toolbar toolbar-ul" style="width: 916px;">
				    	<form id="queryForm" action="${ctx}/memberBC/memberList.do" method="post" >
								<li style="cursor:default;">&nbsp;卡号：<input type="text" name="CARD_ID" value="${record.CARD_ID }" class="search-input" style="height: 20px; width: 150px;"/>
								<span style="float:right" onclick="$('#queryForm').submit();"><a href="#"><img src="${ctx}/skin/default/images/search.png" class="search-img" style="width: 24px;height:24px;"/></a></span></li>
								<li style="cursor:default;">&nbsp;昵称：<input type="text" name="NICKNAME" value="${record.NICKNAME }" class="search-input" style="height: 20px; width: 150px;"/>
								<span style="float:right" onclick="$('#queryForm').submit();"><a href="#"><img src="${ctx}/skin/default/images/search.png" class="search-img" style="width: 24px;height:24px;"/></a></span></li> 		
						</form>
				        
				       <%--  <li id="addGoodsClass" class="click"><span><img src="${ctx}/skin/default/images/d04.png" style="width: 24px;"/></span>注册时间</li>
       			 <select class="zero-select-base zero-select select-class" style="height: 33px; width: 105px; float: left; margin-top: 1px; margin-bottom: 1px;">
				       		<option value="1">商品类别1</option>
							<option value="2">商品类别2</option>
							
				        </select>
				        <select class="zero-select-base zero-select select-class" style="height: 33px; width: 177px; float: left; margin-top: 1px; margin-bottom: 1px;">
				       		<option value="1">商品类别1</option>
							<option value="2">商品类别2</option>
							<option value="1">商品类别1</option>
							
				        </select>				
        <li><span><img src="${ctx}/skin/skinExample/images/icon08.png" style="width: 24px; height: 24px;"/></span>地区</li> --%>
        <!-- <li><span><img src="images/t04.png" /></span>统计</li> -->
        </ul>
        
        
        <%-- <ul class="toolbar1">
        <li><span><img src="${ctx}/skin/default/images/t05.png" /></span>发布排序</li>
        </ul> --%>
    
    </div>
		</div>
    
    <div>
    <table class="imgtable">
    
    <thead>
    <tr>
    <th width="13%;">卡号</th>
    <th width="7%">头像</th>
    <th width="8%;">昵称</th>
    <th width="6%;">城市</th>
    <th width="3.5%;">关注</th>
    <!-- <th width="5%;">等级</th> -->
    <th width=8%;">可用资金</th>
    <th width="6%;">积分</th>
    <th width="9%;">账号</th>
    <th width="11%;">注册时间</th>
    <!-- <th width="11%;">最后登录</th> -->
    <th width="9%;">备注</th>
    <th width="18%;">操作</th>
    </tr>
    </thead>
    
    <tbody>
    <c:forEach var="r" items="${pageView.records}" varStatus="status">
    <tr id="${r.OPEN_ID }">
    <td>${r.CARD_ID}</td>
    <td class="imgtd">
    <c:if test="${empty r.HEADIMGURL }">
   	<img src="${ctx}/skin/webBase/home/images/noHeadImg.jpg" style="margin-right: 5px; width: 66px; height: 66px; margin-top: 5px; margin-bottom: 5px;"/>
   	</c:if>
   	<c:if test="${! empty r.HEADIMGURL }">
   	<img src="${r.HEADIMGURL }" style="margin-right: 5px; width: 66px; height: 66px; margin-top: 5px; margin-bottom: 5px;" />
   	</c:if>
    </td>
    <td><a href="#">${r.NICKNAME }</a></td>
    <td>${r.CITY }</td>
    <td><c:if test="${r.SUBSCRIBE == '1'}"><img src="${ctx }/skin/webBase/common/images/right.png"  style="margin-right: 2px; width: 21px; height: 21px; margin-left: 2px;"></c:if>
    	<c:if test="${r.SUBSCRIBE != '1'}"><img src="${ctx }/skin/webBase/common/images/error.png" style="margin-right: 2px; width: 21px; height: 21px; margin-left: 2px;"></c:if></td>
    <%-- <td>${r.DEGREE }</td> --%>
    <td id="${r.OPEN_ID }_m">￥${empty r.MONEY ? '0.00': r.MONEY}</td>
	<td id="${r.OPEN_ID }_p">${empty r.POINT ? '0' : r.POINT }</td>
	
	<td>${r.LOGIN_NAME }</td> 
	<td>${r.CREATE_TIME }</td>
	<%-- <td>${r.LAST_TIME }</td> --%>
	<td>${r.STORE_REMARK }</td>
	<td>
	<a class="a_link" style="cursor:pointer" onclick="chongzhi('${r.OPEN_ID }','${r.MEMBER_ID }')"  >充值</a>&nbsp;&nbsp;&nbsp;
	<a class="a_link" style="cursor:pointer" onclick="xiaofei('${r.OPEN_ID }','${r.MEMBER_ID }')"  >消费</a>&nbsp;&nbsp;&nbsp;
	<a class="a_link" style="cursor:pointer" onclick="moneyRecord('${r.OPEN_ID }','${r.MEMBER_ID }')"  >消费记录</a>&nbsp;&nbsp;&nbsp;
	<a class="a_link" style="cursor:pointer" onclick="memberDetail('${r.OPEN_ID }','${r.MEMBER_ID }')">编辑</a>&nbsp;&nbsp;&nbsp;
	<%-- <a class="a_link" onclick="deleteMember'${r.OPEN_ID }','${r.MEMBER_ID }')" style="cursor:pointer">删除</a> --%> 
	</td>
    </tr>
    </c:forEach>
    <%-- <tr>
    <td>100</td>
    <td class="imgtd"><img src="${ctx}/skin/default/images/img12.png" style="margin-right: 10px; width: 70px; height: 52px;"  /></td>
    <td><a href="#">一套简约形状</a></td>
    <td>图标设计<p>ID: 82122</p></td>
    <td>青岛</td>
    <td><img src="${ctx}/skin/webBase/common/images/right.png" style="margin-right: 9px; width: 21px; height: 21px; margin-left: 7px;"></td>
    <td>普通会员</td>
    <td>235</td>
    <td>100</td>
    <td>100</td>
    <td>100</td>
    <td>100</td>
    <td>100</td>
    <td>100</td>
    </tr> --%>
    
    
    </tbody>
    
    </table>
   <div class="pagin" style="margin-top: -10px;">
    	<%@ include file="../../../common/pagination_tail.jsp"%>
    </div>
   
    
    </div>

</body>

</html>
