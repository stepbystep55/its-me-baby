package its.me.baby.dto;

import its.me.baby.util.StringUtils;

import java.util.HashMap;
import java.util.Map;

import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.Range;

public class User {

	public static final String DEFAULT_FONT_COLOR = "#000000";
	public static final String DEFAULT_BG_COLOR = "#FFFFFF";
	public static final String BG_IMG_LAYOUT_CENTER = "center";
	public static final String BG_IMG_LAYOUT_TILE = "tile";
	public static final String BG_IMG_LAYOUT_STRETCH = "stretch";
	public static final String PROFILE_BOX_POSITION_LEFT = "left";
	public static final String PROFILE_BOX_POSITION_RIGHT = "right";

	private Integer id = null;

	@Email
	@Length(max=128)
	private String email = null;
	
	@Length(min=8,max=32)
	private String password = null;
	
	@Length(min=3,max=32)
	private String name = null;

	@Pattern(regexp="#[abcdefABCDEF0-9]{6}")
	private String nameFontColor = DEFAULT_FONT_COLOR;

	@Range(min=1,max=300)
	private Integer nameFontSize = 72;

	@Length(max=128)
	private String title = "";

	@Pattern(regexp="#[abcdefABCDEF0-9]{6}")
	private String titleFontColor = DEFAULT_FONT_COLOR;

	@Range(min=1,max=300)
	private Integer titleFontSize = 24;

	@Length(max=2048)
	private String content = "";

	@Pattern(regexp="#[abcdefABCDEF0-9]{6}")
	private String contentFontColor = DEFAULT_FONT_COLOR;

	@Range(min=1,max=300)
	private Integer contentFontSize = 16;

	@Pattern(regexp="#[abcdefABCDEF0-9]{6}")
	private String profileBoxColor = DEFAULT_BG_COLOR;

	@Range(min=0,max=100)
	private Integer profileBoxOpacity = 0;

	private String profileBoxPosition = PROFILE_BOX_POSITION_LEFT;

	// TODO need to revise the regular expression for url
	@Length(max=512)
	@Pattern(regexp="https?://.*")
	private String bgImgUrl = null;

	@Length(max=512)
	private String bgImgLayout = BG_IMG_LAYOUT_CENTER;

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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}

	public String getNameFontColor() {
		return nameFontColor;
	}
	public void setNameFontColor(String nameFontColor) {
		this.nameFontColor = nameFontColor;
	}
	public Integer getNameFontSize() {
		return nameFontSize;
	}
	public void setNameFontSize(Integer nameFontSize) {
		this.nameFontSize = nameFontSize;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getTitleFontColor() {
		return titleFontColor;
	}
	public void setTitleFontColor(String titleFontColor) {
		this.titleFontColor = titleFontColor;
	}
	public Integer getTitleFontSize() {
		return titleFontSize;
	}
	public void setTitleFontSize(Integer titleFontSize) {
		this.titleFontSize = titleFontSize;
	}
	public String getContentFontColor() {
		return contentFontColor;
	}
	public void setContentFontColor(String contentFontColor) {
		this.contentFontColor = contentFontColor;
	}
	public Integer getContentFontSize() {
		return contentFontSize;
	}
	public void setContentFontSize(Integer contentFontSize) {
		this.contentFontSize = contentFontSize;
	}
	public String getBgImgUrl() {
		return bgImgUrl;
	}
	public void setBgImgUrl(String bgImgUrl) {
		this.bgImgUrl = bgImgUrl;
	}
	public String getBgImgLayout() {
		return bgImgLayout;
	}
	public void setBgImgLayout(String bgImgLayout) {
		this.bgImgLayout = bgImgLayout;
	}

	public String getProfileBoxColor() {
		return profileBoxColor;
	}
	public void setProfileBoxColor(String profileBoxColor) {
		this.profileBoxColor = profileBoxColor;
	}
	public Integer getProfileBoxOpacity() {
		return profileBoxOpacity;
	}
	public void setProfileBoxOpacity(Integer profileBoxOpacity) {
		this.profileBoxOpacity = profileBoxOpacity;
	}
	public String getProfileBoxPosition() {
		return profileBoxPosition;
	}
	public void setProfileBoxPosition(String profileBoxPosition) {
		this.profileBoxPosition = profileBoxPosition;
	}
	@Override
	public String toString() {
		return "User [id=" + id + ", email=" + email + "]";
	}

	private Map<String, String> rejectValueMap = new HashMap<String, String>(0);

	public Map<String, String> getRejectValueMap() {
		return rejectValueMap;
	}

	public boolean validForEditingAccount() {
		if (email == null) rejectValueMap.put("email", "org.hibernate.validator.constraints.NotEmpty.message");
		return (rejectValueMap.size() == 0);
	}

	public boolean validForEditingPassword() {
		if (password == null) rejectValueMap.put("password", "org.hibernate.validator.constraints.NotEmpty.message");
		return (rejectValueMap.size() == 0);
	}

	public boolean validForEditingProfile() {
		return (rejectValueMap.size() == 0);
	}
}
