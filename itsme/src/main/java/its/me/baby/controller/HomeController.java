package its.me.baby.controller;

import its.me.baby.dto.User;
import its.me.baby.dto.UserProfile;
import its.me.baby.exception.InvalidInputException;
import its.me.baby.mapper.UserMasterMapper;
import its.me.baby.mapper.UserProfileMapper;
import its.me.baby.util.UserCookieGenerator;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/")
public class HomeController {

	@Autowired
	private UserMasterMapper userMasterMapper;

	@Autowired
	private UserProfileMapper userProfileMapper;

	private UserCookieGenerator userCookieGenerator = new UserCookieGenerator();

	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView top() {

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("top");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "login", method= RequestMethod.GET)
	public ModelAndView login() {

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("user", new User());
		modelAndView.setViewName("login");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "login", method= RequestMethod.POST)
	public ModelAndView login(@Valid User user, BindingResult result, HttpServletResponse response) {

		try {
			if (result.hasErrors()) throw new InvalidInputException();

			User authUser = userMasterMapper.getAuthUserByEmailAndCryptoPassword(user.getEmail(), user.getCryptoPassword());
			if (authUser == null) {
				result.rejectValue("email", "error.login.failed");
				throw new InvalidInputException();
			}
			userCookieGenerator.addUserIdForTemporary(response, authUser.getId());

			ModelAndView modelAndView = new ModelAndView();
			modelAndView.setViewName("redirect:gotoMyPage");
			return modelAndView;

		} catch (InvalidInputException e) {
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("user", user);
			modelAndView.setViewName("login");
			return modelAndView;
		}
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "logout", method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView logout(HttpServletResponse response) {

		userCookieGenerator.removeUserId(response);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "create", method = RequestMethod.GET)
	public ModelAndView create() {

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("user", new User());
		modelAndView.setViewName("create");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "create", method = RequestMethod.POST)
	public ModelAndView create(@Valid User user, BindingResult result, HttpServletResponse response) {

		try {
			if (result.hasErrors()) throw new InvalidInputException();

			if (userMasterMapper.countUserByEmail(user.getEmail(), null) != 0) {
				result.rejectValue("email", "error.email.exists");
				throw new InvalidInputException();
			}
		} catch (InvalidInputException e) {
				ModelAndView modelAndView = new ModelAndView();
				modelAndView.addObject("user", user);
				modelAndView.setViewName("create");
				return modelAndView;
		}

		user.setId(userMasterMapper.newId());
		userMasterMapper.createUser(user);
		UserProfile userProfile = new UserProfile();
		userProfile.setUserId(user.getId());
		userProfile.setName(user.getNameFromEmail());
		userProfileMapper.createUserProfile(userProfile);

		userCookieGenerator.addUserIdForTemporary(response, user.getId());

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:newMyPage");
		return modelAndView;
	}

}
