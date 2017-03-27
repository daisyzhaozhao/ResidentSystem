<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<%@ include file="/WEB-INF/views/common.jsp" %>

<script type="text/javascript">
var datagrid;
$(function() {
	datagrid = $("#dg")
			.datagrid(
					{
						url : "${ctx}/teaching/allList.do",//加载的URL
						isField : "id",
						pagination : true,//显示分页
						pageSize : 20,//分页大小
						pageList : [ 20, 30, 50 ],//每页的个数
						fit : true,//自动补全
						fitColumns : true,
						iconCls : "icon-save",//图标
						columns : [ [ //每个列具体内容
								{
									field : 'id',
									hidden : true
								},
								{
									field : 'deptId',
									hidden : true
								},
								{
									field : 'adminname',
									title : '用户名',
									width : 100,
									align : 'center',
								},
								{
									field : 'secretaryName',
									title : '姓名',
									width : 100,
									align : 'center',
								},
								{
									field : 'sex',
									title : '性别',
									width:100,
									align : 'center',
									formatter : function(value, rowData,
											rowIndex) {
										if (value == '1') {
											return "男";
										} else if(value == '2') {
											return "女";
										}else{
											return "--"
										}
									} 
								},
								{
									field : 'email',
									title : '邮箱',
									width:100,
									align : 'center',
								},
								{
									field : 'mobile',
									title : '电话号码',
									width:100,
									align : 'center',
								}
								,
								{
									field : 'secretaryOffice',
									title : '科室名称',
									width:100,
									align : 'center',
								},
								{
									field : 'secretaryJob',
									title : '职务',
									width:100,
									align : 'center',
										formatter : function(value, rowData,
											rowIndex) {
										if (value == '1') {
											return "教学主任";
										} else {
											return "教学秘书";
										}
									} 
								}
								 ] ],
					
						toolbar : [ //工具条
						            {text:"修改",iconCls:"icon-edit",handler:function(){
							        	var rows=datagrid.datagrid('getSelections');
							        	if(rows.length==1)
							        	{
							        		//$('#dd').dialog('open');
							        		$.ajax({
					        					url : '${ctx}/teaching/id'+rows[0].id+'.do',
					        					data : [],
					        					dataType : 'json',
					        					success : function(r) {
					        						if (r.id) {
					        							 $('#dd').dialog('open');
					        							 $("#secretaryName").textbox("setValue", r.secretaryName);
					        							 $("#secretaryOffice").combobox("setValue", r.secretaryOffice);
					        							 $("#secretaryJob").combobox("setValue", r.secretaryJob);
					        							// $("#userId").val(r.userId);
					        						}else {
					        							$.messager.alert('错误', r.msg, 'error');
					        						}
					        					}
					        				});
							        	} else {
							        		$.messager.alert('错误', "只能选择一个数据进行修改", 'error');
							        	}
							        }},
							        
						            {text:"导入",iconCls:"icon-add",handler:function(){
							        	
							        	 $('#ddUpload').dialog('open');
							        }},
							        
							        {text : "下载模板",
										iconCls : "icon-save",
										handler : function() {
											document.GridExportForm.action = '${ctx}/teaching/exportTeachingExcel.do';
											document.GridExportForm.submit();
										}
									},
							        
							]
					})
					
					
					$('#ddUpload').dialog({
					    title: "上传",
					    closed:true,
					    modal: true, //dialog继承自window，而window里面有modal属性，所以dialog也可以使用

						onClose: function(){
							datagrid.datagrid('unselectAll');
							datagrid.datagrid('reload');
						}
				 });
			     
				 
				 var uploader = new plupload.Uploader({
			    		runtimes : 'html5,flash,silverlight,html4',
			    		browse_button : 'pickfiles', // you can pass in id...
			    		container: document.getElementById('container'), // ... or DOM Element itself
			    		url : '${ctx}/teaching/uploadTeaching.do',
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
				 
					
					 $('#dd').dialog({
			             title: "My Dialog",
			             closed:true,
			             modal: true, //dialog继承自window，而window里面有modal属性，所以dialog也可以使用
			             toolbar: [{
								text:'Ok',
							iconCls:'icon-ok',
							handler:function(){
								$('#ff').form('submit',{
									onSubmit:function(){
										var isValid = $(this).form('validate');
										if(isValid) {
											
										}
										return isValid;
									},
									success: function(){
										$('#ff').form('clear');
										$('#dd').dialog('close');
									}
								});
							
							}
						},{
							text:'Cancel',
							handler:function(){
								$('#dd').dialog('close');
								$('#ff').form('clear');
							}
						}],
						onBeforeOpen: function() {
								
							},
						onOpen: function() {
							
						},
						onClose: function() {
							$('#ff').form('clear');
							datagrid.datagrid('unselectAll');
							datagrid.datagrid('reload');
						}
			         });
					
					 initCombox();
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

function initCombox() {
	// 科室combox显示
	 $('#secretaryOffice').combobox({
		 url: "${ctx}/courseSubject/secretaryoffice.do",
		 valueField:'id',
		 textField:'officeName',
		// editable:false,
	     loadFilter: function(data){
			   if(data!=null){
				   var d =[];
				   var key = 'id';
				   var value = 'officeName';
					  //var defaultValue ="{"+key+":'0',"+value+":'全部' }";
					  //d.push(eval("("+defaultValue+")"));
					  $(data).each(function(index) {
						 d.push(data[index]); 
					  });
					  return d;
			   } else {
				   return data;
			   }
			}
	 }); 
} 



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
							name="secretaryName"></input></td>

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

<div id="dd" title="My Dialog"  style="width:500px;height:400px; text-align: center; padding: 10px; " data-options="closed:true"> 
				    <form id="ff" method="post" action="${ctx}/person/techSecretary/update.do" >
				    		<input type="hidden" id="id" name="id">
					    	<table  style=" width: 100%; border-collapse: collapse; text-align: left;">
					    	<tr>
				    			<td>姓名：</td>
				    			<td><input  class="easyui-textbox"  id="adminname" name="adminname"  readonly="readonly" /></td>
				    		</tr>
					    	<tr>
				    			<td>科室：</td>
				    			<td><input  class="easyui-combobox"  id="secretaryOffice" name="secretaryOffice"   /></td>
				    		</tr>
				    		<tr>
				    			<td>职务</td>
				    			<td><input  class="easyui-combobox"  id="secretaryJob" name="secretaryJob"  /></td>
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