<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品上传成功！</title>
</head>
<body>
	恭喜您，添加购物车成功，1秒后跳转到主页面！
	<script type="text/javascript">
	window.onload=function(){
		setTimeout(function(){ 
		//IE6、7不会提示关闭 
		window.opener.location.reload();
	    window.opener=null;                 //刷新父窗口，关闭子窗口
		window.open("","_self"); 
		window.close(); }, 
		1500);
    }
	</script>
</body>
</html>