<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/Project09/resources/js/jquery.min.js"></script>
<script src="/Project09/resources/layui/layui.js"></script>
<link rel="stylesheet" href="/Project09/resources/layui/css/layui.css">
<link rel="stylesheet" href="/Project09/resources/css/myLayer.css">
<title>登录</title>
<style>
.title {
	font-size: 45px;
	text-align: center;
}
.title, form {
	margin: 50px auto;
	width: 387px;
}
button {
	width: 190px;
}
</style>
</head>
<body>
	<c:if test="${user!=null}">
		<jsp:forward page="/WEB-INF/jsp/index.jsp"></jsp:forward>
	</c:if>
	<div class="title">明拍汽车交易系统</div>
	<form class="layui-form" action="">
		<div class="layui-form-item">
			<label class="layui-form-label">用户名</label>
			<div class="layui-input-inline">
				<input type="text" name="username" placeholder="请输入用户名" value="yiz"
					class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">密码</label>
			<div class="layui-input-inline">
				<input type="password" name="password" placeholder="请输入密码" value="asd"
					 class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn" lay-submit lay-filter="formDemo">登陆</button>
			</div>
		</div>
	</form>
</body>
<script>
	layui.use('form', function() {
		var form = layui.form;
		form.on('submit(formDemo)', function(data) {
			$.ajax({
				type : "post",
				url : "user/login.do",
				data : $("form").serialize(),
				success : function(data) {
					if (data != "") {
						layer.msg(data);
					} else {
						window.location.href = "index.do";
					}
				}
			});
			return false;
		});
 		// 自动登录，测试用
		$(function() {
			$.ajax({
				type : "post",
				url : "user/login.do",
				data : $("form").serialize(),
				success : function(data) {
					if (data != "") {
						layer.msg(data);
					} else {
						window.location.href = "index.do";
					}
				}
 			});
 		});
	});
</script>
</html>
