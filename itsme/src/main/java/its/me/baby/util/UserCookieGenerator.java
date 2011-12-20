package its.me.baby.util;

import its.me.baby.dto.User;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.encrypt.Encryptors;
import org.springframework.security.crypto.encrypt.TextEncryptor;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.util.CookieGenerator;

public class UserCookieGenerator {

	//@Value("#{encryption.password}")
	private String encryptionPassword = "1234567890123456";

	//@Value("#{encryption.salt}")
	private String encryptionSalt = "5c0744940b5c369b";

	private CookieGenerator userIdCookieGenerator = new CookieGenerator();

	private TextEncryptor textEncryptor = Encryptors.text(encryptionPassword, encryptionSalt);

	private static final int ONE_WEEK = 7 * 24 * 60 * 60;

	// cookie control in case of in-momory DB
	// -->
	private static final String KEY_UPDATED_AT = "updatedAt";
	private CookieGenerator updatedAtCookieGenerator = new CookieGenerator();
	// <--

	public UserCookieGenerator() {
		this.userIdCookieGenerator.setCookieName(User.SESSION_KEY_AUTH);
		this.updatedAtCookieGenerator.setCookieName(KEY_UPDATED_AT);
	}

	public void addUserIdForTemporary(HttpServletResponse response, Integer userId) {
		this.userIdCookieGenerator.setCookieMaxAge(-1);
		this.userIdCookieGenerator.addCookie(response, textEncryptor.encrypt(userId.toString()));
		// cookie control in case of in-momory DB
		// -->
		this.updatedAtCookieGenerator.setCookieMaxAge(-1);
		this.updatedAtCookieGenerator.addCookie(response, ""+System.currentTimeMillis());
		// <--
	}

	public void addUserIdForOneWeek(HttpServletResponse response, Integer userId) {
		this.userIdCookieGenerator.setCookieMaxAge(ONE_WEEK);
		this.userIdCookieGenerator.addCookie(response, textEncryptor.encrypt(userId.toString()));
		// cookie control in case of in-momory DB
		// -->
		this.updatedAtCookieGenerator.setCookieMaxAge(ONE_WEEK);
		this.updatedAtCookieGenerator.addCookie(response, ""+System.currentTimeMillis());
		// <--
	}

	public void removeUserId(HttpServletResponse response) {
		this.userIdCookieGenerator.removeCookie(response);
		// cookie control in case of in-momory DB
		// -->
		this.updatedAtCookieGenerator.removeCookie(response);
		// <--
	}

	public Integer getUserId(HttpServletRequest request) {
		Cookie[] cookies = request.getCookies();
		if (cookies == null) return null;

		// cookie control in case of in-momory DB
		WebApplicationContext context
			= WebApplicationContextUtils.getRequiredWebApplicationContext(request.getSession().getServletContext());
		long startupTime = context.getStartupDate();
		long updatedAt = 0;
		for (Cookie cookie : cookies) {
			if (cookie.getName().equals(KEY_UPDATED_AT)) {
				updatedAt = Long.parseLong(cookie.getValue());
				break;
			}
		}
		if (updatedAt < startupTime) return null;
		// <--
		Integer userId = null;
		for (Cookie cookie : cookies) {
			if (cookie.getName().equals(User.SESSION_KEY_AUTH)) {
				userId = new Integer(textEncryptor.decrypt(cookie.getValue()));
				break;
			}
		}
		return userId;
	}
}
