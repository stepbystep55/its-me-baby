package its.me.baby.mapper;

import its.me.baby.dto.UserProfile;

import java.util.List;

public interface UserProfileMapper {

	public UserProfile getUserProfileById(Integer id);

	public List<UserProfile> listUserProfile();

	public void createUserProfile(UserProfile userProfile);

	public void updateUserProfile(UserProfile userProfile);

	public void deleteProfile(Integer id);
}
