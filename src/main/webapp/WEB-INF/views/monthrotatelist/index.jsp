<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<%@ include file="/WEB-INF/views/common.jsp" %> 
<link rel="stylesheet" href="${ctx}/css/table.css"  />	
<style type="text/css">  
ul{
	margin:0;
	padding:0
}
ul li{  
	list-style-type:none
}  
li :HOVER {
	cursor:pointer
}
</style>
<script src="${ctx}/js/plupload-2.1.0/js/plupload.full.min.js" type="text/javascript"></script>    		    
  <script type="text/javascript">
	var startDate = '${startDate}';
	var endDate = '${endDate}';
	var view = '${view}';
	var departmentId = '${departmentId}';
	var userName = '${userName}';
	var userType = '${userType}'
	var departmentIdList=[
	        			<c:forEach var="dept" items="${departmentList}" varStatus="status">
	        			"${dept.id}"
	        			<c:if test="${status.last eq false}">,</c:if>
	        			</c:forEach>
	        	        ];
	var departmentNameList=[
	        			<c:forEach var="dept" items="${departmentList}" varStatus="status">
	        			"${dept.departmentName}"
	        			<c:if test="${status.last eq false}">,</c:if>
	        			</c:forEach>
	        	        ];
	var departmentList=[
		        			<c:forEach var="dept" items="${departmentList}" varStatus="status">
		        			{"id":"${dept.id}","name":"${dept.departmentName}"}
		        			<c:if test="${status.last eq false}">,</c:if>
		        			</c:forEach>
		        	        ];
	var departmentIdListAll=[
	        			<c:forEach var="dept" items="${departmentListAll}" varStatus="status">
	        			"${dept.id}"
	        			<c:if test="${status.last eq false}">,</c:if>
	        			</c:forEach>
	        	        ];
	var departmentNameListAll=[
	        			<c:forEach var="dept" items="${departmentListAll}" varStatus="status">
	        			"${dept.departmentName}"
	        			<c:if test="${status.last eq false}">,</c:if>
	        			</c:forEach>
	        	        ];
	
  $(function () {
	$('#startDate').datebox({
		onSelect: function(date){
	      var years=date.getFullYear();//获取年
	      var months=date.getMonth()+1;//获取月
	      var dates=date.getDate();//获取日
	      
	      if(months<10){//当月份不满10的时候前面补0，例如09
	        months='0'+months;
	      }
	      
	      if(dates<10){//当日期不满10的时候前面补0，例如09
	        dates='0'+dates;
	      }
	      $('#endDate').datebox('setValue',years+1+'-'+months+'-'+dates) 
	    }
	});
	
	$("#btn_search").click(function(){
		$('#view').val($("input[name='ViewStatus']:checked").val());
		var userType = '';
		$("input[name='UserTypeView']:checked").each(function(){ 
			userType += $(this).val()+',';
		});
		$('#userType').val(userType);
		$('#searchForm').submit();
	});	
	
	
	$("#dg").datagrid({
		  onClickRow: function (rowIndex, rowData) {
                      $(this).datagrid('unselectRow', rowIndex);
                  },
	    toolbar:[              //工具条
                    	{text:"导出excel",iconCls:"icon-edit",handler:function(){//回调函数
                    		document.GridExportForm.action = '${ctx}/rotary/result/exportResultExcel.do?view=${view}&startDate=${startDate}&departmentId=${departmentId}&userName=${userName}&userType=${userType}';
                    		document.GridExportForm.submit();
    			    		}}
                     ],
		onLoadSuccess : function(data) {
		}
	})
	
	 $('#info').dialog({
	    width:550,
	    height:300
	    //modal:true,
	    
	});
	
	
 	 $('#departmentId').combobox({
// 		 url: "${ctx}/dpt/combox.do?id=${deptId}",
		 valueField:'id',
		 textField:'name',
		 multiple:true,
		 data:departmentList,
	     loadFilter: function(data){
			   if(data!=null){
				   var d =[];
				   var key = 'id';
				   var value = 'departmentName';
				   if ("${deptId}" == "") {
					   var defaultValue ="{"+key+":'0',"+value+":'全部' }";
					   d.push(eval("("+defaultValue+")"));
					}
				   var dtmp="";
				   for(var i=0;i<departmentIdListAll.length;i++){
					   dtmp="{"+key+":'"+departmentIdListAll[i]+"',"+value+":'"+departmentNameListAll[i]+"' }"
					   d.push(eval("("+dtmp+")")) ;
				   }
					  /* $(data).each(function(index) {
						 d.push(data[index]) 
					  }); */
					  return d;
			   } else {
				   return data;
			   }
			},
		 onLoadSuccess: function(param){
			   if ("${deptId}" != "" && "${deptId}" != null) {
					$('#departmentId').combobox('setValue',"${deptId}");
				}else if ("${dptIds}" != "" && "${dptIds}" != null) {
					$('#departmentId').combobox('setValues',"${dptIds}");
				}else{
					$('#departmentId').combobox('setValue',departmentId);
				}
			}
	 });  
	 

 	 

	//初始化参数
	initParam();
	
	var uploader = new plupload.Uploader({
		runtimes : 'html5,flash,silverlight,html4',
		browse_button : 'pickfiles', // you can pass in id...
		container: document.getElementById('container'), // ... or DOM Element itself
		url : '${ctx}/rotary/result/import.do',
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
	
		init: {
			PostInit: function() {
				document.getElementById('filelist').innerHTML = '';
				document.getElementById('uploadfiles').onclick = function() {
		        	  $.messager.confirm('确定','请确认当前此操作?',function(t){
		        			if(t)
		        			{
		        				if(uploader.files.length ==0){
		     						$.messager.alert('警告','请选择文件!','error');
		     						return false;
		     					}
		     					$.messager.progress({  
		     	                    title:'请稍后',  
		     	                    msg:'正在上传......',  
		     	                    interval:0  
		     	                });
		     					uploader.start();
		        			}
		        	  }) 	 
					return false;
				};
			},
			FilesAdded: function(up, files) {
 				plupload.each(files, function(file) {
 					$("#uploadTable #fileName").html(file.name);
 					$("#uploadTable #fileSize").html(plupload.formatSize(file.size));
 					$("#uploadTable #status").html(file.status);
 					$("#uploadTable #progress").html(file.percent);
 				});
 			},
 			UploadProgress: function(up, file) {
 				$("#uploadTable #progress").html(file.percent);
 				//$.messager.progress('bar').progressbar("options").text=file.name+"("+file.percent+"%)";
 				$.messager.progress('bar').progressbar("setValue",up.total.percent);
 			},
 			UploadComplete : function(up, files,result) {
				uploadResult=JSON.parse(JSON.parse(uploadResult));
				if(uploadResult.state>0){
					$.messager.alert('提示', "上传完成", 'help');
    				$.messager.progress('close');
				}else if(uploadResult.state==-1){
					$.messager.alert('提示',uploadResult.errorMsg, 'error');
    				$.messager.progress('close');
				}else{
					$.messager.alert('提示', "导入失败", 'error');
    				$.messager.progress('close');
				}
				$("#uploadTable #fileName").html("");
				$("#uploadTable #fileSize").html("");
				$("#uploadTable #status").html("");
				$("#uploadTable #progress").html("");
				$.messager.progress('close');
				$('#ddUpload').dialog('close');
			},
			FileUploaded:function(up,file,result){
				uploadResult=(result.response);
			}
		}
	});
	uploader.init();
	//loading隐藏
	 $("#uploading",window.parent.document).hide();
	//initData();
	
	$('.showTip').click(function(){
		var userId = $(this).attr("userId");
	       $.ajax({
        		url : '${ctx}/rotary/result/userDetail.do',
        		data : "userId="+userId,
        		dataType : 'json',
        		success : function(r) {
        			if(r.id) {
        				$('#info').dialog('open');
        				$('#fullName').text(r.userName);
        				$('#sex').text(r.userInfos.sex==1?'男':'女');
        				$('#idCard').text(r.userInfos.idCard);
        				$('#birthday').text(r.userInfos.birthday);
        				$('#mobile').text(r.userInfos.mobile);
        				$('#email').text(r.userInfos.email);
        				$('#VuserName').text(r.userInfos.userName);
        				$('#VfinancialNum').text(r.userInfos.financialNum);
        				$('#department').text(r.userInfos.department);
        				$('#colleges').text(r.userInfos.colleges);
        				$('#eductionalSystme').text(r.userInfos.eductionalSystme);
        				$('#englishLevel').text(r.userInfos.englishLevel);
        				$('#highestEducation').text(r.userInfos.highestEducation);
        				$('#highestDegree').text(r.userInfos.highestDegree);
        				$('#eductionCode').text(r.userInfos.eductionCode);
						$('#yearCapital').text(r.userInfos.yearCapital);
						$('#quaCertificate').text(r.userInfos.quaCertificate=='1'?'是':'否');
						$('#praCertificate').text(r.userInfos.praCertificate=='1'?'是':'否');
        				}else {
        					$.messager.alert('错误', r.msg, 'error');
        				}
        		}
        	});
	});
	
	//添加轮转计划dialog
	 $('#addRotaryDd').dialog({
         title: "添加轮转计划",
         href : "${ctx}/rotary/result/toAddRotaryResultPage.do",
         closed:true,
         modal: true, //dialog继承自window，而window里面有modal属性，所以dialog也可以使用
         toolbar: [],
		onOpen: function() {
			
		},
		onClose: function() {
		}
     });
	 $('#ss').dialog({
			title : "按月导出excel",
			closed : true,
			modal : true, //dialog继承自window，而window里面有modal属性，所以dialog也可以使用
			toolbar : [ {
				text : 'Ok',
				iconCls : 'icon-ok',
				handler : function() {
					var checkmonth=$("#checkmonth").datebox('getValue');
					window.location.href="${ctx}/rotary/result/exportResultExcel2.do?checkmonth="+checkmonth;
					$('#ss').dialog('close');
				}
			}, {
				text : 'Cancel',
				handler : function() {
					$('#ss').dialog('close');
					$('#tt').form('clear');
				}
			} ],
			onOpen : function() {
			},
			onClose : function() {
				$('#tt').form('clear');
			}
		});
});
  function initParam(){
	$('#startDate').datebox('setValue',startDate);
	$('#endDate').datebox('setValue',endDate);
	$('#userName').textbox('setValue',userName);
	$("input[name='ViewStatus'][value="+view+"]").attr("checked",true); 
	var arrUserType = userType.split(",");
	for (var i = 0; i < arrUserType.length-1; i++) {
		$("input[name='UserTypeView'][value="+arrUserType[i]+"]").attr("checked",true); 
	}
  }
  
