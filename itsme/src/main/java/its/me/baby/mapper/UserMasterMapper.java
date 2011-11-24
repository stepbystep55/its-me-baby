package its.me.baby.mapper;

import its.me.baby.dto.User;

import org.apache.ibatis.annotations.Param;

public interface UserMasterMapper {

	public int newId();

	public User getUserById(Integer id);

	public User getAuthUserById(Integer id);

	public User getAuthUserByEmailAndCryptoPassword(@Param("email") String email, @Param("cryptoPassword") String cryptoPassword);

	public int countUserByEmail(@Param("email") String email, @Param("omittedId") Integer omittedId);

	public void createUser(User user);

	public void updateAccount(@Param("id") Integer id, @Param("email") String email);

	public void updatePassword(@Param("id") Integer id, @Param("cryptoPassword") String cryptoPassword);

	public void deleteUser(Integer id);
}
