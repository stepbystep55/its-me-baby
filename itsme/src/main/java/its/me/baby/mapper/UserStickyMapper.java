package its.me.baby.mapper;

import its.me.baby.dto.UserSticky;

import java.util.List;

public interface UserStickyMapper {

	public int newId(Integer userId);

	public List<UserSticky> listByUserId(Integer userId);

	public void create(UserSticky userSticky);

	public void update(UserSticky userSticky);

	public void deleteByUserId(Integer userId);
}