//导出
  function exportExl(){
	  document.GridExportForm.action = '${ctx}/rotary/result/exportResultExcel.do?view=${view}&startDate=${startDate}&departmentId=${departmentId}&userName=${userName}&userType=${userType}';
	  document.GridExportForm.submit();
  }
  function initData(){
	  var userType = '';
		$("input[name='UserTypeView']:checked").each(function(){ 
			userType += $(this).val()+',';
		});
		$('#userType').val(userType);
		//loading隐藏
		// $("#uploading").show();
		//循环加载轮转数据,每次加载一个科室的数据
		var qparam=$("#searchForm").serializeJson();
		$("#tabBody").html("");
		for(var i=0;i<departmentIdList.length;i++){
			$("#tabBody").append("<tr id='"+departmentIdList[i]+"TR'></tr>");
			$("#absoluteColumnBody").append("<tr id='"+departmentIdList[i]+"DeptTR'><td>"+departmentNameList[i]+"<a href=\"#\" onclick=\"javascript:sh(this)\" class=\"layout-button-up\" style=\"color: white;\">___</a></td></tr>");
		}
		for(var i=0;i<departmentIdList.length;i++){
			qparam.departmentId=departmentIdList[i];
			initDataTR(qparam,departmentIdList[i]);
		}
		//$("#uploading").hide();
  }
  function initDataTR(qparam,departmentId){
	  $.ajax({
			url : '${ctx}/rotary/result/listInfo.do',
			data : qparam,
			type:'post',
			dataType : 'text',
			async:true,
			success : function(r) {
				//console.log($("#"+departmentId+"TR")!=undefined);
				//console.log("#"+departmentId+"TR");
				//console.log("#"+qparam.departmentId+"TR");
				//console.log(r.replace("<tr>","").replace("</tr>",""));
				//$("#"+departmentId+"TR").html(r.replace("<tr>","").replace("</tr>",""));
				$("#"+departmentId+"TR").html(r);
				initUserShowTio("#"+departmentId+"TR");
				resize();
			},
			error : function(){
				console.log('error');
			}
		});
  }
  function initUserShowTio(obj){
	  $(obj).find(".showTip").click(function(){
			var userId = $(this).attr("userId");
		       $.ajax({
	        		url : '${ctx}/rotary/result/userDetail.do',
	        		data : "userId="+userId,
	        		dataType : 'json',
	        		success : function(r) {
	        			if(r.id) {
	        				$('#info').dialog('open');
	        				$('#fullName').text(r.userName);
	        				$('#sex').text(r.userInfos.sex==1?'男':'女');
	        				$('#idCard').text(r.userInfos.idCard);
	        				$('#birthday').text(r.userInfos.birthday);
	        				$('#mobile').text(r.userInfos.mobile);
	        				$('#email').text(r.userInfos.email);
	        				$('#VuserName').text(r.userInfos.userName);
	        				$('#VfinancialNum').text(r.userInfos.financialNum);
	        				$('#department').text(r.userInfos.department);
	        				$('#colleges').text(r.userInfos.colleges);
	        				$('#eductionalSystme').text(r.userInfos.eductionalSystme);
	        				$('#englishLevel').text(r.userInfos.englishLevel);
	        				$('#highestEducation').text(r.userInfos.highestEducation);
	        				$('#highestDegree').text(r.userInfos.highestDegree);
	        				$('#eductionCode').text(r.userInfos.eductionCode);
							$('#yearCapital').text(r.userInfos.yearCapital);
							if(r.userInfos.yearCapital)$('#yearCapital').text("PGY"+r.userInfos.yearCapital);
							$('#quaCertificate').text(r.userInfos.quaCertificate=='1'?'是':'否');
							$('#praCertificate').text(r.userInfos.praCertificate=='1'?'是':'否');
	        				}else {
	        					$.messager.alert('错误', r.msg, 'error');
	        				}
	        		}
	        	});
		});

      var before = $("#grid").scrollTop();
	  $("#grid").scroll(function() {
	      var after = $("#grid").scrollTop();
	      if(before==after){
		  	  $("#absoluteColumnTable").css({"z-index":'200'});
		  	  $("#absoluteTable").css({"z-index":'100'});
	      }else {
		  	  $("#absoluteTable").css({"z-index":'200'});
		  	  $("#absoluteColumnTable").css({"z-index":'100'});
	      }
	      var left = $("#grid").scrollLeft();
	      var toLeft = "-"+left+'px';
	      var top = "-"+after+'px';
	  	  $("#absoluteTable").css({"left":toLeft});
	  	  $("#absoluteColumnTable").css({"top":top});
	  	  before =after;
	  });
  }

  function resize(){
	  var ths = $("#dataGrid thead tr th");
	  var targetThs = $("#absoluteHead tr th");
	  for(var i=0;i<ths.length;i++) {
		  $(targetThs[i]).css("width",$(ths[i]).width());
	  }
	  
	  var trs = $("#tabBody tr");
	  var targetTrs = $("#absoluteColumnBody tr");
	  var targetThs = $("#absoluteColumnBody th");
	  targetThs.css({"width":$(ths[0]).width()});
	  for(var i=0;i<trs.length;i++) {
		  $($(targetTrs[i]).find("td:eq(0)")).css("width",$($(trs[i]).find("td:eq(0)")).width());
		  $($(targetTrs[i]).find("td:eq(0)")).css("height",$($(trs[i]).find("td:eq(0)")).height());
	  }
	  $("#absoluteColumnTable").css("width",$(ths[0]).width()+20);
	  $("#tempTable th").css("width",$(ths[0]).width());
	  $("#tempTable").css("width",$(ths[0]).width()+20);
  }
  function opendialog(){
	  $('#ss').dialog('open');
  }
