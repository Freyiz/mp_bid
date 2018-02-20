package pojo;

import java.io.Serializable;

public class VehicleImg implements Serializable {
	private static final long serialVersionUID = 1L;
	private Long id_veh;
	private byte[] img0;
	private byte[] img1;
	private byte[] img2;
	private byte[] img3;
	private byte[] img4;
	private byte[] img5;

	public Long getId_veh() {
		return id_veh;
	}

	public void setId_veh(Long id_veh) {
		this.id_veh = id_veh;
	}

	public byte[] getImg0() {
		return img0;
	}

	public void setImg0(byte[] img0) {
		this.img0 = img0;
	}

	public byte[] getImg1() {
		return img1;
	}

	public void setImg1(byte[] img1) {
		this.img1 = img1;
	}

	public byte[] getImg2() {
		return img2;
	}

	public void setImg2(byte[] img2) {
		this.img2 = img2;
	}

	public byte[] getImg3() {
		return img3;
	}

	public void setImg3(byte[] img3) {
		this.img3 = img3;
	}

	public byte[] getImg4() {
		return img4;
	}

	public void setImg4(byte[] img4) {
		this.img4 = img4;
	}

	public byte[] getImg5() {
		return img5;
	}

	public void setImg5(byte[] img5) {
		this.img5 = img5;
	}
}
