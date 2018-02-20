<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/Project09/resources/js/jquery.min.js"></script>
<script src="/Project09/resources/js/angular.min.js"></script>
<script src="/Project09/resources/layui/layui.js"></script>
<link rel="stylesheet" href="/Project09/resources/layui/css/layui.css">
<link rel="stylesheet" href="/Project09/resources/css/font-awesome.min.css">
<title>查看</title>
<style>
body {
	display: flex;
	flex-direction: column;
	align-items: center;
	padding: 0 20px;
}
form input:not(.fuzzy){
	width: 100px;
}
.count {
    float: left;
	margin: 20px 0 0 5px;
}
#pagination {
	float: right;
}
.startBid {
	text-align: center;
}
</style>
</head>
<body ng-app="myApp" ng-controller="vehicle">
	<form hidden="true" class="result-data">
		<label>品牌：<input type="text" ng-model="query.brand" placeholder="品牌"></label>
		<label>车系：<input type="text" ng-model="query.brand_model" placeholder="车系"></label>
		<label>价格区间：
			<input type="number" ng-model="query.start_price"
			class="price_scope lowest_price" ng-value="lowest_price" 
			min="{{lowest_price}}" max="{{highest_price}}" step="1000">
		</label> <label> ~ <input type="number"
			ng-model="query.curr_price" class="price_scope highest_price"
			ng-value="highest_price" min="{{lowest_price}}"
			max="{{highest_price}}" step="1000"></label>
		<label>
			状态：
			<select ng-model="query.veh_state_detail">
				<option value="">所有</option>
				<option>新入库</option>
				<option>预拍</option>
				<option>拍卖中</option>
				<option>拍卖到期</option>
				<option>待付款</option>
				<option>付款到期</option>
				<option>已付款</option>
				<option>已交车</option>
			</select> 
		</label>
		<label>模糊搜索
			<input type="checkbox" class="fuzzy">
		</label>
		<button ng-click="select()" class="layui-btn search">搜索</button>
      	<button ng-click="reset()" class="layui-btn layui-btn-primary">重置</button>
      	<br>
      	<label>批次：<input type="text" ng-model="query.batch_num" placeholder="批次"></label>
      	<label>
			<select ng-model="unique">
				<option value="">ID</option>
				<option value="license_num">车牌号</option>
				<option value="veh_id_num">车架码</option>
				<option value="engine_num">发动机号</option>
			</select>
			<input type="text" ng-show="unique==''" ng-model="query.id_veh" placeholder="ID">
			<input type="text" ng-show="unique=='license_num'" ng-model="query.license_num" placeholder="车牌号">
			<input type="text" ng-show="unique=='veh_id_num'" ng-model="query.veh_id_num" placeholder="车架码">
			<input type="text" ng-show="unique=='engine_num'" ng-model="query.engine_num" placeholder="发动机号">
		</label>
	</form>
	<div hidden="true" class="result-data">
		<div>
			<span class="count">共计{{count}}个结果</span>
			<div ng-show="count" id="pagination"></div>
		</div>
		<table ng-if="vehicles.length>0" class="layui-table">
			<tr>
				<th>序号</th>
				<th>图片</th>
				<th>批次</th>
				<th>ID</th>
				<th>车牌号</th>
				<th>车架码</th>
				<th>发动机号</th>
				<th>品牌</th>
				<th>车系</th>
				<th>备注</th>
				<th>状态</th>
				<th>拍卖</th>
				<th>管理</th>
			</tr>
			<tr ng-repeat="v in vehicles" id="{{v.id_veh}}">
				<td>{{ v.row_num }}</td>
				<td><a class="fa fa-image" href="" ng-click="showImg(v.id_veh)"></a></td>
				<td>{{ v.batch_num }}</td>
				<td>{{ v.id_veh }}</td>
				<td>{{ v.license_num }}</td>
				<td>{{ v.veh_id_num }}</td>
				<td>{{ v.engine_num }}</td>
				<td>{{ v.brand }}</td>
				<td>{{ v.brand_model }}</td>
				<td>{{ v.remark }}</td>
				<td>{{ v.veh_state_detail }}</td>
				<td class="startBid">
					<a name="{{v.veh_state_detail}}" onclick="startBid(this)"
						ng-show="v.veh_state_detail!='拍卖中'&&v.veh_state_detail!='已付款'&&v.veh_state_detail!='已交车'" 
						class="fa fa-plus" href=""></a> 
				</td>
				<td>
					<a ng-click="updateVehicle(v.id_veh)" href="">修改</a> 
					<a ng-click="deleteVehicle(v)" href="">删除</a>
				</td>
			</tr>
		</table>
	</div>
