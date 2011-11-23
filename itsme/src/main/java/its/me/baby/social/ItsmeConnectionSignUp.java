package its.me.baby.social;

import its.me.baby.dto.AuthUser;

import org.springframework.social.connect.Connection;
import org.springframework.social.connect.ConnectionSignUp;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

/**
 * {@link ConnectionSignUp}
 */
public final class ItsmeConnectionSignUp implements ConnectionSignUp {

	public String execute(Connection<?> connection) {
		AuthUser authUser = (AuthUser)RequestContextHolder.getRequestAttributes().getAttribute(AuthUser.class.getName(), RequestAttributes.SCOPE_SESSION);
		return authUser.getId().toString();
		//return connection.getKey().getProviderUserId();
	}

}
