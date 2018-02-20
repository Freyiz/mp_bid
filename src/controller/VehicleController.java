package controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import pojo.StartBidConfig;
import pojo.User;
import pojo.Vehicle;
import service.VehicleService;
import util.Util;

@Controller
@RequestMapping("/vehicle")
public class VehicleController {
	@Autowired
	private VehicleService vehicleService;
	
	@RequestMapping("/biddingVehicle")
	public String biddingVehicle() {
		return "vehicle/biddingVehicle";
	};
	
	@RequestMapping("/insertVehicle")
	public String insertVehicle() {
		return "vehicle/insertVehicle";
	}

	@RequestMapping("/selectVehicle")
	public String selectVehicle() {
		return "vehicle/selectVehicle";
	}

	@RequestMapping("/updateVehicle")
	public String updateVehicle() {
		return "vehicle/updateVehicle";
	}

	@RequestMapping("/startBid")
	public String startBid() {
		return "vehicle/startBid";
	}

	@RequestMapping("/uploadVehicle")
	public String uploadVehicle() {
		return "vehicle/uploadVehicle";
	}

	@RequestMapping("/showBatchVehicle")
	public ModelAndView showBatchVehicle(String batchId) {
		ModelAndView mav = new ModelAndView();
		System.out.println(batchId);
		Vehicle ve = new Vehicle();
		ve.setBatch_num(batchId);
		List<Vehicle> list = vehicleService.selectVehicle(ve, "precise", 0, 100);
		mav.addObject(ve);
		mav.addObject("list", list);
		return mav;
	}

	@RequestMapping("/insertSelective")
	@ResponseBody
	public int insertSelective(Vehicle vehicle) {
		return vehicleService.insertSelective(vehicle);
	}

	@RequestMapping("/deleteByPrimaryKey/{id_veh}")
	@ResponseBody
	public int deleteByPrimaryKey(@PathVariable Long id_veh) {
		return vehicleService.deleteByPrimaryKey(id_veh);
	}

	@RequestMapping("/selectByPrimaryKey/{id_veh}")
	@ResponseBody
	public Vehicle selectByPrimaryKey(@PathVariable Long id_veh) {
		return vehicleService.selectByPrimaryKey(id_veh);
	}

	@RequestMapping("/updateSelective")
	@ResponseBody
	public int updateSelective(Vehicle vehicle) {
		return vehicleService.updateSelective(vehicle);
	}

	@RequestMapping("/selectCount")
	@ResponseBody
	public int selectCount(@RequestParam String vehicleJSON, @RequestParam String mode) {
		Vehicle vehicle = Util.parseToVehicle(vehicleJSON);
		return vehicleService.selectVehicleCount(vehicle, mode);
	}

	@RequestMapping("/select")
	@ResponseBody
	public List<Vehicle> select(@RequestParam String vehicleJSON, @RequestParam String mode,
			@RequestParam Integer curr_page, @RequestParam Integer per_page) {
		Vehicle vehicle = Util.parseToVehicle(vehicleJSON);
		Integer start = (curr_page - 1) * per_page + 1;
		Integer end = curr_page * per_page;
		return vehicleService.selectVehicle(vehicle, mode, start, end);
	}

	@RequestMapping("/startBidById")
	@ResponseBody
	public String startBidById(StartBidConfig startBidConfig, @RequestParam String type) {
		Long id_veh = startBidConfig.getId_veh();
		if (id_veh!=null) {
			Vehicle vehicle = vehicleService.selectByPrimaryKey(id_veh);
			String veh_state_detail = vehicle.getVeh_state_detail();
			boolean isBidSuccess = veh_state_detail.equals("预拍") || veh_state_detail.equals("待付款")
					|| veh_state_detail.equals("付款到期");
			boolean isAllowToStartBid = isBidSuccess || veh_state_detail.equals("新入库") || veh_state_detail.equals("拍卖到期");
			boolean isForce = type.equals("force");
			if (!isAllowToStartBid || isBidSuccess && !isForce) {
				return veh_state_detail;
			}
		}
		return String.valueOf(vehicleService.startBidById(startBidConfig));
	}
	
	@RequestMapping("/cancelBidById/{id_veh}")
	@ResponseBody
	public int cancelBidById(@PathVariable Long id_veh) {
		return vehicleService.cancelBidById(id_veh);
	}

	@RequestMapping("/selectUserBidSuccessByVId/{id_veh}")
	@ResponseBody
	public User selectUserBidSuccessByVId(@PathVariable Long id_veh) {
		return vehicleService.selectUserBidSuccessByVId(id_veh);
	}

	@RequestMapping("/selectBatchInfo")
	@ResponseBody
	public List<Vehicle> selectBatchInfo(@RequestParam String vehicleJSON) {
		Vehicle vehicle = Util.parseToVehicle(vehicleJSON);
		List<Vehicle> list = vehicleService.selectBatchInfo(vehicle);
		return list;
	}
}
