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
	margin: 20px 0 0 0;
}
.inline>* {
	display: inline-block;
	width: 90px;
	margin: 0;
	float: none;
}
.second {
	margin-left: -45px;
}
.inline input {
	width: 90px;
}
.layui-input {
	width: 267px;
}
.layui-form-label {
	width: 90px;
}
.start_price {
	width: 100px;
	display: inline-block;
}
.delayBidTime{
	width: 165px;
	display: inline-block;
}
.cancelBid {
	width: 90px;
	margin: -3px 0 0 8px;
}
.layui-word-aux {
	display: inline-block;
}
.start_bid_time {
	display: inline-block;
	width: 184px;
	margin-left: 25px;
}
.layui-input-block.last {
	margin-left: 120px;
}
</style>
</head>
<body ng-app="myApp" ng-controller="startBid">
	<form class="layui-form result-data" hidden="true">
		<div class="layui-form-item inline">
			<label class="layui-form-label">ID</label>
			<div class="layui-input-block">
				<input type="text" value="{{v.id_veh}}" name="id_veh"
					readonly class="layui-input">
			</div>
			<label class="layui-form-label second">状态</label>
			<div class="layui-input-block">
				<input type="text" value="{{detail}}"
					readonly class="layui-input">
			</div>
		</div>
		<div ng-if="u" class="layui-form-item inline">
			<label class="layui-form-label">用户ID</label>
			<div class="layui-input-block">
				<input type="text" value="{{u.id_user}}"
					readonly class="layui-input">
			</div>
			<label class="layui-form-label second">用户名</label>
			<div class="layui-input-block">
				<input type="text" value="{{u.username}}"
					readonly class="layui-input">
			</div>
		</div>
		<div ng-if="detail=='新入库'" class="layui-form-item">
			<label class="layui-form-label">入库时间</label>
			<div class="layui-input-block">
				<input type="text" value="{{v.veh_stamp}}"
					readonly class="layui-input">
			</div>
		</div>
		<div ng-if="detail=='预拍'" class="layui-form-item">
			<label class="layui-form-label">预拍时间</label>
			<div class="layui-input-block">
				<input type="text" value="{{v.start_bid_time}}"
					readonly class="layui-input delayBidTime">
				<button class="layui-btn cancelBid" ng-click="cancelBid()">取消预拍</button>
			</div>
		</div>
		<div ng-if="detail=='预拍'" class="layui-form-item">
			<label class="layui-form-label">预拍价</label>
			<div class="layui-input-block">
				<input type="text" value="{{v.start_price}} 元"
					readonly class="layui-input">
			</div>
		</div>
		<div ng-if="u||detail=='拍卖到期'" class="layui-form-item">
			<label ng-if="u" class="layui-form-label">中标时间</label>
			<label ng-if="detail=='拍卖到期'" class="layui-form-label">拍卖到期时间</label>
			<div class="layui-input-block">
				<input type="text" value="{{v.expir_bid_time}}"
					readonly class="layui-input">
			</div>
		</div>
		<div ng-if="u" class="layui-form-item">
			<label class="layui-form-label">付款到期时间</label>
			<div class="layui-input-block">
				<input type="text" value="{{v.expir_pay_time}}"
					readonly class="layui-input">
			</div>
		</div>
		<div class="line"></div>
		<div class="layui-form-item">
			<label class="layui-form-label">延迟拍卖</label>
		    <div class="layui-input-block">
		      	<input type="checkbox" name="delay" lay-skin="switch" 
		      		lay-filter="delay" lay-text="开启|关闭">
		      	<input type="text" name="start_bid_time" placeholder="请指定拍卖日期"
		      	class="layui-input start_bid_time" disabled="disabled">
		    </div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">持续时间</label>
		    <div class="layui-input-block">
				<input type="radio" name="bidDuration" value="3" title="3天" checked>
				<input type="radio" name="bidDuration" value="5" title="5天">
				<input type="radio" name="bidDuration" value="7" title="7天">
   		    </div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">付款期限</label>
		    <div class="layui-input-block">
				<input type="radio" name="payDuration" value="3" title="3天" checked>
				<input type="radio" name="payDuration" value="5" title="5天">
				<input type="radio" name="payDuration" value="7" title="7天">
   		    </div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">起拍价</label>
			<div class="layui-input-block">
				<input type="number" name="start_price" value="10000" min="5000"
					step="1000" max="9999999000" class="layui-input start_price">
				<div class="layui-word-aux">以千为单位递增</div>
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-block last">
				<button class="layui-btn startBid" lay-submit lay-filter="formDemo">确定</button>
      			<button type="reset" class="layui-btn layui-btn-primary">重置</button>
			</div>
		</div>
	</form>
