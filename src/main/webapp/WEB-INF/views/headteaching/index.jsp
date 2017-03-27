<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<%@ include file="/WEB-INF/views/common.jsp" %>
</head>
 <script>
 var datagrid;
 $(function(){
	 //initCombox();
	 datagrid = $("#dg")
		.datagrid(
				  {
					url : "${ctx}/headteaching/list.do",//加载的URL
					isField : "id",
					pagination : true,//显示分页
					pageSize : 20,//分页大小
					pageList : [ 20, 30, 50 ],//每页的个数
					fit : true,//自动补全
					fitColumns : true,
					nowrap: false,
					iconCls : "icon-save",//图标
					columns : [ [ //每个列具体内容
							{
								field : 'id',
								hidden : true
							},
							{
								field : 'fullName',
								title : '姓名',
								width:80,
								align : 'center',
							},
							{
								field : 'adminname',
								title : '登录号',
								width:80,
								align : 'center',
							},
							{
								field : 'sex',
								title : '性别',
								width:30,
								align : 'center',
								formatter : function(value, rowData,
										rowIndex) {
									if (value == '1') {
										return "男";
									} else if (value == '2') {
										return "女";
									} else {
										return "--";
									}
								}
							},
							{
								field : 'company',
								title : '单位',
								width:100,
								align : 'center',
							},
							{
								field : 'department',
								title : '部门',
								width:100,
								align : 'center',
							},
							{
								field : 'mobile',
								title : '手机',
								width:100,
								align : 'center',
							},
							{
								field : 'email',
								title : '邮箱',
								width:100,
								align : 'center',
							},
							{
								field : 'subjectName',
								title : '学科',
								width:150,
								align : 'center',
								nowrap : true
							},
							{
								field : 'isDirector',
								title : '职务',
								width:150,
								align : 'center',
								formatter : function(value, rowData,
										rowIndex) {
									if (value == '1') {
										return "教学主任";
									} else if(value == '0'){
										return "教学秘书";
									}
								} 
							}
							 ] ],
				
					toolbar : [ //工具条
					            {
									text : "增加",
									iconCls : "icon-add",
									handler : function() {//回调函数
										$('#add').dialog('open');
									}
							     },
				                 {
							    	 text:"导入",iconCls:"icon-search",
							    	 handler:function(){
					        	     $('#ddUpload').dialog('open');
					             }},
					             {
					            	 text:"下载模板",iconCls:"icon-save",
					            	 handler:function(){
					        	     document.GridExportForm.action = '${ctx}/headteaching/exportUserExcel.do';
					    		     document.GridExportForm.submit();
					             }},
					             
					             {
					            	  text:"删除",iconCls:"icon-remove",handler:function(){
					        	      var rows=datagrid.datagrid('getSelections');
					  
					        	      if(rows.length<=0)
					        	      {
					        		     $.messager.alert('警告','您还没有选择！','error');
					        	      }
					        	      else
					        	     {
					         	       $.messager.confirm('确定','您确定要删除吗？',function(t){
					        			if(t)
					        			{
					        				var ids = [];
					        				var rows = datagrid.datagrid('getSelections');
					        				for(var i=0; i<rows.length; i++){
					        					ids.push(rows[i].id);
					        					 
					        				}
					        			   
					        				$.ajax({
					        					url : '${ctx}/person/teachResearch/deleteTeachResearch.do',
					        					data : 'ids='+ids.join(','),
					        					method: 'POST',
					        					dataType : 'text',
					        					success : function(r) {
					        						if (r==0) {
					        							$.messager.show({
					        								msg : "操作成功",
					        								title : '成功'
					        							});
					        							datagrid.datagrid('reload');
					        						} else {
					        							$.messager.alert('错误', "操作失败", 'error');
					        						}
					        						datagrid.datagrid('unselectAll');
					        					}
					        				});
					        			
					        			}
					        		})
					        	}
					        	
					        	
					        }} 
						]
				});
				
	 $('#add').dialog({
			title : "My Dialog",
			closed : true,
			modal : true, //dialog继承自window，而window里面有modal属性，所以dialog也可以使用
			toolbar : [ {
				text : 'Ok',
				iconCls : 'icon-ok',
				handler : function() {
						$('#ff').form('submit', {
							onSubmit : function() {
								var isValid = $(this).form('validate');
								if (isValid) {
								}
								return isValid;
							},
							success : function(data) {
								if(data == 0) {
									$.messager.alert('提示', "操作成功！", 'info');
								} else if(data == 1){
									$.messager.alert('提示', "已有该角色，请勿重新分配！", 'error');
								} else{
									$.messager.alert('提示', "操作失败！", 'error');
								}
								$('#add').dialog('close');
							}
						});
				}
			}, {
				text : 'Cancel',
				handler : function() {
					$('#add').dialog('close');
					$('#ff').form('clear');
				}
			} ],
			onOpen : function() {

			},
			onClose : function() {
				$('#ff').form('clear');
				datagrid.datagrid('unselectAll');
				datagrid.datagrid('reload');
			}
		});
				
	 $('#ddUpload').dialog({
		    title: "上传",
		    closed:true,
		    modal: true, //dialog继承自window，而window里面有modal属性，所以dialog也可以使用

			onClose: function() {
				datagrid.datagrid('unselectAll');
				datagrid.datagrid('reload');
			}
	 });
  
	 
	 var uploader = new plupload.Uploader({
 		runtimes : 'html5,flash,silverlight,html4',
 		browse_button : 'pickfiles', // you can pass in id...
 		container: document.getElementById('container'), // ... or DOM Element itself
 		url : '${ctx}/headteaching/uploadUserInfo.do',
 		flash_swf_url : '${ctx}/js/plupload-2.1.2/js/Moxie.swf',
 		silverlight_xap_url : '${ctx}/js/plupload-2.1.2/js/Moxie.xap',
 		
 		multi_selection: false,
 		multiple_queues: false,
 		filters : {
 			max_file_size : '10mb',
 			mime_types: [
 				{title : "excel files", extensions : "xls,xlsx"},
 			]
 		},
 		// PreInit events, bound before the internal events
		preinit : {
			Init: function(up, info) {
				log('[Init]', 'Info:', info, 'Features:', up.features);
			},
			UploadFile: function(up, file) {
				log('[UploadFile]', file);
				// You can override settings before the file is uploaded
				// up.setOption('url', 'upload.php?id=' + file.id);
				// up.setOption('multipart_params', {param1 : 'value1', param2 : 'value2'});
			}
		},
		
 		init: {
 			PostInit: function() {
 				
 				log('[PostInit]');
 				document.getElementById('filelist').innerHTML = '';

 				document.getElementById('uploadfiles').onclick = function() {
 					uploader.start();
 					return false;
 				};
 			},
 			FilesAdded: function(up, files) {
  				if(up.files.length > 1) {
  					log('up.files.length'+up.files.length);
  					//return false;
  				}
  				log('[FilesAdded]');
  				plupload.each(files, function(file) {
  					log('  File:', file);
  					$("#uploadTable #fileName").html(file.name);
  					$("#uploadTable #fileSize").html(plupload.formatSize(file.size));
  					$("#uploadTable #status").html(file.status);
  					$("#uploadTable #progress").html(file.percent);
  				});
  			},
  			UploadProgress: function(up, file) {
  				log('[UploadProgress]', 'File:', file, "Total:", up.total);
  				$("#uploadTable #progress").html(file.percent);
  				//$.messager.progress('bar').progressbar("options").text=file.name+"("+file.percent+"%)";
  				$.messager.progress('bar').progressbar("setValue",up.total.percent);
  			},
/* 	    			UploadComplete: function(up, files, result) {
 				log('[UploadComplete]');
 				$.messager.alert('提示', "上传完成", 'help');
 				alert(result.response);
 				$.messager.progress('close');
 				$('#ddUpload').dialog('close');
 			}, */
 			FileUploaded:function(up,file,result){
 				log('[FileUploaded]');
 				if (result.response == "success") {
 					$.messager.alert('提示', "上传完成", 'help');
	    				$.messager.progress('close');
	    				$('#ddUpload').dialog('close');
					}else{
						var response = JSON.parse(result.response);
						if(response.state=="1") {
							$.messager.alert('提示', "导入完成！", 'help');
						} else {
							$.messager.alert('提示', response.msg, 'help');
						}
					}
 			}
 		}
 	});
		uploader.init();		
	
		
		
 });
 
 function log() {
		var str = "";

		plupload.each(arguments, function(arg) {
		var row = "";
		
		if (typeof(arg) != "string") {
			plupload.each(arg, function(value, key) {
				// Convert items in File objects to human readable form
				if (arg instanceof plupload.File) {
						// Convert status to human readable
						switch (value) {
							case plupload.QUEUED:
								value = 'QUEUED';
								break;

							case plupload.UPLOADING:
								value = 'UPLOADING';
								break;

							case plupload.FAILED:
								value = 'FAILED';
								break;
							
							case plupload.DONE:
								value = 'DONE';
								break;
						}
					}
		
				if (typeof(value) != "function") {
					row += (row ? ', ' : '') + key + '=' + value;
				}
			});
					
							str += row + " ";
			} else {
				str += arg + " ";
				}
		});
		
var log = document.getElementById('console');
		//log.innerHTML += str + "\n";
}	
 
 
 </script>
