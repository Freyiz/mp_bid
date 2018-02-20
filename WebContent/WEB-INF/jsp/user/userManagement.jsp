<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/Project09/resources/js/angular.min.js"></script>
<script src="/Project09/resources/layui/layui.js"></script>
<script src="/Project09/resources/js/jquery.min.js"></script>
<link rel="stylesheet" href="/Project09/resources/layui/css/layui.css">
<style type="text/css">
	.layui-table, .layui-table-view {
	margin: 0
}
</style>
<title>用户管理</title>
</head>

<body ng-app="myApp" ng-controller="user">
	<div class="result-data">
		<table class="layui-table">
			<tr>
				<th hidden="true">id</th>
				<th>用户权限</th>
				<th>用户名</th>
				<th>密码</th>
				<th>公司</th>
				<th>电话</th>
				<th>邮箱</th>
				<th>创建时间</th>
				<th>审核状态</th>
				<th>管理</th>				
			</tr>
			<tr ng-repeat="u in users" id="{{u.id_user}}">
				<td hidden="true">{{ u.id_user }}</td>
				<td>{{ u.role }}</td>
				<td>{{ u.username }}</td>
				<td>{{ u.password }}</td>
				<td>{{ u.org }}</td>
				<td>{{ u.tel }}</td>
				<td>{{ u.email }}</td>
				<td>{{ u.user_stamp }}</td>
				<td>{{ u.confirm }}</td>								
				<td>
					<a ng-click="updateUser(u.id_user)" href="">修改</a> 
					<a ng-click="deleteUser(u.id_user)" href="">删除</a>
				</td>
			</tr>
		</table>
		<div class="insert">
		<button ng-click="insertUser()" href="">添加新用户</button>	
		</div>
		<div id="paging"></div>
	</div>
	
</body>
</html>
<script>
	layui.use('layer', function() {
	var layer = layui.layer;
	});
	
	var usercontroller = angular.module('myApp',[]);
	usercontroller.controller('user', function($scope,$http) {
		
		$scope.per_page = 10;
		
		$scope.postCfg = {
		headers : {
			'Content-Type' : 'application/x-www-form-urlencoded'
		},
		transformRequest : function(data) {
			return $.param(data);
		}
	};
		
		$http.get("selectCount.do").then(function(data){
			$scope.count = data.data;
			layui.use('laypage', function() {
				layui.laypage.render({
					elem : 'paging',
					count : $scope.count,
					limit : $scope.per_page,
					limits : [ 5, 10, 15, 20 ],
					layout : [ 'prev', 'page', 'limit', 'next', 'skip' ],
					jump : function(obj, first) {
						$scope.curr_page = obj.curr;
						$scope.per_page = obj.limit;
						$scope.jump();
					}
				});
			});
		});
		
		$scope.jump = function(){
			$http.post("userList.do", {
				"curr_page" : $scope.curr_page,
				"per_page" : $scope.per_page				
			}, $scope.postCfg).then(function(data) {
				var a = data.data;
				a.forEach(function(e){
					if(e.confirm == 1){
						e.confirm = "已审核";
					}else {
						e.confirm = "未审核";
					}				
				})
				$scope.users = a;
			})
		}		
		
		
// 		$http.get("userList.do").then(function(data) {			
// 			var a = data.data;
// 			a.forEach(function(e){
// 				if (e.confirm == 1){
// 					e.confirm = "已审核";
// 				}else {
// 					e.confirm = "未审核";
// 				}				
// 			})
// 			$scope.users = a;
//  		});
		$scope.updateUser = function(id_user) {
			layer.open({
				type : 2,
				title : '修改',
				shadeClose : true,
				shade : 0.2,
				area : [ '500px', '90%' ],
				content : "updateUser.do?id_user="+id_user
			});
		};
		$scope.insertUser = function() {
			layer.open({
				type : 2,
				title : '新增用户',
				shadeClose : true,
				shade : 0.2,
				area : [ '500px', '90%' ],
				content : "updateUser.do?id_user="+""
			});			
		};
		$scope.deleteUser = function(id_user) {
			layer.confirm('确定删除?', {
				icon : 3,
				title : '提示',
				shadeClose : true
			},function(index) {
			$http.get("deleteByPrimaryKey/"+id_user+".do").then(function(data){
				layer.msg('删除成功！');
				window.location.reload();
			});
			layer.close(index);
			});
		}
		layui.use('laypage', function(){
			  var laypage = layui.laypage;
			  laypage.render({
			    elem: 'paging', //注意，这里的 test1 是 ID，不用加 # 号
			    count: 50, //数据总数，从服务端得到
			    limit: 10
			  });
			});
		
	});
</script>