package its.me.baby.dto;

import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.Length;


public class UserSticky {

	private Integer id = null;

	@Length(max=2048)
	private Integer userId = null;

	@Pattern(regexp="\\d*")
	private Integer positionTop = null;

	@Pattern(regexp="\\d*")
	private Integer positionLeft = null;

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
}
