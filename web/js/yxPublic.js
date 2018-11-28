var ary = new Array(1,2,3,4,5);
var tr=0;
var loadAjax = function(p,s,t,l){
	var ts = t/s;
	if(t%s > 0){
		ts = parseInt(t/s) +1;
	}
	tr = ts;
	var i = (p-1)*s+1;
	var end = p*s;
	$('.span').text('显示第 '+i+' 到第 '+(l+i-1)+' 条记录，总共'+t+'条记录');
	$('.btn-group').find('button').html(s+'<span class="caret"></span>');
	var y = (ts-p-1);
	if(y >=5){
		y =5;
	}
	var  html = $('#pagintor').text().trim();
	if(html == '' || html == null || html == 'undefined'){
		loadPagintor(1,ts);
	}else{
		if($.inArray(p,ary) < 0){
			 $('#pagintor').html('');
			 insertAry(p);
			loadPagintor(p,ts);
		}
	}
}

var loadPagintor = function(v,tr){
	$('#pagintor').append('<li><a mid="1">首页</a></li>');
	$('#pagintor').append('<li><a aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>');
	if(v == tr){
		v = tr -4;
		insertAry(v);
	}
	for (var int = 0; int < 5; int++) {
		if(v <= tr){
			$('#pagintor').append('<li><a mid="'+v+'">'+v+'</a></li>');
			v++;
		}
	}
	$('#pagintor').append('<li><a aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>');
	$('#pagintor').append('<li><a mid="'+tr+'">尾页</a></li>');
}

$(function(){
	$('#pagintor li').live('click',function(){
		var s = $(this).find('a').attr('mid');
		if(s != null && s != '' && s !='undefined'){
			$('input[name="offset"]').val(s);
		}else{
			var m = $(this).find('a').attr('aria-label');
			var t = $('input[name="offset"]').val();
			
			if(m == 'Previous'){
				if(Number(t) >1){
					$('input[name="offset"]').val(Number(t)-1);
				}
			}else{
				if(Number(t)<tr){
					$('input[name="offset"]').val(Number(t)+1);
				}
			}
		}
		ajaxPost($('input[name="url"]').val());
	});
	
	$('.dropdown-menu li').live('click',function(){
		var limit = $(this).find('a').text();
		$(this).parent().prev().html(limit+'<span class="caret"></span>');
		$('input[name="offset"]').val(1);
		$('input[name="limit"]').val(limit);
		ajaxPost($('input[name="url"]').val());
	})
});

var ajaxPost = function(path){
	$('form').append('<input type="hidden" name="url" value="'+path+'"/>');
	var data = $('form').serialize();
	$.ajax({
		url:path,
		data:data,
		type:'post',
		dataType:'json',
		success:function(json){
			var load_data = json.data;
    		var size = json.size;
    		tablestrop(load_data,size);
    		loadAjax(json.rows,size,json.total,json.data.length);
    		$('#pagintor li').each(function(n,value){
    			var a = $(this).find('a').attr('mid');
    			$(this).find('a').css('background-color','');
    			if(Number(a) == json.rows){
    				$(this).find('a').css('background-color','#dedede');
    			}
    		});
		}
	});
}

var insertAry = function(v){
	for(var rs=0;rs<5;rs++){
		ary[rs] = v;
		v++;
	}
}


var judgeXgrade = function(v){
	switch(v){
	  	case 1 : return "1星";
	  	break;
	  	case 2 : return "2星";
	  	break;
	  	case 3 : return "3星";
	  	break;
	  	case 4 : return "4星";
	  	break;
	  	case 5 : return "5星";
	  	break;
	  	default: return "-";
	  	break;
	}   
}


var judgeState = function(v){
	switch (v) {
		case 1: return '未付款';
			break;
		case 2:	return '未消费';
			break;
		case 3:	return '未付余款';
			break;
		case 4:	return '未评价';
			break;
		case 5:	return '已评价';
			break;
		case 6:	return '已取消';
			break;
		case 7:	return '退款中';
			break;
		case 8:	return '已退款';
			break;
		case 9:	return '退款已拒绝';
			break;
		case 10:return '投诉处理中';
			break;
		case 11:return '投诉已解决';
			break;
		case 11: return '已过期';
			break;
		default:
			break;
	}
}

var search = function(url){
	$('input[name="offset"]').val(1);
	$('input[name="limit"]').val(10);
	ajaxPost(url);
}


/**数值转换，把string数字转换成number*/
var convert = function(val){
	if(check(val)){
		if(typeof(val) == 'string'){
			val = parseFloat(val);
		}
		return val;
	}else{
		return null;
	}
}


/**把价格分转换成元保留2位小数点*/
var moneyFormat = function(money){
	money = convert(money);
	var doubleMoney = parseFloat(money/100).toFixed(2);
	
	return doubleMoney;
}


/**
 * 判断是否为金额
 */
var check = function(v)
{
	var a=/^([0-9])|([1-9]\d+)\.\d?$/;
	if(!a.test(v))
	{
	return false;
	}
	else
	{
	return true;
	}
}


/**时间格式化*/
Date.prototype.Format = function (fmt) { //author: meizz 
    var o = {
        "M+": this.getMonth() + 1, //月份 
        "d+": this.getDate(), //日 
        "h+": this.getHours(), //小时 
        "m+": this.getMinutes(), //分 
        "s+": this.getSeconds(), //秒 
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
        "S": this.getMilliseconds() //毫秒 
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
}

/**重置*/
var dataReset = function(){
	document.getElementById('from-data').reset();
	$('select').each(function(n,value){
		$(this).find('option:eq(0)').attr('selected',true);
		$(this).val($(this).val());
		$(this).select2({minimumResultsForSearch: -1});
	});
	returnList();
}

var checkFloat = function(v,$this){
	var s = v.split('.');
	var l = s.length;
	if(l>2){
		$this.val(v.substring(0,v.length-1));
	}else if(l==2){
		var r = s[0];
		var r1 = s[1];
		if(r.length >=2){
			if(r.charAt(0) == '0'){
				if(r.charAt(1) != '.'){
					$this.val(0);
				}
			}
		}
		if(isNaN(r1)){
			$this.val(r);
		}
	}else{
		if(v.length >=2){
			if(!isNaN(v)){
				if(v.charAt(0)=='0'){
					$this.val(0);
				}
			}else{
				$this.val('');
			}
		}
	}
	return true;
}