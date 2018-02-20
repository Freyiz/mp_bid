package pojo;

import java.sql.Timestamp;

import com.fasterxml.jackson.annotation.JsonFormat;

import util.Util;

public class VehicleInBidding {
	private Long row_num;
	private Long id_veh;
	private String brand;
	private String brand_model;
	private Long start_price;
	private Long curr_price;
	private Long curr_user_price;
	private String remaining_time;
	private Integer curr_user_follow;
	private Timestamp expir_bid_time;
	private String veh_state_detail;

	public Long getRow_num() {
		return row_num;
	}

	public void setRow_num(Long row_num) {
		this.row_num = row_num;
	}

	public Long getId_veh() {
		return id_veh;
	}

	public void setId_veh(Long id_veh) {
		this.id_veh = id_veh;
	}

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public String getBrand_model() {
		return brand_model;
	}

	public void setBrand_model(String brand_model) {
		this.brand_model = brand_model;
	}

	public Long getStart_price() {
		return start_price;
	}

	public void setStart_price(Long start_price) {
		this.start_price = start_price;
	}

	public Long getCurr_price() {
		return curr_price;
	}

	public void setCurr_price(Long curr_price) {
		this.curr_price = curr_price;
	}

	public Long getCurr_user_price() {
		return curr_user_price;
	}

	public void setCurr_user_price(Long curr_user_price) {
		this.curr_user_price = curr_user_price;
	}

	public String getRemaining_time() {
		return Util.getDayHourMinute(remaining_time);
	}

	public void setRemaining_time(String remaining_time) {
		this.remaining_time = remaining_time;
	}

	public Integer getCurr_user_follow() {
		return curr_user_follow;
	}

	public void setCurr_user_follow(Integer curr_user_follow) {
		this.curr_user_follow = curr_user_follow;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "GMT+8")
	public Timestamp getExpir_bid_time() {
		return expir_bid_time;
	}

	public void setExpir_bid_time(Timestamp expir_bid_time) {
		this.expir_bid_time = expir_bid_time;
	}

	public String getVeh_state_detail() {
		return veh_state_detail;
	}

	public void setVeh_state_detail(String veh_state_detail) {
		this.veh_state_detail = veh_state_detail;
	}
}
