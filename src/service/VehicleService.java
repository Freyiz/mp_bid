package service;

import java.util.List;

import org.springframework.cache.annotation.CacheEvict;

import pojo.StartBidConfig;
import pojo.User;
import pojo.Vehicle;

public interface VehicleService {
	int insertSelective(Vehicle vehicle);

	@CacheEvict(value = "vehicleImg", key = "'vehicleImg'+#p0")
	int deleteByPrimaryKey(Long id_veh);

	Vehicle selectByPrimaryKey(Long id_veh);

	int updateSelective(Vehicle vehicle);

	int selectVehicleCount(Vehicle vehicle, String mode);

	List<Vehicle> selectVehicle(Vehicle vehicle, String mode, Integer start, Integer end);

	int startBidById(StartBidConfig startBidConfig);

	int cancelBidById(Long id_veh);
	
	User selectUserBidSuccessByVId(Long id_veh);

	List<Vehicle> selectBatchInfo(Vehicle vehicle);
	
	
}