</script>
<style type="text/css">
	.laber{
		text-align: right;
	}
	 #uploading{position:fixed; left:36%; top:36%; width:343px; height:140px;z-index:99999;background:white;text-align:center;padding-top: 84px;border: #9ECEB6 1px solid;}
</style>
</head>
<body style="padding:0 4px; margin:0;  overflow: hidden; ">
<div class="easyui-layout" style="width:100%;height:100%;" data-options="fit:true">
		<div id ="tt" data-options="region:'north'" style="height:110px;">
		<form id="searchForm"  action="${ctx}/rotary/result/list.do" method="post">
		<input id="view"  name="view"   type="hidden" />
		<input id="userType"  name="userType"   type="hidden" />
		<table cellpadding="5" style="width: 880px;;margin: 5px 0px 5px 20px;">
			<tr>
			<td>起始时间:</td>
			<td><input class="easyui-datebox"  id="startDate"  name="startDate" /></td>
			<td>结束时间:</td>
			<td><input class="easyui-datebox"  id="endDate"  name="endDate"  readonly="readonly"/></td>
			<td>科室:</td>
			<td><input class="easyui-combobox"  id="departmentId"  name="dptIds" /></td>
			<td>姓名:</td>
			<td><input class="easyui-textbox"  id="userName"  name="userName"  style="width: 80px"/></td>
			
			</tr>
			<tr>
			    <td>
			        <a href="#" id="btn_search" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:80px;margin-right: 20px;" type="submit">Search</a>
			        
			    </td>
			</tr>
		</table>
		</form>
			<c:if test="${curRole eq 1 or curRole eq 3 }">
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:80px;margin-right: 20px;" onclick="$('#ddUpload').dialog('open')">导入轮转</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'" style="width:80px;margin-right: 20px;" onclick="$('#addRotaryDd').dialog('open')">添加轮转</a>
			</c:if>
		<div class="datagrid-toolbar" style="margin: 10px 0 0 0;">
			<table style="width:200px;" cellspacing="0" cellpadding="0">
				<tbody>
					<tr>
						<td><a href="javascript:void(0)" onclick="exportExl()" class="l-btn l-btn-small l-btn-plain" group="" id=""><span class="l-btn-left l-btn-icon-left"><span class="l-btn-text">导出excel</span><span class="l-btn-icon icon-save">&nbsp;</span></span></a></td>
						<td><a href="javascript:void(0)"  class="l-btn l-btn-small l-btn-plain" group="" id="exportExl" onclick="opendialog();"><span class="l-btn-left l-btn-icon-left"><span class="l-btn-text">按月导出excel</span><span class="l-btn-icon icon-save">&nbsp;</span></span></a></td>
					</tr>
				</tbody>
			</table>
		</div>
		</div>
		<div id="grid" data-options="region:'center'" >
		<div id="uploading" style="display: none">
	                         正在加载数据，请耐心等待。。。。<br/>
	       <img src="../../images/loading.gif"/>          
	    </div>
