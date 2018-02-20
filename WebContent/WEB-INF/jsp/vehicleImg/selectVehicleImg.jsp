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
<title>车辆实图</title>
<style>
.img_wrapper {
	display: flex;
	justify-content: space-around;
	flex-wrap: wrap;
}

.img_wrapper>div {
	height: 200px;
	width: 290px;
	position: relative;
	margin-top: 30px;
	border: 1px dashed darkgray;
}

.img_wrapper>div>div {
	height: 200px;
	width: 290px;
	display: flex;
	align-items: center;
	justify-content: center;
	overflow: hidden;
	position: relative;
}

.img_wrapper img {
	position: absolute;
	width: 290px;
}

.img_wrapper span {
	position: absolute;
	right: -16px;
	top: -16px;
	border: 1px solid darkseagreen;
	border-radius: 50%;
	background: aliceblue;
}

.layui-icon:hover {
	cursor: pointer;
	opacity: 0.5;
}

.layui-icon {
	color: cadetblue;
}

div>.layui-icon {
	font-size: 60px;
}

span>.layui-icon {
	font-size: 30px;
}
</style>
</head>
<body>
	<div ng-app="myApp" ng-controller="vehicleImg" class="img_wrapper">
		<div ng-repeat="i in [0,1,2,3,4,5]">
			<div>
				<i ng-show="${user.role=='manager'}" id="i{{i}}" class="layui-icon">&#xe654;</i> 
				<img ng-show="img{{i}}" id="img{{i}}" alt="" src="../getVehicleImg/img{{i}}.do">
			</div>
			<span ng-show="${user.role=='manager'} && img{{i}}" ng-click="setNullByImgIndex(i)"> 
				<i class="layui-icon">&#x1006;</i>
			</span>
		</div>
	</div>
</body>
<script>
	var id_veh = "${vehicleImg.id_veh}";
	var app = angular.module("myApp", []);
	app.controller("vehicleImg", function($scope, $http) {
		layui.use('upload', function() {
			var upload = layui.upload;
			upload.render({
				elem : '#i0',
				url : '../updateSelective.do',
				field : 'imgFile',
				data : {"imgIndex" : "img0", "id_veh" : id_veh},
				before : function(obj) {
					obj.preview(function(index, file, result) {
						$("#img0").attr('src', result);
						parent.layer.msg("上传成功！");
						$("#img0").parent().next().show();
						$scope.img0 = ' ';
						$scope.$apply();
					});
				}
			});
			upload.render({
				elem : '#i1',
				url : '../updateSelective.do',
				field : 'imgFile',
				data : {"imgIndex" : "img1", "id_veh" : id_veh},
				before : function(obj) {
					obj.preview(function(index, file, result) {
						$("#img1").attr('src', result);
						parent.layer.msg("上传成功！");
						$("#img1").parent().next().show();
						$scope.img1 = ' ';
						$scope.$apply();
					});
				}
			});
			upload.render({
				elem : '#i2',
				url : '../updateSelective.do',
				field : 'imgFile',
				data : {"imgIndex" : "img2", "id_veh" : id_veh},
				before : function(obj) {
					obj.preview(function(index, file, result) {
						$("#img2").attr('src', result);
						parent.layer.msg("上传成功！");
						$("#img2").parent().next().show();
						$scope.img2 = ' ';
						$scope.$apply();
					});
				}
			});
			upload.render({
				elem : '#i3',
				url : '../updateSelective.do',
				field : 'imgFile',
				data : {"imgIndex" : "img3", "id_veh" : id_veh},
				before : function(obj) {
					obj.preview(function(index, file, result) {
						$("#img3").attr('src', result);
						parent.layer.msg("上传成功！");
						$("#img3").parent().next().show();
						$scope.img3 = ' ';
						$scope.$apply();
					});
				}
			});
			upload.render({
				elem : '#i4',
				url : '../updateSelective.do',
				field : 'imgFile',
				data : {"imgIndex" : "img4", "id_veh" : id_veh},
				before : function(obj) {
					obj.preview(function(index, file, result) {
						$("#img4").attr('src', result);
						parent.layer.msg("上传成功！");
						$("#img4").parent().next().show();
						$scope.img4 = ' ';
						$scope.$apply();
					});
				}
			});
			upload.render({
				elem : '#i5',
				url : '../updateSelective.do',
				field : 'imgFile',
				data : {"imgIndex" : "img5", "id_veh" : id_veh},
				before : function(obj) {
					obj.preview(function(index, file, result) {
						$("#img5").attr('src', result);
						parent.layer.msg("上传成功！");
						$("#img5").parent().next().show();
						$scope.img5 = ' ';
						$scope.$apply();
					});
				}
			});
		});
		$scope.img0 = "${vehicleImg.img0}";
		$scope.img1 = "${vehicleImg.img1}";
		$scope.img2 = "${vehicleImg.img2}";
		$scope.img3 = "${vehicleImg.img3}";
		$scope.img4 = "${vehicleImg.img4}";
		$scope.img5 = "${vehicleImg.img5}";
		$scope.postCfg = {
			headers : {
				'Content-Type' : 'application/x-www-form-urlencoded'
			},
			transformRequest : function(data) {
				return $.param(data);
			}
		}
		$scope.setNullByImgIndex = function(imgIndex) {
			imgIndex = "img" + imgIndex;
			layer.confirm('确定删除?', {
				icon : 3,
				title : '提示',
				shadeClose : true
			}, function(index) {
				$http.post("../setNullByImgIndex.do", {
					"id_veh" : id_veh,
					"imgIndex" : imgIndex
				}, $scope.postCfg).then(function(data) {
					var id = "#" + imgIndex;
					parent.layer.msg("删除成功！");
					$(id).attr("src", "");
					$(id).parent().next().hide();
				})
				layer.close(index);
			})
		}
	});
</script>
</html>