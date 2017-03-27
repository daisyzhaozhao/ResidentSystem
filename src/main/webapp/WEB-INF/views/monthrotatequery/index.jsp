<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<%@ include file="/WEB-INF/views/common.jsp" %>
<script type="text/javascript">
  	var which = ${which};
  	var startDate = '${startDate}';
	var datagrid;
	var rowEditor=undefined;
	$(function(){
		$('#startDate').datebox().datebox('calendar').calendar({
			validator: function(date1){
				return date1.getDate()==1;
			}
		});
		$('#startDate').datebox('setValue',startDate);
		
		datagrid=$("#dg").datagrid({
			url:"${ctx}/rotary/list.do",//加载的URL
		    isField:"id",	
			pagination:true,//显示分页
			pageSize:20,//分页大小
			pageList:[20,40,60],//每页的个数
			fit:true,//自动补全
			singleSelect:true,
			nowrap: false,
			fitColumns : true,
			iconCls:"icon-save",//图标
			

			columns:[[      //每个列具体内容
		              {field:'planId', hidden:true },   
		              {field:'departmentId', hidden:true },   
		              {field:'subjectId', hidden:true },   
		              {field:'userName', title:'学生',  width:100,align:'center' },
		              {field:'subjectName', title:'学科',  width:100,align:'center' },
		              {field:'departmentName', title:'轮转科室',  width:200,align:'center' },
		              {field:'fullName', title:'带教老师',  width:200,align:'center',
		            	  formatter: 
			            	  function(value,row){
		            		  if( row.teacher)
			                	  return row.teacher.fullName;
			                  }
		              }
		          ]],
		          onBeforeLoad: function(param){
			        	 param.which = which;
			        	 param.departmentId = "${deptId}";
			        	 setEndDate(param);
			      }
		       });
		$("#btn_search").click(function(){
			var param = $("#searchForm").serializeJson();
			datagrid.datagrid('load', param);

		});
		
	});
	
	function setEndDate(param) {
   		if (param['startDate'] == undefined || param['startDate']==null) {
			param['startDate'] = startDate;
    	} 
       	 
     	startDate = param['startDate'];
     	var arr1 = param['startDate'].split("-"); 
		var date = new Date(arr1[0],parseInt(arr1[1]),arr1[2]); 
		param['endDate'] = formatDate(date);
	}
	
	//格式化日期：yyyy-MM-dd
    function formatDate(date) {
        var myyear = date.getFullYear();
        var mymonth = date.getMonth()+1;
        var myweekday = date.getDate();

        if(mymonth < 10){
            mymonth = "0" + mymonth;
        }
        if(myweekday < 10){
            myweekday = "0" + myweekday;
        }
        return (myyear+"-"+mymonth + "-" + myweekday);
    }
	
	
	
	</script>
</head>

<body style="padding:0 4px; margin:0;  overflow: hidden; ">
    
     <div class="easyui-layout" style="width:100%;height:100%;" data-options="fit:true">
		<div data-options="region:'north'" style="height:80px">
				 <form id="searchForm" >
						<table cellpadding="5">
				    		<tr>
				    			<td>名称:</td>
				    			<td><input class="easyui-textbox" type="text"  name="userName" ></input></td>
				    			<td>轮转科室:</td>
				    			<td><input class="easyui-textbox" type="text"  name="departmentName" ></input></td>
				    			<td>查询时间:</td>
				    			<td><input id="startDate" name="startDate" class="easyui-datebox" style="width:200px"></td>
				    			<input id="endDate" type="hidden"  name="endDate" style="width:200px">
								<!-- <td><input id="endDate"  name="endDate" class="easyui-datetimebox" style="width:200px"></td> -->
				    			<td ><a href="#" id="btn_search" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:80px">Search</a></td>
				    		</tr>
				    		<tr>
				    		</tr>
				    	</table>
				 </form>
	</div>
	<div data-options="region:'center'" >
			<table id="dg" >
			</table>
	</div>
		
</div>
    
</body>
</html>