<!-- 			<table  id="dg"  class="easyui-datagrid"  data-options="singleSelect:true,collapsible:true,fit:true,fitColumns:false,striped:true"> -->
			<table id="tempTable" class="table table-border table-bordered table-striped" style="position: absolute;z-index: 300;">
				<thead>
			    	<tr class="backgroundtr">
			    	<th width="240px">科室</th>
			        <c:forEach items="${title}"  var="item" varStatus="i">
			        <th width="240px"> ${item}</th>
			        </c:forEach>
			    	</tr>
				</thead>
			</table>
			<table id="absoluteTable" class="table table-border table-bordered table-striped" style="position: absolute;z-index: 2;">
				<thead id="absoluteHead">
			    	<tr class="backgroundtr">
			    	<th width="240px">科室</th>
			        <c:forEach items="${title}"  var="item" varStatus="i">
			        <th width="240px"> ${item}</th>
			        </c:forEach>
			        </tr>
				</thead>
			</table>
			<table id="absoluteColumnTable" class="table table-border table-bordered table-striped" style="position: absolute;z-index: 1;">
				<thead>
			    	<tr class="backgroundtr">
			    	<th width="240px">科室</th>
			        <c:forEach items="${title}"  var="item" varStatus="i">
			        	<th width="240px"> ${item}</th>
			        </c:forEach>
			    	</tr>
				</thead>
				<tbody id="absoluteColumnBody"></tbody>
			</table>
			<table id="dataGrid" class="table table-border table-bordered table-striped table-hover">	
			    <thead>
			    	<tr class="backgroundtr">
			    	<!-- <th data-options="field:'jj'" width="80">操作</th> -->
			    	<th data-options="field:'科室'"  width="240px">科室</th>
			        <c:forEach items="${title}"  var="item" varStatus="i">
			        <th data-options="field:'${item}'" width="240px"> ${item}</th>
			        </c:forEach>
			        </tr>
			    </thead>
 			      <tbody id="tabBody">

 			    <c:forEach items="${list}"  var="deptmap" >
 			      <c:forEach items="${deptmap}" var="item">
 			      <c:if test="${item.key.departmentName != '不轮转' && item.key.departmentName != ''}">
					
 			      <tr>
