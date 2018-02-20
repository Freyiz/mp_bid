<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/Project09/resources/js/jquery.min.js"></script>
<script src="/Project09/resources/js/angular.min.js"></script>
<script src="/Project09/resources/layui/layui.js"></script>
<link rel="stylesheet" href="/Project09/resources/layui/css/layui.css">
<link rel="stylesheet"
	href="/Project09/resources/css/font-awesome.min.css">
<title>上传页面</title>
<style type="text/css">
.top{
	
}
.searchBatch{
	width:155px;
	display:inline-block;
}
.expo{
	width:50%;
	
}
#form1{
	display:inline-block;
}
.expo tr th:nth-child(2){
	text-align:center;
}
</style>
</head>
<body>
	
	<div ng-app="myApp" ng-controller="vehicle">
		<div class="top">		
			<input class="layui-input searchBatch" type="text" ng-model="vehicle.batch_num" placeholder="请输入完整的批次号" >
			<button ng-click="selectBatchInfo()" class="layui-btn">查找</button>
			<form method="POST" enctype="multipart/form-data" id="form1"
		action="upload.do">
				<table>
					<tr>
						<td>上传文件:</td>
						<td><input id="upfile" type="file" name="upfile"></td>
						<td><input type="submit" value="提交"
							onclick="return checkData()"></td>
					</tr>
				</table>
			</form>
		</div>
		
		<table class="layui-table expo">
			<tr>
			<th style="text-align:center">批次号</th>
			<th></th>
			<th style="text-align:center">新入库的车辆</th>
			</tr>
			<tr ng-repeat="v in vehicles">
				<th style="text-align:center"><a ng-click="showVID(v.batch_num)">{{ v.batch_num }}</a></th>
				<th style="text-align:left"><button ng-click="exVID(v.batch_num)" class="layui-btn expobtn">导出</button>
					<button ng-click="upBat(v.batch_num)" class="layui-btn" ng-show="v.newveh_count>0">新增竞拍</button>
				</th>
				<th style="text-align:center">
					{{v.newveh_count}}辆
				</th>
				
			</tr>
		</table>
	</div>
	
	



	

	


</body>
<script>
	
layui.use('layer', function() {
	var layer = layui.layer;
});	

	var app = angular.module("myApp", []);
	app.controller("vehicle", function($scope, $http) {
		$scope.postCfg = {
			headers : {
				'Content-Type' : 'application/x-www-form-urlencoded'
			},
			transformRequest : function(data) {
				return $.param(data);
			}
		};
		
		$scope.selectBatchInfo = function() {
			var url = "selectBatchInfo.do";
			$http.post(url, {
				"vehicleJSON" : JSON.stringify($scope.vehicle)
			}, $scope.postCfg).then(function(data) {
				$scope.vehicles = data.data;
			});
		};
		$scope.selectBatchInfo();
		
		$scope.showVID = function(batchId){
			location.href = "showBatchVehicle.do?batchId="+batchId;
		};
		
		$scope.exVID = function(batchId){
			var url = "../export.do?batch_num="+batchId;
			location.href = url;
		};
		
		$scope.upBat = function(batch_Num){
			layer.open({
			type : 2,
			title : '新增竞拍',
			shadeClose : true,
			shade : 0.2,
			area : [ '500px', '100%' ], 
			content : "biddingVehicle.do?batch_num="+batch_Num
			});
		
	
};
	});
	
	

	function checkData() {
		var fileDir = $("#upfile").val();
		var suffix = fileDir.substr(fileDir.lastIndexOf("."));
		if ("" == fileDir) {
			alert("选择需要导入的Excel文件！");
			return false;
		}
		if (".xls" != suffix && ".xlsx" != suffix) {
			alert("选择Excel格式的文件导入！");
			return false;
		}

		return true;
	}

	/* function exportfile() {
		var nbatch_num = $("#nbatch_num").val();
		location.href = "export.do?nbatch_num=" + nbatch_num;
	} */

		var ok = "${msg}";
		
		if (ok !=="") {
 			alert(ok);
 			location.href = "uploadVehicle.do";
		}
		
		
</script>
</html>