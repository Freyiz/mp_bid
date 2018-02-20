<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/Project09/resources/js/jquery.min.js"></script>
<script src="/Project09/resources/js/angular.min.js"></script>
<script src="/Project09/resources/layui/layui.js"></script>
<script src="/Project09/resources/js/curr_time.js"></script>
<link rel="stylesheet" href="/Project09/resources/layui/css/layui.css">
<link rel="stylesheet" href="/Project09/resources/css/index.css">
<title>明拍</title>
<style>
.selectVehicle>a{
	border-top: 1px solid gray;
}
.body>div.layui-nav-tree {
	width: 15%;
}
</style>
</head>
<body>
	<div class="head">
		<div class="left-button">
			<div class="left-nav-button">
				<i class="layui-icon">&#xe62e;</i>
			</div>
		</div>
		<div class="middle">
			<div class="search"></div>

		</div>
		<div class="right-button">
			<div class="search-button layui-anim">
				<i class="layui-icon layui-anim" id="search">&#xe615;</i>
			</div>
			<div class="user">
				<li class="user"><i class="layui-icon">&#xe612;</i>${user.username}</li>
			</div>
			<div class="date">
				<span id="date"></span>
			</div>
			<div>
				<a href="" class="logout">退出</a>
			</div>
		</div>
	</div>
	<div class="body">
		<div class="layui-nav layui-nav-tree">
			<li class="layui-nav-item bid"><a href="" name="vehicleInBidding">车辆拍卖</a></li>
			<li class="layui-nav-item bid"><a href="" name="userBidding">我的竞拍</a></li>
			<li class="layui-nav-item bid"><a href="" name="userFollowing">我的关注</a></li>
			<li class="layui-nav-item bid"><a href="" name="userBidSuccess">竞拍成功</a></li>
 			<li class="layui-nav-item user"><a href="">用户管理</a></li>
<!-- 			<li class="layui-nav-item vehicle"><a href="">拍卖管理</a></li> -->
<!-- 			<li class="layui-nav-item vehicle"><a href="">中标查询</a></li> -->
			<li class="layui-nav-item selectVehicle"><a href="">所有车辆</a></li>
			<li class="layui-nav-item insertVehicle"><a href="">添加车辆</a></li>
			<li class="layui-nav-item uploadVehicle"><a href="">导入车辆</a></li>
		</div>
		<iframe src=""></iframe>
	</div>
</body>
<script>
// 	$("body *").click(function() {
// 		console.log("${user}");
// 		if ("${user}"=='') {
// 			console.log(111);
// 			location.reload();
// 			window.location.href = "login.jsp";
// 		}
// 	})
	$(".user a").click(function() {
		$("iframe").attr("src", "user/userManagement.do");
	})
	$(".bid a").click(function() {
		$("iframe").attr("src", "vehicleInBidding.do?pageType=" + $(this).attr("name"));
	})
	$(".selectVehicle a").click(function() {
		$("iframe").attr("src", "vehicle/selectVehicle.do");
	})
	$(".insertVehicle a").click(function() {
		$("iframe").attr("src", "vehicle/insertVehicle.do");
	})
	$(".uploadVehicle a").click(function() {
		$("iframe").attr("src", "vehicle/uploadVehicle.do");
	})
	$(".layui-nav-item a").click(function() {
		$(".layui-nav a").removeClass("layui-this");
		$(this).addClass("layui-this");
		return false;
	})
	$(".logout").click(function() {
		$.ajax({
			type : "get",
			url : "user/logout.do",
			success : function(data) {
				window.location.href = "login.jsp";
			}
		});
		return false;
	})
</script>
</html>
