<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
   <%@ include file="/WEB-INF/views/common.jsp" %>
		<script>
var datagrid;
$(function(){
	initCombox();
	datagrid=$('#dg').datagrid({
		url:"${ctx}/resident/list.do",//加载的URL
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
		                  {field:'id', hidden:true },  
			              {field:'adminname', title:'登录号', align:'center' },
			              {field:'adminno', title:'学员编号',align:'center' },
			              {field:'grade', title:'年级',align:'center' },
			              {field:'name', title:'姓名',align:'center'},
			              {field:'studentState',title:'学员状态',align:'center'},
			              {field:'trainState', title:'培训状态', align:'center',
			            		formatter:function(value,rowData,rowIndex) {
			            			switch (rowData.trainStatusCode) {
			            			case 1:
			            				return "在培";
			            			case 2:
			            				return "毕业";
			            			case 3:
			            				return "暂停培训";
			            			case 4:
			            				return "退出培训";
			            			default:
			            				return "--";
			            			}
			            		}  
			              },
			              {field:'sex', title:'性别', align:'center',
			            	  formatter:function(value,rowData,rowIndex) { 
			            		  if(rowData.sex==1){
									  return '<span>男</span>';}
			            		  else if(rowData.sex==2) {
			            			  return'<span>女</span>';
			            		  } else 
			            			  return'<span>--</span>';
			            			  
			            	  }},
			              {field:'education', title:'学历',  align:'center',
				            	  formatter:function(value,rowData,rowIndex) { 
										return rowData.edubackground
				              }},
			              {field:'teacher', title:'导师',  align:'center',
				            	  formatter:function(value,rowData,rowIndex) { 
				            		  if(!!rowData.tutor){
					            		  return '<span style="color:green;">'+rowData.tutorName+'</span>';
				            		  }
				              }},
				           {field:'major', title:'在培学科',  align:'center',
				            	  formatter:function(value,rowData,rowIndex) { 
										return rowData.subjectName
				              }},
			              {field:'company', title:'所属单位',align:'center',
			            	  formatter:function(value,rowData,rowIndex) { 
									return rowData.unit
			            	  }
			              },{field:'office', title:'所属科室',align:'center',
			            	  formatter:function(value,rowData,rowIndex) { 
									return rowData.dept
			            	  }
			              },
			              {field:'phoneNum', title:'手机',  align:'center',
			            	  formatter:function(value,rowData,rowIndex) { 
									return rowData.mobile
			            	  }},
			              {field:'bankNum', title:'银行账号',  align:'center'},
			              {field:'idCard', title:'身份证',  align:'center'},
			              {field:'graduateInstitutions', title:'毕业院校',align:'center',
			            	  formatter:function(value,rowData,rowIndex) { 
									return rowData.colleges
			            	  }},
			              {field:'maxGraduate', title:'最高学位',align:'center',
				              formatter:function(value,rowData,rowIndex) { 
									return rowData.highestDegree
				            	}},
			              {field:'technical', title:'职称',align:'center',
				              formatter:function(value,rowData,rowIndex) { 
									return rowData.titleName;
				            	}},
			              {field:'doctorQulification', title:'医师资格',align:'center',
				            		formatter: function(val,row, index) {
					            		if (val == '1'){
					        				return '<span style="color:green;">'+'有'+'</span>';
					        			} else if (val == '0') {
					        				return '<span style="color:red;">'+'无'+'</span>';
					        			}
					            	}  
					              },
			              {field:'practicing', title:'执业资格',align:'center',
					            		formatter: function(val,row, index) {
						            		if (val == '1'){
						        				return '<span style="color:green;">'+'有'+'</span>';
						        			} else if (val == '0') {
						        				return '<span style="color:red;">'+'无'+'</span>';
						        			}
						            	}  
						             },
			             
			              {field:'career', title:'专业',align:'center',
			            	  formatter:function(value,rowData,rowIndex) { 
			            		  
							  return rowData.professionName;
			              }},
							
	              
	          ]],
	          
	          toolbar:[    
	                {text:"增加",iconCls:"icon-add",handler:function(){
	                     $('#add').dialog('open');
	                }}, 
	               
	                {text:"修改",iconCls:"icon-edit",handler:function(){
			        	//var row=datagrid.datagrid('getSelected');
			        	var rows = datagrid.datagrid('getSelections');
			        	if (rows != null && rows.length==1) {
			            var row=datagrid.datagrid('getSelected');
			        	var stuTrainStatus = row.trainState;
		    			//$("input",$("#idCard").next("span")).attr("readonly", true);
		         		$.ajax({
		    				url : '${ctx}/resident/id'+row.id+'.do',
		    				dataType : 'json',
		    				success : function(r) {
		    					if (r.id) {
		    						var sex;
		    						if(r.sex){
		    							if(r.sex=='男'){
		    								sex='1';
		    							}else if(r.sex=='女'){
		    								sex='2'
		    							}else{
		    								sex=r.sex;
		    							}
		    						}
		    						$('#dd').dialog('open');
		    						$("#dd #company").textbox("setValue", r.company);
		    						$("#dd #name").textbox("setValue", r.name);
		    						$("#dd #sex").combobox("setValue", sex);
		    						$("#dd #phoneNum").textbox("setValue", r.phoneNum);
		    						$("#dd #education").combobox("setValue", r.education);
		    						$("#dd #idCard").textbox("setValue", r.idCard);
		    						$("#dd #grade").textbox("setValue", r.grade);
		    						$('#dd #bankNum').textbox("setValue", r.bankNum);
		    						$("#dd #id").val(r.id);
			     					$("#dd #studentNo").textbox("setValue", row.studentNo);
			     					$("#dd #curuserId").val(r.id);
			     					$("#dd #studentState").textbox("setValue", r.studentState);
			     					$("#dd #major").combobox("setValue", r.major);
			     					$("#dd #office").combobox("setValue", r.office);
			     					$("#dd #graduateInstitutions").textbox("setValue", r.graduateInstitutions);
			     					$("#dd #maxGraduate").textbox("setValue", r.maxGraduate);
			     					$("#dd #career").combobox("setValue", r.career);
			     					//职称
			     					$("#dd #technical").combobox("setValue", r.technical);
			     				
  								 			if ( r.doctorQulification == null) {
  								 				$('#dd #doctorQulification').combobox('setValue', 0);
											}else {
												$('#dd #doctorQulification').combobox('setValue', r.doctorQulification);
											}
					     			
  								 			if (r.practicing == null) {
  								 				$('#dd #practicing').combobox('setValue', 0);	
											}else {
												$('#dd #practicing').combobox('setValue', r.practicing);
											}
					         		
					     					if (stuTrainStatus != null) {
					     						$("#dd #trainState").combobox("setValue", r.trainState);
					     					}
					         		
		    					} else {
		    						$.messager.alert('错误', r.msg, 'error');
		    					}
		    				}
		    			});
			        	} else {
			        		$.messager.alert('错误', '请选择一条记录进行修改','error');
			        	}
		         		
			        }}, 
			        
			        
			        {text:"导入",iconCls:"icon-add",handler:function(){
			        	
			        	 $('#ddUpload').dialog('open');
			        }},
			        
			        {text : "下载模板",
						iconCls : "icon-save",
						handler : function() {
							document.GridExportForm.action = '${ctx}/person/undergraduate/exportUndergraduateExcel.do';
							document.GridExportForm.submit();
						}
					},
			        
	               
	          ]
	         
	      		
	      	});
	      	
	 $("#th_search").click(function(){
   		var param=$("#selForm").serializeJson();
   		teacherAlldatagrid.datagrid('load',param);
   	});
	 
	 $('#add').dialog({
			title : "My Dialog",
			closed : true,
			modal : true, //dialog继承自window，而window里面有modal属性，所以dialog也可以使用
			toolbar : [{
				text : 'Ok',
				iconCls : 'icon-ok',
				handler : function() {
						var phone = $("#add_phone").textbox('getValue');
					    if(!!phone && !/^1[34578]\d{9}$/.test(phone)) {
					    	$.messager.alert('错误', "手机号格式不对！", 'error');
					    	return false;
					    }
						$('#hh').form('submit', {
							onSubmit : function() {
								var isValid = $(this).form('validate');
								if (isValid) {
								}
								return isValid;
							},
							success : function(r) {
								if (r == 0) {
									$.messager.show({
										msg : "操作成功",
										title : '成功'
									});
									$('#add').dialog('close');
									datagrid.datagrid('reload');
								} else if (r == 1) {
									$.messager.alert('错误', "登录名已存在！", 'error');
								} else if (r == 2) {
									$.messager.alert('错误', "操作失败！", 'error');
								}
								
							}
						});
				}
			}, {
				text : 'Cancel',
				handler : function() {
// 					$('#add').dialog('close');
// 					$('#hh').form('clear');
				}
			} ],
			onOpen : function() {

			},
			onClose : function() {
// 				$('#hh').form('clear');
// 				datagrid.datagrid('unselectAll');
				//datagrid.datagrid('reload');
			}
		});

	 $('#dd').dialog({
	     title: "修改学员信息",
	     closed:true,
	     modal: true, //dialog继承自window，而window里面有modal属性，所以dialog也可以使用
	     toolbar: [{
	 		text:'确定',
	 		iconCls:'icon-ok',
	 		handler:function(){
	 			if (idcardFlag == "0") {
	 				$.messager.alert('错误', "身份证不存在");	
	 			}else{
	 				//如果毕业状态为：毕业、退出、暂停
	 				var curStatusCode = $("#trainStatusCode").combobox('getValue');
	 				if(curStatusCode == 2 ||curStatusCode == 3 || curStatusCode == 4){
	 					$.messager.confirm('确定', '是否停止轮转计划?', function(t){
	 						if(t){
	 							$("#clearRotary").val(0); 
	 						}
	 						$('#ff').form('submit',{
	 							onSubmit:function(){
	 								var isValid = $(this).form('validate');
	 								if(isValid) {
	 								}
	 								return isValid;
	 							},
	 							success: function(r){
	 								    if(r == 0){
	 								    	$.messager.show({
	 			    							msg : '修改成功',
	 			    							title : 'success'
	 			    						});
	 								    	$('#dd').dialog('close');	
	 								    }else if(r == 1){
	 								    	$.messager.alert('错误', '修改失败','error');
	 								    }else if(r == 2){
	 								    	$.messager.alert('错误', '身份证号已存在','error');
	 								    }else if(r == 3){
	 								    	$.messager.alert('错误', '身份证号格式不对','error');
	 								    }
	 									//$('#ff').form('clear');
	 								}
	 							}
	 						);
	 					});
	 				}else{
	 					$('#ff').form('submit',{
	 						onSubmit:function(){
	 							var isValid = $(this).form('validate');
	 							if(isValid) {
	 							}
	 							return isValid;
	 						},
	 						success: function(r){
	 							    if(r == 0){
	 							    	$.messager.show({
	 		    							msg : '修改成功',
	 		    							title : 'success'
	 		    						});
	 							    	$('#dd').dialog('close');	
	 							    }else if(r == 1){
	 							    	$.messager.alert('错误', '修改失败','error');
	 							    }else if(r == 2){
	 							    	$.messager.alert('错误', '身份证号已存在','error');
	 							    }else if(r == 3){
	 							    	$.messager.alert('错误', '身份证号格式不对','error');
	 							    }
	 								$('#dd').dialog('close');	
	 							}
	 						}
	 					);
	 				}
	 			}
	 		}
	 	},{
	 		text:'取消',
	 		handler:function(){
	 			$('#dd').dialog('close');
	 			$('#ff').form('clear');
	 		}
	 	}],
	 	onOpen: function() {
	 	},
	 	onClose: function() {
	 		$('#ff').form('clear');
	 		datagrid.datagrid('unselectAll');
	 		datagrid.datagrid('reload');
	 	}
	 });
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


