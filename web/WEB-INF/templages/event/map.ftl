<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>根据地址查询经纬度</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=1.3"></script>
    <style>.btn{-moz-border-radius: 3px; -webkit-border-radius: 3px; border-radius: 3px; line-height: 21px; -moz-transition: all 0.2s ease-out 0s; -webkit-transition: all 0.2s ease-out 0s; transition: all 0.2s ease-out 0s; padding: 8px 15px; border-width: 0;}.btn-xs{padding: 2px 10px; font-size: 12px;}.btn-primary{color: #fff; background-color: #428bca; border-color: #357ebd;}.btn-primary:hover, .btn-primary:focus, .btn-primary:active, .btn-primary.active, .open>.dropdown-toggle.btn-primary{color: #fff; cursor:pointer; background-color: #3071a9; border-color: #285e8e;}.btn:hover, .btn:focus{color: #fff; text-decoration: none;}.form-control{width: 300px; height: 25px; padding: 2px 5px; font-size: 14px; line-height: 25px; color: #555; background-color: #fff; border: 1px solid #ccc; border-radius: 4px; -webkit-transition: border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s; -o-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s; transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;}</style>
</head>
<body style="width:100%;margin:0;">
    <div style="width:100%;margin:0;">   
        	<span style="font-size:13px;">要查询的地址：</span><input id="text_" class="form-control" onkeyup="triggerSearch(this,event)" type="text" value=""/>
        	<span style="display:none;">查询结果(经纬度)：<input id="result_" type="text" /></span>
        	<input type="button" class="btn btn-primary btn-xs" value="查询" onclick="searchByStationName();"/>
        	<div id="container" style="width: 100%;margin-top:2px; height: 342px;overflow:hidden;"></div>
    </div>
</body>
<script type="text/javascript">
    var map = new BMap.Map("container");
    map.centerAndZoom("长沙", 12);
    map.enableScrollWheelZoom();    //启用滚轮放大缩小，默认禁用
    map.enableContinuousZoom();    //启用地图惯性拖拽，默认禁用

    //map.addControl(new BMap.NavigationControl());  //添加默认缩放平移控件
    //map.addControl(new BMap.OverviewMapControl()); //添加默认缩略地图控件
    //map.addControl(new BMap.OverviewMapControl({ isOpen: true, anchor: BMAP_ANCHOR_BOTTOM_RIGHT }));   //右下角，打开

	//单击获取点击的经纬度
	map.addEventListener("click",function(e){
		map.clearOverlays();//清空原来的标注
		var marker = new BMap.Marker(new BMap.Point(e.point.lng, e.point.lat));  // 创建标注，为要查询的地方对应的经纬度
	    map.addOverlay(marker);
	    document.getElementById("result_").value = e.point.lng + "," + e.point.lat;
	});

    var localSearch = new BMap.LocalSearch(map);
    localSearch.enableAutoViewport(); //允许自动调节窗体大小
	function searchByStationName() {
	    map.clearOverlays();//清空原来的标注
	    var keyword = document.getElementById("text_").value;
	    localSearch.setSearchCompleteCallback(function (searchResult) {
	        var poi = searchResult.getPoi(0);
	        document.getElementById("result_").value = poi.point.lng + "," + poi.point.lat;
	        map.centerAndZoom(poi.point, 13);
	        var marker = new BMap.Marker(new BMap.Point(poi.point.lng, poi.point.lat));  // 创建标注，为要查询的地方对应的经纬度
	        map.addOverlay(marker);
	        var content = document.getElementById("text_").value + "<br/><br/>经度：" + poi.point.lng + "<br/>纬度：" + poi.point.lat;
	        var infoWindow = new BMap.InfoWindow("<p style='font-size:14px;'>" + content + "</p>");
	        //marker.addEventListener("click", function () { this.openInfoWindow(infoWindow); });
	        // marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
	    });
	    localSearch.search(keyword);
	} 
	function triggerSearch(o,e){
		var e = event || window.event || e;
        if(e && e.keyCode==13){ 
             searchByStationName();
        }
	}
</script>
</html>