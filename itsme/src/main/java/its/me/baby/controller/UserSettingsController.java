package its.me.baby.controller;

import its.me.baby.dto.AuthUser;
import its.me.baby.dto.UserProfile;
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
	@RequestMapping(value = "updateAccount", method = RequestMethod.POST)
	public ModelAndView updateAccount(@Valid AuthUser authUser, BindingResult result, HttpServletRequest request) {

		/* TODO
		User authUser = (User)request.getSession(false).getAttribute("authUser");
		if (!authUser.getId().equals(user.getId())) throw new IllegalRequestException();
		*/

		if (result.hasErrors()) {
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("user", authUser);
			modelAndView.setViewName("user/edit");
			return modelAndView;
		}
		if (!authUser.validForEditingAccount()) {
			ModelAndView modelAndView = new ModelAndView();
			Map<String, String> rejectValueMap = authUser.getRejectValueMap();
			for (Map.Entry<String, String> entry : rejectValueMap.entrySet()) {
				result.rejectValue(entry.getKey(), entry.getValue());
			}
			modelAndView.addObject("authUser", authUser);
			modelAndView.setViewName("user/edit");
			return modelAndView;
		}
		if (userMasterMapper.countUserByEmail(authUser.getEmail(), authUser.getId()) != 0) {
			result.rejectValue("email", "error.email.exists");
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("authUser", authUser);
			modelAndView.setViewName("user/edit");
			return modelAndView;
		}

		userMasterMapper.updateAccount(authUser.getId(), authUser.getEmail());

		authUser = userMasterMapper.getAuthUserByEmailAndCryptoPassword(authUser.getEmail(), authUser.getCryptoPassword());
		request.getSession(false).setAttribute(AuthUser.class.getName(), authUser);

		request.setAttribute("updated", "account");

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("forward:edit");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "updatePassword", method = RequestMethod.POST)
	public ModelAndView updatePassword(@Valid AuthUser authUser, BindingResult result, HttpServletRequest request) {

		if (result.hasErrors()) {
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("authUser", authUser);
			modelAndView.setViewName("user/edit");
			return modelAndView;
		}
		if (!authUser.validForEditingPassword()) {
			ModelAndView modelAndView = new ModelAndView();
			Map<String, String> rejectValueMap = authUser.getRejectValueMap();
			for (Map.Entry<String, String> entry : rejectValueMap.entrySet()) {
				result.rejectValue(entry.getKey(), entry.getValue());
			}
			modelAndView.addObject("authUser", authUser);
			modelAndView.setViewName("user/edit");
			return modelAndView;
		}

		userMasterMapper.updatePassword(authUser.getId(), authUser.getCryptoPassword());

		authUser = userMasterMapper.getAuthUserByEmailAndCryptoPassword(authUser.getEmail(), authUser.getCryptoPassword());
		request.getSession(false).setAttribute(AuthUser.class.getName(), authUser);

		request.setAttribute("updated", "password");

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("forward:edit");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "updateProfile", method = RequestMethod.POST)
	public ModelAndView updateProfile(@Valid AuthUser authUser, BindingResult result, HttpServletRequest request) {

		if (result.hasErrors()) {
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("authUser", authUser);
			modelAndView.setViewName("user/edit");
			return modelAndView;
		}
		if (!authUser.validForEditingProfile()) {
			ModelAndView modelAndView = new ModelAndView();
			Map<String, String> rejectValueMap = authUser.getRejectValueMap();
			for (Map.Entry<String, String> entry : rejectValueMap.entrySet()) {
				result.rejectValue(entry.getKey(), entry.getValue());
			}
			modelAndView.addObject("authUser", authUser);
			modelAndView.setViewName("user/edit");
			return modelAndView;
		}

		userProfileMapper.updateUserProfile(authUser.getProfile());

		authUser = userMasterMapper.getAuthUserByEmailAndCryptoPassword(authUser.getEmail(), authUser.getCryptoPassword());
		request.getSession(false).setAttribute(AuthUser.class.getName(), authUser);

		request.setAttribute("updated", "profile");

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("forward:edit");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "disconnect", method = RequestMethod.POST)
	public ModelAndView disconnect(@RequestParam String provider, HttpServletRequest request) {
		
		AuthUser authUser = (AuthUser)request.getSession(false).getAttribute(AuthUser.class.getName());

		ConnectionRepository connectionRepository = usersConnectionRepository.createConnectionRepository(authUser.getId().toString());
		if (provider.equals("facebook")) {
			Connection connection = connectionRepository.findPrimaryConnection(Facebook.class);
			if (connection != null) connectionRepository.removeConnection(connection.getKey());
		} else if (provider.equals("twitter")) {
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

		AuthUser authUser = (AuthUser)request.getSession(false).getAttribute(AuthUser.class.getName());

		UserProfile userProfile = userProfileMapper.getUserProfileById(authUser.getId());
		authUser.setProfile(userProfile);

		ConnectionRepository connectionRepository = usersConnectionRepository.createConnectionRepository(authUser.getId().toString());
		boolean facebookConnected = (connectionRepository.findPrimaryConnection(Facebook.class) != null) ? true : false;
		boolean twitterConnected = (connectionRepository.findPrimaryConnection(Twitter.class) != null) ? true : false;

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("authUser", authUser);
		modelAndView.addObject("facebookConnected", facebookConnected);
		modelAndView.addObject("twitterConnected", twitterConnected);
		modelAndView.setViewName("user/edit");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "delete", method = RequestMethod.POST)
	public ModelAndView delete(@RequestParam Integer id) {

		userMasterMapper.deleteUser(id);

		ConnectionRepository connectionRepository = usersConnectionRepository.createConnectionRepository(id.toString());
		Connection connection = connectionRepository.findPrimaryConnection(Facebook.class);
		if (connection != null) connectionRepository.removeConnection(connection.getKey());
		connection = connectionRepository.findPrimaryConnection(Twitter.class);
		if (connection != null) connectionRepository.removeConnection(connection.getKey());

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("forward:logout");
		return modelAndView;
		
	}
}
