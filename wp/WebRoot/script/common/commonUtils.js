var BaseUtils = {
		showWaitMsg : function(msg) {
			if (msg) {

			} else {
				msg = '正在处理，请稍候...';
			}
			var panelContainer = $("body");
			$("<div id='msg-background' class='wait-mask' style=\"display:block;z-index:10006;\"></div>").appendTo(panelContainer);
			var msgDiv = $("<div id='msg-board' class='wait-mask-msg' style=\"display:block;z-index:10007; position:fixed;left:50%\"></div>").html(msg).appendTo(
					panelContainer);
			msgDiv.css("marginLeft", -msgDiv.outerWidth() / 2);
		},
		hideWaitMsg : function() {
			$('.wait-mask').remove();
			$('.wait-mask-msg').remove();
		}
};
/**
 * 
 * @param url 请求链接
 * @param param 请求参数
 * @param callBackFunction 回调函数，处理返回data
 */
function defaultAjax(url,param,callBackFunction){
	$.ajax({
		url: url,
		type:"post",
		data: param,
		dataType:"json",
		async : false,
		success: function(data) {
			if(callBackFunction == "" || callBackFunction == undefined || callBackFunction == null){
				
			}else{
				callBackFunction(data);
			}
			
		}
	});
}

/**
 * layer弹出框中调用ajax默认回调函数
 * 
 * 执行结果：提示是否保存成功，并且如果成功则关闭当前弹出框
 * 
 * @param data
 */
function defaultAjaxCallBackInLayerModule(data){
	//var ret = jQuery.parseJSON(data);
	BaseUtils.hideWaitMsg();
	alert(data.msg);
	if (data.flag) {
		var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
		parent.layer.close(index);
	}
}

/**
 * 
 * @param url 请求链接
 * @param param 请求参数
 * @param callBackFunction 回调函数，处理返回data
 */
function defaultDialog(title,url,width,height){
	layer.open({
		title:title,
	    type: 2,
	    area: [width, height],
	    fix: false, //不固定
	    maxmin: true,
	    content: url
	});
}

/**
 * 
 * @param msg 弹窗显示消息
 * @param confirmFunction 点击确认后执行的方法名
 */
function defaultConfirm(msg,confirmFunction){
	layer.confirm(msg, {
	    btn: ['确定','取消'] //按钮
	}, function(index){
		confirmFunction();
	    layer.close(index);
	});
}