</body>
<script>
	window.onload = function() {
		$('.result-data').show();
	};
	var lowest_price, highest_price;
	var app = angular.module("myApp", []);
	app.controller("vehicle", function($scope, $http) {
		$scope.unique = '';
		$scope.per_page = 10;
		$scope.postCfg = {
			headers : {
				'Content-Type' : 'application/x-www-form-urlencoded'
			},
			transformRequest : function(data) {
				return $.param(data);
			}
		}
		$http.get("../selectLowestAndHighestPrice.do").then(function(data) {
			$scope.lowest_price = parseInt(data.data[0]);
			lowest_price = $scope.lowest_price;
			$scope.highest_price = parseInt(data.data[1]);
			highest_price = $scope.highest_price;
		})
		$scope.showImg = function(id_veh) {
			parent.layer.open({
				type : 2,
				title : '车辆实图',
				shadeClose : true,
				shade : 0.2,
				area : [ '1000px', '90%' ],
				content : "vehicleImg/selectByForeignKey/"+id_veh+".do"
			});
		}
		//获取数据总数，渲染分页
		$scope.select = function() {
			$scope.vehicleJSON = JSON.stringify($scope.query);
			$scope.mode = $(".fuzzy").is(":checked") ? "fuzzy" : "precise";
			$http.post("selectCount.do", {
				"vehicleJSON" : $scope.vehicleJSON,
				"mode" : $scope.mode,
			}, $scope.postCfg).then(function(data) {
				$scope.count = data.data;
				layui.use('laypage', function() {
					layui.laypage.render({
						elem : 'pagination',
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
		}
		//分页跳转
		$scope.jump = function() {
			$http.post("select.do", {
				"vehicleJSON" : $scope.vehicleJSON,
				"mode" : $scope.mode,
				"curr_page" : $scope.curr_page,
				"per_page" : $scope.per_page
			}, $scope.postCfg).then(function(data) {
				$scope.vehicles = data.data;
			});			
		}
		$scope.select();

		$scope.reset = function() {
			$scope.query = {
				start_price : lowest_price,
				curr_price : highest_price,
			};
			$(".fuzzy").attr("checked", false);
			$(".search").removeAttr("disabled").css({
				"background-color" : "#009688",
				"cursor" : "pointer"
			});
		}
		$scope.updateVehicle = function(id_veh) {
			parent.layer.open({
				type : 2,
				title : '修改',
				shadeClose : true,
				shade : 0.2,
				area : [ '500px', '90%' ],
				content : "vehicle/updateVehicle.do?id_veh=" + id_veh
			});
		}
		$scope.deleteVehicle = function(v) {
			parent.layer.confirm('确定删除?', {
				icon : 2,
				title : '提示',
				shadeClose : true
			}, function(index) {
				$http.get("deleteByPrimaryKey/" + v.id_veh + ".do").then(function(data) {
					parent.layer.msg('删除成功！');
					$scope.vehicles.splice($scope.vehicles.indexOf(v), 1);
				});
				parent.layer.close(index);
			});
		}
	});
	// 使用onclick而不是ng-click，确保加入拍卖或预定拍卖后再点击拍卖按钮时弹出正确的提示信息 
	function startBid(currNode){
		var id_veh = currNode.parentNode.parentNode.id;
		// 获取更新后的提示信息
		var veh_state_detail = currNode.name;
		if (veh_state_detail=='预拍' || veh_state_detail=='待付款' 
			|| veh_state_detail=='付款到期') {
			parent.layer.confirm('该车辆处于'+veh_state_detail+'状态，仍然继续?', {
				icon : 7,
				title : '警告',
				shadeClose : true
			}, function(index) {
				parent.layer.close(index);
				toStartBidPage(id_veh,"force");
			});
		} else {
			toStartBidPage(id_veh,"noforce");
		}
	}
	// type：force表示强制加入拍卖， noforce表示若车辆处于中标状态则不会重新加入拍卖
	function toStartBidPage(id_veh,type){
		parent.layer.open({
			type : 2,
			title : '拍卖管理',
			shadeClose : true,
			shade : 0.1,
			area : [ '460px', '90%' ],
			content : "vehicle/startBid.do?id_veh=" + id_veh + "&type=" + type
		});
	}
	$(".price_scope").bind("input propertychange",function() {
		var val = parseInt($(this).val());
		if ((/^\d+000$/.test(val)) && val >= lowest_price
				&& val <= highest_price) {
			$(".search").removeAttr("disabled").css({
				"background-color" : "#009688",
				"cursor" : "pointer"
			});
		} else {
			$(".search").attr("disabled", "disabled").css({
				"background-color" : "rgba(0, 150, 136,0.3)",
				"cursor" : "default"
			});
		}
	});
</script>
</html>