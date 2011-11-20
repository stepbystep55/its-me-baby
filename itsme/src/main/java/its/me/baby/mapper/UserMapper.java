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

	public void updateAccount(@Param("id") Integer id, @Param("email") String email);

	public void updatePassword(@Param("id") Integer id, @Param("cryptoPassword") String cryptoPassword);

	public void updateProfile(User user);

	public void delete(Integer id);

	public List<User> list();
}
