package controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import pojo.User;
import service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {
	@Autowired
	private UserService userService;

	@RequestMapping("/login")
	@ResponseBody
	public String login(User user, HttpSession session) {
		String username = user.getUsername();
		String password = user.getPassword();
		if (username == null || password == null) {
			return "404";
		}
		if (username.trim().equals("")) {
			return "用户名不得为空！";
		}
		if (password.trim().equals("")) {
			return "密码不得为空！";
		}
		user = userService.selectUserByUsername(username);
		if (user == null) {
			return "用户名或密码不正确";
		}

		Subject subject = SecurityUtils.getSubject();
		if (!subject.isAuthenticated()) {
			UsernamePasswordToken token = new UsernamePasswordToken(username, password);
			// token.setRememberMe(true);
			try {
				subject.login(token);
				session.setAttribute("user", user);
			} catch (AuthenticationException e) {
//				e.printStackTrace();
				return "用户名或密码不正确";
			}
		}
		return "";
	}

	@RequestMapping("/logout")
	@ResponseBody
	public String logout(HttpSession session) {
		session.removeAttribute("user");
		Subject subject = SecurityUtils.getSubject();
		subject.logout();
		return "";
	}

	@RequestMapping("/insertUser")
	public String insertUser() {
		return "insertUser";
	}

	@RequestMapping("/selectUser")
	public String selectUser() {
		return "selectUser";
	}

	@RequestMapping("/updateUser")
	public String updateUser() {
		return "user/updateUser";
	}
	
	@RequestMapping("/userManagement")
	public String userManagement() {
		return "user/userManagement";
	}
	
	@RequestMapping("/userList")
	@ResponseBody
	public List<User> getUserList(@RequestParam Integer curr_page, @RequestParam Integer per_page) {
		Integer start = (curr_page - 1) * per_page + 1;
		Integer end = curr_page * per_page;		
		return userService.getUserList(start, end);		
	}
	
	@RequestMapping("/selectCount")
	@ResponseBody
	public int selectCount() {		
		return userService.selectUserCount();
	}	

	@RequestMapping("/insertSelective")
	@ResponseBody
	public int insertSelective(User user) {
		return userService.insertSelective(user);
	}

	@RequestMapping("/deleteByPrimaryKey/{id_user}")
	@ResponseBody
	public int deleteByPrimaryKey(@PathVariable Long id_user) {
		return userService.deleteByPrimaryKey(id_user);
	}


	@RequestMapping("/selectByPrimaryKey/{id_user}")
	@ResponseBody
	public User selectByPrimaryKey(@PathVariable Long id_user) {
		return userService.selectByPrimaryKey(id_user);
	}

	@RequestMapping("/selectPrecise")
	@ResponseBody
	public List<User> selectPrecise(User user) {
		return userService.selectPrecise(user);
	}

	@RequestMapping("/selectFuzzy")
	@ResponseBody
	public List<User> selectFuzzy(User user) {
		return userService.selectFuzzy(user);
	}

	@RequestMapping("/updateSelective")
	@ResponseBody
	public int updateSelective(User user) {
		if(user.getConfirm()==null) {
			long confirm = 0;
			user.setConfirm(confirm);
		}
		return userService.updateSelective(user);
	}
}
