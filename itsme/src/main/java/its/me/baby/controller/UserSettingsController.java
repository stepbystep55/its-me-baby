package its.me.baby.controller;

import its.me.baby.dto.AuthUser;
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
	@RequestMapping(value = "updateAccount", method = RequestMethod.POST)
	public ModelAndView updateAccount(
			@Valid AuthUser accountUpdater, BindingResult result, HttpServletRequest request)
					throws IllegalRequestException {

		AuthUser authUser = (AuthUser)request.getSession(false).getAttribute(AuthUser.class.getName());
		if (!authUser.getId().equals(accountUpdater.getId())) throw new IllegalRequestException();

		if (result.hasErrors()) {
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("user", accountUpdater);
			modelAndView.setViewName("user/edit");
			return modelAndView;
		}
		if (!accountUpdater.validForEditingAccount()) {
			Map<String, String> rejectValueMap = accountUpdater.getRejectValueMap();
			for (Map.Entry<String, String> entry : rejectValueMap.entrySet()) {
				result.rejectValue(entry.getKey(), entry.getValue());
			}
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("authUser", accountUpdater);
			modelAndView.setViewName("user/edit");
			return modelAndView;
		}
		if (userMasterMapper.countUserByEmail(accountUpdater.getEmail(), accountUpdater.getId()) != 0) {
			result.rejectValue("email", "error.email.exists");
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("authUser", accountUpdater);
			modelAndView.setViewName("user/edit");
			return modelAndView;
		}

		userMasterMapper.updateAccount(accountUpdater.getId(), accountUpdater.getEmail());

		request.getSession(false).setAttribute(AuthUser.class.getName(), userMasterMapper.getAuthUserById(authUser.getId()));

		request.setAttribute("updated", "account");

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("forward:edit");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "updatePassword", method = RequestMethod.POST)
	public ModelAndView updatePassword(
			@Valid AuthUser passwordUpdater, BindingResult result, HttpServletRequest request)
					throws IllegalRequestException {

		AuthUser authUser = (AuthUser)request.getSession(false).getAttribute(AuthUser.class.getName());
		if (!authUser.getId().equals(passwordUpdater.getId())) throw new IllegalRequestException();
		
		if (result.hasErrors()) {
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("authUser", passwordUpdater);
			modelAndView.setViewName("user/edit");
			return modelAndView;
		}
		if (!passwordUpdater.validForEditingPassword()) {
			Map<String, String> rejectValueMap = passwordUpdater.getRejectValueMap();
			for (Map.Entry<String, String> entry : rejectValueMap.entrySet()) {
				result.rejectValue(entry.getKey(), entry.getValue());
			}
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("authUser", passwordUpdater);
			modelAndView.setViewName("user/edit");
			return modelAndView;
		}

		userMasterMapper.updatePassword(passwordUpdater.getId(), passwordUpdater.getCryptoPassword());

		request.getSession(false).setAttribute(AuthUser.class.getName(), userMasterMapper.getAuthUserById(authUser.getId()));

		request.setAttribute("updated", "password");

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("forward:edit");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "updateProfile", method = RequestMethod.POST)
	public ModelAndView updateProfile(
			@Valid UserProfile userProfile, BindingResult result, HttpServletRequest request)
					throws IllegalRequestException {

		AuthUser authUser = (AuthUser)request.getSession(false).getAttribute(AuthUser.class.getName());
		System.out.println("authid="+authUser.getId()+", reqid="+userProfile.getId());
		if (!authUser.getId().equals(userProfile.getId())) throw new IllegalRequestException();

		if (result.hasErrors()) {
			/*
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("authUser", authUser);
			modelAndView.setViewName("user/edit");
			return modelAndView;
			*/
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.setViewName("forward:edit");
			return modelAndView;
		}
		if (!userProfile.validForEditingProfile()) {
			Map<String, String> rejectValueMap = userProfile.getRejectValueMap();
			for (Map.Entry<String, String> entry : rejectValueMap.entrySet()) {
				result.rejectValue(entry.getKey(), entry.getValue());
			}
			/*
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("authUser", authUser);
			modelAndView.setViewName("user/edit");
			return modelAndView;
			*/
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.setViewName("forward:edit");
			return modelAndView;
		}

		userProfileMapper.updateUserProfile(userProfile);

		request.setAttribute("updated", "profile");

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("forward:edit");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "disconnect", method = RequestMethod.POST)
	public ModelAndView disconnect(
			@RequestParam Integer id, @RequestParam String provider, HttpServletRequest request)
					throws IllegalRequestException {
		
		AuthUser authUser = (AuthUser)request.getSession(false).getAttribute(AuthUser.class.getName());
		if (!authUser.getId().equals(id)) throw new IllegalRequestException();

		ConnectionRepository connectionRepository = usersConnectionRepository.createConnectionRepository(id.toString());
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
		if (userProfile == null) userProfile = authUser.newProfile();

		ConnectionRepository connectionRepository = usersConnectionRepository.createConnectionRepository(authUser.getId().toString());
		boolean facebookConnected = (connectionRepository.findPrimaryConnection(Facebook.class) != null) ? true : false;
		boolean twitterConnected = (connectionRepository.findPrimaryConnection(Twitter.class) != null) ? true : false;

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("authUser", authUser);
		modelAndView.addObject("userProfile", userProfile);
		modelAndView.addObject("facebookConnected", facebookConnected);
		modelAndView.addObject("twitterConnected", twitterConnected);
		modelAndView.setViewName("user/edit");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "delete", method = RequestMethod.POST)
	public ModelAndView delete(
			@RequestParam Integer id, HttpServletRequest request)
					throws IllegalRequestException {

		AuthUser authUser = (AuthUser)request.getSession(false).getAttribute(AuthUser.class.getName());
		if (!authUser.getId().equals(id)) throw new IllegalRequestException();

		userProfileMapper.deleteProfile(id);
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
