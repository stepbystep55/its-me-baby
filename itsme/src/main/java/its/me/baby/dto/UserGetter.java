package its.me.baby.dto;

import its.me.baby.util.StringUtils;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;

public class UserGetter {

	@NotEmpty
	@Email
	@Length(max=128)
	private String email = null;

	@NotEmpty
	@Length(max=32)
	private String password = null;
	
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
	@Override
	public String toString() {
		return "UserGetter [email=" + email + ", password=<<secret>>]";
	}
}
