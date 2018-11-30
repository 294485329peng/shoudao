// QQ表情插件
(function($){  
	$.fn.qqFace = function(options){
		var defaults = {
			id : 'facebox',
			path : 'face/',
			assign : 'content',
			tip : 'em_'
		};
		var option = $.extend(defaults, options);
		var assign = $('#'+option.assign);
		var id = option.id;
		var path = option.path;
		var tip = option.tip;
		
		if(assign.length<=0){
			//alert('缺少表情赋值对象。');
			return false;
		}
		
		$(this).click(function(e){
			var strFace, labFace;
			if($('#'+id).length<=0){
				strFace = '<div id="'+id+'" style="position:absolute;display:none;z-index:1000;" class="qqFace">' +
							  '<table border="0" cellspacing="0" cellpadding="0"><tr>';
				for(var i=1; i<=75; i++){
					switch (i)
					{
					case 1:
						tip = '微笑';
						break;
					case 2:
						tip = '撇嘴';
						break;
					case 3:
						tip = '色';
						break;
					case 4:
						tip = '发呆';
						break;
					case 5:
						tip = '流泪';
						break;
					case 6:
						tip = '害羞';
						break;
					case 7:
						tip = '闭嘴';
						break;
					case 8:
						tip = '睡';
						break;
					case 9:
						tip = '大哭';
						break;
					case 10:
						tip = '尴尬';
						break;
					case 11:
						tip = '发怒';
						break;
					case 12:
						tip = '调皮';
						break;
					case 13:
						tip = '呲牙';
						break;
					case 14:
						tip = '惊讶';
						break;
					case 15:
						tip = '难过';
						break;
					case 16:
						tip = '冷汗';
						break;
					case 17:
						tip = '疯了';
						break;
					case 18:
						tip = '吐';
						break;
					case 19:
						tip = '偷笑';
						break;
					case 20:
						tip = '愉快';
						break;
					case 21:
						tip = '白眼';
						break;
					case 22:
						tip = '傲慢';
						break;
					case 23:
						tip = '饥饿';
						break;
					case 24:
						tip = '困';
						break;
					case 25:
						tip = '惊恐';
						break;
					case 26:
						tip = '流汗';
						break;
					case 27:
						tip = '憨笑';
						break;
					
					case 28:
						tip = '悠闲';
						break;
					case 29:
						tip = '奋斗';
						break;
					case 30:
						tip = '咒骂';
						break;
						
					case 31:
						tip = '疑问';
						break;
					case 32:
						tip = '嘘';
						break;
					case 33:
						tip = '晕';
						break;
					case 34:
						tip = '疯了';
						break;
					case 35:
						tip = '衰';
						break;
					case 36:
						tip = '敲打';
						break;
					case 37:
						tip = '再见';
						break;
					case 38:
						tip = '擦汗';
						break;
					case 39:
						tip = '抠鼻';
						break;
					case 40:
						tip = '糗大了';
						break;
					case 41:
						tip = '坏笑';
						break;
					case 42:
						tip = '左哼哼';
						break;
					case 43:
						tip = '右哼哼';
						break;
					case 44:
						tip = '哈欠';
						break;
					case 45:
						tip = '鄙视';
						break;
					case 46:
						tip = '委屈';
						break;
					case 47:
						tip = '快哭了';
						break;
					case 48:
						tip = '阴险';
						break;
					case 49:
						tip = '亲亲';
						break;
					case 50:
						tip = '吓';
						break;
					case 51:
						tip = '可怜';
						break;
					case 52:
						tip = '拥抱';
						break;
					case 53:
						tip = '月亮';
						break;
					case 54:
						tip = '太阳';
						break;
					case 55:
						tip = '炸弹';
						break;
					case 56:
						tip = '骷髅';
						break;
					case 57:
						tip = '菜刀';
						break;
					case 58:
						tip = '猪头';
						break;
					case 59:
						tip = '西瓜';
						break;
					case 60:
						tip = '咖啡';
						break;
					case 61:
						tip = '饭';
						break;
					case 62:
						tip = '爱心';
						break;
					case 63:
						tip = '强';
						break;
					case 64:
						tip = '弱';
						break;
					case 65:
						tip = '握手';
						break;
					case 66:
						tip = '胜利';
						break;
					case 67:
						tip = '抱拳';
						break;
					case 68:
						tip = '勾引';
						break;
					case 69:
						tip = 'OK';
						break;
					case 70:
						tip = 'NO';
						break;
					case 71:
						tip = '玫瑰';
						break;
					case 72:
						tip = '凋谢';
						break;
					case 73:
						tip = '嘴唇';
						break;
					case 74:
						tip = '爱情';
						break;
					case 75:
						tip = '飞吻';
						break;
					
						
					}
					labFace = '['+tip+']';
					strFace += '<td><img src="'+path+i+'.gif" onclick="$(\'#'+option.assign+'\').setCaret();$(\'#'+option.assign+'\').insertAtCaret(\'' + labFace + '\');" /></td>';
					if( i % 15 == 0 ) strFace += '</tr><tr>';
				}
				strFace += '</tr></table></div>';
			}
			$(this).parent().append(strFace);
			var offset = $(this).position();
			var top = offset.top + $(this).outerHeight();
			$('#'+id).css('top',top);
			$('#'+id).css('left',offset.left);
			$('#'+id).show();
			e.stopPropagation();
		});

		$(document).click(function(){
			$('#'+id).hide();
			$('#'+id).remove();
		});
	};

})(jQuery);

