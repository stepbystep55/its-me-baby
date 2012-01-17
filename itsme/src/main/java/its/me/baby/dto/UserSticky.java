package its.me.baby.dto;

import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.Length;


public class UserSticky {

	public static final String DEFAULT_FONT_COLOR = "#000000";
	public static final String DEFAULT_BG_COLOR = "#FFFFFF";

	private Integer id = null;

	@Length(max=2048)
	private Integer userId = null;

	@Pattern(regexp="\\d*")
	private Integer positionTop = null;

	@Pattern(regexp="\\d*")
	private Integer positionLeft = null;

	@Pattern(regexp="\\d*")
	private Integer width = null;

	@Pattern(regexp="\\d*")
	private Integer height = null;

	@Pattern(regexp="\\d*")
	private Integer fontSize = 38;
	
	@Pattern(regexp="#[abcdefABCDEF0-9]{6}")
	private String fontColor = DEFAULT_FONT_COLOR;
	
	private boolean transparent = false;

	@Pattern(regexp="#[abcdefABCDEF0-9]{6}")
	private String bgColor = DEFAULT_BG_COLOR;

	@Length(max=2048)
	private String content = null;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Integer getPositionTop() {
		return positionTop;
	}

	public void setPositionTop(Integer positionTop) {
		this.positionTop = positionTop;
	}

	public Integer getPositionLeft() {
		return positionLeft;
	}

	public void setPositionLeft(Integer positionLeft) {
		this.positionLeft = positionLeft;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Integer getWidth() {
		return width;
	}

	public void setWidth(Integer width) {
		this.width = width;
	}

	public Integer getHeight() {
		return height;
	}

	public void setHeight(Integer height) {
		this.height = height;
	}

	public Integer getFontSize() {
		return fontSize;
	}

	public void setFontSize(Integer fontSize) {
		this.fontSize = fontSize;
	}

	public String getFontColor() {
		return fontColor;
	}

	public void setFontColor(String fontColor) {
		this.fontColor = fontColor;
	}

	public boolean getTransparent() {
		return transparent;
	}

	public void setTransparent(boolean transparent) {
		this.transparent = transparent;
	}

	public String getBgColor() {
		return bgColor;
	}

	public void setBgColor(String bgColor) {
		this.bgColor = bgColor;
	}
}
