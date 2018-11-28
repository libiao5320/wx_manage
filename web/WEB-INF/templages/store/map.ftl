<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0"/>
<meta name="apple-mobile-web-app-capable" content="no"/>
<meta name="format-detection" content="telephone=no" />
<title>根据地址查询经纬度</title>
<link href="css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=E4a51c429ff711c1072eb83bf39f3096"></script>
<script src="/js/jquery-1.11.1/jquery-1.11.1.min.js"></script>
<style>
.btn{-moz-border-radius: 3px; -webkit-border-radius: 3px; border-radius: 3px; line-height: 21px; -moz-transition: all 0.2s ease-out 0s; -webkit-transition: all 0.2s ease-out 0s; transition: all 0.2s ease-out 0s; padding: 8px 15px; border-width: 0;}.btn-xs{padding: 2px 10px; font-size: 12px;}.btn-primary{color: #fff; background-color: #428bca; border-color: #357ebd;}.btn-primary:hover, .btn-primary:focus, .btn-primary:active, .btn-primary.active, .open>.dropdown-toggle.btn-primary{color: #fff; cursor:pointer; background-color: #3071a9; border-color: #285e8e;}.btn:hover, .btn:focus{color: #fff; text-decoration: none;}.form-control{width: 300px; height: 25px; padding: 2px 5px; font-size: 14px; line-height: 25px; color: #555; background-color: #fff; border: 1px solid #ccc; border-radius: 4px; -webkit-transition: border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s; -o-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s; transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;}
#allmap {width: 100%;height: 100%;overflow: hidden;margin:0;font-family:"微软雅黑";}
</style>
</head>
<body>
    <div>   
    	<span style="font-size:13px;">要查询的地址：</span><input id="suggestId" class="form-control" type="text" value=""/>
    		<!--style="display:none;"-->
		<div id="searchResultPanel" style="border:1px solid #C0C0C0;width:150px;height:auto; display:none;"></div>
    	<span style="display:none;">查询结果(经纬度)：<input id="lnsX" type="text" /><input id="lnsY" type="text"></span>
    	<input type="button" class="btn btn-primary btn-xs" value="刷新" onclick="window.location.reload();"/>
    	<div id="l-map" style="width: 100%;margin-top:2px; height: 342px;overflow:hidden;"></div>
    </div>
	<script type="text/javascript">
		var map = new BMap.Map("l-map");
		var geoc = new BMap.Geocoder();
		var points;
		var lng = $('input[name="lbsX"]', window.parent.document).val();
		var lat = $('input[name="lbsY"]', window.parent.document).val();
		if(lng != null && lng !='' && lng != 'undefined'){
			points = new BMap.Point(lng,lat);
			getLoaction(points);
			addMarker(points);
		}else{
			var address = parent.returnAddress();
			var province = $('#provinceId option:selected',window.parent.document).text();
			geoc.getPoint(address,function(point){
				if(point){
					points = point;
					getLoaction(points);
					addMarker(points);
				}else{
					map.centerAndZoom("长沙",18);
				}
			},province);
		}
		// 百度地图API功能
		function G(id) {
			return document.getElementById(id);
		}
		
		map.enableScrollWheelZoom(true);
		
		map.addEventListener("click", function(e){
			map.clearOverlays();
			var pt = e.point;
			getLoaction(pt);
			addMarker(pt);
		});
		
		var ac = new BMap.Autocomplete(    //建立一个自动完成的对象
			{"input" : "suggestId"
			,"location" : map
		});
	
		ac.addEventListener("onhighlight", function(e) {  //鼠标放在下拉列表上的事件
			var str = "";
			var _value = e.fromitem.value;
			var value = "";
			if (e.fromitem.index > -1) {
				value = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
			}    
			str = "FromItem<br />index = " + e.fromitem.index + "<br />value = " + value;
			
			value = "";
			if (e.toitem.index > -1) {
				_value = e.toitem.value;
				value = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
			}    
			str += "<br />ToItem<br />index = " + e.toitem.index + "<br />value = " + value;
			G("searchResultPanel").innerHTML = str;
		});
		
		var myValue;
		ac.addEventListener("onconfirm", function(e) {    //鼠标点击下拉列表后的事件
			var _value = e.item.value;
			myValue = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
			G("searchResultPanel").innerHTML ="onconfirm<br />index = " + e.item.index + "<br />myValue = " + myValue;
			setPlace();
		});
	
		function setPlace(){
			map.clearOverlays();    //清除地图上所有覆盖物
			function myFun(){
				var pp = local.getResults().getPoi(0).point;    //获取第一个智能搜索的结果
				addMarker(pp);
			}
			var local = new BMap.LocalSearch(map, { //智能搜索
			  onSearchComplete: myFun
			});
			local.search(myValue);
		}
		
		function getLoaction(point){
			geoc.getLocation(point, function(rs){
				var addComp = rs.addressComponents;
				var address = '';
				if(addComp.province == addComp.city){
					address = addComp.province + addComp.district + addComp.street +  addComp.streetNumber;
				}else{
					address = addComp.province + addComp.city +  addComp.district + addComp.street +  addComp.streetNumber;
				}
				$('#suggestId').val(address);
			});
		}
		
		function addMarker(points){
			document.getElementById('lnsX').value=points.lng;
			document.getElementById('lnsY').value=points.lat;
			map.centerAndZoom(points,18);
			var marker = new BMap.Marker(points);  // 创建标注
			map.addOverlay(marker);              // 将标注添加到地图中
		}	   
	</script>
</body>
</html>