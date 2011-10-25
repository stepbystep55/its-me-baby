package its.me.baby.dto;

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
	
	@NotEmpty
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
		return password+"a";
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
}
