<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
   <%@ include file="/WEB-INF/views/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<title>首页</title>
<script type="text/javascript">
var lastTabs = new Array(); 
var currentTabTitle = "Home";
var json = window.data;
$(document).ready(function () {
	$(".iframe").load(function () {
	    var mainheight = $(this).contents().find("body").height() + 40;
	    $(this).height(mainheight);
	});
	
	 $(".easyui-accordion li").mouseover(function(){
		 if($(this).hasClass("clicked")) {
			 return;
		 } else {
			 $(this).addClass("menuHover");
		 }
	 });
	 $(".easyui-accordion li").mouseout(function(){
		 if($(this).hasClass("clicked")) {
			 return;
		 } else {
			 $(this).removeClass("menuHover");
		 }
	 });
	 $(".easyui-accordion li").click(function(){
		 //退出登录
		 if($(this).attr("href").indexOf("/ajaxLogout.do")>0){
			 $.ajax({
					url : $(this).attr("href"),
					data : null,
					method: 'POST',
					dataType : 'text',
					success : function(r) {
						window.location="${ctx}/login/tologin.do";
					}
				});
		 } else
		 if($(this).hasClass("clicked")) {
			 refreshTab({tabTitle:$(this).attr("title"),url:$(this).attr("href")});
		 } else {
			 $(".easyui-accordion .clicked").removeClass("clicked");
			 $(this).removeClass("menuHover");
			 $(this).addClass("clicked");
			 addTab($(this).attr("title"),$(this).attr("href"),null);
	
		 }
	 });
	 
	 $("#forword").click(function(){
		 //退出登录
		 if($(this).attr("href").indexOf("/ajaxLogout.do")>0){
			 $.ajax({
					url : $(this).attr("href"),
					data : null,
					method: 'POST',
					dataType : 'text',
					success : function(r) {
						window.location="${ctx}/login/tologin.do";
					}
				});
		 } else
		 if($(this).hasClass("clicked")) {
			 refreshTab({tabTitle:$(this).attr("title"),url:$(this).attr("href")});
		 } else {
			 $(".easyui-accordion .clicked").removeClass("clicked");
			 $(this).removeClass("menuHover");
			 $(this).addClass("clicked");
			 addTab($(this).attr("title"),$(this).attr("href"),null);
	
		 }
	 });
	 
	 $("#toExit").click(function(){
		 $.messager.confirm('确定','您确定要注销吗',function(t){
 			if(t)
 			{
			 $.ajax({
				url : $(this).attr("href"),
				data : null,
				method: 'POST',
				dataType : 'text',
				success : function(r) {
					window.location="${ctx}/login/tologin.do";
				}
			});
 			}
	 	})
	 });
	 
	 
	 $('.easyui-tabs').tabs({
		 onSelect: function(title) { 
			//移除 tt 
			lastTabs = $.grep(lastTabs, function(n, i) { return n != title; }); 
			//重新压入，保证 最新的在最上面 
			lastTabs.push(title); 
			//更新当前 
			currentTabTitle = title; 
			var clickedMenu =  $(".easyui-accordion .clicked");
			 if(clickedMenu) {
				 clickedMenu.removeClass("clicked");
				 $(".easyui-accordion li[title='"+title+"']").addClass("clicked");
				 var titleparent =  $(".easyui-accordion li[title='"+title+"']").parent().parent().siblings();
				 if (titleparent.hasClass("accordion-header-selected")){
					 
				 }else{
					 titleparent.trigger('click');
				 }
				 //展开tab所属的一级菜单
				var menuGroupTitle = $(".easyui-accordion li[title='"+title+"']").parent().parent().attr("atitle");
				  if(clickedMenu.parent().parent().attr("atitle") !=menuGroupTitle  ) {
					  $("#aa").accordion('select', menuGroupTitle);
				 }
				  
				  if(currentTabTitle == "首页"){
					  refreshTab({tabTitle:currentTabTitle,url:null});
				  }
			 }
			 
			 
			}, 
		 onClose:function(title){   
			 var tt = $('.easyui-tabs');
			//移除 tt 
			 lastTabs = $.grep(lastTabs, function(n, i) { return n != title; }); 
			 //重新选择 
			 tt.tabs('select', lastTabs[lastTabs.length - 1]); 
			 
			 
			 var clickedMenu =  $(".easyui-accordion .clicked");
			 if(clickedMenu) {
				 if(clickedMenu.attr("title") == title) {
					 clickedMenu.removeClass("clicked");
				 }
			 }
	      }   
	  });
	 
	/*  table */
	$('.course_t tr:odd,.exam_t tr:odd').css("background-color","#f8f8f8");
	$('.course_t tr:last,.exam_t tr:last,.table-year tr:last').css("border-bottom","0");
})

