package its.me.baby.util;

import its.me.baby.dto.User;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.encrypt.Encryptors;
import org.springframework.security.crypto.encrypt.TextEncryptor;
import org.springframework.web.util.CookieGenerator;

public class UserCookieGenerator {

	//@Value("#{encryption.password}")
	private String encryptionPassword = "1234567890123456";

	//@Value("#{encryption.salt}")
	private String encryptionSalt = "5c0744940b5c369b";

	private CookieGenerator cookieGenerator = new CookieGenerator();

	private TextEncryptor textEncryptor = Encryptors.text(encryptionPassword, encryptionSalt);

	private static final int ONE_WEEK = 7 * 24 * 60 * 60;

	public UserCookieGenerator() {
		this.cookieGenerator.setCookieName(User.SESSION_KEY_AUTH);
	}

	public void addUserIdForTemporary(HttpServletResponse response, Integer userId) {
		this.cookieGenerator.setCookieMaxAge(-1);
		this.cookieGenerator.addCookie(response, textEncryptor.encrypt(userId.toString()));
	}

	public void addUserIdForOneWeek(HttpServletResponse response, Integer userId) {
		this.cookieGenerator.setCookieMaxAge(ONE_WEEK);
		this.cookieGenerator.addCookie(response, textEncryptor.encrypt(userId.toString()));
	}

	public void removeUserId(HttpServletResponse response) {
		this.cookieGenerator.addCookie(response, "");
	}
	
	public Integer getUserId(HttpServletRequest request) {
		Integer userId = null;
		for (Cookie cookie : request.getCookies()) {
			if (cookie.getName().equals(User.SESSION_KEY_AUTH)) {
				userId = new Integer(textEncryptor.decrypt(cookie.getValue()));
				break;
			}
		}
		return userId;
	}
}
