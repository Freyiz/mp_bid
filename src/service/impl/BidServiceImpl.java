package service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.BidDao;
import pojo.QueryForBidding;
import pojo.Vehicle;
import pojo.VehicleInBidding;
import service.BidService;

@Service
public class BidServiceImpl implements BidService {
	@Autowired
	private BidDao bidDao;

	@Override
	public int selectVehicleInBiddingCount(QueryForBidding queryForBidding, String mode) {
		return bidDao.selectVehicleInBiddingCount(queryForBidding, mode);
	}

	@Override
	public List<VehicleInBidding> selectVehicleInBidding(QueryForBidding queryForBidding, String mode, Integer start,
			Integer end) {
		return bidDao.selectVehicleInBidding(queryForBidding, mode, start, end);
	}

	@Override
	public int selectUserFollowingCount(QueryForBidding queryForBidding, String mode) {
		return bidDao.selectUserFollowingCount(queryForBidding, mode);
	}

	@Override
	public List<VehicleInBidding> selectUserFollowing(QueryForBidding queryForBidding, String mode, Integer start,
			Integer end) {
		return bidDao.selectUserFollowing(queryForBidding, mode, start, end);
	}

	@Override
	public int selectUserBiddingCount(QueryForBidding queryForBidding, String mode) {
		return bidDao.selectUserBiddingCount(queryForBidding, mode);
	}

	@Override
	public List<VehicleInBidding> selectUserBidding(QueryForBidding queryForBidding, String mode, Integer start,
			Integer end) {
		return bidDao.selectUserBidding(queryForBidding, mode, start, end);
	}

	@Override
	public int selectUserBidSuccessCount(QueryForBidding queryForBidding, String mode) {
		return bidDao.selectUserBidSuccessCount(queryForBidding, mode);
	}

	@Override
	public List<VehicleInBidding> selectUserBidSuccess(QueryForBidding queryForBidding, String mode, Integer start,
			Integer end) {
		return bidDao.selectUserBidSuccess(queryForBidding, mode, start, end);
	}

	@Override
	public Vehicle selectByPrimaryKey(Long id_veh) {
		return bidDao.selectByPrimaryKey(id_veh);
	}

	@Override
	public Long selectLowest_price() {
		return bidDao.selectLowest_price();
	}

	@Override
	public Long selectHighest_price() {
		return bidDao.selectHighest_price();
	}

	@Override
	public Long selectCurr_price(Long id_veh) {
		return bidDao.selectCurr_price(id_veh);
	}

	@Override
	public int select(Long id_user, Long id_veh) {
		return bidDao.select(id_user, id_veh);
	};

	@Override
	public int insert(Long id_user, Long id_veh, Long bid_price) {
		return bidDao.insert(id_user, id_veh, bid_price);
	};

	@Override
	public int update(Long id_user, Long id_veh, Long bid_price) {
		return bidDao.update(id_user, id_veh, bid_price);
	};

	@Override
	public int follow(Long id_user, Long id_veh) {
		return bidDao.follow(id_user, id_veh);
	};

	@Override
	public int unfollow(Long id_user, Long id_veh) {
		return bidDao.unfollow(id_user, id_veh);
	};
}