<!--  			      <td width="80"><a href="#" onclick="javascript:sh(this)">收起/展开</a></td> -->
 			      <td width="240">${item.key.departmentName }<a href="#" onclick="javascript:sh(this)" class="layout-button-up" style="color: white;">___</a></td>
						<c:forEach items="${title}" var="date">
							<td width="338">
								<div class="sh">
								<c:if test="${item.value != null }">
								<c:if test="${fn:length(item.value[date]) != 0}">
								<div align="left" style="color: threedshadow;">${fn:length(item.value[date])}人</div>
								</c:if>
								<ul >
								<c:forEach items="${item.value[date]}" var="student" >
									<li class="showTip" userId="${student.userId }">
									<c:if test="${student.userInfos.trainLimit ==1}">
									<div style="color: red">${student.fullName}
									<span style="color: threedshadow;">
									(
									<c:choose>
									   <c:when test="${student.userInfos.subjectName!=null }">
									   	${fn:replace(student.userInfos.subjectName,'('.concat(fn:substringAfter(student.userInfos.subjectName,'(')),'')}
									   </c:when>
									   <c:otherwise>
									   	${fn:replace(student.subjectName,'('.concat(fn:substringAfter(student.subjectName,'(')),'')}
									   </c:otherwise>
									</c:choose>
									/${student.userInfos.grade}级/
									<c:if test="${student.userInfos.userType ==1}">本科生</c:if>
									<c:if test="${student.userInfos.userType ==2}">研究生</c:if>
									<c:if test="${student.userInfos.userType ==3}">住院医</c:if>
									<c:if test="${student.userInfos.userType ==4}">进修医</c:if>
									<c:if test="${student.userInfos.userType ==8}">Intern</c:if>
									</c:if>
									<c:if test="${student.userInfos.trainLimit ==2}">
									<div style="color: green;">${student.fullName}
									<span style="color: threedshadow;">
									(
									<c:choose>
									   <c:when test="${student.userInfos.subjectName!=null }">
									   	${fn:replace(student.userInfos.subjectName,'('.concat(fn:substringAfter(student.userInfos.subjectName,'(')),'')}
									   </c:when>
									   <c:otherwise>
									   	${fn:replace(student.subjectName,'('.concat(fn:substringAfter(student.subjectName,'(')),'')}
									   </c:otherwise>
									</c:choose>
									/${student.userInfos.grade}级/
									<c:if test="${student.userInfos.userType ==1}">本科生</c:if>
									<c:if test="${student.userInfos.userType ==2}">研究生</c:if>
									<c:if test="${student.userInfos.userType ==3}">住院医</c:if>
									<c:if test="${student.userInfos.userType ==4}">进修医</c:if>
									<c:if test="${student.userInfos.userType ==8}">Intern</c:if>
									</c:if>
									<c:if test="${student.userInfos.trainLimit ==3}">
									<div style="color: blue;">${student.fullName }
									<span style="color: threedshadow;">
									(
									<c:choose>
									   <c:when test="${student.userInfos.subjectName!=null }">
									   	${fn:replace(student.userInfos.subjectName,'('.concat(fn:substringAfter(student.userInfos.subjectName,'(')),'')}
									   </c:when>
									   <c:otherwise>
									   	${fn:replace(student.subjectName,'('.concat(fn:substringAfter(student.subjectName,'(')),'')}
									   </c:otherwise>
									</c:choose>
									/${student.userInfos.grade}级/
									<c:if test="${student.userInfos.userType ==1}">本科生</c:if>
									<c:if test="${student.userInfos.userType ==2}">研究生</c:if>
									<c:if test="${student.userInfos.userType ==3}">住院医</c:if>
									<c:if test="${student.userInfos.userType ==4}">进修医</c:if>
									<c:if test="${student.userInfos.userType ==8}">Intern</c:if>
									</c:if>
									<c:if test="${student.userInfos.trainLimit == null}">
									<div style="color: #551A8B;">${student.fullName }
									<span style="color: threedshadow;">
									(
									<c:choose>
									   <c:when test="${student.userInfos.subjectName!=null }">
									   	${fn:replace(student.userInfos.subjectName,'('.concat(fn:substringAfter(student.userInfos.subjectName,'(')),'')}
									   </c:when>
									   <c:otherwise>
									   	${fn:replace(student.subjectName,'('.concat(fn:substringAfter(student.subjectName,'(')),'')}
									   </c:otherwise>
									</c:choose>
									/${student.userInfos.grade}级/
									<c:if test="${student.userInfos.userType ==1}">本科生</c:if>
									<c:if test="${student.userInfos.userType ==2}">研究生</c:if>
									<c:if test="${student.userInfos.userType ==3}">住院医</c:if>
									<c:if test="${student.userInfos.userType ==4}">进修医</c:if>
									<c:if test="${student.userInfos.userType ==8}">Intern</c:if>
									</c:if>
									/${student.userInfos.yearCapital})</span></div>
									</li>
								</c:forEach>
								</ul>
								</c:if>
								</div>
							</td>
						</c:forEach>
						</c:if>
					</tr>
					</c:forEach>
 			      </c:forEach>
			     
			 </tbody>		 
			</table>
		</div>
		
		<div id="info"  title="个人基本信息"  style="width:1000;height:1000px; text-align: left;" data-options="closed:true"> 
		 <form>
						<table style=" width: 100%;height:100%; border-collapse: collapse; text-align: left;" class="editTable">
				    		<tr>
				    			<td class="laber">姓名:</td>
				    			<td  id="fullName" ></td>
				    			<td class="laber">性别:</td>
				    			<td id="sex" ></td>
				    		</tr>
				    		<tr>
				    			<td class="laber">身份证号:</td>
				    			<td id="idCard" ></td>
				    			<td class="laber">出生日期:</td>
				    			<td  id="birthday" ></td>
				    		</tr>
				    		<tr>
				    			<td class="laber">手机:</td>
				    			<td id="mobile" ></td>
				    			<td class="laber">电子邮件:</td>
				    			<td id="email"></td>
				    		</tr>
				    		<tr>
				    			<td class="laber">财务号:</td>
				    			<td id="VfinancialNum" ></td>
				    			<td class="laber">单位:</td>
				    			<td id="department"></td>
				    		</tr>
				    		<tr>
				    			<td class="laber">毕业院校:</td>
				    			<td id="colleges"></td>
				    			<td class="laber">学制:</td>
				    			<td id="eductionalSystme"></td>
				    		</tr>
				    		<tr>
				    			<!-- <td class="laber">英语水平:</td>
				    			<td id="englishLevel" ></td> -->
				    			<td class="laber">最高学位:</td>
				    			<td id="highestDegree"></td>
				    			<td class="laber">最高学历:</td>
				    			<td id="highestEducation" ></td>
				    		</tr>
				    		<tr>
				    			<!-- <td class="laber">学历证书号:</td>
				    			<td id="eductionCode"></td> -->
								<td class="laber">医师资格:</td>
								<td id="quaCertificate"></td>
								<td class="laber">执业资格:</td>
								<td id="praCertificate"></td>
				    		</tr>
							<tr>
								<td class="laber">年资:</td>
								<td id="yearCapital"></td>
								<td class="laber">登录号:</td>
								<td id="VuserName"></td>
							</tr>
				    		</table>
				    		</form>
			</div>
			
		<div id="grid-export-form" class="x-hidden">
			<form method="POST" name="GridExportForm"></form>
		</div>
        
        <!-- 添加轮转结果 -->
   		<div id="addRotaryDd" title="My Dialog" class="easyui-dialog" style="width:600px;height:400px;text-align: center;" data-options="closed:true">
   		</div>
        <!-- 导入轮转结果 -->
   		<div id="ddUpload" title="My Dialog" class="easyui-dialog" style="width:600px;height:400px;text-align: center;" data-options="closed:true">

			<div id="container">
				<div id="tool">
						<a id="pickfiles"  href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add'">选择文件</a>
					    <a id="uploadfiles" href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-save'">上传文件</a>
					    <a id="uploadfiles" href="${ctx}/download/template/rotaryResult.xlsx" class="easyui-linkbutton" data-options="iconCls:'icon-save'">下载模板</a>
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
						</table>
					</div>
			</div>
			<div id="filelist">Your browser doesn't have Flash, Silverlight
				or HTML5 support.</div>
			<br />
			<pre id="console"></pre>

	   </div>
	   <div id="ss" title="按月份导出" class="easyui-dialog" style="width:300px;height:200px;text-align: center;" data-options="closed:true">
   			<form  id="tt" action="${ctx}/rotary/result/exportResultExcel.do">
   				<lebel> 请选择导出轮转月份：</lebel>
   				<input class="easyui-datebox" type="text" id="checkmonth" name="checkmonth" data-options="required:true" ></input>
			</form>
   		</div>
   </div>
</body>
  <script type="text/javascript">
   function sh(obj){
		var $tds = $(obj).parents("tr").find("td");
		var $tr = $(obj).parents("tr");
		var $a = null;
		var index=null;
		$tds.each(function(index){
			if(index==0){
				$a=$(this).find("a");
				if($a.hasClass("layout-button-up")){
					$a.removeClass("layout-button-up");
					$a.addClass("layout-button-down")
				}else if($a.hasClass("layout-button-down")){
					$a.removeClass("layout-button-down");
					$a.addClass("layout-button-up")
				};
			}
			if(index>0){
				var $div = $(this).find("div[class='sh']");
				$div.toggle();
			};
		});
		var deptId=$tr.attr("id").substring(0,$tr.attr("id").indexOf("DeptTR"));
		var tabBodyDeptTr=$("#"+deptId+"TR");
		var targetTds=tabBodyDeptTr.find("td");
		targetTds.each(function(index){
			if(index==0){
				$a=$(this).find("a");
				if($a.hasClass("layout-button-up")){
					$a.removeClass("layout-button-up");
					$a.addClass("layout-button-down")
				}else if($a.hasClass("layout-button-down")){
					$a.removeClass("layout-button-down");
					$a.addClass("layout-button-up")
				};
			}
			if(index>0){
				var $div = $(this).find("div[class='sh']");
				$div.toggle();
			};
		});
		resize();
	};
   </script>
</html>