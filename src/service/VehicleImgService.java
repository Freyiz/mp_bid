package service;

import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;

import pojo.VehicleImg;

public interface VehicleImgService {
	@Cacheable(value = "vehicleImg", key = "'vehicleImg'+#p0")
	VehicleImg selectByForeignKey(Long id_veh);

	@CacheEvict(value = "vehicleImg", key = "'vehicleImg'+#p0.id_veh")
	int updateSelective(VehicleImg vehicleImg);

	@CacheEvict(value = "vehicleImg", key = "'vehicleImg'+#p0")
	int setNullByImgIndex(Long id_veh, String imgIndex);
}
