package its.me.baby.mapper;

import its.me.baby.dto.User;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface UserMapper {

	public int newId();

	public User getUserById(@Param("id") Integer id);

	public User getUserByEmailAndCryptoPassword(@Param("email") String email, @Param("cryptoPassword") String cryptoPassword);

	public int countUserByEmail(String email);

	public void saveUser(User user);

	public void updateUser(User user);

	public List<User> list();
}
