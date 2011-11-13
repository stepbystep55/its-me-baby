package its.me.baby.controller;

import its.me.baby.dto.User;
import its.me.baby.mapper.UserMapper;

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
	private UserMapper userMapper;

/*
	@ModelAttribute
	public User setUpForm(){
		return new User();
	}
*/

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "updateAccount", method = RequestMethod.POST)
	public ModelAndView updateAccount(@Valid User user, BindingResult result, HttpServletRequest request) {

		/* TODO
		User userInSession = (User)request.getSession(false).getAttribute("authUser");
		if (!userInSession.getId().equals(user.getId())) throw new IllegalRequestException();
		*/

		if (result.hasErrors()) {
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("user", user);
			modelAndView.setViewName("user/edit");
			return modelAndView;
		}
		if (!user.validForEditingAccount()) {
			ModelAndView modelAndView = new ModelAndView();
			Map<String, String> rejectValueMap = user.getRejectValueMap();
			for (Map.Entry<String, String> entry : rejectValueMap.entrySet()) {
				result.rejectValue(entry.getKey(), entry.getValue());
			}
			modelAndView.addObject("user", user);
			modelAndView.setViewName("user/edit");
			return modelAndView;
		}
		if (userMapper.countUserByEmail(user.getEmail(), user.getId()) != 0) {
			result.rejectValue("email", "error.email.exists");
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("user", user);
			modelAndView.setViewName("user/edit");
			return modelAndView;
		}

		userMapper.updateAccount(user.getId(), user.getName(), user.getEmail());

		user = userMapper.getUserById(user.getId());

		request.getSession(false).setAttribute("authUser", user);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("resultUpdated", true);
		modelAndView.setViewName("forward:edit");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "updatePassword", method = RequestMethod.POST)
	public ModelAndView updatePassword(@Valid User user, BindingResult result, HttpServletRequest request) {

		if (result.hasErrors()) {
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("user", user);
			modelAndView.setViewName("user/edit");
			return modelAndView;
		}
		if (!user.validForEditingPassword()) {
			ModelAndView modelAndView = new ModelAndView();
			Map<String, String> rejectValueMap = user.getRejectValueMap();
			for (Map.Entry<String, String> entry : rejectValueMap.entrySet()) {
				result.rejectValue(entry.getKey(), entry.getValue());
			}
			modelAndView.addObject("user", user);
			modelAndView.setViewName("user/edit");
			return modelAndView;
		}

		userMapper.updatePassword(user.getId(), user.getCryptoPassword());

		user = userMapper.getUserById(user.getId());

		request.getSession(false).setAttribute("authUser", user);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("resultUpdated", true);
		modelAndView.setViewName("forward:edit");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "updateProfile", method = RequestMethod.POST)
	public ModelAndView updateProfile(@Valid User user, BindingResult result, HttpServletRequest request) {

		if (result.hasErrors()) {
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("user", user);
			modelAndView.setViewName("user/edit");
			return modelAndView;
		}
		if (!user.validForEditingProfile()) {
			ModelAndView modelAndView = new ModelAndView();
			Map<String, String> rejectValueMap = user.getRejectValueMap();
			for (Map.Entry<String, String> entry : rejectValueMap.entrySet()) {
				result.rejectValue(entry.getKey(), entry.getValue());
			}
			modelAndView.addObject("user", user);
			modelAndView.setViewName("user/edit");
			return modelAndView;
		}

		userMapper.updateProfile(user.getId(), user.getProfile());

		user = userMapper.getUserById(user.getId());

		request.getSession(false).setAttribute("authUser", user);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("resultUpdated", true);
		modelAndView.setViewName("forward:edit");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "disconnect", method = RequestMethod.POST)
	public ModelAndView disconnect(@RequestParam String provider, HttpServletRequest request) {
		
		User user = (User)request.getSession(false).getAttribute("authUser");

		ConnectionRepository connectionRepository = usersConnectionRepository.createConnectionRepository(user.getId().toString());
		if (provider.equals("facebook")) {
			Connection connection = connectionRepository.findPrimaryConnection(Facebook.class);
			if (connection != null) connectionRepository.removeConnection(connection.getKey());
		} else if (provider.equals("twitter")) {
			Connection connection = connectionRepository.findPrimaryConnection(Twitter.class);
			if (connection != null) connectionRepository.removeConnection(connection.getKey());
		}

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("resultUpdated", true);
		modelAndView.setViewName("forward:edit");
		return modelAndView;
	}
	
	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "edit", method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView edit(HttpServletRequest request) {

		User user = (User)request.getSession(false).getAttribute("authUser");

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
	@RequestMapping(value = "delete", method = RequestMethod.POST)
	public ModelAndView delete(@RequestParam Integer id) {

		userMapper.delete(id);

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
