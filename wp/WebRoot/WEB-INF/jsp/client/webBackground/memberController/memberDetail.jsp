<!DOCTYPE html>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
    <%@ include file="../../../common/common_header.jsp"%>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>个人主页</title>

    <!--共同控件  -->
    <link rel="stylesheet" href="${ctx}/skin/common/css/elementStyle.css"/>
    <!--end  -->
    <link href="${ctx}/skin/webBase/member/css/UserCSS.css" rel="stylesheet" type="text/css"/>
    <!--form 验证 -->
<script type="text/javascript" src="${ctx }/Validform/js/Validform_v5.3.2.js"></script>
<link rel="stylesheet" href="${ctx }/Validform/css/style.css" />
<!--end  -->
    <script type="text/javascript">

	/* function save(w_id,m_id){
		alert($("#BIRTHDAY").val());
		$.ajax({
			type: "post",
			url: $("#insertMember").attr("action"),
			data : $("#insertMember").serialize(),
			dataType:"json",
			success : function(data) {
				//var ret = jQuery.parseJSON(data);
				
				alert(data.msg);
				
				
			}
		});
	} */
	/* function delteMember(w_id,m_id){
		defaultConfirm("你确定要删除吗？删除后不可恢复！",(function(){
			BaseUtils.showWaitMsg();
				$.ajax({
					type: "post",
					url:'${ctx}/memberBC/delete.do',
					data : {"OPEN_ID":w_id,"MEMBER_ID":m_id},
					dataType:"json",
					success : function(data) {
						//var ret = jQuery.parseJSON(data);
						
						if (data.flag) {
							window.location.href="${ctx}/memberBC/memberList.do";
						}else{
							BaseUtils.hideWaitMsg();
							alert("操作失败请稍后再试！");
							
						}
					}
				});
		}));
	} */
	function goBack(){
		window.location.href="${ctx}/memberBC/memberList.do";
	}
	/* $(function()
            {
					var age="";
					var myDate = new Date();
					//if (!!window.ActiveXObject || "ActiveXObject" in window){          // 其他浏览器
	                   		//$("#BIRTHDAY").get(0).onpropertychange = setJsUserName;
	                    	//$("#AGE").get(0).onpropertychange = handle;
	                      // alert("3322");
                    	//}else{          // IE浏览器 
                    		
                            var intervalName;        // 定时器句柄
	                        $("#BIRTHDAY").get(0).addEventListener("input",setJsUserName,false);
	                        // 获得焦点时，启动定时器
	                        $("#BIRTHDAY").focus(function(){
	                                intervalName = setInterval(handle,200);
	                        });
	                        // 失去焦点时，清除定时器
	                        $("#BIRTHDAY").blur(function()
	                        {
	                                clearInterval(intervalName);
	                        });
	                        
                    	//} 
                    // 设置jsUserName input的值
                    function setJsUserName()
                    {
                    	var BIRTHDAY = $("#BIRTHDAY").val();
            			var myDate = new Date();
            			$("#AGE").val(myDate.getFullYear() - BIRTHDAY.substr(0, 4));
            			if($("#BIRTHDAY").val() == ""){
                        	$("#AGE").val("");
                        }
                    }
                    // jsUserName input的值改变时执行的函数
                    function handle()
                    {    
                    	
                    	age = myDate.getFullYear() - $("#BIRTHDAY").val().substr(0, 4);
                    	//alert(age+"__"+$("#AGE").val());
                            // IE浏览器此处判断没什么意义，但为了统一，且提取公共代码而这样处理。
                          // if($("#AGE").val()  age){
	                   			$("#AGE").val(age);
                           //} 
                            if($("#BIRTHDAY").val() == ""){
                            	$("#AGE").val("");
                            }
                    }
}); */
	
	/* $(document).ready(function(){ 
		$("#BIRTHDAY").change(function(){ 
			alert("223");
			var BIRTHDAY = $("#BIRTHDAY").val();
			var myDate = new Date();
			age = myDate.getFullYear() - BIRTHDAY.substr(0, 4);
			$("#AGE").val(age); 
	 
		});
	}); */
	</script>
