package sys;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.realm.AuthenticatingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

import pojo.User;
import service.UserService;

public class ShiroRealm extends AuthenticatingRealm {
	@Autowired
	private UserService userService;

//	@Override
//    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token)
//            throws AuthenticationException {
//        //获取用户账号
//        String username = token.getPrincipal().toString() ;
//        User user = userService.selectUserByUsername(username) ;
//        if (user != null){
//            //将查询到的用户账号和密码存放到 authenticationInfo用于后面的权限判断。第三个参数传入realName。
//            AuthenticationInfo authenticationInfo = new SimpleAuthenticationInfo(user.getUsername(),user.getPassword(),
//            		getName()) ;
//            return authenticationInfo ;
//        }else{
//            return  null ;
//        }
//    }

	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
		UsernamePasswordToken upToken = (UsernamePasswordToken) token;
		String username = upToken.getPrincipal().toString();
		User user = userService.selectUserByUsername(username);
		if (user == null) {
			return null;
			// throw new UnknownAccountException("用户不存在!");
		}
		Object principal = username;
		ByteSource credentialsSalt = ByteSource.Util.bytes(username);
		String hashAlgorithmName = "MD5";
		int hashIterations = 1024;
		Object beforecook = user.getPassword();
		Object result = new SimpleHash(hashAlgorithmName, beforecook, credentialsSalt, hashIterations);
		String realmName = getName();
		SimpleAuthenticationInfo info = new SimpleAuthenticationInfo(principal, result, credentialsSalt, realmName);
		return info;
	}
//
//	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
//		return null;
//	}
}
