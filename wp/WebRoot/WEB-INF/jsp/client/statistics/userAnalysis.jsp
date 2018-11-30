<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <%@ include file="../../common/common_header.jsp"%>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <title>微信用户分析</title>
    <!-- chart统计表单  -->
    <script type="text/javascript" src="${ctx }/skin/statistics/js/jsapi.js"></script>
    <script type="text/javascript" src="${ctx }/skin/statistics/js/format+zh_CN,default,corechart.I.js"></script>
    <script type="text/javascript" src="${ctx }/skin/statistics/js/jquery.gvChart-1.0.1.min.js"></script>
    <script type="text/javascript" src="${ctx }/skin/statistics/js/jquery.ba-resize.min.js"></script>
    <!-- 日期选择器  -->
    <script type="text/javascript" src="${ctx }/skin/statistics/js/dateRange.js"></script>
    <script type="text/javascript" src="${ctx }/skin/statistics/js/monthPicker.js"></script>
    <link rel="stylesheet" type="text/css" href="${ctx }/skin/statistics/css/dateRange.css"/>
    <link rel="stylesheet" type="text/css" href="${ctx }/skin/statistics/css/monthPicker.css"/>
    <!--统计的css  -->
    <link rel="stylesheet" href="${ctx }/skin/statistics/css/statistics.css">

    <script type="text/javascript">
        gvChartInit();
        jQuery(document).ready(function () {
            jQuery('#myTable1').gvChart({
                chartType: 'AreaChart',
                gvSettings: {
                    vAxis: {title: '金额'},
                    hAxis: {title: '月份'},
                    width: 720,
                    height: 300
                }
            });

            jQuery('#myTable2').gvChart({
                chartType: 'LineChart',
                gvSettings: {
                    vAxis: {title: '金额'},
                    hAxis: {title: '月份'},
                    width: 920,
                    height: 300
                }
            });

            jQuery('#myTable3').gvChart({
                chartType: 'BarChart',
                gvSettings: {
                    vAxis: {title: '金额'},
                    hAxis: {title: '月份'},
                    width: 720,
                    height: 300
                }
            });

            jQuery('#myTable4').gvChart({
                chartType: 'ColumnChart',
                gvSettings: {
                    vAxis: {title: '金额'},
                    hAxis: {title: '月份'},
                    width: 720,
                    height: 300
                }
            });

            jQuery('#myTable5').gvChart({
                chartType: 'PieChart',
                gvSettings: {
                    vAxis: {title: '金额'},
                    hAxis: {title: '月份'},
                    width: 720,
                    height: 300
                }
            });
        });

    </script>
