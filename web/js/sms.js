/*
 * 短信平台获取验证码类
 * 作者：周降临
 * 邮箱：zhoutq@outlook.com
 */
var sms=function(){
	
	/**
	 * 通过亿美平台发送短信
	 */
	var smsYiMei=function(phone,content)
	{
		var cdkey = '6SDK-EMY-6688-KHXNQ';
		var pwd = '182001';
		var content = '【贝多】请妥善保管好您的验证码，不要泄露给任何人'+content;
		var url = "http://sdk4report.eucp.b2m.cn:8080/sdkproxy/sendsms.action?cdkey="+cdkey+"&password="+pwd+"&phone="+phone+"&message="+content+"&addserial=";
		$.get(url);
		return url;
	}
	
	/*
	 * 通过企信通平台发送短信
	 */
	this.smsQXT=function(phone, content)
	{
		var user = 'ceshi';
	    var	pwd = 'bdjk';
		var content = '【贝多】请妥善保管好您的验证码，不要泄露给任何人'+content;
		//发送短信
		url = "http://221.179.180.158:9007/QxtSms/QxtFirewall?OperID="+user+"&OperPass="+pwd+"&DesMobile="+phone+"&Content="+content+"&ContentType=15";
		$.get(url);
	    return url;
	}
	
	/*
	 * 随机产生idx位数字验证码
	 * 
	 */
		this.addNumber=function (idx){
		var str = '';
		for(var i = 0; i < idx; i += 1){
		str += Math.floor(Math.random() * 10);
		}
		return str;
		}
}
/*
 * 调用方式列子

$(function(){
	  var sms1=new sms();
	  var number=sms1.addNumber(6);
      sms1.smsYiMei("15574856759",number);
      return number;
})
 */