</head>
<body>
<div class="modstitle">
    <h3>会员详情</h3>
</div>

<div class="mcontent_no_border">

    <!-- /.u-menu -->
    <div class="">
        <div class="ucenter">
            <div class="ucenter-info mt10">
            <form id="insertMember" action="${ctx}/memberBC/update.do" method="post" class="registerform">
                <div class="info-title">
                    <h5> ${record.NICKNAME }&nbsp;&nbsp;会员信息</h5>
                </div>
                <div class="info">
                    <ul class="info-img">
                        <li>
                        	<c:if test="${empty record.HEADIMGURL }">
                        	<img src="${ctx}/skin/webBase/home/images/noHeadImg.jpg" style="border: 1px solid; width: 134px; height: 134px;" class="avatar"/>
                        	</c:if>
                        	<c:if test="${! empty record.HEADIMGURL }">
                            <img src="${record.HEADIMGURL}" style="border: 1px solid; width: 134px; height: 134px;" class="avatar"/>
                            </c:if>
                        </li>
                    </ul>
                    <div class="info-main info-main-size" style="width: 310px;margin-left: 40px;">
                    <input type="hidden" id="OPEN_ID" name="OPEN_ID" value="${record.OPEN_ID }" />
			  		<input type="hidden" id="MEMBER_ID" name="MEMBER_ID" value="${record.MEMBER_ID}" />
                        <div class="row">
                            <label>
                                用户名：</label><input name="REAL_NAME" type="text" class="zero-input-text input-text-e" value="${record.REAL_NAME }" errormsg="用户名2~10个字符！" nullmsg="请填写用户名！" ignore="ignore" datatype="s2-10"/></div>
                        <div class="row">
                            <label>
                                昵称：</label><input name="NICKNAME" type="text" class="zero-input-text input-text-e" value="${record.NICKNAME }" errormsg="昵称2~10个字符！" nullmsg="请填写昵称！" ignore="ignore" datatype="s2-10" /></div>
                        <div class="row">
                            <label>
                                登录ID：</label><input  readonly="readonly"  type="text" class="zero-input-text input-text-e" value="${record.LOGIN_NAME }"/></div>
                        <div class="row">
                            <label>
                                登录密码：</label><input name="LOGIN_PASSWORD"  type="text" class="zero-input-text input-text-e" value="${record.LOGIN_PASSWORD }" errormsg="密码6~16个位！" nullmsg="请填写密码！"  datatype="s6-16"/></div>
                        <div class="row">
                            <label>
                                可用金额：</label><input readonly="readonly" type="text" class="zero-input-text input-text-e" value="${empty record.MONEY ? '0.00' : record.MONEY}"/>￥
                        </div>
                        <div class="row">
                            <label>
                                积分：</label><input readonly="readonly" type="text" class="zero-input-text input-text-e" value="${empty record.POINT ? '0' : record.POINT}"/></div>

                        <%-- <div class="row">
                            <label>
                                累计消费：</label><input name="VOLUME_SALES" readonly="readonly" type="text"
                                                    class="zero-input-text input-text-e " value="${record.VOLUME_SALES == null ? '0.00' : record.VOLUME_SALES}"/>￥
                        </div>
                        <div class="row">
                            <label>
                                积分：</label><input name="POINT" type="text" class="zero-input-text input-text-e" value="${record.POINT == null ? '0' : record.POINT}"/></div>
                        <div class="row">
                            <label>
                                分类：</label><select class="zero-select-base zero-select"
                                                   style="width: 157px; margin-bottom: 0px;">
                            <option value="1">商品类别1</option>
                            <option value="2">商品类别2</option>

                        </select></div>
                        <div class="row">
                            <label>
                                等级：</label><input name="DEGREE"  type="text"
                                                  class="zero-input-text input-text-e orange" value="${record.DEGREE }"/></div>
                        <div class="row">
                            <label>
                                认证：</label><input name="ATTESTATION" readonly="readonly" type="text" class="zero-input-text input-text-e"
                                                    style="color:${record.ATTESTATION == '1' ? 'green' : 'red'};" value="${record.ATTESTATION == '1' ? '已关注' : '未关注'}"/>
                          </div> --%>                          

                        
                    </div>
                    <div class="info-main info-main-size" style="float:right;width: 310px;margin-right: 70px;"">
                        <div class="row">
                            <label>
                                是否关注：</label><input  readonly="readonly" type="text" class="zero-input-text input-text-e"
                                                    style="color:${record.SUBSCRIBE == '1' ? 'green':'red'};" value="${record.SUBSCRIBE == '1' ? '已关注':'未关注'}"/>
                                          
                                                    </div>
                        <%-- <div class="row">
                            <label>
                                性别：</label><input id="SEX" name="SEX" type="text" class="zero-input-text input-text-e" value="${record.SEX }"/>
                        </div>
                        <div class="row">
                            <label>
                                年龄：</label><input id="AGE" name="AGE" type="text" readonly="readonly" class="zero-input-text input-text-e" value="${record.AGE }"/>
                        </div> --%>
                        <div class="row">
                            <label>
                                城市：</label><input name="CITY" type="text" class="zero-input-text input-text-e" value="${record.CITY }" errormsg="城市名称最多10个字符！"  ignore="ignore" datatype="s0-10"/>
                        </div>
                        <div class="row">
                            <label>
                                手机号：</label><input name="PHONE" type="text" class="zero-input-text input-text-e" value="${record.PHONE }" errormsg="请填写正确手机号格式！" nullmsg="请填写手机号！" ignore="ignore" datatype="m"/>
                        </div>
                        <%-- <div class="row">
                            <label>
                                身份证：</label><input name="IDENTITY_CARD" type="text" class="zero-input-text input-text-e" value="${record.IDENTITY_CARD }"/>
                        </div> --%>
                        <div class="row">
                            <label>
                                注册时间：</label><input readonly="readonly" type="text" class="zero-input-text input-text-e" value="${record.CREATE_TIME }"/>
                        </div>
                         <div class="row">
                            <label>
                                备注：</label><input name="STORE_REMARK" type="text" class="zero-input-text input-text-e" value="${record.STORE_REMARK }" errormsg="最多20个字符" ignore="ignore" datatype="s0-20"/></div>                            
                        
                        <%-- <div class="row">
                            <label>
                                最后登录：</label><input name="LAST_TIME" type="text" class="zero-input-text input-text-e" value="${record.LAST_TIME }"/>
                        </div> 
                        <div class="row">
                            <label>
                                出生日期：</label><input id="BIRTHDAY" name="BIRTHDAY" type="text" class="zero-input-text input-text-e Wdate"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="${record.BIRTHDAY }"/>
                        </div>
                        <div class="row">
                            <label>
                                下单量：</label><input name="ALL_ORDER_COUNT" type="text" class="zero-input-text input-text-e" value="${record.ALL_ORDER_COUNT }"/></div>
                        <div class="row">
                            <label>
                                成交量：</label><input name="FINISH_ORDER_COUNT" type="text" class="zero-input-text input-text-e" value="${record.FINISH_ORDER_COUNT }"/></div>
                        --%>
                        <!-- <div class="row">
                            <label>
                                个人统计：</label><span class="orange">0</span>&nbsp;条贷款记录 ， 共计&nbsp;<span class="orange">0</span>&nbsp;元
                            ； <span class="orange">0</span>&nbsp;条投标记录 ， 共计&nbsp;<span class="orange">0.00</span>&nbsp;元
                            。
                        </div> -->
                    </div>
                    <div class="clear">
                    </div>
                </div>
            
                <div style="margin-top: 30px; margin-left: 500px;">
                            <input type="button" class="zero_btn zero_btn_primary" id="save" value="保存"/>
                            <input type="button" class="zero_btn" onclick="goBack();" value="返回"
                                   style="margin-left: 40px;"/>
                            <%-- <input type="button" class="zero_btn zero_btn_red" onclick="delteMember('${record.OPEN_ID }','${record.MEMBER_ID }');" value="删除并返回"
                                   style="margin-left: 15px;"/> --%>
                        </div>
            </form>
            </div>
            <%-- <div class="ucenter-info mt10">
                <div class="ucenter-tab-box">
                    <ul class="u-tab ">
                        <li class="current"><a>订单记录</a></li>
                        <!-- <li><a>成交记录</a></li> -->
                        <!-- <li><a>消费记录</a></li>
                        <li><a>操作记录</a></li> -->
                    </ul>
                </div>
                <form id="queryForm" action="${ctx}/memberBC/memberDetail.do" method="post" >
                <input type="hidden" name="OPEN_ID" value="${record.OPEN_ID }"/>
                <input type="hidden" name="MEMBER_ID" value="${record.MEMBER_ID }"/>
                </form>
                <div id="tab_box">
                    <div class="u-form-wrap" style="padding-bottom: 60px;">
                        <div class="right_list">
                            <table class="tablelist">
                                <tr>
                                    <th width="4%" align="center">编号&nbsp;&nbsp;</th>
                                    <th width="17%" align="center">订单编号</th>
                                    <th width="10%" align="center">顾客</th>
                                    <!-- <th width="7%" align="center">顾客类型</th> -->
                                    <th width="8%" align="center">城市</th>
                                    <th width="8%" align="center">总价&nbsp;&nbsp;
                                    <span class="zero-icon-rank" style=" text-indent: 0px;">
									<i class="zero-arrow zero-arrow-up"></i>
									<i class="zero-arrow zero-arrow-down"></i>
									</span></th>
                                    <th width="7%" align="center">支付方式</th>
                                    <th width="10%" align="center">状态&nbsp;&nbsp;
                                    <span class="zero-icon-rank" style=" text-indent: 0px;">
									<i class="zero-arrow zero-arrow-up"></i>
									<i class="zero-arrow zero-arrow-down"></i>
									</span></th>
                                    <th width="11%" align="center">下单时间&nbsp;&nbsp;
                                    <span class="zero-icon-rank" style=" text-indent: 0px;">
									<i class="zero-arrow zero-arrow-up"></i>
									<i class="zero-arrow zero-arrow-down"></i>
									</span></th>
                                    <th width="7%" align="center">操作</th>
                                </tr>
                                <c:forEach var="r" items="${pageView.records}" varStatus="status">
    							<tr id="tr_${status.index}">
                                    <td>${(pageView.pageNow - 1) * pageView.pageSize + status.index + 1}</td>
                                    <td>${r.ORDER_ID }</td>
                                    <td>${r.CUSTOMER_NAME }</td>
                                    <td>${r.CITY }</td>
                                    <td>￥${r.TOTAL_PRICE }</td>
                                    <td>${r.PAY_TYPE eq '1'? '<a>在线支付</a>': '<a>线下支付</a>' }</td>
                                    <td>
                                    	<c:if test="${r.DEAL_TYPE =='0' }">
							        	<a style="color:red;">未处理</a>
							        	</c:if>
							        	<c:if test="${r.DEAL_TYPE =='1' }">
							        	<a style="color:#f46a6a;">正在配货</a>
							        	</c:if>
							        	<c:if test="${r.DEAL_TYPE =='2' }">
							        	<a style="color:#2aed3d;">已发货</a>
							        	</c:if>
							        	<c:if test="${r.DEAL_TYPE =='3' }">
							        	<a style="color:#48abf3;">交易完成</a>
							        	</c:if>
							        	<c:if test="${r.DEAL_TYPE =='10' }">
							        	<a style="color:#ae3db3;">订单取消</a>
							        	</c:if>
							        	<c:if test="${r.DEAL_TYPE =='30' }">
							        	<a style="color:#ae3db3;">订单信息待补充</a>
							        	</c:if>
                                    </td>
                                    <td>${r.CREATE_TIME }</td>
                                    <td>
							        <c:if test="${r.DEAL_TYPE =='0' || r.DEAL_TYPE == '1' || r.DEAL_TYPE == '2' || r.DEAL_TYPE == '30'}">
						        	<a href="#" class="tablelink" onclick="orderDeal('${r.ORDER_ID}','${r.OPEN_ID}','${r.MEMBER_ID}')">处理</a>
						        	</c:if>
						        	<c:if test="${r.DEAL_TYPE =='10' || r.DEAL_TYPE == '3'}">
						        	<a href="#" class="tablelink" onclick="orderDetail('${r.ORDER_ID}','${r.OPEN_ID}','${r.MEMBER_ID}')">详情</a>
						        	</c:if>
						        	</td>
                                </tr>
                                </c:forEach>
                               
                            </table>
                            <div style="margin-top: -10px;">
                                <%@ include file="../../../common/pagination_tail.jsp"%>
                            </div>
                        </div>
                    </div>
                    <div class="u-form-wrap" style="display: none;">
                        <div>
                            这是关注我的用户
                        </div>
                    </div>
                    <div class="u-form-wrap" style="display: none;">
                        <div>
                            这是我的投标记录
                        </div>
                    </div>
                    <div class="u-form-wrap" style="display: none;">
                        <div>
                            这是
                        </div>
                    </div>
                </div>
            </div> --%>
            <script type="text/javascript">

                var $div_li = $(".ucenter-tab-box ul li");

                $div_li.click(function () {

                    $(this).addClass("current").siblings().removeClass("current");

                    var div_index = $div_li.index(this);

                    $("#tab_box>div").eq(div_index).show().siblings().hide();

                }).hover(function () {

                    $(this).addClass("hover");

                }, function () {

                    $(this).removeClass("hover");

                });

            </script>
        </div>
        <!-- /.u-main -->
    </div>
