<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/Project09/resources/js/angular.min.js"></script>
<script src="/Project09/resources/layui/layui.js"></script>
<link rel="stylesheet" href="/Project09/resources/layui/css/layui.css">
<title>用户管理</title>
</head>
<body ng-app="myApp">
<div  class="result-data" ng-controller="user">
		<!-- <div class=""><span class="count">共计{{count}}个结果</span><div id="pagination"></div></div> -->
		<table class="layui-table">
			<tr>
				<th hidden="true">id</th>
				<th>用户名</th>
				<th>公司</th>
				<th>电话</th>
				<th>邮箱</th>
				<th>管理</th>				
			</tr>
			<tr ng-repeat="u in users" id="{{u.id_user}}">
				<td hidden="true">{{ u.id_user }}</td>
				<td>{{ u.username }}</td>
				<td>{{ u.org }}</td>
				<td>{{ u.tel }}</td>
				<td>{{ u.email }}</td>				
				<td><span>修改      </span><span>  删除</span></td>
			</tr>
		</table>
	</div>
</body>
</html>
<script type="text/javascript">
	var usercontroller = angular.module('myApp',[]);
	usercontroller.controller('user', function($scope) {
		$scope.users = [
			{id_user: 12,username:'bai',org:'deke',tel: 123,email:'ds'},
			{id_user: 12,username:'bai',org:'deke',tel: 123,email:'ds'},
			{id_user: 12,username:'bai',org:'deke',tel: 123,email:'ds'},
			{id_user: 12,username:'bai',org:'deke',tel: 123,email:'ds'},
		];
	});
</script>