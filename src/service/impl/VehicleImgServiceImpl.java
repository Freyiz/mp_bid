package service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.VehicleImgDao;
import pojo.VehicleImg;
import service.VehicleImgService;

@Service
public class VehicleImgServiceImpl implements VehicleImgService {
	@Autowired
	private VehicleImgDao vehicleImgDao;

	@Override
	public VehicleImg selectByForeignKey(Long id_veh) {
		return vehicleImgDao.selectByForeignKey(id_veh);
	}

	@Override
	public int updateSelective(VehicleImg vehicleImg) {
		return vehicleImgDao.updateSelective(vehicleImg);
	}
	
	@Override
	public int setNullByImgIndex(Long id_veh, String imgIndex) {
		return vehicleImgDao.setNullByImgIndex(id_veh, imgIndex);
	}
}
