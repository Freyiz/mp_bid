<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/Project09/resources/js/jquery.min.js"></script>
<script src="/Project09/resources/layui/layui.js"></script>
<link rel="stylesheet" href="/Project09/resources/layui/css/layui.css">
<title>修改</title>
<style>
form {
	margin-right: 50px;
	margin-top: 20px;
}
.layui-input {
	width: 232px;
}
.bid_price,
.curr_price{
	width: 123px;
	display: inline-block;
}
.refresh {
	margin: -3px 0 0 5px;
}
.layui-word-aux {
	display: inline-block;
}
</style>
</head>
<body>
	<form class="layui-form" action="">
		<input hidden="true" type="text" name="id_veh"
			value="${vehicle.id_veh }">
		<div class="layui-form-item">
			<label class="layui-form-label">品牌</label>
			<div class="layui-input-block">
				<input type="text" value="${vehicle.brand }"
					disabled="disabled" class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">车系</label>
			<div class="layui-input-block">
				<input type="text" value="${vehicle.brand_model }"
					disabled="disabled" class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">起拍价</label>
			<div class="layui-input-block">
				<input type="text" value="${vehicle.start_price } 元"
					disabled="disabled" class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">现价</label>
			<div class="layui-input-block">
				<input type="text" value="${vehicle.curr_price } 元"
					disabled="disabled" class="layui-input curr_price">
				<button class="layui-btn refresh">刷新</button>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">竞拍价</label>
			<div class="layui-input-block">
				<input type="number" name="bid_price"
					value="${vehicle.curr_price+1000 }" min="${vehicle.curr_price+1000 }"
					step="1000" max="9999999000"
					placeholder="${vehicle.curr_price }" autocomplete="off"
					class="layui-input bid_price">
				<div class="layui-word-aux">以千为单位递增</div>
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn bid" lay-submit lay-filter="formDemo">确认出价</button>
			</div>
		</div>
	</form>
</body>
<script>
	var id_veh = $("[name=id_veh]").attr("value");
	var old_curr_price = parseInt("${vehicle.curr_price}");
	layui.use('form', function() {
		var form = layui.form;
		form.on('submit(formDemo)', function(data) {
			var bid_price = $("[name=bid_price]").val();
			$.ajax({
				type : "post",
				url : "insertOrUpdateBid.do",
				data : {
					id_user : "${user.id_user}",
					id_veh : id_veh,
					bid_price : bid_price
				},
				success : function(data) {
					if (data==-1){
						layer.msg("竞拍价无效，请刷新现价！");
						return;
					}
					if (data==0) {
						layer.msg("竞拍无效，拍卖已到期！");
						return;						
					}
					var id = "#" + id_veh;
					var tr_modified = parent.$("iframe").contents().find(id);
					tr_modified.css("background-color", "rgba(0, 150, 136,0.3)");
					
					var td_curr_user_price = tr_modified.find(".fa-plus").parent().parent();
					td_curr_user_price.html(bid_price);

					var td_curr_price = td_curr_user_price.prev();
					td_curr_price.html(bid_price);
					
					parent.layer.close(parent.layer
							.getFrameIndex(window.name));
					parent.layer.msg("已竞拍！");
				}
			});
			return false;
		});
	});
	$(".refresh").click(function() {
		$.ajax({
			type : "get",
			url : "selectCurr_price/"+id_veh+".do",
			success : function(data) {
				$(".curr_price").val(data+" 元");
				
				var curr_price = parseInt(data);
				if (curr_price > old_curr_price){
					$(".bid_price").val(curr_price + 1000).attr("min",curr_price + 1000);
					old_curr_price = curr_price;
				}
				layer.msg("已刷新！");
			}
		});
		return false;
	});
	$(".bid_price").bind("input propertychange", function() {
		var val = parseInt($(this).val());
		if ((/^\d+000$/.test(val)) && val >= old_curr_price + 1000 && val <= 9999999000) {
			$(".bid").removeAttr("disabled").css({
				"background-color" : "#009688",
				"cursor" : "pointer"
			});
		} else {
			$(".bid").attr("disabled", "disabled").css({
				"background-color" : "rgba(0, 150, 136,0.3)",
				"cursor" : "default"
			});
		}
	});
</script>
</html>