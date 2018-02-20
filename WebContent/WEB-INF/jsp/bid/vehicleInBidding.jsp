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
form {
	margin-bottom: 20px;
}
form input:not(.fuzzy){
	width: 100px;
}
.fa:hover {
	cursor: pointer;
}
.count {
    float: left;
	margin: 20px 0 0 5px;
}
#pagination {
	float: right;
}
</style>
</head>
<body ng-app="myApp" ng-controller="vehicleInBidding">
	<form>
		<label>品牌：<input type="text" ng-model="query.brand" placeholder="品牌"></label>
		<label>车系：<input type="text" ng-model="query.brand_model" placeholder="车系"></label> 
		<label>价格区间：
			<input type="number" ng-model="query.lowest_price"
			class="price_scope lowest_price" ng-value="lowest_price" 
			min="{{lowest_price}}" max="{{highest_price}}" step="1000">
		</label> <label> ~ <input type="number"
			ng-model="query.highest_price" class="price_scope highest_price"
			ng-value="highest_price" min="{{lowest_price}}"
			max="{{highest_price}}" step="1000"></label>
		<label>
			<span ng-if="pageType=='userBidSuccess'">付款</span>剩余时间：
			<select ng-model="query.remaining_time">
			<option value="">所有</option>
			<option value="2880">48小时内</option>
			<option value="1440">24小时内</option>
			<option value="720">12小时内</option>
			<option value="60">1小时内</option>
		</select> </label>
		<label>模糊搜索
			<input type="checkbox" class="fuzzy">
		</label>
		<button ng-click="select()" class="layui-btn search">搜索</button>
      	<button ng-click="reset()" class="layui-btn layui-btn-primary">重置</button>
	</form>
	<div hidden="true" class="result-data">
		<div>
			<span class="count">共计{{count}}个结果</span>
			<div ng-show="count" id="pagination"></div>
		</div>
		<table ng-if="vehicles.length>0" class="layui-table">
			<tr>
				<th hidden="true">ID</th>
				<th>序号</th>
				<th>图片</th>
				<th>品牌</th>
				<th>车系</th>
				<th>指标一</th>
				<th>指标二</th>
				<th>指标三</th>
				<th>起拍价</th>
				<th ng-if="pageType!='userBidSuccess'">现价</th>
				<th ng-if="pageType=='userBidSuccess'">中标价</th>
				<th ng-if="pageType!='userBidSuccess'">我的出价</th>
				<th ng-if="pageType=='userBidSuccess'">中标时间</th>
				<th><span ng-if="pageType=='userBidSuccess'">付款</span>剩余时间</th>
				<th ng-if="pageType!='userBidSuccess'">关注</th>
				<th ng-if="pageType=='userBidSuccess'">状态</th>
			</tr>
			<tr ng-repeat="v in vehicles" id="{{v.id_veh}}">
				<td hidden="true">{{ v.id_veh }}</td>
				<td>{{ v.row_num }}</td>
				<td><a class="fa fa-image" href="" ng-click="showImg(v.id_veh)"></a></td>
				<td>{{ v.brand }}</td>
				<td>{{ v.brand_model }}</td>
				<td></td>
				<td></td>
				<td></td>
				<td>{{ v.start_price }}</td>
				<td>{{ v.curr_price }}</td>
				<td ng-if="pageType!='userBidSuccess'">{{ v.curr_user_price }}
					<span ng-if="v.curr_user_price!=v.curr_price&&(v.veh_state_detail=='拍卖中'||pageType!='userFollowing')">
						<i class="fa fa-plus" ng-click="bid(v.id_veh)"></i>
					</span>
				</td>
				<td ng-if="pageType=='userBidSuccess'">{{ v.expir_bid_time }}</td>
				<td ng-if="v.veh_state_detail=='预拍'">已到期</td>	
				<td ng-if="v.veh_state_detail!='预拍'">{{ v.remaining_time }}</td>	
				<td ng-if="pageType!='userBidSuccess' && v.curr_user_follow==1">
					<i class="fa fa-heart" ng-click="followToggle($event,v.id_veh)"></i>
				</td>
				<td ng-if="pageType!='userBidSuccess' && v.curr_user_follow!=1">
					<i class="fa fa-heart-o" ng-click="followToggle($event,v.id_veh)"></i>
				</td>
				<td ng-if="pageType=='userBidSuccess'">{{ v.veh_state_detail }}</td>
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
	app.controller("vehicleInBidding", function($scope, $http) {
		$scope.per_page = 10;
		//页面类型，包括：vehicleInBidding, userFollowing, userBidding, userBidSuccess
		$scope.pageType = window.document.location.href.split("=")[1];
		
		$scope.postCfg = {
			headers : {
				'Content-Type' : 'application/x-www-form-urlencoded'
			},
			transformRequest : function(data) {
				return $.param(data);
			}
		}
		$http.get("selectLowestAndHighestPrice.do").then(function(data) {
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
			$scope.queryForBiddingJSON = JSON.stringify($scope.query);
			$scope.mode = $(".fuzzy").is(":checked") ? "fuzzy" : "precise";
			$scope.id_user = "${user.id_user}";
			$http.post("selectCount.do", {
				"queryForBiddingJSON" : $scope.queryForBiddingJSON,
				"mode" : $scope.mode,
				"pageType" : $scope.pageType,
				"id_user" : $scope.id_user
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
				"queryForBiddingJSON" : $scope.queryForBiddingJSON,
				"mode" : $scope.mode,
				"curr_page" : $scope.curr_page,
				"per_page" : $scope.per_page,
				"pageType" : $scope.pageType,
				"id_user" : $scope.id_user
			}, $scope.postCfg).then(function(data) {
				$scope.vehicles = data.data;
			});			
		}
		$scope.select();

		$scope.reset = function() {
			$scope.query = {
				lowest_price : lowest_price,
				highest_price : highest_price,
			};
			$(".fuzzy").attr("checked", false);
			$(".search").removeAttr("disabled").css({
				"background-color" : "#009688",
				"cursor" : "pointer"
			});
		}
		$scope.bid = function(id_veh) {
			$http.get("selectByPrimaryKey/" + id_veh + ".do").then(function(data) {
				parent.layer.open({
					type : 2,
					title : '竞拍',
					shadeClose : true,
					shade : 0.2,
					area : [ '400px', '65%' ],
					content : "bid.do"
				});
			});
		}
		$scope.followToggle = function($event, id_veh) {
			var msg, action;
			var target = $($event.target);
			if (target.attr("class").search("fa-heart-o") !== -1) {
				target.attr("class", "fa fa-heart");
				action = "follow";
				msg = "已关注！";
			} else {
				target.attr("class", "fa fa-heart-o");
				action = "unfollow";
				msg = "已取消关注！";
			}
			$http.post("followToggle.do", {
				"id_user" : "${user.id_user}",
				"id_veh" : id_veh,
				"action" : action
			}, $scope.postCfg).then(function(data) {
				parent.layer.msg(msg);
			});
		}
	});
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