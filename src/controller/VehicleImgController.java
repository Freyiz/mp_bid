package controller;

import java.io.IOException;
import java.io.InputStream;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import pojo.VehicleImg;
import service.VehicleImgService;

@Controller
@RequestMapping("/vehicleImg")
public class VehicleImgController {
	@Autowired
	private VehicleImgService vehicleImgService;

	@RequestMapping("/selectByForeignKey/{id_veh}")
	public String selectByForeignKey(@PathVariable Long id_veh, HttpSession session) {
		VehicleImg vehicleImg = vehicleImgService.selectByForeignKey(id_veh);
		session.setAttribute("vehicleImg", vehicleImg);
		return "vehicleImg/selectVehicleImg";
	}

	@RequestMapping("/updateSelective")
	@ResponseBody
	public int updateSelective(@RequestParam Long id_veh, @RequestParam String imgIndex, MultipartFile imgFile, HttpSession session)
			throws IOException {
		VehicleImg vehicleImg = (VehicleImg) vehicleImgService.selectByForeignKey(id_veh);
		InputStream is = imgFile.getInputStream();
		byte[] bytes = FileCopyUtils.copyToByteArray(is);
		if (imgIndex.equals("img1")) {
			vehicleImg.setImg1(bytes);
		} else if (imgIndex.equals("img2")) {
			vehicleImg.setImg2(bytes);
		} else if (imgIndex.equals("img3")) {
			vehicleImg.setImg3(bytes);
		} else if (imgIndex.equals("img4")) {
			vehicleImg.setImg4(bytes);
		} else if (imgIndex.equals("img5")) {
			vehicleImg.setImg5(bytes);
		} else {
			vehicleImg.setImg0(bytes);
		}
		session.setAttribute("vehicleImg", vehicleImg);
		return vehicleImgService.updateSelective(vehicleImg);
	}

	@RequestMapping("/setNullByImgIndex")
	@ResponseBody
	public int setNullByImgIndex(@RequestParam Long id_veh, @RequestParam String imgIndex) {
		return vehicleImgService.setNullByImgIndex(id_veh, imgIndex);
	}

	@RequestMapping("/getVehicleImg/{imgIndex}")
	@ResponseBody
	public byte[] getVehicleImg(@PathVariable String imgIndex, HttpSession session) {
		VehicleImg vehicleImg = (VehicleImg) session.getAttribute("vehicleImg");
		if (imgIndex.equals("img1")) {
			return vehicleImg.getImg1();
		} else if (imgIndex.equals("img2")) {
			return vehicleImg.getImg2();
		} else if (imgIndex.equals("img3")) {
			return vehicleImg.getImg3();
		} else if (imgIndex.equals("img4")) {
			return vehicleImg.getImg4();
		} else if (imgIndex.equals("img5")) {
			return vehicleImg.getImg5();
		}
		return vehicleImg.getImg0();
	}
}
