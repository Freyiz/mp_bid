package dao;

import java.util.List;
import java.util.Set;

import org.apache.ibatis.annotations.Param;

import pojo.User;

public interface UserDao {
	int insertSelective(User user);

	int deleteByPrimaryKey(Long id_user);

	User selectByPrimaryKey(Long id_user);

//	User selectForLogin(User user);
	
	User selectUserByUsername(String username);
	
	User selectRoleByUsername(String username);
	
	Set<String> selectRole(String username);

	List<User> selectPrecise(User user);

	List<User> selectFuzzy(User user);

	int updateSelective(User user);

	int selectUserCount();

	List<User> getUserList(@Param("start") Integer start,@Param("end") Integer end);
}
