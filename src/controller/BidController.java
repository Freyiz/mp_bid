package controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import pojo.QueryForBidding;
import pojo.Vehicle;
import pojo.VehicleInBidding;
import service.BidService;
import util.Util;

@Controller
public class BidController {
	@Autowired
	private BidService bidService;

	@RequestMapping("/index")
	public String insertVehicle() {
		return "index";
	}

	@RequestMapping("/vehicleInBidding")
	public String VehicleInBidding() {
		return "bid/vehicleInBidding";
	}

	@RequestMapping("/selectCount")
	@ResponseBody
	public int selectCount(@RequestParam String queryForBiddingJSON, @RequestParam String mode,
			@RequestParam String pageType, @RequestParam Long id_user) {
		QueryForBidding queryForBidding = Util.parseToQueryForBidding(queryForBiddingJSON);
		queryForBidding.setId_user(id_user);
		if (pageType.equals("userFollowing")) {
			return bidService.selectUserFollowingCount(queryForBidding, mode);
		} else if (pageType.equals("userBidding")) {
			return bidService.selectUserBiddingCount(queryForBidding, mode);
		} else if (pageType.equals("userBidSuccess")) {
			return bidService.selectUserBidSuccessCount(queryForBidding, mode);
		}
		return bidService.selectVehicleInBiddingCount(queryForBidding, mode);
	}

	@RequestMapping("/select")
	@ResponseBody
	public List<VehicleInBidding> select(@RequestParam String queryForBiddingJSON, @RequestParam String mode,
			@RequestParam Integer curr_page, @RequestParam Integer per_page, @RequestParam String pageType,
			@RequestParam Long id_user) {
		QueryForBidding queryForBidding = Util.parseToQueryForBidding(queryForBiddingJSON);
		queryForBidding.setId_user(id_user);
		Integer start = (curr_page - 1) * per_page + 1;
		Integer end = curr_page * per_page;
		if (pageType.equals("userFollowing")) {
			return bidService.selectUserFollowing(queryForBidding, mode, start, end);
		} else if (pageType.equals("userBidding")) {
			return bidService.selectUserBidding(queryForBidding, mode, start, end);
		} else if (pageType.equals("userBidSuccess")) {
			return bidService.selectUserBidSuccess(queryForBidding, mode, start, end);
		}
		return bidService.selectVehicleInBidding(queryForBidding, mode, start, end);
	}

	@RequestMapping("/selectByPrimaryKey/{id_veh}")
	@ResponseBody
	public Vehicle selectByPrimaryKey(@PathVariable Long id_veh, HttpSession session) {
		Vehicle vehicle = bidService.selectByPrimaryKey(id_veh);
		session.setAttribute("vehicle", vehicle);
		return vehicle;
	}

	@RequestMapping("/selectLowestAndHighestPrice")
	@ResponseBody
	public String[] selectLowestAndHighestPrice() {
		String lowest_price = String.valueOf(bidService.selectLowest_price());
		String highest_price = String.valueOf(bidService.selectHighest_price());
		return new String[] { lowest_price, highest_price };
	}

	@RequestMapping("/selectCurr_price/{id_veh}")
	@ResponseBody
	public String selectCurr_price(@PathVariable Long id_veh) {
		return String.valueOf(bidService.selectCurr_price(id_veh));
	}

	@RequestMapping("/bid")
	public ModelAndView updateVehicle(HttpSession session) {
		ModelAndView mav = new ModelAndView("bid/bid");
		mav.addObject(session.getAttribute("vehicle"));
		return mav;
	}

	@RequestMapping("/insertOrUpdateBid")
	@ResponseBody
	public int insertOrUpdateBid(@RequestParam Long id_user, @RequestParam Long id_veh, @RequestParam Long bid_price) {
		Long curr_price = bidService.selectCurr_price(id_veh);
		if (bid_price <= curr_price) {
			return -1;
		}
		// result为1表示当前用户对指定车辆不是初次出价，此时调用方法bidService.update
		// result为0表示当前用户对指定车辆是初次出价，此时调用bidService.insert
		int result = bidService.select(id_user, id_veh);
		return result == 1 ? bidService.update(id_user, id_veh, bid_price)
				: bidService.insert(id_user, id_veh, bid_price);
	}

	@RequestMapping("/followToggle")
	@ResponseBody
	public int followToggle(@RequestParam Long id_user, @RequestParam Long id_veh, @RequestParam String action) {
		return action.equals("follow") ? bidService.follow(id_user, id_veh) : bidService.unfollow(id_user, id_veh);
	}
}