function initCombox() {
	 $('#dd #doctorQulification').combobox({
		 data: [
			{"id":'1', 
			"text":"有" 
			},{ 
			"id":'0', 
			"text":"无" 
			}],
		 valueField:'id', 
		 textField:'text'
	 });
	 
	 
	 $('#add #doctorQulification').combobox({
		 data: [
			{"id":'1', 
			"text":"有" 
			},{ 
			"id":'0', 
			"text":"无" 
			}],
		 valueField:'id', 
		 textField:'text'
	 });
	 
	 $("#dd #trainState").combobox({
		 data: [{"id":"1","text":"在培"},
			       {"id":"2","text":"毕业"},
			       {"id":"3","text":"暂停培训"},
			       {"id":"4","text":"退出培训"},
			      ],
		valueField:"id",
		textField:"text",
		editable:false
	 });
	 
	 $("#add #trainState").combobox({
		 data: [{"id":"1","text":"在培"},
			       {"id":"2","text":"毕业"},
			       {"id":"3","text":"暂停培训"},
			       {"id":"4","text":"退出培训"},
			      ],
		valueField:"id",
		textField:"text",
		editable:false
	 });
	 
	 $('#dd #practicing').combobox({
		 data: [
				{"id":'1', 
				"text":"有" 
				},{ 
				"id":'0', 
				"text":"无" 
				}],
		 valueField:'id', 
		 textField:'text',
		 editable:false,
		 panelHeight:50
	 });
	 
	 $('#add #practicing').combobox({
		 data: [
				{"id":'1', 
				"text":"有" 
				},{ 
				"id":'0', 
				"text":"无" 
				}],
		 valueField:'id', 
		 textField:'text',
		 editable:false,
		 panelHeight:50
	 });
	 
	 $('#dd #education').combobox({
		 data: [
			{"id":'0', 
			"text":"本科" 
			},{ 
			"id":'1', 
			"text":"硕士" 
			},{ 
				"id":'2', 
				"text":"博士" 
			},{ 
				"id":'3', 
			    "text":"博士后" 
			}],
		 valueField:'id', 
		 textField:'text'
	 });
	 
	 
	 
	 $('#add #education').combobox({
		 data: [
			{"id":'0', 
			"text":"本科" 
			},{ 
			"id":'1', 
			"text":"硕士" 
			},{ 
				"id":'2', 
				"text":"博士" 
			},{ 
				"id":'3', 
			    "text":"博士后" 
			}],
		 valueField:'id', 
		 textField:'text'
	 });
	 
	 $('#dd #technical').combobox({
		 data: [
			{"id":'0', 
			"text":"住院医师" 
			},{ 
			"id":'1', 
			"text":"主治医师" 
			},{ 
				"id":'2', 
				"text":"副主治医师" 
			},{ 
				"id":'3', 
			    "text":"主任医师" 
			},{ 
				"id":'4', 
			    "text":"副主任医师" 
			}],
		 valueField:'id', 
		 textField:'text'
	 });
	 
	 $('#add #technical').combobox({
		 data: [
			{"id":'0', 
			"text":"住院医师" 
			},{ 
			"id":'1', 
			"text":"主治医师" 
			},{ 
				"id":'2', 
				"text":"副主治医师" 
			},{ 
				"id":'3', 
			    "text":"主任医师" 
			},{ 
				"id":'4', 
			    "text":"副主任医师" 
			}],
		 valueField:'id', 
		 textField:'text'
	 });
	 
	 
	 
	// 学科combox显示
	 $('#major').combobox({
		 url: "${ctx}/courseSubject/secondNode.do",
		 valueField:'id',
		 textField:'subjectName',
		 multiple:true,
		// editable:false,
	     loadFilter: function(data){
			   if(data!=null){
				   var d =[];
				   var key = 'id';
				   var value = 'subjectName';
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


// var uploader = new plupload.Uploader({
// 		runtimes : 'html5,flash,silverlight,html4',
// 		browse_button : 'pickfiles', // you can pass in id...
// 		container: document.getElementById('container'), // ... or DOM Element itself
// 		url : '${ctx}/person/residency/uploadResidency.do',
// 		flash_swf_url : '${ctx}/js/plupload-2.1.2/js/Moxie.swf',
// 		silverlight_xap_url : '${ctx}/js/plupload-2.1.2/js/Moxie.xap',
		
// 		multi_selection: false,
// 		multiple_queues: false,
// 		filters : {
// 			max_file_size : '10mb',
// 			mime_types: [
// 				{title : "excel files", extensions : "xls,xlsx"},
// 			]
// 		},
// 	preinit : {
// 		Init: function(up, info) {
// 			log('[Init]', 'Info:', info, 'Features:', up.features);
// 		},
// 		UploadFile: function(up, file) {
// 			log('[UploadFile]', file);
// 		}
// 	},
	
// 		init: {
// 			PostInit: function() {
				
// 				log('[PostInit]');
// 				document.getElementById('filelist').innerHTML = '';

// 				document.getElementById('uploadfiles').onclick = function() {
// 					if(uploader.files.length ==0){
// 						$.messager.alert('警告','请选择文件!','error');
// 						return false;
// 					}
// 					$.messager.progress({  
// 	                    title:'请稍后',  
// 	                    msg:'正在上传......',  
// 	                    interval:0  
// 	                });
// 					uploader.start();
// 					return false;
// 				};
// 			},
// 			FilesAdded: function(up, files) {
// 				if(up.files.length > 1) {
// 					log('up.files.length'+up.files.length);
// 					//return false;
// 				}
// 				log('[FilesAdded]');
// 				plupload.each(files, function(file) {
// 					log('  File:', file);
// 					$("#uploadTable #fileName").html(file.name);
// 					$("#uploadTable #fileSize").html(plupload.formatSize(file.size));
// 					$("#uploadTable #status").html(file.status);
// 					$("#uploadTable #progress").html(file.percent);
// 				});
// 			},
// 			UploadProgress: function(up, file) {
// 				log('[UploadProgress]', 'File:', file, "Total:", up.total);
// 				$("#uploadTable #progress").html(file.percent);
// 				//$.messager.progress('bar').progressbar("options").text=file.name+"("+file.percent+"%)";
// 				$.messager.progress('bar').progressbar("setValue",up.total.percent);
// 			},
// 			UploadComplete: function(up, files, result) {
// 				log('[UploadComplete]');
// 				uploadResult=JSON.parse(uploadResult);
// 					if(uploadResult.row>0){
// 					var rowmsg="第"+uploadResult.row+"行数据出错：";
// 					if(uploadResult.msg==1){
//    				$.messager.alert('提示', rowmsg+"必填项不能为空", 'error');
//    				$.messager.progress('close');
//    				}/* else if(uploadResult==2){
//    					$.messager.alert('提示', "培训时间格式应为yyyy-mm-dd", 'error');
//    					$.messager.progress('close');
//    				} */
//    				else if(uploadResult.msg==3){
//    					$.messager.alert('提示', rowmsg+"手机号错误", 'error');	
//    					$.messager.progress('close');
//    				}else if(uploadResult.msg==4){
//    					$.messager.alert('提示', rowmsg+"身份证号错误", 'error');
//    					$.messager.progress('close');
//    				}else if(uploadResult.msg==5){
// 	    				$.messager.alert('提示', rowmsg+"年级格式应为yyyy", 'error');
// 	    				$.messager.progress('close');
// 					} else if(uploadResult.msg==6){
// 	    				$.messager.alert('提示', rowmsg+"纳入培训时间格式不正确", 'error');
// 	    				$.messager.progress('close');
// 					} else if(uploadResult.msg==7){
// 	    				$.messager.alert('提示', rowmsg+"身份不匹配", 'error');
// 	    				$.messager.progress('close');
// 					}else if(uploadResult.msg==9){
// 						$.messager.alert('提示', rowmsg+"身份证已存在，无法导入！", 'error');
// 	    				$.messager.progress('close');
// 					}else if(uploadResult.msg==10){
// 						$.messager.alert('提示', rowmsg+"数据出错，无法执行修改操作，请重新校验后上传！", 'error');
// 	    				$.messager.progress('close');
// 					}else if(uploadResult.msg==11){
// 						$.messager.alert('提示', rowmsg+"数据格式不匹配，请核对！", 'error');
// 	    				$.messager.progress('close');
// 					}else if(uploadResult.msg==12){
// 						$.messager.alert('提示', rowmsg+"年资输入不合法，正确范围为1-3年!", 'error');
// 	    				$.messager.progress('close');
// 					}
// 				}else if(uploadResult.msg==8){
// 	    				$.messager.alert('提示', "导入失败", 'error');
// 	    				$.messager.progress('close');
// 				}else{
//    					$.messager.alert('提示', "上传完成", 'help');
// 	    				$.messager.progress('close');
// 				}
// 					$("#uploadTable #fileName").html("");
// 					$("#uploadTable #fileSize").html("");
// 					$("#uploadTable #status").html("");
// 					$("#uploadTable #progress").html("");
// 					$.messager.progress('close');
// 					$('#ddUpload').dialog('close');	
// 			}, 
// 			FileUploaded:function(up,file,result){
// 				log('[FileUploaded]');
// 				uploadResult=(result.response);
// 			} 
// 		}
// 	});
// 	uploader.init();
// 	 initCombox();

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

<div id="add" title="My Dialog"  style="width:800px;height:450px; text-align: left; " data-options="closed:true"> 
				    <form id="ff" method="post"  action="${ctx}/person/residency/saveResidency.do" >
				    	<input type="hidden" id="id" name="id">
				    	<!-- 是否清除轮转计划 -->
				    	<input type="hidden" id="clearRotary" name="clearRotary" />
				    	<input type="hidden" id="curuserId" name="id">
						<table cellpadding="3" >
				    		<tr>
				    			<td>身份证:</td>
				    			<td><input class="easyui-textbox"   type="text" id="idCard" name="idCard" data-options="required:true"  value="请输入身份证" /></td>
				    			<td>姓名:</td>
				    			<td><input class="easyui-textbox" type="text" id="name"  name="name"/></td>
				    			<td>性别:</td>
				    			<td><select  class="easyui-combobox"  id="sex" name="sex"  style="width: 80px" data-options="editable:false,panelHeight:50">
				    				<option value="1">男</option>
				    				<option value="2">女</option>
				    			</select>
				    			</td>
				    		</tr>
				    		
				    		<tr>
					    		<td>电话:</td>
					    		<td><input class="easyui-textbox" type="text" id="phoneNum"  name="phoneNum" data-options="required:true"/></td>
					    		
					    		<td>学员编号:</td>
					    		<td><input  class="easyui-textbox" type="text" id="adminno" name="adminno"/></td>	
				    		</tr>
				    		<tr>
				    		<td>学历:</td>
					    		<td><input  class="easyui-combobox"  id="education" name="education" /></td>
					    		<td>所属单位:</td>
					    		<td><input  class="easyui-textbox" type="text" id="company"  name="company"/>
				    		</tr>
				    		
				    		<tr>
				    			<td>医师资格:</td>
				    			<td><input  class="easyui-combobox"  id="doctorQulification" name="doctorQulification"  /> 
				    			</td>
				    			<td>执业资格:</td>
				    			<td><input  class="easyui-combobox"  id="practicing" name="practicing"  /> 
				    			</td>
				    		</tr>
				    		
				    		<tr>		    		    
				    			<td>培训状态:</td>
				    			<td><input  class="easyui-combobox"  id="trainState" name="trainState"  /> 
				    			</td>
				    		</tr>
				    		<tr>
				    			<td>银行账号:</td>
				    			<td><input  class="easyui-textbox"  id="bankCard" name="bankCard"  /> 
				    			</td>
				    			
				    		</tr>
				    		<tr>
				    			<td>学员状态:</td>
				    			<td><input  class="easyui-textbox" type="text" id="studentState"  name="studentState"/>
				    			<td>在培学科:</td>
				    		    <td><input  class="easyui-combobox" type="text" id="major" name="major"/></td>
				    			
				    		</tr>
				    		
				    		<tr>
					    		<td>所属科室:</td>
					    		<td><input class="easyui-combobox"  id="office"  name="office"/></td>
					    		<td>毕业院校:</td>
					    		<td><input  class="easyui-textbox" type="text" id="graduateInstitutions"  name="graduateInstitutions"/></td>
					    		<td>最高学位:</td>
					    		<td><input  class="easyui-textbox" type="text" id="maxGraduate"  name="maxGraduate"/></td>
				    		</tr>
				    		
				    		<tr>
					    		<td>专业:</td>
					    		<td><input class="easyui-combobox"  id="career"  name="career"/></td>
					    		
				    		</tr>
				    		
				    		<tr>
				    		 
				    		   	<td>职称:</td>
						    	<td>
						    	<select style="width: 100px" class="easyui-combobox" id="technical" name="technical"  data-options="">
						        </select></td>
				    		</tr>
				    		<tr>
				    			<td>年级:</td>
				    			<td><input  class="easyui-textbox" type="text" id="grade"  name="grade" data-options="required:true" />
				    			</td>
				    		</tr>
				    		</table>
				  </form>
			</div>
					
           <div id="dd" title="My Dialog"  style="width:800px;height:450px; text-align: left; " data-options="closed:true"> 
				    <form id="ff" method="post"  action="${ctx}/person/residency/saveResidency.do" >
				    	<input type="hidden" id="id" name="id">
				    	<!-- 是否清除轮转计划 -->
				    	<input type="hidden" id="clearRotary" name="clearRotary" />
				    	<input type="hidden" id="curuserId" name="registerUser.userId">
						<table cellpadding="3" >
				    		<tr>
				    			<td>身份证:</td>
				    			<td><input class="easyui-textbox"   type="text" id="idCard" name="idCard" data-options="required:true"  value="请输入身份证" /></td>
				    			<td>姓名:</td>
				    			<td><input class="easyui-textbox" type="text" id="name"  name="name"/></td>
				    			<td>性别:</td>
				    			<td><select  class="easyui-combobox"  id="sex" name="sex"  style="width: 80px" data-options="editable:false,panelHeight:50">
				    				<option value="1">男</option>
				    				<option value="2">女</option>
				    			</select>
				    			</td>
				    		</tr>
				    		
				    		<tr>
					    		<td>电话:</td>
					    		<td><input class="easyui-textbox" type="text" id="phoneNum"  name="phoneNum" data-options="required:true"/></td>
					    		
					    		<td>学员编号:</td>
					    		<td><input  class="easyui-textbox" type="text" id="adminno" name="adminno"/></td>
					    		
				    		</tr>
				    		<tr>
				    			<td>学历:</td>
					    		<td><input  class="easyui-combobox"  id="education" name="education" /></td>
					    		<td>所属单位:</td>
					    		<td><input  class="easyui-textbox" type="text" id="company"  name="company"/>
				    		</tr>
				    		
				    		<tr>
				    			<td>医师资格:</td>
				    			<td><input  class="easyui-combobox"  id="doctorQulification" name="doctorQulification"  /> 
				    			</td>
				    			<td>执业资格:</td>
				    			<td><input  class="easyui-combobox"  id="practicing" name="practicing"  /> 
				    			</td>
				   
				    		</tr>
				    		
				    		<tr>
				    			<td>培训状态:</td>
				    			<td><input  class="easyui-combobox"  id="trainState" name="trainState"  /> 
				    			</td>
				    		</tr>
		
				    		<tr>
				    			<td>银行账号:</td>
				    			<td><input  class="easyui-textbox"  id="bankNum" name="bankNum"  /> 
				    			</td>	
				    		</tr>
				    		<tr>
				    			<td>学员状态:</td>
				    			<td><input  class="easyui-textbox" type="text" id="studentState"  name="studentState"/>
				    			<td>在培学科:</td>
				    		    <td><input  class="easyui-combobox" type="text" id="major" name="major"/></td>	
				    		</tr>
				    		
				    		<tr>
					    		<td>所属科室:</td>
					    		<td><input class="easyui-combobox"  id="office"  name="office"/></td>
					    		<td>毕业院校:</td>
					    		<td><input  class="easyui-textbox" type="text" id="graduateInstitutions"  name="graduateInstitutions"/></td>
					    		<td>最高学位:</td>
					    		<td><input  class="easyui-textbox" type="text" id="maxGraduate"  name="maxGraduate"/></td>
				    		</tr>
				    		
				    		<tr>
					    		<td>专业:</td>
					    		<td><input class="easyui-combobox"  id="career"  name="career"/></td>
				    		</tr>
				    		
				    		<tr> 
				    		   	<td>职称:</td>
						    	<td>
						    	<select style="width: 100px" class="easyui-combobox" id="technical" name="technical"  data-options="">
						        </select></td>
				    		</tr>
				    		<tr>
                                <td>年级:</td>
				    			<td><input  class="easyui-textbox" type="text" id="grade"  name="grade" data-options="required:true" />
				    			</td>
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