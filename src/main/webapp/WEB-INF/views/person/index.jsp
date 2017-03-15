<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
   <%@ include file="/WEB-INF/views/common.jsp" %>
<script>
var teacherAlldatagrid;
$(function(){
	teacherAlldatagrid=$('#dg').datagrid({
// 		url:"${ctx}/person/list.do",//加载的URL
	    isField:"id",
		pagination:true,//显示分页
		pageSize:10,//分页大小
		pageList:[10,15,20],//每页的个数
		fit:true,//自动补全
		fitColumns:true,
		iconCls:"icon-save",//图标
		//selectOnCheck: true,
		//checkOnSelect: true,
		
		columns:[[      //每个列具体内容
	              {field:'userId', hidden:true },      
	              {field:'workNo', title:'登录号', width:100,align:'center' },
	              {field:'staffName', title:'姓名',  width:100,align:'center' },
	              {field:'mobile', title:'电话',  width:100,align:'center' },
	              {field:'userType ', title:'身份 ',  width:100,align:'center' ,
	            	  formatter:function(value,rowData,rowIndex) { 
							
	            		switch(rowData.userType){
	            		case 1:
	            			return "本科生";
	            		case 2:
	            			return "研究生 ";
	            		
	            		case 3:
	            			return "住院医 ";
	            		case 4:
	            			return "进修医  ";
	            		case 5:
	            			return "教研室管理员 ";
	            		case 6:
	            			return "教学秘书或主任";
	            		case 7:
	            			return "老师";
	            		case 8:
	            			return "INTERN";
	            		case 9:
	            			return "医联体";
	            		case 10:
	            			return " 对口支援 "
	            		default:
	            			return "--";
	            		
	            		}
	            		  
	            	  }
	            	  },
	              {field:'idCardNo', title:'身份证',  width:100,align:'center' }
	              
	          ]],
	          
	         
	      		
	      	});
	      	
	 $("#th_search").click(function(){
   		var param=$("#selForm").serializeJson();
   		teacherAlldatagrid.datagrid('load',param);
   	})

	});
	
	

</script>
</head>

<body style="padding: 0 4px; margin: 0; overflow: hidden;">
<div class="easyui-layout" style="width: 100%; height: 100%;"
		data-options="fit:true">
		<div title="人员查询" data-options="region:'north'" style="height: 80px">
			<form id="selForm">
				<table cellpadding="5">
					<tr>
						<td>姓名:</td>
						<td><input class="easyui-textbox" type="text" id="teacherName"
							name="staffName"></input></td>

						<td><a href="#" id="th_search" class="easyui-linkbutton"
							data-options="iconCls:'icon-search'" style="width: 80px">Search</a></td>
					</tr>
				</table>
		 </form>				
	</div>
		<div data-options="region:'center'">
			<table id="dg">
			</table>
		</div>				
				
</div>
					
						
</body>
</html>