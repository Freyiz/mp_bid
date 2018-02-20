package service;

import java.util.List;
import java.util.Set;

import pojo.User;

public interface UserService {
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

	List<User> getUserList(Integer start, Integer end);
}
