<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/Project09/resources/js/jquery.min.js"></script>
<script src="/Project09/resources/js/angular.min.js"></script>
<script src="/Project09/resources/layui/layui.js" charset="utf-8"></script>
<link rel="stylesheet" href="/Project09/resources/layui/css/layui.css">
<title>修改</title>
<style>
form {
	margin-left: 65px;
	margin-top: 20px;  
	
}
.labtext{
	text-align:left;
	width:100px;
}
.hidden {
    display: none;
} 
</style>
</head>
<body ng-app="myApp" ng-controller="vehicle">
	
		<form class="layui-form" action="">
		<div class="layui-form-item">
			<label class="layui-form-label labtext">车辆批次</label>
			<div class="layui-input-inline ">
				<input class="layui-input" type="text" value="{{batch_num}}" readonly name="batch_num"  />
			</div>
		</div>
		
	
		<div class="layui-form-item">
			<label class="layui-form-label labtext">设置延迟拍卖</label>
			<div class="layui-input-inline">
			<input type="checkbox" class="check_sbt" checked="" lay-skin="switch" lay-filter="opensbt" lay-text="现在|延迟" />	
			</div>
			
		</div>
		
		<div class="layui-form-item hidden" id="isHide">
		<label class="layui-form-label labtext"></label>
		<div class="layui-input-inline">
				<input class="layui-input" type="text" name="start_bid_time" id="time1" />
			</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label labtext">拍卖到期时间</label>
				<div class="layui-input-inline">
					<select id="bidDuration" name="bidDuration">
						<option selected="selected" value="3">三天后</option>
						<option value="5">五天后</option>
						<option value="10">十天后</option>
					</select>
					
				</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label labtext">付款到期时间</label>
				<div class="layui-input-inline">
					<select id="payDuration" name="payDuration">
						<option selected="selected" value="3">三天后</option>
						<option value="5">五天后</option>
						<option value="10">十天后</option>
					</select>
				</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label labtext">起拍价</label>
				<div class="layui-input-inline">
					<input class="layui-input" type="number" name="start_price" value="10000" step="1000" min="10000" id="start_price"/> 
				</div>
		</div>
		
			<button class="layui-btn subbtn" lay-submit lay-filter="formDemo">新增竞拍</button>
		</form>
</body>

<script>
var app = angular.module("myApp", []);
app.controller("vehicle", function($scope, $http) {
	var hide = true;
	var elem = $("#isHide");
	
	$scope.batch_num = window.document.location.href.split("=")[1];
	$scope.postCfg = {
		headers :{
			
			'Content-Type' : 'application/x-www-form-urlencoded'
			
		},
		transformRequest : function(data) {
			return $.param(data);
		}
			
			
	};
	
	
	
	
	layui.use(['form','layedit','laydate' ],function(){
		var form = layui.form;
		var laydate = layui.laydate;
		var layedit = layui.layedit;
		laydate.render({
			elem: '#time1',
			type: 'datetime',
			value: new Date()
			
		});
	 	form.on('switch(opensbt)', function(data){
	 	    if(hide){
	 	    	elem.show().removeAttr("display");
				hide = false;
//	 			layer.tips('', data.othis);
	 	    }else{
	 	    	elem.hide().attr("display", "none");
				hide = true;
	 	    }
	 	  });
		form.on('submit(formDemo)', function(data) {
			$.ajax({
				type : "post",
				url : "startBidById.do?type=force",
				data : $("form").serialize(),
				success : function(data) {
						parent.layer.close(parent.layer.getFrameIndex(window.name));
						parent.layer.msg("已加入拍卖！");
				}
			});
			return false;
		})
	 	
	});	
	
	
	
		
		
		
	
	$("#start_price").bind("input propertychange", function() {
		var start_price = document.getElementById("start_price").value;
		if(start_price<10000) {
			$(".subbtn").attr("disabled", "disabled").css({
				"background-color" : "rgba(0, 150, 136,0.3)",
				"cursor" : "default"
			});
		}else{
			$(".subbtn").removeAttr("disabled").css({
				"background-color" : "#009688",
				"cursor" : "pointer"
			});
			
		}
	});
// 	$scope.exnewbid = function(){
// 		console.log($("form").serialize());
// 		$.ajax({
// 			type : "post",
// 			url : "startBidById.do?type=force",
// 			data : "batch_num=2000000&delay=on&start_bid_time=2018-01-31+00%3A00%3A00&bidDuration=3&payDuration=3&start_price=10000",
// 			success : function(data) {
// 				if (data == '1') {
// 					parent.layer.close(parent.layer.getFrameIndex(window.name));
// 					parent.layer.msg("已加入拍卖！");
// 				} 
// 			}
// 		});
// 		return false;
// 	};

// 		alert($("#timeslot").val());
// 		date4.setDate(date2.getDate() + 10);
// 		alert(date4);
// 		alert($("#time2").val());
		
	
	/* Date.prototype.format = function(format)
	{
	 var o = {
	 "M+" : this.getMonth()+1, //month
	 "d+" : this.getDate(),    //day
	 "h+" : this.getHours(),   //hour
	 "m+" : this.getMinutes(), //minute
	 "s+" : this.getSeconds(), //second
	 "q+" : Math.floor((this.getMonth()+3)/3),  
	 "S" : this.getMilliseconds() //millisecond
	 }
	 if(/(y+)/.test(format)) format=format.replace(RegExp.$1,
	 (this.getFullYear()+"").substr(4 - RegExp.$1.length));
	 for(var k in o)if(new RegExp("("+ k +")").test(format))
	 format = format.replace(RegExp.$1,
	 RegExp.$1.length==1 ? o[k] :
	 ("00"+ o[k]).substr((""+ o[k]).length));
	 return format;
	} */
	
});

	
</script>
</html>