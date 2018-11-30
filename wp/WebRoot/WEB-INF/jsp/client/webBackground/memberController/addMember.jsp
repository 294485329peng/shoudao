<!DOCTYPE html>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
	<%@ include file="../../../common/common_header.jsp"%>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>个人主页</title>
    
    <!--共同控件  -->
	<link rel="stylesheet" href="${ctx}/skin/common/css/elementStyle.css"/>
	<!--end  -->
	<link href="${ctx}/skin/webBase/member/css/UserCSS.css" rel="stylesheet" type="text/css" />
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
                    <div class="info-title">
                        <h5> 胖子会员信息</h5>
                    </div>
                    <div class="info">
                        <ul class="info-img">
                            <li>
                                <img src="${ctx }/skin/webBase/home/images/nopic.jpg" style="border: 1px solid;" class="avatar" /></li></ul>
                        <div class="info-main info-main-size" >
                            <div class="row">
                                <label>
                                    用户名：</label><input type="text" class="zero-input-text input-text-e" value="占三"/></div>
                            <div class="row">
                            <label>
                                    微信名：</label><input type="text" class="zero-input-text input-text-e" value="占三"/></div>
                            <div class="row">
                                <label>
                                    账户ID：</label><input readonly="readonly" type="text" class="zero-input-text input-text-e" value="2323233"/></div>
                            <div class="row">
                                <label>
                                  可用金额：</label><input readonly="readonly" type="text" class="zero-input-text input-text-e" value="22.00"/>￥</div>
                                  <div class="row">
                                <label>
                                    累计消费：</label><input readonly="readonly" type="text" class="zero-input-text input-text-e " value="100"/>￥</div>
                            <div class="row">
                                <label>
                                   积分：</label><input  type="text" class="zero-input-text input-text-e" value="100"/></div>
                            <div class="row">
                                <label>
                                   分类：</label><select class="zero-select-base zero-select"  style="width: 157px; margin-bottom: 0px;">
                                   <option value="1">商品类别1</option>
							<option value="2">商品类别2</option>
                                   
                                   </select> </div>       
                            <div class="row">
                                <label>
                                    等级：</label><input readonly="readonly" type="text" class="zero-input-text input-text-e orange" value="普通会员"/></div>
                                    
                            <!-- <div class="row">
                                <label>
                                    个人统计：</label><span class="orange">0</span>&nbsp;条贷款记录 ， 共计&nbsp;<span class="orange">0</span>&nbsp;元
                                ； <span class="orange">0</span>&nbsp;条投标记录 ， 共计&nbsp;<span class="orange">0.00</span>&nbsp;元
                                。
                            </div> -->
                        </div>
                        <div class="info-main info-main-size" style="float:right;">
                            <div class="row">
                                <label>
                                    是否关注：</label><input readonly="readonly"  type="text" class="zero-input-text input-text-e" style="color:green;" value="已关注"/></div>
                            <div class="row">
                                <label>
                                    手机号：</label><input   type="text" class="zero-input-text input-text-e"  value="1512222222"/></div>
                            <div class="row">
                                <label>
                                    注册时间：</label><input  type="text" class="zero-input-text input-text-e" value="2016-1-1"/></div>
                            <div class="row">
                                <label>
                                    最后登录：</label><input  type="text" class="zero-input-text input-text-e" value="2016-1-1"/></div>
                            <div class="row">
                                <label>
                                    出生日期：</label><input  type="text" class="zero-input-text input-text-e" value="2016-1-1"/></div>
                            <div class="row">
                                <label>
                                    下单量：</label><input  type="text" class="zero-input-text input-text-e" value="22"/></div>
                           <div class="row">
                                <label>
                                    成交量：</label><input  type="text" class="zero-input-text input-text-e" value="22"/></div>
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
                </div> 
                <div class="ucenter-info mt10">
                <div class="ucenter-tab-box">
                        <ul class="u-tab ">
                            <li class="current"><a>订单记录</a></li>
                            <li><a>成交记录</a></li>
                            <!-- <li><a>消费记录</a></li>
                            <li><a>操作记录</a></li> -->
                        </ul>
                </div>
                <div id="tab_box">
                    <div class="u-form-wrap" style="padding-bottom: 60px;">
                        <div class="right_list">
			<table class="tablelist">
				<tr>
					<th width="4%" align="center">编号&nbsp;&nbsp;</th>
					<th width="17%" align="center">订单编号</th>
					<th width="10%" align="center">顾客</th>
					<th width="7%" align="center">顾客类型</th>
					<th width="8%" align="center">城市</th>
					<th width="8%" align="center">总价&nbsp;&nbsp;<span class="zero-icon-rank" style=" text-indent: 0px;">
						<i class="zero-arrow zero-arrow-up"></i>
						<i class="zero-arrow zero-arrow-down"></i>
						</span></th>
					<th width="7%" align="center">支付</th>
					<th width="7%" align="center">状态&nbsp;&nbsp;<span class="zero-icon-rank" style=" text-indent: 0px;">
						<i class="zero-arrow zero-arrow-up"></i>
						<i class="zero-arrow zero-arrow-down"></i>
						</span></th>
					<th width="11%" align="center">下单时间&nbsp;&nbsp;<span class="zero-icon-rank" style=" text-indent: 0px;">
						<i class="zero-arrow zero-arrow-up"></i>
						<i class="zero-arrow zero-arrow-down"></i>
						</span></th>
					<th width="11%" align="center">处理时间&nbsp;&nbsp;<span class="zero-icon-rank" style=" text-indent: 0px;">
						<i class="zero-arrow zero-arrow-up"></i>
						<i class="zero-arrow zero-arrow-down"></i>
						</span></th>
					<th width="10%" align="center">操作</th>
				</tr>
				 <tr>
		        <td>1</td>
		        
		        <td>分类1</td>
		        <td>江西</td>
		        <td>游客</td>
		        <td>青岛</td>
		        <td>100.00</td>
		        <td><a style="color:red">未支付</a></td>
		        <td><a>未处理</a></td>
		        <td>2013-09-06 10:36</td>
		       	<td>2013-09-06 10:36</td>
		        <td><a href="#" class="tablelink">编辑</a>     <a href="#" class="tablelink">删除</a></td>
		        </tr>
		        <tr>
		        <td>1</td>
		        <td>分类1</td>
		        <td>江西</td>
		        <td>vip4</td>
		        <td>青岛</td>
		        <td>100.22</td>
		        <td><a>未支付</a></td>
		        <td><a>未支付</a></td>
		        <td>2013-09-06 10:36</td>
		        <td>2013-09-06 10:36</td>
		        <td><a href="#" class="tablelink">处理</a>  &nbsp;&nbsp;    <a href="#" class="tablelink">详情</a></td>
		        </tr>
		        <tr>
		        <td>1</td>
		        <td>分类1</td>
		        <td>江西</td>
		        <td>vip4</td>
		        <td>青岛</td>
		        <td>100.22</td>
		        <td><a>未支付</a></td>
		        <td><a>未支付</a></td>
		        <td>2013-09-06 10:36</td>
		        <td>2013-09-06 10:36</td>
		        <td><a href="#" class="tablelink">处理</a>  &nbsp;&nbsp;    <a href="#" class="tablelink">详情</a></td>
		        </tr>
				<%-- <c:forEach var="r" items="${pageView.records}" varStatus="status">
					<tr>
						<td><input class="formcheckbox" type="checkbox" name="check" value="${r.ROLE_ID}" /></td>
						<td>${(pageView.pageNow - 1) * pageView.pageSize + status.index + 1}</td>
						<td>${r.ROLE_NAME }</td>
						<td>${r.ROLE_TYPE }</td>
						<td>${r.ROLE_DESC }</td>
						<td>${r.CREATE_TIME }</td>
						<td><a href="javascript:forUpdate('${r.ROLE_ID}');">修改</a> 
						<a href="javascript:forAcFuncCheckTree('${r.ROLE_ID}','${r.APP_ID}');">功能分配</a> 
						<a href="javascript:forOmEmployeeCheckTree('${r.ROLE_ID}');">关联人员</a>
						<a href="javascript:forAcHomeModuleCheck('${r.ROLE_ID}','${r.APP_ID}');">首页模块</a></td>
					</tr>
				</c:forEach> --%>
			</table>
			<div style="margin-top: -10px;">
			<%@ include file="../../../common/pagination_tail.jsp"%>
			</div>
		</div>
                    </div>
                    <div class="u-form-wrap" style="display: none;">
                        <div>
                            这是关注我的用户</div>
                    </div>
                    <div class="u-form-wrap" style="display: none;">
                        <div>
                            这是我的投标记录</div>
                    </div>
                    <div class="u-form-wrap" style="display: none;">
                        <div>
                            这是我的贷款记录</div>
                    </div>
                </div>                
            </div>
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
	<div style="text-align:center;">
</div>
</body>
</html>
