<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML>
<html>
	<head>
		<base href="<%=basePath%>">
		<title>我的购物车</title>
		<link rel="stylesheet" type="text/css"
			href="css/bootstrap.css">
		<link rel="stylesheet" type="text/css"
			href="css/theme.css">
		<link rel="stylesheet"
			href="css/font-awesome.css">
		<script src="js/jquery-2.1.0.min.js" type="text/javascript"></script>
		<script type="text/javascript">
		var goodadd=function(){
			var windows=window.open("/goodadd", "商品添加页面", "height=520, width=520, toolbar =no, menubar=no, scrollbars=no, resizable=no, location=no, status=no");
		}
		</script>
	</head>

	<body class="content1" >
		<div class="container-fluid">
			<div class="row-fluid">
				<div class="span12">
					<div class="page-header">
						<h3>
							${sessionScope.user.username}您好，以下是您的购物车！
						</h3>
					</div>
					<ul class="nav nav-tabs">
						<li class="active">
							<a href="?">购物列表</a>
						</li>
						<li class="disabled">
							<a href="#">返回继续购买</a>
						</li>
					</ul>
					<form action="/selectbuyorderlistid" method="get">
						 购物车ID：${buycar.carid}<br/>
						<input class="input-medium search-query" type="text" id="orderid" />
						 <button  onclick="selectbyid()" class="btn">查找</button>
						
					</form>
					<table class="table">
						<thead>
							<tr>
								<th><input type="checkbox"  onclick="selectall(this);" value="all"/>全选
								</th>
								<th>
									商品ID
								</th>
								<th>
									商品图
								</th>
								<th>
									商品编号
								</th>
								<th>
									商品名称
								</th>
								<th>
									商品价格
								</th>
								<th>
									购买数量
								</th>
								<th>
									支付状态
								</th>
								<th>
									操作
								</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${buycar.list}" var="order">
								<tr>
									<td><input type="checkbox" name="selectget" value="${order.orderid}" 
										<c:if test="${order.buystate==1}">
											 disabled 
										</c:if>
									/></td>
									<td>${order.good.goodid}</td>
									<td><img src="${order.good.goodimg}" width="120px;"></img></td>
									<td>${order.good.goodno}</td>
									<td>${order.good.goodname}</td>
									<td>${order.good.goodprice}</td>
									<td>${order.buynum}</td>
									<td>
										<c:choose>
											<c:when test="${order.buystate==1}">
												已支付
											</c:when>
											<c:otherwise>
												未支付
											</c:otherwise>
										</c:choose>								
									</td>
									<td>
										<a>修改所购商品数</a><br/>
										<a>删除该商品</a>
									</td>
								</tr>
							</c:forEach>
							<tr>
								<td  colspan="9" style="text-align: right;">
									总价：${buycar.totalmaney}
								</td>
							</tr>
							<tr>
								<td colspan="9" style="text-align: right;">
									<button onclick="getall()">结账</button>
									<script type="text/javascript">
										var getall=function(){
											var checkboxs = document.getElementsByName("selectget");
											var totalmoney=0;
											var s=0;
											var orderids=[];
											for(var i=0;i<checkboxs.length;i++){
												if(checkboxs[i].checked){
													orderids[s++]=checkboxs[i].value;
												}
											}
											$.post("/orderclose","orderids="+orderids,function(data){
												if(data.msg==""){
													alert("您本次共消费："+data.totelprice+"元！");
												}else{
													alert("您本次共消费："+data.totelprice+"元！,其中"+data.msg+"。");
												}
												window.location.reload();
											})
										}
									</script>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="pagination pagination-right">
						<ul>
							<li>
								<a href="#" >上一页</a>
							</li>
							<li>
								<a href="#">1</a>
							</li>
							<li>
								<a href="#">2</a>
							</li>
							<li>
								<a href="#">3</a>
							</li>
							<li>
								<a href="#">4</a>
							</li>
							<li>
								<a href="#">5</a>
							</li>
							<li>
								<a href="#">下一页</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<script type="text/javascript">
			var selectall=function(obj){
				var checkboxs = document.getElementsByName("selectget");
				for(var i=0;i<checkboxs.length;i++){checkboxs[i].checked = obj.checked;}
			}
		</script>
	</body>
</html>