</div>
</body>
<script type="text/javascript">
var index;
/*通用验证框架  */
$("body").append("<!--验证的遮蔽层  -->"  
		+"<div id=\"mask\" class=\"mask\"></div>"
		+"<!-- end -->");
$(function(){
	//$(".registerform").Validform();  //就这一行代码！;
	$(".registerform:eq(0)").Validform({
		btnSubmit:"#save",
		tipSweep:true,
		tiptype:1,
		ajaxPost:true,
		beforeSubmit:function(curform){
			//在验证成功后，表单提交前执行的函数，curform参数是当前表单对象。
			//这里明确return false的话表单将不会提交;
			index = layer.load(1, {
			    shade: [0.1,'#fff'] //0.1透明度的白色背景
			});
		},
		callback:function(data){
			layer.close(index);
				if(data.status=="y"){
					setTimeout(function(){
						$.Showmsg(data.msg);
						$.Hidemsg(); //公用方法关闭信息提示框;显示方法是$.Showmsg("message goes here.");
					},2000);
				}else{
					$.Showmsg(data.msg);
				}
			//返回数据data是json对象，{"info":"demo info","status":"y"}
			//info: 输出提示信息;
			//status: 返回提交数据的状态,是否提交成功。如可以用"y"表示提交成功，"n"表示提交失败，在ajax_post.php文件返回数据里自定字符，主要用在callback函数里根据该值执行相应的回调操作;
			//你也可以在ajax_post.php文件返回更多信息在这里获取，进行相应操作；
			//ajax遇到服务端错误时也会执行回调，这时的data是{ status:**, statusText:**, readyState:**, responseText:** }；
	 
			//这里执行回调操作;
			//注意：如果不是ajax方式提交表单，传入callback，这时data参数是当前表单对象，回调函数会在表单验证全部通过后执行，然后判断是否提交表单，如果callback里明确return false，则表单不会提交，如果return true或没有return，则会提交表单。
		}
	});
})
</script>
</html>
