<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/Project09/resources/js/jquery.min.js"></script>
<script src="/Project09/resources/layui/layui.js"></script>
<script src="/Project09/resources/js/angular.min.js"></script>
<link rel="stylesheet" href="/Project09/resources/layui/css/layui.css">
<title>修改</title>
<style>
form {
	margin-right: 50px;
	margin-top: 20px;
}


</style>
</head>
<body ng-app="update">
	<form class="layui-form" action="" ng-controller="updateCtrl">
		<input hidden="true" type="text" name="id_user" ng-model="user.id_user"
			value="{{ user.id_user }}">
		<div class="layui-form-item">
			<label class="layui-form-label">用户权限</label>
			<div class="layui-input-block">
				<input type="radio" name="role" value="user" title="普通用户" ng-model="user.role" checked>
				<input type="radio" name="role" value="manager" title="管理员" ng-model="user.role">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">用户名</label>
			<div class="layui-input-block">
				<input type="text" name="username" ng-model="user.username" 
				value="{{ user.username }}" placeholder="用户名" autocomplete="on"
					class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">密码</label>
			<div class="layui-input-block">
				<input type="text" name="password" ng-model="user.password" 
				value="{{ user.password }}" placeholder="密码" autocomplete="on"
					class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">公司</label>
			<div class="layui-input-block">
				<input type="text" name="org" ng-model="user.org"
					value="{{ user.org }}"
					placeholder="公司" autocomplete="on"
					class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">电话</label>
			<div class="layui-input-block">
				<input type="text" name="tel" ng-model="user.tel" 
				value="{{ user.tel }}" placeholder="电话" autocomplete="on"
					class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">邮箱</label>
			<div class="layui-input-block">
				<input type="text" name="email" ng-model="user.email" 
				value="{{ user.email }}" placeholder="邮箱" autocomplete="on"
					class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">审核状态</label>
			<div class="layui-input-block">
				<input type="checkbox" name="confirm" lay-skin="switch" lay-text="已审|未审" ng-model="user.confirm" value="1" ng-checked="user.confirm==1">
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn" lay-submit lay-filter="formDemo">保存</button>
			</div>
		</div>
	</form>
</body>
<script>
	var updatecontroller = angular.module('update', []);
	var id_user = window.document.location.href.split("=")[1];
	updatecontroller.controller('updateCtrl', function($scope, $http) {
		$scope.postCfg = {
				headers : {
					'Content-Type' : 'application/x-www-form-urlencoded'
				},
				transformRequest : function(data) {
					return $.param(data);
				}
			};
		
		$http.get("selectByPrimaryKey/" + id_user + ".do").then(function(data) {
			$scope.user = data.data;
			console.log($scope.user);
			if ($scope.user.id_user !=null) {
				$scope.url = "updateSelective.do";
				$scope.method = 'post';
				layui.use([ 'form', 'layer' ], function() {
					var form = layui.form, layer = layui.layer;
					
					if($scope.user.confirm == null){
						$scope.user.confirm == 0;
					};
					console.log($scope.user.confirm);
					form.on('submit(formDemo)', function(id_user) {
						console.log($scope.user.confirm);
						$.ajax({
							type : "post",
							url : "updateSelective.do",
							data : $("form").serialize(),
							success : function(data) {
								layer.msg("添加成功！");
								parent.layer.close(parent.layer.getFrameIndex(window.name));
								parent.layer.msg("修改成功！");
								parent.location.reload();
							}
						});				
						return false;
//		 				$http({
//		 					method : $scope.method,
//		 					url : $scope.url,
//		 					data : $("form").serialize()
//		 				}).then(
//		 						function(response) {
//		 							var data = response.date;
//		 							if (data = 1) {
//		 								parent.layer.close(parent.layer
//		 										.getFrameIndex(window.name));
//		 								parent.location.reload;
//		 								parent.layer.msg("修改成功！");
//		 							} else {
//		 								layer.msg("修改失败");
//		 							}

//		 						}, function(response) {
//		 							$scope.data = response.data;
//		 							$scope.status = response.data;
//		 						});
//		 				return false;
					});
				});
			} else {
				$scope.url = "insertSelective.do";
				$scope.method = 'post';
				if($scope.user.confirm !=1) {
					$scope.user.confirm = 0;
				}
				layui.use([ 'form', 'layer' ], function() {
					var form = layui.form, layer = layui.layer;
					form.on('submit(formDemo)', function(id_user) {				
						$.ajax({
							type : "post",
							url : "insertSelective.do",
							data : $("form").serialize(),
							success : function(data) {
								layer.msg("添加成功！");
								parent.layer.close(parent.layer.getFrameIndex(window.name));
								parent.layer.msg("修改成功！");
								parent.location.reload();
							}
						});				
						return false;
					});
				});
			}
		});

	});
</script>
</html>