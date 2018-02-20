package pojo;

import java.sql.Timestamp;

import com.fasterxml.jackson.annotation.JsonFormat;

public class Vehicle {
	private Long row_num;
	private Long newveh_count;
	private Long id_veh;
	private String batch_num;
	private String license_num;
	private String veh_id_num;
	private String engine_num;
	private String brand;
	private String brand_model;
	private String intro;
	private Timestamp veh_stamp;
	private Timestamp start_bid_time;
	private Timestamp expir_bid_time;
	private Timestamp expir_pay_time;
	private Long start_price;
	private Long curr_price;
	private String remark;
	private Long veh_state;
	private String veh_state_detail;

	public Long getRow_num() {
		return row_num;
	}

	public void setRow_num(Long row_num) {
		this.row_num = row_num;
	}
	
	public Long getNewveh_count() {
		return newveh_count;
	}

	public void setNewveh_count(Long newveh_count) {
		this.newveh_count = newveh_count;
	}

	public Long getId_veh() {
		return id_veh;
	}

	public void setId_veh(Long id_veh) {
		this.id_veh = id_veh;
	}

	public String getBatch_num() {
		return batch_num;
	}

	public void setBatch_num(String batch_num) {
		this.batch_num = batch_num;
	}

	public String getLicense_num() {
		return license_num;
	}

	public void setLicense_num(String license_num) {
		this.license_num = license_num;
	}

	public String getVeh_id_num() {
		return veh_id_num;
	}

	public void setVeh_id_num(String veh_id_num) {
		this.veh_id_num = veh_id_num;
	}

	public String getEngine_num() {
		return engine_num;
	}

	public void setEngine_num(String engine_num) {
		this.engine_num = engine_num;
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

	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
	public Timestamp getVeh_stamp() {
		return veh_stamp;
	}

	public void setVeh_stamp(Timestamp veh_stamp) {
		this.veh_stamp = veh_stamp;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
	public Timestamp getStart_bid_time() {
		return start_bid_time;
	}

	public void setStart_bid_time(Timestamp start_bid_time) {
		this.start_bid_time = start_bid_time;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
	public Timestamp getExpir_bid_time() {
		return expir_bid_time;
	}

	public void setExpir_bid_time(Timestamp expir_bid_time) {
		this.expir_bid_time = expir_bid_time;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
	public Timestamp getExpir_pay_time() {
		return expir_pay_time;
	}

	public void setExpir_pay_time(Timestamp expir_pay_time) {
		this.expir_pay_time = expir_pay_time;
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

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Long getVeh_state() {
		return veh_state;
	}

	public void setVeh_state(Long veh_state) {
		this.veh_state = veh_state;
	}

	public String getVeh_state_detail() {
		return veh_state_detail;
	}

	public void setVeh_state_detail(String veh_state_detail) {
		this.veh_state_detail = veh_state_detail;
	}
}
