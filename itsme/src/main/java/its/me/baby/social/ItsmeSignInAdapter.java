package its.me.baby.social;

import org.springframework.social.connect.Connection;
import org.springframework.social.connect.web.SignInAdapter;
import org.springframework.web.context.request.NativeWebRequest;

/**
 * 
 */
public final class ItsmeSignInAdapter implements SignInAdapter {

	public String signIn(String userId, Connection<?> connection, NativeWebRequest request) {
		request.setAttribute("updated", "social", NativeWebRequest.SCOPE_REQUEST);
		return null;
	}

}