function removePanel(){
	 var tt = $('.easyui-tabs');
    var tab = tt.tabs('getSelected');
    if(tab){
        var index = tt.tabs('getTabIndex',tab);
        tt.tabs('close',index);
    }
}

function getTabs(){
	return  $('.easyui-tabs');
}

function getSelectedTabIndex(){
	var tt = $('.easyui-tabs');
	var tab = tt.tabs('getSelected');
	return tt.tabs('getTabIndex',tab);
}

/**    
 * 刷新tab
 * @cfg 
 *example: {tabTitle:'tabTitle',url:'refreshUrl'}
 *如果tabTitle为空，则默认刷新当前选中的tab
 *如果url为空，则默认以原来的url进行reload
 */
function refreshTab(cfg){
	var refresh_tab = cfg.tabTitle?$('.easyui-tabs').tabs('getTab',cfg.tabTitle):$('.easyui-tabs').tabs('getSelected');
	if(refresh_tab && refresh_tab.find('iframe').length > 0){
	var _refresh_ifram = refresh_tab.find('iframe')[0];
	var refresh_url = cfg.url?cfg.url:_refresh_ifram.src;
	_refresh_ifram.contentWindow.location.href=refresh_url;
	}
}

</script> 

</head>
<body class="easyui-layout" data-options="fit:true">
    <div region="north" style="overflow: hidden; height: 50px;border:none;">
        <div class="top-bg">
        	<div style="width:200px; height:50px;float: left;text-align: center;background:#ffffff;"><img alt="医院logo" src="logo.png" style="height:47px;width:163px;"></div>
        	<div class="top-center">
        	     <!-- <span class="ml-20"><a href="##">系统配置</a></span>
        	     <span class="ml-20"><a href="##">公告管理</a></span> -->
        	</div>
        	<div class="top-right">    
        	   <!--   系统通知  -->
        	         	    
        	     <div class="people">
        	          <img src="${ctx}/images/toppeople.png" alt="用户" style="width:31px;float:left;"/>
        	          <span class="peoplezi">用户名</span>
        	     </div>  
        	     <div class="checkout">
        	           <a id="toExit" >注销</a>
        	     </div>  	     
        	</div>
        </div>
    </div>
    <div region="west" border="true" title="导航菜单" style="width: 200px;">
    	<div id="aa" class="easyui-accordion" >
            <div title="<img src='${ctx}/js/easyui/themes/icons/graduate-management.png'>人员维护"  style="overflow: auto; padding: 2px 0px 2px 0px;">
    			<ul style="list-style: none; margin: 0; width: 100%; padding: 0; vertical-align: middle;">
    				
    					<li href="${ctx}/searchperson"  title="人员身份信息查询">人员身份信息查询
    					<li href="${ctx}/residentmanage"  title="住院医管理">住院医管理
    					<li href="${ctx}/teachermanage"  title="师资管理">师资管理
    					<li href="${ctx}/teachingsecretary"  title="教学秘书与主任">教学秘书与主任
    					<li href="${ctx}/headofteaching"  title="教研室秘书与主任">教研室秘书与主任
    			</ul>
    		</div>
    		
            <div title="<img src='${ctx}/js/easyui/themes/icons/graduate-management.png'>培训课程"  style="overflow: auto; padding: 2px 0px 2px 0px;">
    			<ul style="list-style: none; margin: 0; width: 100%; padding: 0; vertical-align: middle;">
    				
    					<li href="${ctx}/traintype"  title="培训类型管理">培训类型管理
    					<li href="${ctx}/coursetype"  title="课程类型管理">课程类型管理
    					<li href="${ctx}/trainorder"  title="教学活动预约">教学活动预约
    					<li href="${ctx}/hospitalcheck"  title="院级课程审核">院级课程审核
    					<li href="${ctx}/trainquery"  title="教学活动查询">教学活动查询
    			</ul>
    		</div>
    		
    		<div title="<img src='${ctx}/js/easyui/themes/icons/graduate-management.png'>轮转管理"  style="overflow: auto; padding: 2px 0px 2px 0px;">
    			<ul style="list-style: none; margin: 0; width: 100%; padding: 0; vertical-align: middle;">
    	
    					<li href="${ctx}/monthrotatelist"  title="按月轮转一览表">按月轮转一览表
    					<li href="${ctx}/monthrotatequery"  title="按月轮转入科查询">按月轮转入科查询
    			</ul>
    		</div>
    		
    		<div title="<img src='${ctx}/js/easyui/themes/icons/graduate-management.png'>出科评价"  style="overflow: auto; padding: 2px 0px 2px 0px;">
    			<ul style="list-style: none; margin: 0; width: 100%; padding: 0; vertical-align: middle;">
    				
    					<li href="${ctx}/teacherstatistics"  title="带教老师评价统计">带教老师评价统计
    					<li href="${ctx}/url"  title="学员出科评价统计">学员出科评价统计
    			</ul>
    		</div>
    		
    		<div title="<img src='${ctx}/js/easyui/themes/icons/graduate-management.png'>考勤管理"  style="overflow: auto; padding: 2px 0px 2px 0px;">
    			<ul style="list-style: none; margin: 0; width: 100%; padding: 0; vertical-align: middle;">
    				
    					<li href="${ctx}/url"  title="学生请假管理">学生请假管理
    					<li href="${ctx}/url"  title="学生请假记录查询">学生请假记录查询
    					<li href="${ctx}/url"  title="考勤统计">考勤统计
    			</ul>
    		</div>
    		
    		<div title="<img src='${ctx}/js/easyui/themes/icons/graduate-management.png'>数据字典管理"  style="overflow: auto; padding: 2px 0px 2px 0px;">
    			<ul style="list-style: none; margin: 0; width: 100%; padding: 0; vertical-align: middle;">
    				
    					<li href="${ctx}/url"  title="科室类别">科室类别
    					<li href="${ctx}/url"  title="房间管理">房间管理
    					<li href="${ctx}/url"  title="科室管理">科室管理
    					<li href="${ctx}/url"  title="学科管理">学科管理
    					<li href="${ctx}/url"  title="学科科室">学科科室
    					<li href="${ctx}/url"  title="科室分类管理">科室分类管理
    			</ul>
    		</div>
    		
    		<div title="<img src='${ctx}/js/easyui/themes/icons/graduate-management.png'>学籍管理"  style="overflow: auto; padding: 2px 0px 2px 0px;">
    			<ul style="list-style: none; margin: 0; width: 100%; padding: 0; vertical-align: middle;">
    				
    					<li href="${ctx}/url"  title="本院住院医">本院住院医
    					<li href="${ctx}/url"  title="基地住院医">基地住院医
    			</ul>
    		</div>
    	</div>
    </div>
    <div id="mainPanle" border="true"  region="center" style="overflow: auto;background:#f4f4f4;padding:15px 5px 5px 15px;">
    	<div class="easyui-tabs" data-options="tabWidth:150,tools:'#tab-tools', fit:true" >
			<div title="首页" style="width:100%;height:100%;" >
				<div class="index_top">
				    <div class="index_img">
				        <img src="${ctx}/images/people.png" />
				    </div> 
				    <div class="index_right">
				         <p>欢迎<span class="index_name">$测试</span>登录，您的登录时间为： <span class="index_name"> ${currentDate } </span></p>
				         <!-- <p><a class="find" id="returnPasswd"><a class="find" id="">修改密码</a>&nbsp;|&nbsp; <a class="find" id="">信息维护</a></p> -->
				    </div>   
				</div>
				
				<iframe class="iframe" src="" frameborder=no scrolling=auto style="width:100%;margin:10px 0px 10px 0px;"></iframe>
					
   			</div>
   		</div>
   	</div>
   	<script type="text/javascript">
	   	function addTab(title, href,icon){
	   		var tt = $('.easyui-tabs');
	   		if (tt.tabs('exists', title)){//如果tab已经存在,则选中并刷新该tab    	
	   	        tt.tabs('select', title);
	   	        refreshTab({tabTitle:title,url:href});
	   		} else {
	   			var content = '未实现';
	   	    	if (href){
	   		    	 content = '<iframe scrolling="no" frameborder="0"  src="'+href+'" style="width:100%;height:100%;"></iframe>';
	   	    	} else {
	   	    	}
	   	    	tt.tabs('add',{
	   		    	title:title,
	   		    	closable:true,
	   		    	content:content,
	   	    	});
	   		}
	   	}
	   	
	   	function openTable(title, href){
	   	 //展开tab所属的一级菜单
	   	 var li = $(".easyui-accordion li[title='"+title+"']");
	   	 if(li){
	   		var clickedMenu =  $(".easyui-accordion .clicked");
	   		if(clickedMenu) {
				 clickedMenu.removeClass("clicked");
	   		}
			$(".easyui-accordion li[title='"+title+"']").addClass("clicked");
			addTab(title, href, null);
	   		
	   		var menuGroupTitle = li.parent().parent().attr("atitle");
		   	  if(clickedMenu.parent().parent().attr("atitle") !=menuGroupTitle  ) {
		   		  $("#aa").accordion('select', menuGroupTitle);
		   	 }
	   	 }
	   }
   	</script>
</body>

</html>