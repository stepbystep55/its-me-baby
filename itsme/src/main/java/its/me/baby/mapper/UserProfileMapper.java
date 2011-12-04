package its.me.baby.mapper;

import its.me.baby.dto.UserProfile;

public interface UserProfileMapper {

	public UserProfile getUserProfileById(Integer id);

	public void createUserProfile(UserProfile userProfile);

	public void updateUserProfile(UserProfile userProfile);

	public void deleteProfile(Integer id);
}
