/**杨鑫*/
$(function(){
	$('.save').click(function(){
		if($("input[name='storeName']").val() == ''){
			bootbox.alert("商家名称为空", function() {
			});
			return;
		}
		if($("input[name='sellerName']").val() == ''){
			bootbox.alert("商家登录用户名为空", function() {
			});
			return;
		}
		if($("input[name='storeLoginPhone']").val() == ''){
			bootbox.alert("商家登录电话为空", function() {
			});
			return;
		}
		if($(this).attr("id") == "addStore"){
			var flag = 0;
			$.ajax({
				url:'/store/validateRegistor.ajax',
				data:{phone:$("input[name='storeLoginPhone']").val()},
				type:'post',
				dataType:'json',
				async: false,
				success:function(json){
					if(json.state==1){
						flag = -1;
					}else{
						flag = 0;
					}
				},
				error:function(){
					flag = -2;
				}
			})
			if(flag == -1){
				bootbox.alert("商家登录电话已经存在，请输入其他电话！", function() {
				});
				return;
			}
			if(flag == -2){
				bootbox.alert("商家登录电话校验失败！", function() {
				});
				return;
			}
		}
		if($("select[name='cityId']").val() == ''){
			bootbox.alert("区域城市为空", function() {
			});
			return;
		}
		if($("select[name='areaId']").val() == ''){
			bootbox.alert("区域区县为空", function() {
			});
			return;
		}
		if($("input[name='storeAddress']").val() == ''){
			bootbox.alert("商家详细地址为空", function() {
			});
			return;
		}
		if($("input[name='storePhone']").val() == ''){
			bootbox.alert("商家电话为空", function() {
			});
			return;
		}
		if($("input[name='accounts']").val() == ''){
			bootbox.alert("商家开户名称为空", function() {
			});
			return;
		}
		if($("input[name='accountsNo']").val() == ''){
			bootbox.alert("商家开户账号为空", function() {
			});
			return;
		}
		if($("input[name='accountHolder']").val() == ''){
			bootbox.alert("商家开户人为空", function() {
			});
			return;
		}
		if($("input[name='serviceRatio']").val() == ''){
			bootbox.alert("商家服务费比例为空", function() {
			});
			return;
		}
		if($("input[name='serviceRatio5']").val() == ''){
			bootbox.alert("商家评价服务系数5为空", function() {
			});
			return;
		}
		if($("input[name='serviceRatio4']").val() == ''){
			bootbox.alert("商家评价服务系数4为空", function() {
			});
			return;
		}
		if($("input[name='serviceRatio3']").val() == ''){
			bootbox.alert("商家评价服务系数3为空", function() {
			});
			return;
		}
		if($("input[name='serviceRatio2']").val() == ''){
			bootbox.alert("商家评价服务系数2为空", function() {
			});
			return;
		}
		if($("input[name='serviceRatio1']").val() == ''){
			bootbox.alert("商家评价服务系数1为空", function() {
			});
			return;
		}
		if($("input[name='storeLabel']").val() == ''){
			bootbox.alert("商家图片为空，请重新上传商家图片！", function() {
			});
			return;
		}
		if($("input[name='storeWorkingtime']").val() == ''){
			bootbox.alert("商家营业时间为空", function() {
			});
			return;
		}
		if($("input[name='storeDetail']").val() == ''){
			bootbox.alert("商家介绍为空", function() {
			});
			return;
		}
		$.ajax({
			url:'/store/save.ajax',
			data:$('form').serialize(),
			type:'post',
			dataType:'json',
			success:function(json){
				if(json.state){
					bootbox.alert(json.message, function() {
						window.location.href="/store/index.htm";
					});
				}else{
					bootbox.alert(json.message, function() {
					});
				}
			},
			error:function(){
				alert('系统繁忙，请稍候再试！');
			}
		})
	});
	
	
	$('.area').change(function(){
		var value = $(this).val();
		var name = $(this).attr('name');
		if(name != 'areaId'){
			if(name == 'provinceId'){
				name = 'cityId';
			}else if(name == 'cityId'){
				name = 'areaId';
			}
			changeArea(name,value);
		}
	})

	
	/****/
	$('#locationMap').click(function(){
		var _this = $(this);
		bootbox.dialog({
			message: "<iframe width='100%' id='mapIframe' style='margin: -10px 0px;' height='370' frameborder='no' border='0' src='/store/map.htm'></iframe>",
			title: "地图选点",
			buttons: {
				success: {
					label: "确定",
					className: "btn-primary btn-xs",
					callback: function() {
						var lnsX = $("#mapIframe").contents().find("#lnsX").val();
						var lnsY = $("#mapIframe").contents().find("#lnsY").val();
						$('input[name="lbsX"]').val(lnsX);
						$('input[name="lbsY"]').val(lnsY);
						_this.text('修改地图位置');
					}
				},
				cancel: {
					label: "取消",
					className: "btn-default btn-xs",
					callback: function() {
						
					}
				}
			}
		});
	});
})

