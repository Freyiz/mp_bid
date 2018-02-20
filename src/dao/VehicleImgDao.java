package dao;

import org.apache.ibatis.annotations.Param;

import pojo.VehicleImg;

public interface VehicleImgDao {
	VehicleImg selectByForeignKey(Long id_veh);

	int updateSelective(VehicleImg vehicleImg);

	int setNullByImgIndex(@Param("id_veh") Long id_veh, @Param("imgIndex") String imgIndex);
}
