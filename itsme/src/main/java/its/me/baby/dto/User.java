package its.me.baby.dto;

import its.me.baby.util.StringUtils;

import java.util.HashMap;
import java.util.Map;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;

public class User {

	private Integer id = null;

	@NotEmpty
	@Length(min=3,max=32)
	private String name = null;
	
	@NotEmpty
	@Email
	@Length(max=128)
	private String email = null;
	
	@NotEmpty
	@Length(min=8,max=32)
	private String password = null;
	
	@Length(max=2048)
	private String profile = null;

	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
	public String getProfile() {
		return profile;
	}
	public void setProfile(String profile) {
		this.profile = profile;
	}
	@Override
	public String toString() {
		return "User [id=" + id + ", name=" + name + ", email=" + email
				+ ", password=<<secret>>" + ", profile=" + profile + "]";
	}
	
	public Map<String, String> validateForEdit() {
		Map<String, String> rejectValueMap = new HashMap<String, String>();
		if (profile == null) rejectValueMap.put("profile", "org.hibernate.validator.constraints.NotEmpty.message");
		return (rejectValueMap.size() == 0) ? null : rejectValueMap;
	}
}
