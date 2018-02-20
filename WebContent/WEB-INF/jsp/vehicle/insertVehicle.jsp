<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/Project09/resources/js/angular.min.js"></script>
<script src="/Project09/resources/js/jquery.min.js"></script>
<script src="/Project09/resources/layui/layui.js"></script>
<link rel="stylesheet" href="/Project09/resources/layui/css/layui.css">
<link rel="stylesheet"
	href="/Project09/resources/css/font-awesome.min.css">
<title>添加</title>
<style>
body {
	display: flex;
	flex-direction: column;
	align-items: center;
}

form {
	width: 610px;
	padding-right: 125px;
}

form>div:last-child {
	margin: 20px 0 30px 0;
}

form>div:last-child>div {
	margin-left: 166px;
}

.inline {
	display: inline-block;
	padding-left: 50px;
}

.inline>* {
	display: inline-block;
	width: 85px;
	margin: 0;
	float: none;
}

.inline>div {
	width: 162px;
	margin-left: -3px;
}

.intro>label {
	width: 136px;
}

.intro>div {
	margin-left: 166px;
}

form button {
	width: 100%;
}

.layui-inline {
	margin-left: 165px;
}
</style>
</head>
<body>
	<div style="line-height: 100px;">
		<h1>添加车辆，*为必填项</h1>
	</div>
	<form class="layui-form" action="">
		<div class="layui-form-item inline">
			<label class="layui-form-label">批次</label>
			<div class="layui-input-block">
				<input type="text" name="batch_num" class="layui-input">
			</div>
			<label class="layui-form-label">* 车牌号</label>
			<div class="layui-input-block">
				<input type="text" name="license_num" class="layui-input">
			</div>
		</div>
		<div class="layui-form-item inline">
			<label class="layui-form-label">* 车架码</label>
			<div class="layui-input-block">
				<input type="text" name="veh_id_num" class="layui-input">
			</div>
			<label class="layui-form-label">* 发动机编号</label>
			<div class="layui-input-block">
				<input type="text" name="engine_num" class="layui-input">
			</div>
		</div>
		<div class="layui-form-item inline">
			<label class="layui-form-label">* 品牌</label>
			<div class="layui-input-block">
				<input type="text" name="brand" class="layui-input">
			</div>
			<label class="layui-form-label">* 车系</label>
			<div class="layui-input-block">
				<input type="text" name="brand_model" class="layui-input">
			</div>
		</div>
		<div class="layui-form-item intro layui-form-text">
			<label class="layui-form-label">* 简介</label>
			<div class="layui-input-block">
				<textarea name="intro" class="layui-textarea"></textarea>
			</div>
		</div>
		<div class="layui-inline">
			设置拍卖时间<input id="asd" type="text" name="start_bid_time"
				class="layui-input"> 拍卖到期时间<input id="asd1" type="text"
				name="expir_bid_time" class="layui-input"> 付款到期时间<input
				id="asd2" type="text" name="expir_pay_time" class="layui-input">
			起拍价<input type="text" value="50000" name="start_price"
				class="layui-input">
		</div>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn" lay-submit lay-filter="formDemo">保存</button>
			</div>
		</div>
	</form>
</body>
<script>
	layui.use([ 'form', 'laydate' ], function() {
		var form = layui.form, laydate = layui.laydate;
		laydate.render({
			elem : '#asd',
			type : 'datetime',
			value : new Date()
		});
		var date1 = new Date();
		date1.setDate(date1.getDate() + Math.floor(Math.random() * 3) + 1);
		laydate.render({
			elem : '#asd1',
			type : 'datetime',
			value : date1
		});
		var date2 = new Date();
		date2.setDate(date2.getDate() + Math.floor(Math.random() * 3) + 4);
		laydate.render({
			elem : '#asd2',
			type : 'datetime',
			value : date2
		});
		form.on('submit(formDemo)', function(data) {
			$.ajax({
				type : "post",
				url : "insertSelective.do",
				data : $("form").serialize(),
				success : function(data) {
					layer.msg("添加成功！");
				}
			});
			return false;
		});
	});
</script>
</html>