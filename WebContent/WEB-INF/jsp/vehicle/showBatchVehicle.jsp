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
<title>Insert title here</title>
<style>
table{
	border:solid 1px black;
}
table tr td{
	border:solid 1px black;
}
</style>
</head>
<body>
<table class="layui-table">
<tr>
<th>批次</th>
<th>车牌号</th>
<th>车架码</th>
<th>发动机号</th>
<th>品牌</th>
<th>车系</th>
<th>简介</th>
<th>入库时间</th>
<th>预拍时间</th>
<th>拍卖到期时间</th>
<th>付款到期时间</th>
<th>起拍价</th>
<th>现价</th>
<th>备注</th>
<th>状态</th>
</tr>
<c:forEach items="${requestScope.list}" var="v" >
<tr>
<th>${v.batch_num}</th>
<th>${v.license_num}</th>
<th>${v.veh_id_num}</th>
<th>${v.engine_num}</th>
<th>${v.brand}</th>
<th>${v.brand_model}</th>
<th>${v.intro}</th>
<th>${v.veh_stamp}</th>
<th>${v.start_bid_time}</th>
<th>${v.expir_bid_time}</th>
<th>${v.expir_pay_time}</th>
<th>${v.start_price}</th>
<th>${v.curr_price}</th>
<th>${v.remark}</th>
<th>${v.veh_state_detail}</th>
</tr>
</c:forEach>
</table>
</body>
</html>