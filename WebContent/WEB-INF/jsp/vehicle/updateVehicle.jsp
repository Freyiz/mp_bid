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
<title>修改</title>
<style>
form {
	margin-right: 50px;
	margin-top: 20px;
}
.layui-form-label {
	width: 92px;
}
.layui-input-block {
	margin-left: 122px;
}
</style>
</head>
<body ng-app="myApp" ng-controller="vehicle">
	<form class="layui-form result-data" hidden="true">
		<div class="layui-form-item">
			<label class="layui-form-label">批次</label>
			<div class="layui-input-block">
				<input type="text" name="batch_num" value="{{vehicle.batch_num }}"
					placeholder="{{vehicle.batch_num }}" autocomplete="off"
					class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">ID</label>
			<div class="layui-input-block">
				<input type="text" name="id_veh" value="{{vehicle.id_veh }}"
					class="layui-input" readonly>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">车牌号</label>
			<div class="layui-input-block">
				<input type="text" name="license_num"
					value="{{vehicle.license_num }}"
					placeholder="{{vehicle.license_num }}" autocomplete="off"
					class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">车架码</label>
			<div class="layui-input-block">
				<input type="text" name="veh_id_num" value="{{vehicle.veh_id_num }}"
					placeholder="{{vehicle.veh_id_num }}" autocomplete="off"
					class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">发动机号</label>
			<div class="layui-input-block">
				<input type="text" name="engine_num" value="{{vehicle.engine_num }}"
					placeholder="{{vehicle.engine_num }}" autocomplete="off"
					class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">品牌</label>
			<div class="layui-input-block">
				<input type="text" name="brand" value="{{vehicle.brand }}"
					placeholder="{{vehicle.brand }}" autocomplete="off"
					class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">车系</label>
			<div class="layui-input-block">
				<input type="text" name="brand_model"
					value="{{vehicle.brand_model }}"
					placeholder="{{vehicle.brand_model }}" autocomplete="off"
					class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">简介</label>
			<div class="layui-input-block">
				<input type="text" name="intro" value="{{vehicle.intro }}"
					placeholder="{{vehicle.intro }}" autocomplete="off"
					class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">导入时间</label>
			<div class="layui-input-block">
				<input type="text" name="veh_stamp" value="{{vehicle.veh_stamp }}"
					class="layui-input" disabled="disabled">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">加入拍卖时间</label>
			<div class="layui-input-block">
				<input type="text" name="start_bid_time"
					value="{{vehicle.start_bid_time }}" class="layui-input"
					disabled="disabled">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">拍卖到期时间</label>
			<div class="layui-input-block">
				<input type="text" name="expir_bid_time"
					value="{{vehicle.expir_bid_time }}" class="layui-input"
					disabled="disabled">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">付款到期时间</label>
			<div class="layui-input-block">
				<input type="text" name="expir_pay_time" class="layui-input"
				disabled="disabled" value="{{vehicle.expir_pay_time }}">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">起拍价</label>
			<div class="layui-input-block">
				<input type="text" name="start_price"
					value="{{vehicle.start_price}}" class="layui-input"
					disabled="disabled">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">现价</label>
			<div class="layui-input-block">
				<input type="text" name="curr_price" value="{{vehicle.curr_price}}"
					class="layui-input" disabled="disabled">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">备注</label>
			<div class="layui-input-block">
				<input type="text" name="remark" value="{{vehicle.remark }}"
					placeholder="{{vehicle.remark }}" autocomplete="off"
					class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">状态</label>
			<div class="layui-input-block">
				<input type="radio" name="veh_state" value="0" title="未付款"
					ng-checked="vehicle.veh_state==0"> <input type="radio"
					name="veh_state" value="1" title="已付款"
					ng-checked="vehicle.veh_state==1"
					ng-disabled="detail=='新入库'||detail=='预拍'||detail=='拍卖中'||detail=='拍卖到期'">
				<input type="radio" name="veh_state" value="2" title="已交车"
					ng-checked="vehicle.veh_state==2"
					ng-disabled="detail=='新入库'||detail=='预拍'||detail=='拍卖中'||detail=='拍卖到期'">
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn submit" lay-submit lay-filter="formDemo">保存</button>
			</div>
		</div>
	</form>
</body>
<script>
	window.onload = function() {
		$('.result-data').show();
	};
	var app = angular.module("myApp", []);
	app.controller("vehicle", function($scope, $http) {
		var id_veh = window.document.location.href.split("=")[1];
		$http.get("selectByPrimaryKey/" + id_veh + ".do").then(function(data) {
			$scope.vehicle = data.data;
			if ($scope.vehicle.start_price){
				$scope.vehicle.start_price += " 元";
			}
			if ($scope.vehicle.curr_price){
				$scope.vehicle.curr_price +=" 元";
			}
			$scope.detail = $scope.vehicle.veh_state_detail;
			layui.use('form', function() {
				var form = layui.form;
				form.on('submit(formDemo)', function(data) {
					$.ajax({
						type : "post",
						url : "updateSelective.do",
						data : $("form").serialize(),
						success : function(data) {
							updateParentFrame();
						},
						error : function() {
							parent.layer.msg("出错了，请检查修改后的数据！");
						}
					});
					return false;
				});
			});
		})
		// 更新父窗口数据 
		function updateParentFrame(){
			var id = "#" + id_veh;
			var tr_modified = parent.$("iframe").contents().find(id);
			tr_modified.css("background-color","rgba(0, 150, 136,0.3)");
			var td_list = tr_modified.children();
			var input_list = $("input");
			for (var i = 2; i < td_list.length - 4; i++) {
				td_list[i].innerHTML = input_list[i - 2].value;
			}
			td_list[9].innerHTML = input_list[14].value;
			
			var veh_state_modified = $(":checked").val();
			if (veh_state_modified != $scope.vehicle.veh_state){
				var startBidLink = tr_modified.find(".startBid a");
				if (veh_state_modified == 0){
					$http.get("selectByPrimaryKey/" + id_veh + ".do").then(function(data) {
						var detail = data.data.veh_state_detail;
						td_list[10].innerHTML = detail;
						startBidLink.attr({"class":"fa fa-plus","name":detail});
					});
				} else {
					startBidLink.attr("class","");
					td_list[10].innerHTML = $(":checked").attr("title");
				}
			}
			parent.layer.close(parent.layer.getFrameIndex(window.name));
			parent.layer.msg("修改成功！");
		}
	});
</script>
</html>