package its.me.baby.mapper;

import its.me.baby.dto.UserProfile;

// TODO adding a foreign key to id on user_profile
public interface UserProfileMapper {

	public UserProfile getUserProfileById(Integer id);

	public void createUserProfile(UserProfile userProfile);

	public void updateUserProfile(UserProfile userProfile);
}