</head>
<body>
<div style="height: 100%">
    <div class="youkuangjia">
        <div class="modstitle">
            <h3>用户分析</h3>
        </div>
        <div class="mcontent" style="border-bottom:0px;">
            <div class="alert">
                <p>注意：1级菜单最多只能开启3个，2级子菜单最多开启5个!</p>

                <p>只有保存主菜单后才可以添加子菜单</p>
                <!--   <p>生成自定义菜单,必须在已经保存的基础上进行,临时勾选启用点击生成是无效的! 第一步必须先修改保存状态！第二步点击生成!</p>
                  <p>当您为自定义菜单填写链接地址时请填写以"http://"开头，这样可以保证用户手机浏览的兼容性更好</p>
                  <p>撤销自定义菜单：撤销后，您的微信公众帐号上的自定义菜单将不存在；如果您想继续在微信公众帐号上使用自定义菜单，请点击“生成自定义菜单”按钮，将重新启用！</p>  -->
            </div>
            <div class="col_main">

                <div id="js_topTab" class="title_tab">
                    <ul class="tab_navs title_tab" data-index="0">
                        <li class="tab_nav first js_top selected" data-id="user_stat" data-index="0">
                            <a href="#">用户增长</a>
                        </li>
                        <li class="tab_nav js_top" data-id="user_attr" data-index="1">
                            <a href="#">用户属性</a>
                        </li>
                    </ul>
                </div>
                <div class="main_bd user_analysis">
                    <div class="wrp_overview">
                        <div class="page_msg mini top">
                            <div class="inner group">
	            <span class="msg_icon_wrp">
	                <i class="icon_msg_mini info"></i>
	            </span>

                                <div class="msg_content">
                                    <p>本页根据昨日数据来计算，而用户管理页根据当前数据计算，两者不一致。</p>
                                </div>
                            </div>
                        </div>

                        <div class="info_box" id="ddfdf">
                            <div class="inner">
                                <div class="info_hd append_ask">
                                    <h4>昨日关键指标</h4>

                                    <div class="ext_info help">
                                        <i id="" class="icon_msg_mini ask"></i>

                                        <div class="help_content">
                                            <i class="dropdown_arrow out"></i>
                                            <i class="dropdown_arrow in"></i>


                                        </div>
                                    </div>
                                </div>
                                <div class="info_bd">
                                    <div class="content" id="js_keydata">
                                        <table class="ui_trendgrid ui_trendgrid_3">
                                            <tbody>
                                            <tr>
                                                <td class="first">
                                                    <div class="ui_trendgrid_item">
                                                        <div class="ui_trendgrid_chart"></div>
                                                        <dl>
                                                            <dt><b>新关注人数</b></dt>
                                                            <dd class="ui_trendgrid_number"><strong style="font-size: 30px;">0</strong><em
                                                                class="ui_trendgrid_unit"></em></dd>
                                                            <dd>日 &nbsp;&nbsp;&nbsp;--</dd>
                                                            <dd>周 &nbsp;&nbsp;&nbsp;--</dd>
                                                            <dd>月 &nbsp;&nbsp;&nbsp;--</dd>
                                                        </dl>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="ui_trendgrid_item">
                                                        <div class="ui_trendgrid_chart"></div>
                                                        <dl>
                                                            <dt><b>取消关注人数</b></dt>
                                                            <dd class="ui_trendgrid_number"><strong style="font-size: 30px;">0</strong><em
                                                                class="ui_trendgrid_unit"></em></dd>
                                                            <dd>日 &nbsp;&nbsp;&nbsp;--</dd>
                                                            <dd>周 &nbsp;&nbsp;&nbsp;--</dd>
                                                            <dd>月 &nbsp;&nbsp;&nbsp;--</dd>
                                                        </dl>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="ui_trendgrid_item">
                                                        <div class="ui_trendgrid_chart"></div>
                                                        <dl>
                                                            <dt><b>净增关注人数</b></dt>
                                                            <dd class="ui_trendgrid_number"><strong style="font-size: 30px;">0</strong><em
                                                                class="ui_trendgrid_unit"></em></dd>
                                                            <dd>日 &nbsp;&nbsp;&nbsp;--</dd>
                                                            <dd>周 &nbsp;&nbsp;&nbsp;--</dd>
                                                            <dd>月 &nbsp;&nbsp;&nbsp;--</dd>
                                                        </dl>
                                                    </div>
                                                </td>
                                                <td class="last">
                                                    <div class="ui_trendgrid_item">
                                                        <div class="ui_trendgrid_chart"></div>
                                                        <dl>
                                                            <dt><b>累积关注人数</b></dt>
                                                            <dd class="ui_trendgrid_number"><strong style="font-size: 30px;">0</strong><em
                                                                class="ui_trendgrid_unit"></em></dd>
                                                            <dd>
                                                                	日
                                                                <i class="icon_down" title="上升"></i>
                                                                0%
                                                            </dd>
                                                            <dd>
                                                                	周
                                                                <i class="icon_down_grey" title="上升"></i>
                                                                0%
                                                            </dd>
                                                            <dd>
                                                                	月
                                                                <i class="icon_up" title="上升"></i>
                                                                0%
                                                            </dd>
                                                        </dl>
                                                    </div>
                                                </td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="info_box drop_hd_right">
                            <div class="inner" id="js_actions">
                                <div>
                                    <div class="info_hd">
                                        <strong class="lable time_lable">关键指标详解</strong>

                                        <div class="tabs">


                                            <a class="first current" href="javascript:;">新增人数</a>


                                            <a href="javascript:;">取消关注人数</a>


                                            <a href="javascript:;">净增人数</a>


                                            <a class="last" href="javascript:;">累积人数</a>


                                        </div>
                                    </div>

                                    <div class="sub_menu">
                                        <div>

                                            <strong class="lable time_lable">时间</strong>

                                            <div class="button_group">
                                                <a class="btn btn_default" href="javascript:;" range="7">7日</a>
                                                <a class="btn btn_default" href="javascript:;" range="14">14日</a>
                                                <a class="btn btn_default selected" href="javascript:;"
                                                   range="30">30日</a>

                                                <div class="btn_group_item td_data_container" id="js_date_container0">
                                                    <div class="ta_date" id="div_date1">
                                           				 <span class="date_title" id="date1"></span>
                                                        <a class="opt_sel" id="input_trigger1" href="#">
                                                            <i class="i_orderd"></i>
                                                        </a>
                                                    </div>

                                                </div>
                                                
                                             
                                                <div class="btn_group_item td_data_container"
                                                     id="js_single_timer_container"></div>
                                            </div>


                                            <div class="setup">
                                                <button class="btn btn_primary" id="js_compare_btn0">按时间对比</button>
                                            </div>

                                        </div>
                                    </div>
                                    <div></div>
                                </div>


                                <div class="sub_menu" id="js_subselection">
                                    <strong class="lable time_lable">增长来源</strong>

                                    <div class="button_group">

                                        <a class="btn btn_default selected" href="javascript:;" data-tab="1"
                                           data-source="99999999">全部</a>
                                        <a class="btn btn_default" href="javascript:;" data-tab="3" data-source="35">搜索公众号名称</a>
                                        <a class="btn btn_default" href="javascript:;" data-tab="4" data-source="3">搜索微信号</a>
                                        <a class="btn btn_default" href="javascript:;" data-tab="6" data-source="43">图文页右上角菜单</a>
                                        <a class="btn btn_default" href="javascript:;" data-tab="2" data-source="17">名片分享</a>
                                        <a class="btn btn_default" href="javascript:;" data-tab="7"
                                           data-source="0">其他</a>

                                    </div>
                                </div>

                                <div class="info_bd">
                                    <div class="page_msg mini">
                                        <div class="inner group">
           		            <span class="msg_icon_wrp">
           		                <i class="icon_msg_mini info"></i>
           		            </span>

                                            <div class="msg_content">
                                                <p>用户增长来源目前只支持过滤趋势图，暂不支持区分详细数据，请知悉。</p>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="page_msg mini" style="display: none;">
                                        <div class="inner group">
           		            <span class="msg_icon_wrp">
           		                <i class="icon_msg_mini info"></i>
           		            </span>

                                            <div class="msg_content">
                                                <p>用户增长来源增加了新的来源，新来源将缺少历史统计数据，请知悉。</p>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sub_title">趋势图</div>
                                    <div class="sub_content">
                                        <div title="Title1" style="padding: 10px;">
                                            <h2 id="area">
                                                区域报表
                                            </h2>
                                            <table id='myTable1'>
                                                <caption>
                                                    报表分析
                                                </caption>
                                                <thead>
                                                <tr>
                                                    <th>
                                                    </th>
                                                    <th>
                                                        一月

                                                    </th>
                                                    <th>
                                                        二月

                                                    </th>
                                                    <th>
                                                        三月

                                                    </th>
                                                    <th>
                                                        四月

                                                    </th>
                                                    <th>
                                                        五月

                                                    </th>
                                                    <th>
                                                        六月

                                                    </th>
                                                    <th>
                                                        七月

                                                    </th>
                                                    <th>
                                                        八月

                                                    </th>
                                                    <th>
                                                        九月

                                                    </th>
                                                    <th>
                                                        十月

                                                    </th>
                                                    <th>
                                                        十一月

                                                    </th>
                                                    <th>
                                                        十二月

                                                    </th>
                                                </tr>
                                                </thead>
                                                <tbody>
                                                <tr>
                                                    <th>
                                                        实际完成

                                                    </th>
                                                    <td>
                                                        900

                                                    </td>
                                                    <td>
                                                        600

                                                    </td>
                                                    <td>
                                                        327

                                                    </td>
                                                    <td>
                                                        359

                                                    </td>
                                                    <td>
                                                        376

                                                    </td>
                                                    <td>
                                                        398

                                                    </td>
                                                    <td>
                                                        60
                                                    </td>
                                                    <td>
                                                        50
                                                    </td>
                                                    <td>
                                                        404
                                                    </td>
                                                    <td>
                                                        700
                                                    </td>
                                                    <td>
                                                        200
                                                    </td>
                                                    <td>
                                                        500
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th>
                                                        计划任务

                                                    </th>
                                                    <td>
                                                        1167

                                                    </td>
                                                    <td>
                                                        1110

                                                    </td>
                                                    <td>
                                                        691

                                                    </td>
                                                    <td>
                                                        165

                                                    </td>
                                                    <td>
                                                        135

                                                    </td>
                                                    <td>
                                                        157

                                                    </td>
                                                    <td>
                                                        139

                                                    </td>
                                                    <td>
                                                        136

                                                    </td>
                                                    <td>
                                                        938

                                                    </td>
                                                    <td>
                                                        1120

                                                    </td>
                                                    <td>
                                                        55

                                                    </td>
                                                    <td>
                                                        55

                                                    </td>
                                                </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                        <div title="Title2" style="padding: 10px;">
                                            <h2 id="line">
                                                LineChart
                                            </h2>
                                            <table id='myTable2'>
                                                <caption>
                                                    报表分析
                                                </caption>
                                                <thead>
                                                <tr>
                                                    <th>
                                                    </th>
                                                    <th>
                                                        一月

                                                    </th>
                                                    <th>
                                                        二月

                                                    </th>
                                                    <th>
                                                        三月

                                                    </th>
                                                    <th>
                                                        四月

                                                    </th>
                                                    <th>
                                                        五月

                                                    </th>
                                                    <th>
                                                        六月

                                                    </th>
                                                    <th>
                                                        七月

                                                    </th>
                                                    <th>
                                                        八月

                                                    </th>
                                                    <th>
                                                        九月

                                                    </th>
                                                    <th>
                                                        十月

                                                    </th>
                                                    <th>
                                                        十一月

                                                    </th>
                                                    <th>
                                                        十二月

                                                    </th>
                                                </tr>
                                                </thead>
                                                <tbody>
                                                <tr>
                                                    <th>
                                                        实际完成

                                                    </th>
                                                    <td>
                                                        900

                                                    </td>
                                                    <td>
                                                        600

                                                    </td>
                                                    <td>
                                                        327

                                                    </td>
                                                    <td>
                                                        359

                                                    </td>
                                                    <td>
                                                        376

                                                    </td>
                                                    <td>
                                                        398

                                                    </td>
                                                    <td>
                                                        60
                                                    </td>
                                                    <td>
                                                        50
                                                    </td>
                                                    <td>
                                                        404
                                                    </td>
                                                    <td>
                                                        700
                                                    </td>
                                                    <td>
                                                        200
                                                    </td>
                                                    <td>
                                                        500
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th>
                                                        计划任务

                                                    </th>
                                                    <td>
                                                        1167

                                                    </td>
                                                    <td>
                                                        1110

                                                    </td>
                                                    <td>
                                                        691

                                                    </td>
                                                    <td>
                                                        165

                                                    </td>
                                                    <td>
                                                        135

                                                    </td>
                                                    <td>
                                                        157

                                                    </td>
                                                    <td>
                                                        139

                                                    </td>
                                                    <td>
                                                        136

                                                    </td>
                                                    <td>
                                                        938

                                                    </td>
                                                    <td>
                                                        1120

                                                    </td>
                                                    <td>
                                                        55

                                                    </td>
                                                    <td>
                                                        55

                                                    </td>
                                                </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                        <div title="Title3" style="padding: 10px;">
                                            <h2 id="bar">
                                                BarChart
                                            </h2>
                                            <table id='myTable3'>
                                                <caption>
                                                    报表分析
                                                </caption>
                                                <thead>
                                                <tr>
                                                    <th>
                                                    </th>
                                                    <th>
                                                        一月

                                                    </th>
                                                    <th>
                                                        二月

                                                    </th>
                                                    <th>
                                                        三月

                                                    </th>
                                                    <th>
                                                        四月

                                                    </th>
                                                    <th>
                                                        五月

                                                    </th>
                                                    <th>
                                                        六月

                                                    </th>
                                                    <th>
                                                        七月

                                                    </th>
                                                    <th>
                                                        八月

                                                    </th>
                                                    <th>
                                                        九月

                                                    </th>
                                                    <th>
                                                        十月

                                                    </th>
                                                    <th>
                                                        十一月

                                                    </th>
                                                    <th>
                                                        十二月

                                                    </th>
                                                </tr>
                                                </thead>
                                                <tbody>
                                                <tr>
                                                    <th>
                                                        实际完成

                                                    </th>
                                                    <td>
                                                        900

                                                    </td>
                                                    <td>
                                                        600

                                                    </td>
                                                    <td>
                                                        327

                                                    </td>
                                                    <td>
                                                        359

                                                    </td>
                                                    <td>
                                                        376

                                                    </td>
                                                    <td>
                                                        398

                                                    </td>
                                                    <td>
                                                        60
                                                    </td>
                                                    <td>
                                                        50
                                                    </td>
                                                    <td>
                                                        404
                                                    </td>
                                                    <td>
                                                        700
                                                    </td>
                                                    <td>
                                                        200
                                                    </td>
                                                    <td>
                                                        500
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th>
                                                        计划任务

                                                    </th>
                                                    <td>
                                                        1167

                                                    </td>
                                                    <td>
                                                        1110

                                                    </td>
                                                    <td>
                                                        691

                                                    </td>
                                                    <td>
                                                        165

                                                    </td>
                                                    <td>
                                                        135

                                                    </td>
                                                    <td>
                                                        157

                                                    </td>
                                                    <td>
                                                        139

                                                    </td>
                                                    <td>
                                                        136

                                                    </td>
                                                    <td>
                                                        938

                                                    </td>
                                                    <td>
                                                        1120

                                                    </td>
                                                    <td>
                                                        55

                                                    </td>
                                                    <td>
                                                        55

                                                    </td>
                                                </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                        <div title="Title4" style="padding: 10px;">
                                            <h2 id="column">
                                                ColumnChart
                                            </h2>
                                            <table id='myTable4'>
                                                <caption>
                                                    报表分析
                                                </caption>
                                                <thead>
                                                <tr>
                                                    <th>
                                                    </th>
                                                    <th>
                                                        一月

                                                    </th>
                                                    <th>
                                                        二月

                                                    </th>
                                                    <th>
                                                        三月

                                                    </th>
                                                    <th>
                                                        四月

                                                    </th>
                                                    <th>
                                                        五月

                                                    </th>
                                                    <th>
                                                        六月

                                                    </th>
                                                    <th>
                                                        七月

                                                    </th>
                                                    <th>
                                                        八月

                                                    </th>
                                                    <th>
                                                        九月

                                                    </th>
                                                    <th>
                                                        十月

                                                    </th>
                                                    <th>
                                                        十一月

                                                    </th>
                                                    <th>
                                                        十二月

                                                    </th>
                                                </tr>
                                                </thead>
                                                <tbody>
                                                <tr>
                                                    <th>
                                                        实际完成

                                                    </th>
                                                    <td>
                                                        900

                                                    </td>
                                                    <td>
                                                        600

                                                    </td>
                                                    <td>
                                                        327

                                                    </td>
                                                    <td>
                                                        359

                                                    </td>
                                                    <td>
                                                        376

                                                    </td>
                                                    <td>
                                                        398

                                                    </td>
                                                    <td>
                                                        60
                                                    </td>
                                                    <td>
                                                        50
                                                    </td>
                                                    <td>
                                                        404
                                                    </td>
                                                    <td>
                                                        700
                                                    </td>
                                                    <td>
                                                        200
                                                    </td>
                                                    <td>
                                                        500
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th>
                                                        计划任务

                                                    </th>
                                                    <td>
                                                        1167

                                                    </td>
                                                    <td>
                                                        1110

                                                    </td>
                                                    <td>
                                                        691

                                                    </td>
                                                    <td>
                                                        165

                                                    </td>
                                                    <td>
                                                        135

                                                    </td>
                                                    <td>
                                                        157

                                                    </td>
                                                    <td>
                                                        139

                                                    </td>
                                                    <td>
                                                        136

                                                    </td>
                                                    <td>
                                                        938

                                                    </td>
                                                    <td>
                                                        1120

                                                    </td>
                                                    <td>
                                                        55

                                                    </td>
                                                    <td>
                                                        55

                                                    </td>
                                                </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                        <div title="Title5" style="padding: 10px;">
                                            <h2 id="pie">
                                                PieChart
                                            </h2>
                                            <table id='myTable5'>
                                                <caption>
                                                    报表分析
                                                </caption>
                                                <thead>
                                                <tr>
                                                    <th>
                                                    </th>
                                                    <th>
                                                        一月

                                                    </th>
                                                    <th>
                                                        二月

                                                    </th>
                                                    <th>
                                                        三月

                                                    </th>
                                                    <th>
                                                        四月

                                                    </th>
                                                    <th>
                                                        五月

                                                    </th>
                                                    <th>
                                                        六月

                                                    </th>
                                                    <th>
                                                        七月

                                                    </th>
                                                    <th>
                                                        八月

                                                    </th>
                                                    <th>
                                                        九月

                                                    </th>
                                                    <th>
                                                        十月

                                                    </th>
                                                    <th>
                                                        十一月

                                                    </th>
                                                    <th>
                                                        十二月

                                                    </th>
                                                </tr>
                                                </thead>
                                                <tbody>
                                                <tr>
                                                    <th>
                                                        2010

                                                    </th>
                                                    <td>
                                                        125

                                                    </td>
                                                    <td>
                                                        185

                                                    </td>
                                                    <td>
                                                        327

                                                    </td>
                                                    <td>
                                                        359

                                                    </td>
                                                    <td>
                                                        376

                                                    </td>
                                                    <td>
                                                        398

                                                    </td>
                                                    <td>
                                                        0

                                                    </td>
                                                    <td>
                                                        0

                                                    </td>
                                                    <td>
                                                        0

                                                    </td>
                                                    <td>
                                                        0

                                                    </td>
                                                    <td>
                                                        0

                                                    </td>
                                                    <td>
                                                        0

                                                    </td>
                                                </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <h4 class="sub_title">详细数据
                                        <div class="tr_ext_info"><a target="_blank"
                                                                    href="https://mp.weixin.qq.com/misc/useranalysis?&amp;download=1&amp;begin_date=2015-11-04&amp;end_date=2015-12-03&amp;source=99999999&amp;token=694364309&amp;lang=zh_CN"
                                                                    id="js_download_detail">导出Excel</a></div>
                                    </h4>
                                    <div class="page_msg mini top">
                                        <div class="inner group">
                            <span class="msg_icon_wrp">
                                <i class="icon_msg_mini info"></i>
                            </span>

                                            <div class="msg_content">
                                                <p>用户总数和用户增长数分别根据不同方法和时间点来统计，可能出现不匹配。</p>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sub_content">
                                        <div class="table_wrp">
                                            <table class="table" id="js_single_table" cellspacing="0">
                                                <thead class="thead">
                                                <tr>
                                                    <th class="table_cell rank_area tl" data-type="date">
                                                        时间                                        <span
                                                        class="icon_rank rank_area">
                                            <i class="arrow arrow_up"></i><i class="arrow arrow_down"></i>
                                        </span>
                                                    </th>
                                                    <th class="table_cell rank_area tr" data-type="new_user">
                                                        新关注人数                                        <span
                                                        class="icon_rank">
                                            <i class="arrow arrow_up"></i><i class="arrow arrow_down"></i>
                                        </span>
                                                    </th>
                                                    <th class="table_cell rank_area tr" data-type="cancel_user">
                                                        取消关注人数                                        <span
                                                        class="icon_rank">
                                            <i class="arrow arrow_up"></i><i class="arrow arrow_down"></i>
                                        </span>
                                                    </th>
                                                    <th class="table_cell rank_area tr" data-type="netgain_user">
                                                        净增关注人数                                        <span
                                                        class="icon_rank">
                                            <i class="arrow arrow_up"></i><i class="arrow arrow_down"></i>
                                        </span>
                                                    </th>
                                                    <th class="table_cell tr rank_area last_child no_extra"
                                                        data-type="cumulate_user">
                                                        累积关注人数                                        <span
                                                        class="icon_rank">
                                            <i class="arrow arrow_up"></i><i class="arrow arrow_down"></i>
                                        </span>
                                                    </th>

                                                </tr>
                                                </thead>
                                                <tbody class="tbody" id="js_detail">
                                                <tr>
                                                    <td class="table_cell">2015-12-03</td>
                                                    <td class="table_cell tr js_new_user td_high_light">0</td>
                                                    <td class="table_cell tr js_cancel_user">0</td>
                                                    <td class="table_cell tr js_netgain_user">0</td>
                                                    <td class="table_cell tr js_cumulate_user">0</td>
                                                </tr>

                                                <tr>
                                                    <td class="table_cell">2015-12-02</td>
                                                    <td class="table_cell tr js_new_user td_high_light">0</td>
                                                    <td class="table_cell tr js_cancel_user">0</td>
                                                    <td class="table_cell tr js_netgain_user">0</td>
                                                    <td class="table_cell tr js_cumulate_user">0</td>
                                                </tr>

                                                <tr>
                                                    <td class="table_cell">2015-12-01</td>
                                                    <td class="table_cell tr js_new_user td_high_light">0</td>
                                                    <td class="table_cell tr js_cancel_user">0</td>
                                                    <td class="table_cell tr js_netgain_user">0</td>
                                                    <td class="table_cell tr js_cumulate_user">0</td>
                                                </tr>

                                                <tr>
                                                    <td class="table_cell">2015-11-30</td>
                                                    <td class="table_cell tr js_new_user td_high_light">0</td>
                                                    <td class="table_cell tr js_cancel_user">0</td>
                                                    <td class="table_cell tr js_netgain_user">0</td>
                                                    <td class="table_cell tr js_cumulate_user">0</td>
                                                </tr>

                                                <tr>
                                                    <td class="table_cell">2015-11-29</td>
                                                    <td class="table_cell tr js_new_user td_high_light">0</td>
                                                    <td class="table_cell tr js_cancel_user">0</td>
                                                    <td class="table_cell tr js_netgain_user">0</td>
                                                    <td class="table_cell tr js_cumulate_user">0</td>
                                                </tr>

                                                <tr>
                                                    <td class="table_cell">2015-11-28</td>
                                                    <td class="table_cell tr js_new_user td_high_light">0</td>
                                                    <td class="table_cell tr js_cancel_user">0</td>
                                                    <td class="table_cell tr js_netgain_user">0</td>
                                                    <td class="table_cell tr js_cumulate_user">0</td>
                                                </tr>

                                                <tr>
                                                    <td class="table_cell">2015-11-27</td>
                                                    <td class="table_cell tr js_new_user td_high_light">0</td>
                                                    <td class="table_cell tr js_cancel_user">0</td>
                                                    <td class="table_cell tr js_netgain_user">0</td>
                                                    <td class="table_cell tr js_cumulate_user">0</td>
                                                </tr>

                                                <tr>
                                                    <td class="table_cell">2015-11-26</td>
                                                    <td class="table_cell tr js_new_user td_high_light">0</td>
                                                    <td class="table_cell tr js_cancel_user">0</td>
                                                    <td class="table_cell tr js_netgain_user">0</td>
                                                    <td class="table_cell tr js_cumulate_user">0</td>
                                                </tr>

                                                <tr>
                                                    <td class="table_cell">2015-11-25</td>
                                                    <td class="table_cell tr js_new_user td_high_light">0</td>
                                                    <td class="table_cell tr js_cancel_user">0</td>
                                                    <td class="table_cell tr js_netgain_user">0</td>
                                                    <td class="table_cell tr js_cumulate_user">0</td>
                                                </tr>

                                                <tr>
                                                    <td class="table_cell">2015-11-24</td>
                                                    <td class="table_cell tr js_new_user td_high_light">0</td>
                                                    <td class="table_cell tr js_cancel_user">0</td>
                                                    <td class="table_cell tr js_netgain_user">0</td>
                                                    <td class="table_cell tr js_cumulate_user">0</td>
                                                </tr>

                                                <tr>
                                                    <td class="table_cell">2015-11-23</td>
                                                    <td class="table_cell tr js_new_user td_high_light">0</td>
                                                    <td class="table_cell tr js_cancel_user">0</td>
                                                    <td class="table_cell tr js_netgain_user">0</td>
                                                    <td class="table_cell tr js_cumulate_user">0</td>
                                                </tr>

                                                <tr>
                                                    <td class="table_cell">2015-11-22</td>
                                                    <td class="table_cell tr js_new_user td_high_light">0</td>
                                                    <td class="table_cell tr js_cancel_user">0</td>
                                                    <td class="table_cell tr js_netgain_user">0</td>
                                                    <td class="table_cell tr js_cumulate_user">0</td>
                                                </tr>

                                                <tr>
                                                    <td class="table_cell">2015-11-21</td>
                                                    <td class="table_cell tr js_new_user td_high_light">0</td>
                                                    <td class="table_cell tr js_cancel_user">0</td>
                                                    <td class="table_cell tr js_netgain_user">0</td>
                                                    <td class="table_cell tr js_cumulate_user">0</td>
                                                </tr>

                                                <tr>
                                                    <td class="table_cell">2015-11-20</td>
                                                    <td class="table_cell tr js_new_user td_high_light">0</td>
                                                    <td class="table_cell tr js_cancel_user">0</td>
                                                    <td class="table_cell tr js_netgain_user">0</td>
                                                    <td class="table_cell tr js_cumulate_user">0</td>
                                                </tr>


                                                </tbody>
                                            </table>

                                            <table class="table" id="js_compare_table" style="display: none;"
                                                   cellspacing="0">
                                                <thead class="thead">
                                                <tr>
                                                    <th class="table_cell rank_area tl">
                                                        序号
                                                    </th>
                                                    <th class="table_cell rank_area tl">
                                                        时间
                                                    </th>
                                                    <th class="table_cell rank_area tr">
                                                        新关注人数
                                                    </th>
                                                    <th class="table_cell rank_area tr">
                                                        取消关注人数
                                                    </th>
                                                    <th class="table_cell rank_area tr">
                                                        净增关注人数
                                                    </th>
                                                    <th class="table_cell tr rank_area last_child no_extra">
                                                        累积关注人数
                                                    </th>

                                                </tr>
                                                </thead>
                                                <tbody class="tbody">
                                                </tbody>
                                            </table>
                                        </div>


                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>


            </div>

        </div>
    </div>
</div>
</body>
<script type="text/javascript">
    //var STATS_START_TIME = '1329148800';
    var dateRange1 = new pickerDateRange('date1', {
        isTodayValid : true,
        startDate : '2012-06-14',
        endDate : '2012-07-10',
        needCompare : false,
        defaultText : ' 至 ',
        //autoSubmit : true,
        inputTrigger : 'input_trigger1',
        theme : 'ta',
        success : function(obj) {
            //$("#dCon2").html('开始时间 : ' + obj.startDate + '<br/>结束时间 : ' + obj.endDate);
        }
    });

</script>
</html>
