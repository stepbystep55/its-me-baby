package its.me.baby.controller;

import its.me.baby.dto.User;
import its.me.baby.dto.UserProfile;
import its.me.baby.dto.UserSticky;
import its.me.baby.exception.IllegalRequestException;
import its.me.baby.exception.InvalidInputException;
import its.me.baby.mapper.UserMasterMapper;
import its.me.baby.mapper.UserProfileMapper;
import its.me.baby.mapper.UserStickyMapper;
import its.me.baby.util.UserCookieGenerator;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import org.springframework.web.bind.annotation.ResponseBody;
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

	@Autowired
	private UserStickyMapper userStickyMapper;

	private UserCookieGenerator userCookieGenerator = new UserCookieGenerator();

/*
	@ModelAttribute
	public User setUpForm(){
		return new User();
	}
*/

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "edit", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView edit() throws IllegalRequestException {

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("activeTab", "profile");
		modelAndView.setViewName("user/edit");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "updateAccount", method = RequestMethod.GET)
	public ModelAndView updateAccount(HttpServletRequest request) throws IllegalRequestException {

		User user = userMasterMapper.getUserById(userCookieGenerator.getUserId(request));
		if (user == null) throw new IllegalRequestException();

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("user", user);
		modelAndView.setViewName("user/editAccount");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "updateAccount", params = {"update"}, method = RequestMethod.POST)
	public ModelAndView updateAccount(
			@Valid User user, BindingResult result, HttpServletRequest request) throws IllegalRequestException {

		if (!userCookieGenerator.getUserId(request).equals(user.getId())) throw new IllegalRequestException();

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

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("activeTab", "account");
		modelAndView.addObject("updated", true);
		modelAndView.setViewName("user/edit");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "updateAccount", params = {"delete"}, method = RequestMethod.POST)
	public ModelAndView deleteAccount(@Valid User user, HttpServletRequest request) throws IllegalRequestException {

		Integer authUserId = userCookieGenerator.getUserId(request);
		if (!authUserId.equals(user.getId())) throw new IllegalRequestException();

		userProfileMapper.deleteProfile(authUserId);
		userMasterMapper.deleteUser(authUserId);

		ConnectionRepository connectionRepository = usersConnectionRepository.createConnectionRepository(authUserId.toString());
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

		User user = userMasterMapper.getUserById(userCookieGenerator.getUserId(request));
		if (user == null) throw new IllegalRequestException();

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("user", user);
		modelAndView.setViewName("user/editPassword");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "updatePassword", method = RequestMethod.POST)
	public ModelAndView updatePassword(
			@Valid User user, BindingResult result, HttpServletRequest request) throws IllegalRequestException {

		if (!userCookieGenerator.getUserId(request).equals(user.getId())) throw new IllegalRequestException();

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

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("activeTab", "password");
		modelAndView.addObject("updated", true);
		modelAndView.setViewName("user/edit");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "updateProfile", method = RequestMethod.GET)
	public ModelAndView updateProfile(HttpServletRequest request) throws IllegalRequestException {

		UserProfile userProfile = userProfileMapper.getUserProfileById(userCookieGenerator.getUserId(request));
		if (userProfile == null) throw new IllegalRequestException();

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("userProfile", userProfile);
		modelAndView.setViewName("user/editProfile");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "updateProfile", method = RequestMethod.POST)
	public ModelAndView updateProfile(
			@Valid UserProfile userProfile, BindingResult result, HttpServletRequest request) throws IllegalRequestException {

		if (!userCookieGenerator.getUserId(request).equals(userProfile.getUserId())) throw new IllegalRequestException();

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
	
		userProfileMapper.updateUserProfile(userProfile);
	
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("activeTab", "profile");
		modelAndView.addObject("updated", true);
		modelAndView.setViewName("user/edit");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "updateSocial", method = RequestMethod.GET)
	public ModelAndView updateSocial(HttpServletRequest request) throws IllegalRequestException {

		Integer authUserId = userCookieGenerator.getUserId(request);

		ConnectionRepository connectionRepository = usersConnectionRepository.createConnectionRepository(authUserId.toString());
		boolean facebookConnected = ((connectionRepository.findPrimaryConnection(Facebook.class)) != null);
		boolean twitterConnected = ((connectionRepository.findPrimaryConnection(Twitter.class)) != null);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("facebookConnected", facebookConnected);
		modelAndView.addObject("twitterConnected", twitterConnected);
		modelAndView.setViewName("user/editSocial");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "afterConnect", method = RequestMethod.GET)
	public ModelAndView afterConnect() throws IllegalRequestException {

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("activeTab", "social");
		modelAndView.addObject("updated", true);
		modelAndView.setViewName("user/edit");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "disconnect", method = RequestMethod.POST)
	public ModelAndView disconnect(HttpServletRequest request) throws IllegalRequestException {

		Integer authUserId = userCookieGenerator.getUserId(request);

		ConnectionRepository connectionRepository = usersConnectionRepository.createConnectionRepository(authUserId.toString());
		if (request.getParameter("disconnectFacebook") != null) {
			Connection connection = connectionRepository.findPrimaryConnection(Facebook.class);
			if (connection != null) connectionRepository.removeConnection(connection.getKey());
		}
		if (request.getParameter("disconnectTwitter") != null) {
			Connection connection = connectionRepository.findPrimaryConnection(Twitter.class);
			if (connection != null) connectionRepository.removeConnection(connection.getKey());
		}
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("activeTab", "social");
		modelAndView.addObject("updated", true);
		modelAndView.setViewName("user/edit");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "newMyPage", method={RequestMethod.GET})
	public ModelAndView newMyPage(HttpServletRequest request) throws IllegalRequestException {
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("created", true);
		modelAndView.setViewName("forward:gotoMyPage");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "gotoMyPage", method={RequestMethod.GET})
	public ModelAndView gotoMyPage(HttpServletRequest request) throws IllegalRequestException {

		Integer authUserId = userCookieGenerator.getUserId(request);

		UserProfile userProfile = userProfileMapper.getUserProfileById(authUserId);
		if (userProfile == null) throw new IllegalRequestException();

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("userProfileDisplay", userProfile);
		modelAndView.addObject("userProfile", userProfile);
		modelAndView.addObject("userStickyList", userStickyMapper.listByUserId(authUserId));
		modelAndView.addObject("editMode", true);
		modelAndView.setViewName("user/mypage");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "updateMyPage", method={RequestMethod.POST})
	public ModelAndView updateMyPage(
		@Valid UserProfile userProfile, BindingResult result, HttpServletRequest request) throws IllegalRequestException {

		Integer authUserId = userCookieGenerator.getUserId(request);
		if (!authUserId.equals(userProfile.getUserId())) throw new IllegalRequestException();
	
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
			modelAndView.addObject("userProfileDisplay", userProfileMapper.getUserProfileById(authUserId));
			modelAndView.addObject("userProfile", userProfile);
		modelAndView.addObject("userStickyList", userStickyMapper.listByUserId(authUserId));
			modelAndView.addObject("editMode", true);
			modelAndView.setViewName("user/show");
			return modelAndView;
		}
	
		userProfileMapper.updateUserProfile(userProfile);
		userProfile = userProfileMapper.getUserProfileById(authUserId);
	
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("userProfileDisplay", userProfile);
		modelAndView.addObject("userProfile", userProfile);
		modelAndView.addObject("userStickyList", userStickyMapper.listByUserId(authUserId));
		modelAndView.addObject("editMode", true);
		modelAndView.addObject("updated", true);
		modelAndView.setViewName("user/show");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "addSticky", method={RequestMethod.POST})
	public @ResponseBody Map<String, String> addSticky(HttpServletRequest request, HttpServletResponse response) throws IllegalRequestException {
		
		Integer userId = new Integer(request.getParameter("userId"));
		Integer positionTop = new Integer(request.getParameter("positionTop"));
		Integer positionLeft = new Integer(request.getParameter("positionLeft"));
		Integer height = new Integer(request.getParameter("height"));
		Integer width = new Integer(request.getParameter("width"));
		String content = (String)request.getParameter("content");

		System.out.println("content="+content+", pTop="+positionTop+", pLft="+positionLeft);
		UserSticky userSticky = new UserSticky();
		userSticky.setId(userStickyMapper.newId(userId));
		userSticky.setUserId(userId);
		userSticky.setPositionTop(positionTop);
		userSticky.setPositionLeft(positionLeft);
		userSticky.setHeight(height);
		userSticky.setWidth(width);
		userSticky.setContent(content);
		
		userStickyMapper.create(userSticky);

		Map<String, String> map = new HashMap<String, String>(1);
		map.put("msg", "OK");
		return map;
	}
}
