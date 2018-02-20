package dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import pojo.StartBidConfig;
import pojo.User;
import pojo.Vehicle;

public interface VehicleDao {
	int insertSelective(Vehicle vehicle);

	int deleteByPrimaryKey(Long id_veh);

	Vehicle selectByPrimaryKey(Long id_veh);

	int updateSelective(Vehicle vehicle);

	int selectVehicleCount(@Param("param") Vehicle vehicle, @Param("mode") String mode);

	List<Vehicle> selectVehicle(@Param("param") Vehicle vehicle, @Param("mode") String mode,
			@Param("start") Integer start, @Param("end") Integer end);

	int startBidById(StartBidConfig startBidConfig);
	
	int cancelBidById(Long id_veh);

	User selectUserBidSuccessByVId(Long id_veh);

	List<Vehicle> selectBatchInfo(Vehicle vehicle);
}
