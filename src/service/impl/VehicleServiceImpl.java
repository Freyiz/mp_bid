package service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.VehicleDao;
import pojo.StartBidConfig;
import pojo.User;
import pojo.Vehicle;
import service.VehicleService;

@Service
public class VehicleServiceImpl implements VehicleService {
	@Autowired
	private VehicleDao vehicleDao;

	@Override
	public int insertSelective(Vehicle vehicle) {
		return vehicleDao.insertSelective(vehicle);
	}

	@Override
	public int deleteByPrimaryKey(Long id_veh) {
		return vehicleDao.deleteByPrimaryKey(id_veh);
	}

	@Override
	public Vehicle selectByPrimaryKey(Long id_veh) {
		return vehicleDao.selectByPrimaryKey(id_veh);
	}
	
	@Override
	public int updateSelective(Vehicle vehicle) {
		return vehicleDao.updateSelective(vehicle);
	}

	@Override
	public int selectVehicleCount(Vehicle vehicle, String mode) {
		return vehicleDao.selectVehicleCount(vehicle, mode);
	}

	@Override
	public List<Vehicle> selectVehicle(Vehicle vehicle, String mode, Integer start, Integer end) {
		return vehicleDao.selectVehicle(vehicle, mode, start, end);
	}

	@Override
	public int startBidById(StartBidConfig startBidConfig) {
		return vehicleDao.startBidById(startBidConfig);
	}
	
	@Override
	public int cancelBidById(Long id_veh) {
		return vehicleDao.cancelBidById(id_veh);
	}

	@Override
	public User selectUserBidSuccessByVId(Long id_veh) {
		return vehicleDao.selectUserBidSuccessByVId(id_veh);
	}

	@Override
	public List<Vehicle> selectBatchInfo(Vehicle vehicle) {
		// TODO Auto-generated method stub
		return vehicleDao.selectBatchInfo(vehicle);
	}
}
