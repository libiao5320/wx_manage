<div class="locked  center-block ">
	<div class="lockedpanel" style="width:535px;">
		<div class="pageheader" style="height:180px;">
            <div class="row">
		      <div class="col-xs-12" 
		         style="background-color: #eee;line-height:50px;height:50px;">
		         顾客提现明细
		      </div>
		   </div>
		   <div class="row">
		      <div class="col-xs-12" 
		         style="background-color: #fff;">
		         	<table class="table">
		         		<tr>
		         			<td style="background-color: #eee;">提现顾客</td><td>${kiting.name !'-'}</td>
		         		</tr>
		         		<tr>
		         			<td style="background-color: #eee;">账户余额</td><td>${kiting.member.availablePredepositDollor !'-'}</td>
		         		</tr>
		         		<tr>
		         			<td style="background-color: #eee;">收益余额</td><td>-</td>
		         		</tr>
		         	</table>
		      </div>
		   </div>
        </div><!-- pageheader -->
        
        <div class="contentpanel">
             <div class="panel panel-default">
                <div class="panel-body">
                	
                    <div class="row">
                        <table id="table">
                        </table>
                    </div><!-- row -->
                </div><!-- panel-body -->
            </div>
        </div><!-- contentpanel -->
	</div>
</div>
<script>
	$(function(){
		var queryParams = function(params){   //提交参数
			var map = {
				memberId : ${kiting.memberId !''},
				pageSize : params.limit,      //每页大小
				pageNo : params.offset/10 + 1 //页码
			};
			
			params.map = JSON.stringify(map);
			
			return params;
		};  
		
        $("#table").bootstrapTable('destroy', null);
        $("#table").bootstrapTable({
            method : 'get',
		    url : '/kiting/list.ajax',
		    queryParams : queryParams,
            striped : true,
            pagination : true,
            pageList : [10],
            pageSize : 10,
            search : false,
            showColumns : false,
            clickToSelect : false,
            sidePagination:"server",//设置为服务器端分页
            columns : [ {
                field : 'type',
                title : '收益类型',
                align : 'left',
                valign : 'bottom',
                formatter: function(value,row,index){
                	return '-';
                }
            }, {
                field : 'memberName',
                title : '顾客姓名',
                align : 'left',
                valign : 'middle'
            },  {
                field : 'memberMobile',
                title : '电话',
                align : 'left',
                valign : 'middle'
            },  {
                field : 'createTime',
                title : '申请时间',
                align : 'left',
                valign : 'middle'
            }, {
                field : 'reason',
                title : '申请理由',
                align : 'left',
                valign : 'middle'
            }, {
                field : 'status',
                title : '审核状态',
                align : 'left',
                valign : 'middle',
                formatter: function(value,row,index){
                	if(value == 'examining'){
                		return '待审核';
                	}
                	if(value == 'unexamine'){
                		return '审核拒绝';
                	}
                	if(value == 'examined'){
                		return '审核通过';
                	}else{
                		return '-';
                	}
                }
            }]
        });
	});
</script>