package its.me.baby.mapper;

import its.me.baby.dto.User;

public interface UserMapper {

	public int newId();

	public User getUserById(int userId, String cryptoPassword);

	public User getUserByEamil(String email, String cryptoPassword);

	public int countUserByEamil(String email);

	public void saveUser(User user);
}
