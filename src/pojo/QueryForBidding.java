package pojo;

public class QueryForBidding {
	private Long id_user;
	private String brand;
	private String brand_model;
	private Long lowest_price;
	private Long highest_price;
	private String remaining_time;

	public Long getId_user() {
		return id_user;
	}

	public void setId_user(Long id_user) {
		this.id_user = id_user;
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

	public Long getLowest_price() {
		return lowest_price;
	}

	public void setLowest_price(Long lowest_price) {
		this.lowest_price = lowest_price;
	}

	public Long getHighest_price() {
		return highest_price;
	}

	public void setHighest_price(Long highest_price) {
		this.highest_price = highest_price;
	}

	public String getRemaining_time() {
		return remaining_time;
	}

	public void setRemaining_time(String remaining_time) {
		this.remaining_time = remaining_time;
	}
}
