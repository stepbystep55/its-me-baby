package its.me.baby.social;

import its.me.baby.dto.User;

import org.springframework.social.connect.Connection;
import org.springframework.social.connect.ConnectionSignUp;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

/**
 * {@link ConnectionSignUp}
 */
public final class ItsmeConnectionSignUp implements ConnectionSignUp {

	public String execute(Connection<?> connection) {
		User user = (User)RequestContextHolder.getRequestAttributes().getAttribute(User.class.getName(), RequestAttributes.SCOPE_SESSION);
		return user.getId().toString();
		//return connection.getKey().getProviderUserId();
	}

}
