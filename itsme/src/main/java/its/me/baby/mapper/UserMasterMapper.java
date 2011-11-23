package its.me.baby.mapper;

import its.me.baby.dto.AuthUser;

import org.apache.ibatis.annotations.Param;

public interface UserMasterMapper {

	public int newId();

	public AuthUser getAuthUserById(Integer id);

	public AuthUser getAuthUserByEmailAndCryptoPassword(@Param("email") String email, @Param("cryptoPassword") String cryptoPassword);

	public int countUserByEmail(@Param("email") String email, @Param("omittedId") Integer omittedId);

	public void createUser(AuthUser authUser);

	public void updateAccount(@Param("id") Integer id, @Param("email") String email);

	public void updatePassword(@Param("id") Integer id, @Param("cryptoPassword") String cryptoPassword);

	public void deleteUser(Integer id);
}
