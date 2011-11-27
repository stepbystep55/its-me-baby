package its.me.baby.dto;

import its.me.baby.util.StringUtils;

import java.util.HashMap;
import java.util.Map;

import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.Length;


public class User {

	public static final String SESSION_KEY_AUTH = "authUser";

	private Integer id = null;

	@Email
	@Length(max=128)
	private String email = null;

	//@Length(min=8,max=32)
	@Pattern(regexp=".{0}|.{8,32}")
	private String password = null;

	private boolean facebookConnected = false;

	private boolean twitterConnected = false;

	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public String getCryptoPassword() {
		return StringUtils.getMD5Hash(password);
	}
	public void setPassword(String password) {
		this.password = password;
	}

	public boolean getFacebookConnected() {
		return facebookConnected;
	}
	public void setFacebookConnected(boolean facebookConnected) {
		this.facebookConnected = facebookConnected;
	}
	public boolean getTwitterConnected() {
		return twitterConnected;
	}
	public void setTwitterConnected(boolean twitterConnected) {
		this.twitterConnected = twitterConnected;
	}

	/**
	 * ログインユーザ識別用ユーザオブジェクトを返す。
	 */
	public User getAuthUser() {
		User authUser = new User();
		authUser.setId(id);
		authUser.setEmail(email);
		return authUser;
	}

	private Map<String, String> rejectValueMap = new HashMap<String, String>(0);

	public Map<String, String> getRejectValueMap() {
		return rejectValueMap;
	}
	
	public boolean validForCreating() {
		if (email == null) rejectValueMap.put("email", "org.hibernate.validator.constraints.NotEmpty.message");
		if (password == null) rejectValueMap.put("password", "org.hibernate.validator.constraints.NotEmpty.message");
		return (rejectValueMap.size() == 0);
	}
	public boolean validForAuth() {
		if (email == null) rejectValueMap.put("email", "org.hibernate.validator.constraints.NotEmpty.message");
		if (password == null) rejectValueMap.put("password", "org.hibernate.validator.constraints.NotEmpty.message");
		return (rejectValueMap.size() == 0);
	}
	public boolean validForEditingAccount() {
		if (email == null) rejectValueMap.put("email", "org.hibernate.validator.constraints.NotEmpty.message");
		return (rejectValueMap.size() == 0);
	}

	public boolean validForEditingPassword() {
		if (password == null) rejectValueMap.put("password", "org.hibernate.validator.constraints.NotEmpty.message");
		return (rejectValueMap.size() == 0);
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", email=" + email + "]";
	}
}
