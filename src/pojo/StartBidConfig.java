package pojo;

import java.sql.Timestamp;

import com.fasterxml.jackson.annotation.JsonFormat;

public class StartBidConfig {
	private Long id_veh;
	private String batch_num;
	private String delay;
	private Timestamp start_bid_time;
	private int bidDuration;
	private int payDuration;
	private Long start_price;

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

	public String getDelay() {
		return delay;
	}

	public void setDelay(String delay) {
		this.delay = delay;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
	public Timestamp getStart_bid_time() {
		return start_bid_time;
	}

	public void setStart_bid_time(Timestamp start_bid_time) {
		this.start_bid_time = start_bid_time;
	}

	public int getBidDuration() {
		return bidDuration;
	}

	public void setBidDuration(int bidDuration) {
		this.bidDuration = bidDuration;
	}

	public int getPayDuration() {
		return payDuration;
	}

	public void setPayDuration(int payDuration) {
		this.payDuration = payDuration;
	}

	public Long getStart_price() {
		return start_price;
	}

	public void setStart_price(Long start_price) {
		this.start_price = start_price;
	}
}
