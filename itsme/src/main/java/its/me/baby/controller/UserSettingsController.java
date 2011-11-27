package its.me.baby.controller;

import its.me.baby.dto.User;
import its.me.baby.dto.UserProfile;
import its.me.baby.exception.IllegalRequestException;
import its.me.baby.mapper.UserMasterMapper;
import its.me.baby.mapper.UserProfileMapper;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.social.connect.Connection;
import org.springframework.social.connect.ConnectionRepository;
import org.springframework.social.connect.UsersConnectionRepository;
import org.springframework.social.facebook.api.Facebook;
import org.springframework.social.twitter.api.Twitter;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/")
public class UserSettingsController {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private UsersConnectionRepository usersConnectionRepository;

	@Autowired
	private UserMasterMapper userMasterMapper;

	@Autowired
	private UserProfileMapper userProfileMapper;

	private class InvalidInputException extends Exception {
		private static final long serialVersionUID = -4771506268156706310L;

		public InvalidInputException() {
			super();
		}
	}

/*
	@ModelAttribute
	public User setUpForm(){
		return new User();
	}
*/

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "updateAccount", method = RequestMethod.GET)
	public ModelAndView updateAccount(HttpServletRequest request) throws IllegalRequestException {

		User authUser = (User)request.getSession(false).getAttribute(User.SESSION_KEY_AUTH);
		User user = userMasterMapper.getUserById(authUser.getId());

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("user", user);
		modelAndView.setViewName("user/editAccount");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "updateAccount", params = {"update"}, method = RequestMethod.POST)
	public ModelAndView updateAccount(
			@Valid User user, BindingResult result, HttpServletRequest request) throws IllegalRequestException {

		User authUser = (User)request.getSession(false).getAttribute(User.SESSION_KEY_AUTH);
		if (!authUser.getId().equals(user.getId())) throw new IllegalRequestException();

		try {
			if (result.hasErrors()) {
				throw new InvalidInputException();
			}
			if (!user.validForEditingAccount()) {
				Map<String, String> rejectValueMap = user.getRejectValueMap();
				for (Map.Entry<String, String> entry : rejectValueMap.entrySet()) {
					result.rejectValue(entry.getKey(), entry.getValue());
				}
				throw new InvalidInputException();
			}
			if (userMasterMapper.countUserByEmail(user.getEmail(), user.getId()) != 0) {
				result.rejectValue("email", "error.email.exists");
				throw new InvalidInputException();
			}
		} catch (InvalidInputException e) {
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("activeTab", "account");
			modelAndView.addObject("user", user);
			modelAndView.setViewName("user/edit");
			return modelAndView;
		}

		userMasterMapper.updateAccount(user.getId(), user.getEmail());

		request.getSession(false).setAttribute(User.SESSION_KEY_AUTH, userMasterMapper.getAuthUserById(user.getId()));

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("activeTab", "account");
		modelAndView.addObject("updated", "true");
		modelAndView.setViewName("forward:edit");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "updateAccount", params = {"delete"}, method = RequestMethod.POST)
	public ModelAndView deleteAccount(
			@Valid User user, HttpServletRequest request) throws IllegalRequestException {

		User authUser = (User)request.getSession(false).getAttribute(User.SESSION_KEY_AUTH);
		if (!authUser.getId().equals(user.getId())) throw new IllegalRequestException();

		userProfileMapper.deleteProfile(authUser.getId());
		userMasterMapper.deleteUser(authUser.getId());

		ConnectionRepository connectionRepository = usersConnectionRepository.createConnectionRepository(authUser.getId().toString());
		Connection connection = connectionRepository.findPrimaryConnection(Facebook.class);
		if (connection != null) connectionRepository.removeConnection(connection.getKey());
		connection = connectionRepository.findPrimaryConnection(Twitter.class);
		if (connection != null) connectionRepository.removeConnection(connection.getKey());

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("forward:logout");
		return modelAndView;
		
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "updatePassword", method = RequestMethod.GET)
	public ModelAndView updatePassword(HttpServletRequest request) throws IllegalRequestException {

		User authUser = (User)request.getSession(false).getAttribute(User.SESSION_KEY_AUTH);
		User user = userMasterMapper.getUserById(authUser.getId());

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("user", user);
		modelAndView.setViewName("user/editPassword");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "updatePassword", method = RequestMethod.POST)
	public ModelAndView updatePassword(
			@Valid User user, BindingResult result, HttpServletRequest request) throws IllegalRequestException {

		User authUser = (User)request.getSession(false).getAttribute(User.SESSION_KEY_AUTH);
		if (!authUser.getId().equals(user.getId())) throw new IllegalRequestException();

		try {
			if (result.hasErrors()) {
				throw new InvalidInputException();
			}
			if (!user.validForEditingPassword()) {
				Map<String, String> rejectValueMap = user.getRejectValueMap();
				for (Map.Entry<String, String> entry : rejectValueMap.entrySet()) {
					result.rejectValue(entry.getKey(), entry.getValue());
				}
				throw new InvalidInputException();
			}
		} catch (InvalidInputException e) {
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("activeTab", "password");
			modelAndView.addObject("user", user);
			modelAndView.setViewName("user/edit");
			return modelAndView;
		}
	
		userMasterMapper.updatePassword(user.getId(), user.getCryptoPassword());

		request.getSession(false).setAttribute(User.SESSION_KEY_AUTH, userMasterMapper.getAuthUserById(user.getId()));

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("activeTab", "password");
		modelAndView.addObject("updated", "true");
		modelAndView.setViewName("forward:edit");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "updateProfile", method = RequestMethod.GET)
	public ModelAndView updateProfile(HttpServletRequest request) throws IllegalRequestException {

		User authUser = (User)request.getSession(false).getAttribute(User.SESSION_KEY_AUTH);
		UserProfile userProfile = userProfileMapper.getUserProfileById(authUser.getId());
		if (userProfile == null) {
			userProfile = new UserProfile();
			userProfile.setUserId(authUser.getId());
		}

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("userProfile", userProfile);
		modelAndView.setViewName("user/editProfile");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "updateProfile", method = RequestMethod.POST)
	public ModelAndView updateProfile(
			@Valid UserProfile userProfile, BindingResult result, HttpServletRequest request) throws IllegalRequestException {

		User authUser = (User)request.getSession(false).getAttribute(User.SESSION_KEY_AUTH);
		if (!authUser.getId().equals(userProfile.getUserId())) throw new IllegalRequestException();

		try {
			if (result.hasErrors()) {
				throw new InvalidInputException();
			}
			if (!userProfile.validForEditingProfile()) {
				Map<String, String> rejectValueMap = userProfile.getRejectValueMap();
				for (Map.Entry<String, String> entry : rejectValueMap.entrySet()) {
					result.rejectValue(entry.getKey(), entry.getValue());
				}
				throw new InvalidInputException();
			}
		} catch (InvalidInputException e) {
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("activeTab", "profile");
			modelAndView.addObject("userProfile", userProfile);
			modelAndView.setViewName("user/editProfile");
			return modelAndView;
		}
	
		userProfileMapper.mergeUserProfile(userProfile);
	
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("activeTab", "profile");
		modelAndView.addObject("updated", "true");
		modelAndView.setViewName("forward:edit");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "update", params = {"connectFacebook", "connectTwitter"}, method = RequestMethod.POST)
	public ModelAndView connect(@Valid User user, HttpServletRequest request) throws IllegalRequestException {

		User authUser = (User)request.getSession(false).getAttribute(User.SESSION_KEY_AUTH);
		if (!authUser.getId().equals(user.getId())) throw new IllegalRequestException();

		boolean connectFacebook = (request.getAttribute("connectFacebook") != null);
		boolean connectTwitter = (request.getAttribute("connectTwitter") != null);

		ModelAndView modelAndView = new ModelAndView();
		if (connectFacebook) {
			modelAndView.setViewName("forward:signin/facebook");
		} else if (connectTwitter) {
			modelAndView.setViewName("forward:signin/twitter");
		}
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "update", params = {"disconnectFacebook", "disconnectTwitter"}, method = RequestMethod.POST)
	public ModelAndView disconnect(@Valid User user, HttpServletRequest request) throws IllegalRequestException {
		
		User authUser = (User)request.getSession(false).getAttribute(User.SESSION_KEY_AUTH);
		if (!authUser.getId().equals(user.getId())) throw new IllegalRequestException();

		boolean disconnectFacebook = (request.getAttribute("disconnectFacebook") != null);
		boolean disconnectTwitter = (request.getAttribute("disconnectTwitter") != null);

		ConnectionRepository connectionRepository = usersConnectionRepository.createConnectionRepository(user.getId().toString());
		if (disconnectFacebook) {
			Connection connection = connectionRepository.findPrimaryConnection(Facebook.class);
			if (connection != null) connectionRepository.removeConnection(connection.getKey());
		}
		if (disconnectTwitter) {
			Connection connection = connectionRepository.findPrimaryConnection(Twitter.class);
			if (connection != null) connectionRepository.removeConnection(connection.getKey());
		}
		request.setAttribute("updated", "social");

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("forward:edit");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "edit", method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView edit(HttpServletRequest request) {

		User authUser = (User)request.getSession(false).getAttribute(User.SESSION_KEY_AUTH);

		User user = userMasterMapper.getUserById(authUser.getId());
		ConnectionRepository connectionRepository = usersConnectionRepository.createConnectionRepository(user.getId().toString());
		boolean facebookConnected = (connectionRepository.findPrimaryConnection(Facebook.class) != null) ? true : false;
		boolean twitterConnected = (connectionRepository.findPrimaryConnection(Twitter.class) != null) ? true : false;

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("facebookConnected", facebookConnected);
		modelAndView.addObject("twitterConnected", twitterConnected);
		modelAndView.setViewName("user/edit");
		return modelAndView;
	}
}
