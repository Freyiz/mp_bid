package service;

import java.util.List;

import pojo.QueryForBidding;
import pojo.Vehicle;
import pojo.VehicleInBidding;

public interface BidService {
	int selectVehicleInBiddingCount(QueryForBidding queryForBidding, String mode);

	List<VehicleInBidding> selectVehicleInBidding(QueryForBidding queryForBidding, String mode, Integer start,
			Integer end);

	int selectUserFollowingCount(QueryForBidding queryForBidding, String mode);

	List<VehicleInBidding> selectUserFollowing(QueryForBidding queryForBidding, String mode, Integer start,
			Integer end);

	int selectUserBiddingCount(QueryForBidding queryForBidding, String mode);

	List<VehicleInBidding> selectUserBidding(QueryForBidding queryForBidding, String mode, Integer start,
			Integer end);

	int selectUserBidSuccessCount(QueryForBidding queryForBidding, String mode);

	List<VehicleInBidding> selectUserBidSuccess(QueryForBidding queryForBidding, String mode, Integer start,
			Integer end);

	Vehicle selectByPrimaryKey(Long id_veh);

	Long selectLowest_price();

	Long selectHighest_price();

	Long selectCurr_price(Long id_veh);

	int select(Long id_user, Long id_veh);

	int insert(Long id_user, Long id_veh, Long bid_price);

	int update(Long id_user, Long id_veh, Long bid_price);

	int follow(Long id_user, Long id_veh);

	int unfollow(Long id_user, Long id_veh);
}