</body>
<script>
	window.onload = function() {
		$('.result-data').show();
	};
	var params = window.document.location.href.split(/=|&/);
	var id_veh = params[1];
	var app = angular.module("myApp", []);
	app.controller("startBid", function($scope, $http) {
		$http.get("selectByPrimaryKey/" + id_veh + ".do").then(function(data) {
			$scope.v = data.data;
			$scope.detail = $scope.v.veh_state_detail;
			if ($scope.detail == '待付款' || $scope.detail == '付款到期' ||
			    $scope.detail == '已付款' || $scope.detail == '已交车') {
				$http.get("selectUserBidSuccessByVId/" + id_veh + ".do").then(function(data) {
					$scope.u = data.data;
				})
			}
		})
		$scope.cancelBid = function() {
			$http.get("cancelBidById/"+id_veh+".do").then(function(data) {
				parent.layer.close(parent.layer.getFrameIndex(window.name));
				parent.layer.msg("已取消预拍！");
				
				var id = "#" + id_veh;
				var tr_modified = parent.$("iframe").contents().find(id);
				tr_modified.css("background-color","rgba(0, 150, 136,0.3)");
				
				var startBidLink = tr_modified.find(".fa-plus");
				var td_veh_state_detail = tr_modified.find(".startBid").prev();
				startBidLink.attr("name","新入库");
				td_veh_state_detail.text("新入库");
			})
		}
	});

	var elem = $(".start_bid_time");
	elem.hide();
	// hide为true表示不延迟拍卖，false表示延迟拍卖
	var hide = true;
	var delay_millisecond;
	layui.use([ 'form', 'laydate' ], function() {
		var form = layui.form, laydate = layui.laydate;
		var date = new Date();
		date.setMinutes(date.getMinutes() + 5);
		laydate.render({
			elem : '.start_bid_time',
			type : 'datetime',
			max : 7,
		  	done: function(date){
		  		 delay_millisecond = new Date(date).getTime() - new Date().getTime();
			}
		});
		form.on('switch(delay)', function(data) {
			if (hide) {
				elem.show().removeAttr("disabled");
				hide = false;
			} else {
				elem.hide().attr("disabled", "disabled");
				hide = true;
			}
		});
		form.on('submit(formDemo)', function(data) {
			// 忽略延迟时间小于1分钟和延迟日期为空的情况
			hide = delay_millisecond < 60000 || elem.val().trim() == '';
			if (hide) {
				elem.attr("disabled", "disabled");
				$("[name=delay]").attr("disabled", "disabled");
			}
			$.ajax({
				type : "post",
				url : "startBidById.do?type=" + params[3],
				data : $("form").serialize(),
				success : function(data) {
					if (data == '1') {
						var action = hide ? "加入" : "预定";
						parent.layer.close(parent.layer.getFrameIndex(window.name));
						parent.layer.msg("已" + action + "拍卖！");

						var id = "#" + id_veh;
						var tr_modified = parent.$("iframe").contents().find(id);
						tr_modified.css("background-color","rgba(0, 150, 136,0.3)");
						
						var startBidLink = tr_modified.find(".fa-plus");
						var td_veh_state_detail = tr_modified.find(".startBid").prev();
						if (hide) {
							startBidLink.attr("class", "");
							td_veh_state_detail.text("拍卖中");
						} else {
							startBidLink.attr("name","预拍");
							td_veh_state_detail.text("预拍");
						}
					} else {
						parent.layer.msg("无法将" + data + "车辆加入拍卖！");
						elem.removeAttr("disabled");
					}
				}
			});
			return false;
		});
	});
	$(":reset").click(function() {
		elem.hide().attr("disabled", "disabled");
		hide = true;
		$(".startBid").removeAttr("disabled").css({
			"background-color" : "#009688",
			"cursor" : "pointer"
		});
	});
	$(".start_price").bind("input propertychange", function() {
		var val = parseInt($(this).val());
		if ((/^\d+000$/.test(val)) && val >= 5000 && val <= 9999999000) {
			$(".startBid").removeAttr("disabled").css({
				"background-color" : "#009688",
				"cursor" : "pointer"
			});
		} else {
			$(".startBid").attr("disabled", "disabled").css({
				"background-color" : "rgba(0, 150, 136,0.3)",
				"cursor" : "default"
			});
		}
	});
</script>
</html>