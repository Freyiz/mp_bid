layui.use('table', function() {
});

layui.use('element', function() {

});

layui.use('laypage', function() {
	var laypage = layui.laypage;

	laypage.render({
		elem : 'paging',
		count : 50
	});
});

function showTime() {
	var today = new Date();
	var year = today.getFullYear();
	var month = today.getMonth() + 1;
	var day = today.getDate();
	var hours = today.getHours();
	var minutes = today.getMinutes();
	var seconds = today.getSeconds();
	month = month < 10 ? "0" + month : month;
	day = day < 10 ? "0" + day : day;
	hours = hours < 10 ? "0" + hours : hours;
	minutes = minutes < 10 ? "0" + minutes : minutes;
	seconds = seconds < 10 ? "0" + seconds : seconds;

	var str = year + "." + month + "." + day + "&nbsp&nbsp&nbsp" + hours + ":"
			+ minutes + ":" + seconds;
	var obj = document.getElementById("date");

	obj.innerHTML = str;
	setTimeout("showTime()");
}
setTimeout("showTime()");