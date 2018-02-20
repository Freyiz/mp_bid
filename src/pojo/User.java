package pojo;

import java.sql.Timestamp;

import com.fasterxml.jackson.annotation.JsonFormat;

public class User {
	private Long row_num;
	private Long id_user;
	private String role;
	private String username;
	private String password;
	private String org;
	private Long tel;
	private String email;
	private Timestamp user_stamp;
	private Long confirm;
	private String follow;

	public Long getRow_num() {
		return row_num;
	}

	public void setRow_num(Long row_num) {
		this.row_num = row_num;
	}

	public Long getId_user() {
		return id_user;
	}

	public void setId_user(Long id_user) {
		this.id_user = id_user;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getOrg() {
		return org;
	}

	public void setOrg(String org) {
		this.org = org;
	}

	public Long getTel() {
		return tel;
	}

	public void setTel(Long tel) {
		this.tel = tel;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
	public Timestamp getUser_stamp() {
		return user_stamp;
	}

	public void setUser_stamp(Timestamp user_stamp) {
		this.user_stamp = user_stamp;
	}

	public Long getConfirm() {
		return confirm;
	}

	public void setConfirm(Long confirm) {
		this.confirm = confirm;
	}

	public String getFollow() {
		return follow;
	}

	public void setFollow(String follow) {
		this.follow = follow;
	}
}