<body style="padding: 0 4px; margin: 0; overflow: hidden;">
  <div class="easyui-layout" style="width: 100%; height: 100%;"
		data-options="fit:true">
		<div title="人员查询" data-options="region:'north'" style="height: 80px">
			<form id="selForm">
				<table cellpadding="5">
					<tr>
						<td>姓名:</td>
						<td><input class="easyui-textbox" type="text" id="teacherName"
							name="name"></input></td>

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

<div id="grid-export-form" class="x-hidden">
			<form method="POST" name="GridExportForm"></form>
</div>


<div id="add" title="My Dialog"style="width: 480px; height: 300px; text-align: left;"data-options="closed:true">
			<form id="ff" method="post"action="${ctx}/person/teachResearch/addTeach.do">
				<table cellpadding="3">
					<tr>
						<td>登录名:</td>
						<td><input class="easyui-textbox" type="text" id="adminname"name="adminname" data-options="required:true"></input></td>
						<td>姓名:</td>
						<td><input class="easyui-textbox" type="text" id="fullName"name="fullName" data-options="required:true"></input></td>
					</tr>
					
					<tr>
						<td>密码:</td>
						<td><input class="easyui-textbox" type="text" id="passwd"name="passwd" data-options="required:true"></input></td>
						<td>性别:</td>
						<td>
						<select class="easyui-combobox"id="sex" style="width: 160px" name="sex" data-options="required:true,editable:false">
								<option value="1">男</option>
								<option value="2">女</option>
						</select>
						</td>
					</tr>
					
					<tr>
						<td>职务:</td>
						<td>
						<select class="easyui-combobox"id="isDirector" style="width: 160px" name="isDirector" data-options="required:true,editable:false">
								<option value="0">教研室秘书</option>
								<option value="1">教研室主任</option>
						</select>
						</td>
						<td>单位:</td>
						<td><input class="easyui-textbox" type="text" id="company"name="company" data-options="required:true"></input></td>
					</tr>
					
					<tr>
						<td>部门:</td>
						<td><input class="easyui-textbox" type="text" id="department"name="department" data-options="required:true"></input></td>
						<td>手机:</td>
						<td><input class="easyui-textbox" type="text" id="mobile"name="mobile" data-options="required:true"></input></td>
					</tr>
					
					<tr>
						<td>邮箱:</td>
						<td><input class="easyui-textbox" type="text" id="email"name="email" data-options="required:true"></input></td>
					</tr>
				</table>
			</form>
		</div>
		
		<div id="ddUpload" title="My Dialog" style="width: 600px; height: 400px; text-align: center;" data-options="closed:true">

				<div id="container">
					<div id="tool">
							<a id="pickfiles"  href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'">选择文件</a>
						    <a id="uploadfiles" href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-save'">上传文件</a>
						</div>
						<div data-options="region:'center'" >
							<table  id="uploadTable"   style=" width: 100%; border-collapse: collapse; text-align: left;" class="editTable">
							        <tr>
							            <th width="100">文件名</th>
							            <td id="fileName"></td>
							         </tr>
							        <tr>
							            <th>文件大小</th>
							            <td id="fileSize"></td>
							         </tr>
							        <tr>
							            <th>状态</th>
							            <td id="status"></td>
							         </tr>
							        <tr>
							            <th>上传进度</th>
							            <td id="progress"></td>
							         </tr>
							         <tr>
										<td colspan="2">
											<ul>
												<li>1、在导入之前，为保证数据的准确唯一性</li>
												<li>2、下列属性需填写准确无误的内容 <span style="color: red;">工号、密码、手机号、身份证号、纳入培训时间、年级</span>请参照模板内容</li>
												<li>3、如模板内容不能满足要求，请跟管理员反馈</li>
											</ul>
										</td>
									</tr>
							</table>
						</div>
				</div>
				<div id="filelist">Your browser doesn't have Flash, Silverlight
					or HTML5 support.</div>
				<br />
				<pre id="console"></pre>

		</div>
</body>
</html>