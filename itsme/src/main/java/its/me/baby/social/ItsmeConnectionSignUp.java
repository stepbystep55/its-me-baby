package its.me.baby.social;

import javax.servlet.http.HttpServletRequest;

import its.me.baby.util.UserCookieGenerator;

import org.springframework.social.connect.Connection;
import org.springframework.social.connect.ConnectionSignUp;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

/**
 * {@link ConnectionSignUp}
 */
public class ItsmeConnectionSignUp implements ConnectionSignUp {

	private UserCookieGenerator userCookieGenerator = new UserCookieGenerator();

	public String execute(Connection<?> connection) {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String userId = userCookieGenerator.getUserId(request).toString();
		System.out.println("ItsmeConnectionSignUp#userId="+userId);
		return userId;
		//return userCookieGenerator.getUserId(request).toString();
		//return connection.getKey().getProviderUserId();
	}

}
