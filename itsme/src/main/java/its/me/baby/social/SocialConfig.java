package its.me.baby.social;

import its.me.baby.dto.User;

import javax.inject.Inject;
import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.security.crypto.encrypt.Encryptors;
import org.springframework.social.connect.ConnectionFactory;
import org.springframework.social.connect.ConnectionFactoryLocator;
import org.springframework.social.connect.ConnectionRepository;
import org.springframework.social.connect.NotConnectedException;
import org.springframework.social.connect.UsersConnectionRepository;
import org.springframework.social.connect.jdbc.JdbcUsersConnectionRepository;
import org.springframework.social.connect.support.ConnectionFactoryRegistry;
import org.springframework.social.facebook.api.Facebook;
import org.springframework.social.facebook.connect.FacebookConnectionFactory;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

/**
 * Spring Social Configuration.
 */
@Configuration
public class SocialConfig {

	@Value("${facebook.clientId}")
	private String facebookClientId;
	
	@Value("${facebook.clientSecret}")
	private String facebookClientSecret;
	
	@Inject
	private DataSource dataSource;

	/**
	 * When a new provider is added to the app, register its {@link ConnectionFactory} here.
	 * @see FacebookConnectionFactory
	 */
	@Bean
	public ConnectionFactoryLocator connectionFactoryLocator() {
		ConnectionFactoryRegistry registry = new ConnectionFactoryRegistry();
		registry.addConnectionFactory(new FacebookConnectionFactory(facebookClientId, facebookClientSecret));
		return registry;
	}

	/**
	 * Singleton data access object providing access to connections across all users.
	 */
	@Bean
	public UsersConnectionRepository usersConnectionRepository() {
		JdbcUsersConnectionRepository repository = new JdbcUsersConnectionRepository(dataSource,
				connectionFactoryLocator(), Encryptors.noOpText());
		repository.setConnectionSignUp(new ItsmeConnectionSignUp());
		return repository;
	}

	/**
	 * Request-scoped data access object providing access to the current user's connections.
	 */
	/*
	@Bean
	@Scope(value="request", proxyMode=ScopedProxyMode.INTERFACES)
	public ConnectionRepository connectionRepository() {
		User user = (User)RequestContextHolder.getRequestAttributes().getAttribute("its.me.baby.User", RequestAttributes.SCOPE_SESSION);
		return usersConnectionRepository().createConnectionRepository(user.getId().toString());
	}
	*/

	/**
	 * A proxy to a request-scoped object representing the current user's primary Facebook account.
	 * @throws NotConnectedException if the user is not connected to facebook.
	 */
	/*
	@Bean
	@Scope(value="request", proxyMode=ScopedProxyMode.INTERFACES)	
	public Facebook facebook() {
		return connectionRepository().getPrimaryConnection(Facebook.class).getApi();
	}
	*/
}