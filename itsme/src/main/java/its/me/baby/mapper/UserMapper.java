package its.me.baby.mapper;

import its.me.baby.dto.User;
import its.me.baby.dto.UserGetter;

import java.util.List;

public interface UserMapper {

	public int newId();

	public User getUserById(UserGetter userGetter);

	public User getUserByEmail(UserGetter userGetter);

	public int countUserByEmail(String email);

	public void saveUser(User user);

	public List<User> list();
}