var changeArea = function(id,value){
	if(value != null && value !='' && value !='undefined'){
		$.ajax({
			url:'/query/area.ajax',
			data:{"id":value},
			type:'post',
			dataType:'json',
			async: true,
			success:function(json){
				if(json.state){
					var data = json.param;
					if(data != null && data !='' && data != 'undefined'){
						$('select[name="'+id+'"]').empty();
						$('select[name="'+id+'"]').append('<option value="">请选择</option>');
						$.each(data,function(n,value){
							var html = '<option value="'+value.areaId+'">'+value.areaName+'</option>';
							$('select[name="'+id+'"]').append(html);
						});
						$('select[name="'+id+'"]').find("option:eq(1)").attr("selected","selected");
						$('select[name="'+id+'"]').select2({minimumResultsForSearch: -1});
						$('select[name="'+id+'"]').trigger("change");
					}
				}
			},
			error:function(){
				alert('系统繁忙，请稍候再试！');
			}
		})
	}
}

var returnAddress = function(){
	var city = $('#cityId option:selected').text();
	var county = $('#areaId option:selected').text();
	var address = $('input[name="storeAddress"]').val();
	return city+county+address;
}

/**上传图片*/
$(document).on('ready',function(){
	$("#provinceId").val(18);
	$("#provinceId").select2({minimumResultsForSearch: -1});
	$("#provinceId").trigger("change");
	/*$("#cityId").val(275);
	$("#cityId").select2({minimumResultsForSearch: -1});
	$("#cityId").trigger("change");*/
	
	
	$('input[name="uploadFile"]').each(function(){
		//var id = $(this).attr('id');
		var name = $(this).attr('data-name');
		$(this).fileinput({
			language: 'zh', //设置语言
			uploadUrl:'/store/uploadImg.ajax', //上传的地址
			allowedFileExtensions : ['jpg', 'png','gif'],//接收的文件后缀
			showUpload: true, //是否显示上传按钮
			showCaption: false,//是否显示标题
			browseClass: "btn btn-primary", //按钮样式
			maxFileSize: 2000,
			maxFileCount: 1,
			mainClass: "input-group-lg",
		});
		/**上传成功监听事件*/
		$(this).on("fileuploaded", function(event, data, previewId, index) {
			var imagePath = data.response.param.imagePath;
			var _input = $(this).parents('td').find('input[name="'+name+'"]');
			if(_input.length == 0){
				$(this).parents('td').append('<input type="hidden" name="'+name+'" value="'+imagePath+'"><img src="/uploadFiles/store/'+imagePath+'" style="width:10%">');
			}else{
				_input.val(imagePath);
				_input.next().attr('src','/uploadFiles/store/'+imagePath);
				_input.next().show();
			}
		});
		/***移除事件*/
		$(this).on('fileclear',function(event, data, previewId, index){
			var _input = $(this).parents('td').find('input[name="'+name+'"]');
			_input.val('');
			_input.next().attr('src','');
			_input.next().hide();
		});
	})
	/***file-thumbnail-footer*/
});