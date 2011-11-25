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
import org.springframework.web.bind.annotation.RequestParam;
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

/*
	@ModelAttribute
	public User setUpForm(){
		return new User();
	}
*/

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "update", params = {"updateAccount"}, method = RequestMethod.POST)
	public ModelAndView updateAccount(@Valid User user, BindingResult result, HttpServletRequest request) throws IllegalRequestException {

		User authUser = (User)request.getSession(false).getAttribute(User.SESSION_KEY_AUTH);
		if (!authUser.getId().equals(user.getId())) throw new IllegalRequestException();

		if (result.hasErrors()) {
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("user", user);
			modelAndView.setViewName("user/edit");
			return modelAndView;
		}
		if (!user.validForEditingAccount()) {
			Map<String, String> rejectValueMap = user.getRejectValueMap();
			for (Map.Entry<String, String> entry : rejectValueMap.entrySet()) {
				result.rejectValue(entry.getKey(), entry.getValue());
			}
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("user", user);
			modelAndView.setViewName("user/edit");
			return modelAndView;
		}
		if (userMasterMapper.countUserByEmail(user.getEmail(), user.getId()) != 0) {
			result.rejectValue("email", "error.email.exists");
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("user", user);
			modelAndView.setViewName("user/edit");
			return modelAndView;
		}

		userMasterMapper.updateAccount(user.getId(), user.getEmail());

		request.getSession(false).setAttribute(User.SESSION_KEY_AUTH, userMasterMapper.getAuthUserById(user.getId()));

		request.setAttribute("updated", "account");

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("forward:edit");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "update", params = {"updatePassword"}, method = RequestMethod.POST)
	public ModelAndView updatePassword(@Valid User user, BindingResult result, HttpServletRequest request) throws IllegalRequestException {

		User authUser = (User)request.getSession(false).getAttribute(User.SESSION_KEY_AUTH);
		if (!authUser.getId().equals(user.getId())) throw new IllegalRequestException();
		
		if (result.hasErrors()) {
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("user", user);
			modelAndView.setViewName("user/edit");
			return modelAndView;
		}
		if (!user.validForEditingPassword()) {
			Map<String, String> rejectValueMap = user.getRejectValueMap();
			for (Map.Entry<String, String> entry : rejectValueMap.entrySet()) {
				result.rejectValue(entry.getKey(), entry.getValue());
			}
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("user", user);
			modelAndView.setViewName("user/edit");
			return modelAndView;
		}

		userMasterMapper.updatePassword(user.getId(), user.getCryptoPassword());

		request.getSession(false).setAttribute(User.SESSION_KEY_AUTH, userMasterMapper.getAuthUserById(user.getId()));

		request.setAttribute("updated", "password");

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("forward:edit");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "update", params = {"updateProfile"}, method = RequestMethod.POST)
	public ModelAndView updateProfile(@Valid User user, BindingResult result, HttpServletRequest request) throws IllegalRequestException {
System.out.println("updateProfile");
		User authUser = (User)request.getSession(false).getAttribute(User.SESSION_KEY_AUTH);
		if (!authUser.getId().equals(user.getId())) throw new IllegalRequestException();

		if (result.hasErrors()) {
System.out.println("result="+result);
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("user", user);
			modelAndView.setViewName("user/edit");
			return modelAndView;
		}

		UserProfile userProfile = user.getUserProfile();
		if (!userProfile.validForEditingProfile()) {
			Map<String, String> rejectValueMap = userProfile.getRejectValueMap();
			for (Map.Entry<String, String> entry : rejectValueMap.entrySet()) {
				result.rejectValue(entry.getKey(), entry.getValue());
			}
System.out.println("result="+result);
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("user", user);
			modelAndView.setViewName("user/edit");
			return modelAndView;
		}

		userProfileMapper.updateUserProfile(userProfile);

		request.setAttribute("updated", "profile");

		ModelAndView modelAndView = new ModelAndView();
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
System.out.println("user="+user);
		ConnectionRepository connectionRepository = usersConnectionRepository.createConnectionRepository(user.getId().toString());
		boolean facebookConnected = (connectionRepository.findPrimaryConnection(Facebook.class) != null) ? true : false;
		boolean twitterConnected = (connectionRepository.findPrimaryConnection(Twitter.class) != null) ? true : false;

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("user", user);
		modelAndView.addObject("facebookConnected", facebookConnected);
		modelAndView.addObject("twitterConnected", twitterConnected);
		modelAndView.setViewName("user/edit");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "update", params = {"delete"}, method = RequestMethod.POST)
	public ModelAndView delete(@Valid User user, HttpServletRequest request) throws IllegalRequestException {

		User authUser = (User)request.getSession(false).getAttribute(User.SESSION_KEY_AUTH);
		if (!authUser.getId().equals(user.getId())) throw new IllegalRequestException();

		userProfileMapper.deleteProfile(user.getId());
		userMasterMapper.deleteUser(user.getId());

		ConnectionRepository connectionRepository = usersConnectionRepository.createConnectionRepository(user.getId().toString());
		Connection connection = connectionRepository.findPrimaryConnection(Facebook.class);
		if (connection != null) connectionRepository.removeConnection(connection.getKey());
		connection = connectionRepository.findPrimaryConnection(Twitter.class);
		if (connection != null) connectionRepository.removeConnection(connection.getKey());

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("forward:logout");
		return modelAndView;
		
	}
}
