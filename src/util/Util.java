package util;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;

import pojo.QueryForBidding;
import pojo.Vehicle;

public class Util {
	public static String getDayHourMinute(String minuteInString) {
		double minuteInDouble = Double.valueOf(minuteInString);
		if (minuteInDouble < 0) {
			return "已到期";
		}
		if (minuteInDouble < 1) {
			return "<1分钟";
		}
		int minute_count, hour_count, day_count;
		minute_count = (int) minuteInDouble;
		hour_count = minute_count / 60;
		day_count = hour_count / 24;

		String minute, hour, day;
		minute = minute_count - hour_count * 60 + "分钟";
		hour = hour_count > 0 ? hour_count - day_count * 24 + "小时" : "";
		day = day_count > 0 ? day_count + "天" : "";
		return day + hour + minute;
	}

	public static Vehicle parseToVehicle(String jsonString) {
		return jsonString.length() > 0 ? JSON.parseObject(jsonString, new TypeReference<Vehicle>() {
		}) : new Vehicle();
	}

	public static QueryForBidding parseToQueryForBidding(String jsonString) {
		return jsonString.length() > 0 ? JSON.parseObject(jsonString, new TypeReference<QueryForBidding>() {
		}) : new QueryForBidding();
	}
}
