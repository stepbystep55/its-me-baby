package its.me.baby.mapper;

import its.me.baby.dto.UserSticky;

import java.util.List;

public interface UserStickyMapper {


	public List<UserSticky> listByUserId(Integer userId);

	public void create(UserSticky userProfile);

	public void update(UserSticky userProfile);

	public void deleteByUserId(Integer userId);
}
