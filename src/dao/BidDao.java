package dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import pojo.QueryForBidding;
import pojo.Vehicle;
import pojo.VehicleInBidding;

public interface BidDao {
	int selectVehicleInBiddingCount(@Param("param") QueryForBidding queryForBidding, @Param("mode") String mode);

	List<VehicleInBidding> selectVehicleInBidding(@Param("param") QueryForBidding queryForBidding,
			@Param("mode") String mode, @Param("start") Integer start, @Param("end") Integer end);

	int selectUserFollowingCount(@Param("param") QueryForBidding queryForBidding, @Param("mode") String mode);

	List<VehicleInBidding> selectUserFollowing(@Param("param") QueryForBidding queryForBidding,
			@Param("mode") String mode, @Param("start") Integer start, @Param("end") Integer end);

	int selectUserBiddingCount(@Param("param") QueryForBidding queryForBidding, @Param("mode") String mode);

	List<VehicleInBidding> selectUserBidding(@Param("param") QueryForBidding queryForBidding,
			@Param("mode") String mode, @Param("start") Integer start, @Param("end") Integer end);

	int selectUserBidSuccessCount(@Param("param") QueryForBidding queryForBidding, @Param("mode") String mode);

	List<VehicleInBidding> selectUserBidSuccess(@Param("param") QueryForBidding queryForBidding,
			@Param("mode") String mode, @Param("start") Integer start, @Param("end") Integer end);

	Vehicle selectByPrimaryKey(Long id_veh);

	Long selectLowest_price();

	Long selectHighest_price();

	Long selectCurr_price(Long id_veh);

	int select(@Param("id_user") Long id_user, @Param("id_veh") Long id_veh);

	int insert(@Param("id_user") Long id_user, @Param("id_veh") Long id_veh, @Param("bid_price") Long bid_price);

	int update(@Param("id_user") Long id_user, @Param("id_veh") Long id_veh, @Param("bid_price") Long bid_price);

	int follow(@Param("id_user") Long id_user, @Param("id_veh") Long id_veh);

	int unfollow(@Param("id_user") Long id_user, @Param("id_veh") Long id_veh);
}