jQuery.extend({ 
unselectContents: function(){ 
	if(window.getSelection) 
		window.getSelection().removeAllRanges(); 
	else if(document.selection) 
		document.selection.empty(); 
	} 
}); 
jQuery.fn.extend({ 
	selectContents: function(){ 
		$(this).each(function(i){ 
			var node = this; 
			var selection, range, doc, win; 
			if ((doc = node.ownerDocument) && (win = doc.defaultView) && typeof win.getSelection != 'undefined' && typeof doc.createRange != 'undefined' && (selection = window.getSelection()) && typeof selection.removeAllRanges != 'undefined'){ 
				range = doc.createRange(); 
				range.selectNode(node); 
				if(i == 0){ 
					selection.removeAllRanges(); 
				} 
				selection.addRange(range); 
			} else if (document.body && typeof document.body.createTextRange != 'undefined' && (range = document.body.createTextRange())){ 
				range.moveToElementText(node); 
				range.select(); 
			} 
		}); 
	}, 

	setCaret: function(){ 
		if(!$.browser.msie) return; 
		var initSetCaret = function(){ 
			var textObj = $(this).get(0); 
			textObj.caretPos = document.selection.createRange().duplicate(); 
		}; 
		$(this).click(initSetCaret).select(initSetCaret).keyup(initSetCaret); 
	}, 

	insertAtCaret: function(textFeildValue){ 
		var textObj = $(this).get(0); 
		if(document.all && textObj.createTextRange && textObj.caretPos){ 
			var caretPos=textObj.caretPos; 
			caretPos.text = caretPos.text.charAt(caretPos.text.length-1) == '' ? 
			textFeildValue+'' : textFeildValue; 
		} else if(textObj.setSelectionRange){ 
			var rangeStart=textObj.selectionStart; 
			var rangeEnd=textObj.selectionEnd; 
			var tempStr1=textObj.value.substring(0,rangeStart); 
			var tempStr2=textObj.value.substring(rangeEnd); 
			textObj.value=tempStr1+textFeildValue+tempStr2; 
			textObj.focus(); 
			var len=textFeildValue.length; 
			textObj.setSelectionRange(rangeStart+len,rangeStart+len); 
			textObj.blur(); 
		}else{ 
			textObj.value+=textFeildValue; 
		} 
	} 
});