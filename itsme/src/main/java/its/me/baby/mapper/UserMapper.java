package its.me.baby.mapper;

import its.me.baby.dto.User;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface UserMapper {

	public int newId();

	public User getUserById(Integer id);

	public User getUserByEmailAndCryptoPassword(@Param("email") String email, @Param("cryptoPassword") String cryptoPassword);

	public int countUserByEmail(@Param("email") String email, @Param("omittedId") Integer omittedId);

	public void saveUser(User user);

	public void updateUser(User user);

	public List<User> list();
}
