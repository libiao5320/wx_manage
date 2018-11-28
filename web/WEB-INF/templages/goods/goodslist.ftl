<#include "../head.ftl"/>
<style>
.delete,.edit{cursor:pointer;}
</style>
<section>
	<div class="mainwrapper">
	<#include "../leftnav.ftl"/>
    <script type="text/javascript" src="/js/cityselect/jquery.cityselect.js"></script>
    <script src="../js/bootbox/bootbox.min.js"></script>
    <script type="text/javascript">
        $(function(){
            $("#city_5").citySelect({
                url:'/class/queryGoodsClass.ajax',
                prov:"",
                city:"",
                dist:"",
                nodata:"none"
            });
        });
</script>

		<div class="mainpanel">
			<div class="pageheader">
                        <div class="media">
                            <div class="pageicon pull-left">
                                <i class="fa fa-bars"></i>
                            </div>
                            <div class="media-body">
                                <ul class="breadcrumb">
                                    <li><a href=""><i class="fa fa-home"></i></a></li>
                                    <li>产品管理</li>
                                </ul>
                                <h4>产品管理</h4>
                            </div>
                        </div><!-- media -->
                    </div><!-- pageheader -->
                    
                    <div class="contentpanel">
                        <div class="alert alert-info">
                            <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                            <strong>说明：</strong>产品列表，库存为初始库存，0即库存无限；实际库存=库存-销量
                        </div>
                         <div class="panel panel-default">
                           <div class="panel-heading">
                                <form>
								<div class="form-horizontal cb pt5">
									<div class="form-line">
                                        <label class="w10 fl control-label lh20"></label>
                                        <select id="fieldName" class="select2 w100 fl">
                                          <option value="goodsName">产品名称</option>
                                          <option value="goodsId">产品ID</option>
                                          <option value="storeName">合作商家</option>

                                        </select>
                                        <input type="text" id="fieldValue" placeholder="" class="form-control input-sm w160 fl ml10">
										
                                        
										<label class="w100 fl control-label lh20">产品状态:</label>
										<select id="goodsState" class="select2 w100 fl ml10">
                                          <option value="">全部</option>
										  <option value="2">已上架</option>
										  <option value="1">已下架</option>
										  <option value="3">库存</option>
										</select>
                                        
                                        <label class="w100 fl control-label lh20">产品排序:</label>
										<select id="sort" class="select2 w160 fl ml10">
										  <option value="goodsAddtime">添加时间</option>
										  <option value="sortSaleNum">销量最高</option>
										  <option value="sortGoogsId">产品ID最大</option>
										  <option value="sortStorage">库存最小</option>
										</select>
                                        <div class="cb"></div>
									</div>
                                    
                                    <div class="form-line mt10" id="city_5">
                                        <label class="w100 fl control-label lh20">产品分类:</label>
                                        <select name="prov" id="prov" class="select2 w160 fl ml10 "></select>
                                        <select name="city" id="city" class="select2 w100 fl ml10 " id="gcId2" disabled="disabled"></select>
                                        <select name="dist" id="dist" class="select2 w160 fl ml10 " style="display:none"disabled="disabled" ></select>           
                                       
                                        <div class="cb"></div>
                                    </div>

                                    
								</div>
								


								<div class="pull-right mt-30">
									<button type="button" id="queryBtn" class="btn btn-primary btn-sm">查询</button>    
									<button type="reset"  id="clearBtn" class="btn btn-primary btn-sm">清空</button>
									<button type="button" class="btn btn-primary btn-sm" id="exportBtn">导出</button>
                                   
								</div>
                                </form>
                                
                            </div><!-- panel-heading -->
                            <div class="panel-body">
                                <div class="row">
                                    <table id="table" data-show-export="true"></table>
                                </div><!-- row -->
                            </div><!-- panel-body -->
                        </div>
                    </div><!-- contentpanel -->
		</div>
	</div>
</section>
<script src="../js/bootstrap-table/bootstrap-table-export.js"></script>
	<script src="../js/bootstrap-table/tableExport.js"></script>
