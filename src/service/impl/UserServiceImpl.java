package service.impl;

import java.util.List;
import java.util.Set;

import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;

import pojo.User;
import dao.UserDao;
import service.UserService;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
	private UserDao userDao;

	@Override
	public int insertSelective(User user) {
		return userDao.insertSelective(user);
	}

	@Override
	public int deleteByPrimaryKey(Long id_user) {
		return userDao.deleteByPrimaryKey(id_user);
	}

	@Override
	public User selectByPrimaryKey(Long id_user) {
		return userDao.selectByPrimaryKey(id_user);
	}

//	@Override
//	public User selectForLogin(User user) {
//		return userDao.selectForLogin(user);
//	}
	
	@Override
	public User selectUserByUsername(String username) {
		return userDao.selectUserByUsername(username);
	}
	
	@Override
	public User selectRoleByUsername(String username) {
		return userDao.selectRoleByUsername(username);
	}

	@Override
	public Set<String> selectRole(String username) {
		return userDao.selectRole(username);
	}

	@Override
	public List<User> selectPrecise(User user) {
		return userDao.selectPrecise(user);
	}

	@Override
	public List<User> selectFuzzy(User user) {
		return userDao.selectFuzzy(user);
	}

	@Override
	public int updateSelective(User user) {
		return userDao.updateSelective(user);
	}

	@Override
	public int selectUserCount() {
		// TODO Auto-generated method stub
		return userDao.selectUserCount();
	}

	@Override
	public List<User> getUserList(Integer start, Integer end) {
		// TODO Auto-generated method stub
		System.out.println("测试");
		System.out.println(userDao.getUserList(start, end));
		
		return userDao.getUserList(start,end);
		
	}

}