<script>
	(function(){
      
		var QUERY_FLAG = false;    //是否使用了查询输入进行查询标志位
		$(document).ready(function(){
			renderTable(false);
			$("#queryBtn").click(function(){
				renderTable(true);
			});
			$("#exportBtn").click(function(){
				$(".bootstrap-table .export .dropdown-menu > li[data-type='excel']").click();
			});
			
			$("#clearBtn").click(function(){
				$("#fieldName").val('goodsName');
				$("#fieldName").select2({minimumResultsForSearch: -1});
				$("#fieldValue").val("");
				$("#goodsState").val('');
				$("#goodsState").select2({minimumResultsForSearch: -1});
				$("#sort").val('goodsAddtime');
				$("#sort").select2({minimumResultsForSearch: -1});
				$("#prov").val('');
				$("#prov").select2({minimumResultsForSearch: -1});
				$("#city").val('');
				$("#city").select2({minimumResultsForSearch: -1});
				$("#prov").trigger("change");
				$('#queryBtn').click();
			});
		});
     	var queryParams = function(params){   //提交参数
            var map = {
                pageSize : params.limit,      //每页大小
                pageNo : params.offset/10 + 1 //页码
            };
            if(QUERY_FLAG){
                if($("#fieldValue").val() != ''){
                    var field = $("#fieldName").val();
                    map[field] = $("#fieldValue").val();
                }
                if($("#sort").val() != ''){
                    map.sort = $("#sort").val();
                }
                if($("#goodsState").val() != ''){
                    map.goodsState = $("#goodsState").val();
                }
                if($("#gcId2").val() != ''){
                    map.gcId2 = $("#gcId2").val();
                }
            }else{
            	map.sort = "goodsAddtime";
            }
            params.map = JSON.stringify(map);
            return params;
        }; 
		
		var renderTable = function(flag){
			QUERY_FLAG = flag;
	        $("#table").bootstrapTable('destroy', null);
	        $("#table").bootstrapTable({
	            method : 'get',
			    url : '/goods/query.ajax',
			    queryParams : queryParams,   //查询参数
	            striped : true,
	            pagination : true,
	            pageList : [10],
	            pageSize : 10,
	            search : false,
	            showColumns : false,
	            clickToSelect : false,
	            sidePagination:"server",//设置为服务器端分页
	            columns : [ {
	                field : 'goodsId',
	                title : '产品ID',
	                align : 'left',
	                valign : 'bottom'
	            }, {
	                field : 'goodsName',
	                title : '产品名称',
	                align : 'left',
	                valign : 'middle'
	            },  {
	                field : 'storeName',
	                title : '合作商家',
	                align : 'left',
	                valign : 'middle'
	            },  {
	                field : 'classTwo.className',
	                title : '产品分类',
	                align : 'left',
	                valign : 'middle'
	            },  {
	                field : 'goodsSalenum',
	                title : '销量',
	                align : 'left',
	                valign : 'middle',
	                formatter: function(value,row,index){
	                	if(typeof(value) == 'undefined') value=0;
	                	return value;
	                }
	            },  {
	                field : 'goodsStorage',
	                title : '库存',
	                align : 'left',
	                valign : 'middle'
	                
	            },  {
	                field : 'goodsState',
	                title : '产品状态',
	                align : 'left',
	                valign : 'middle',
	                formatter: function(value,row,index){
	                	if(value==1){
			        		return '已下架';
			        	}else if(value ==2){ 
			        		return '已上架';
			        	}else if(value ==3){ 
			        		return '库存';
			        	}
			        }
	                
	            }, {
	                field : '',
	                title : '操作',
	                align : 'left',
	                valign : 'top',
	                formatter: function(value,row,index){
				    	return "<a class='edit' goodsId='" + row.goodsId + "'>编辑</a>&nbsp;&nbsp;<a class='delete' goodsId='" + row.goodsId + "'>删除</a>";
			                        
				    }
	                
	            }],
                onLoadSuccess: function(data){
                    $(".edit").click(function(){
                        window.location.href = "editGood/" + $(this).attr("goodsId") + ".htm";
                    });
                    $(".delete").click(function(){
                        var goodsId = $(this).attr("goodsId");
                        bootbox.confirm("您确定要删除此产品吗?", function(result) {
                            if(result){
                                deleteGoods(goodsId);
                            }
                        });
                    });
                }
	        });
		};
        var deleteGoods = function(id){
            $.ajax({
                url: '/goods/deleteGoodsById.ajax' ,
                type: 'POST',
                data: {id:id} ,
                dataType: 'json',
                success: function(json){
                    if(json.state == 1){
                        bootbox.alert("删除成功！");
                        $('#table').bootstrapTable('removeAll');
                        $('#table').bootstrapTable('refresh');
                    }else{
                        bootbox.alert(json.message);
                    }
                } ,
                error: function(){
                    bootbox.alert("网络忙，请稍后重试！");
                }
            });
        };
	})(window);
</script>
</body>
</html>