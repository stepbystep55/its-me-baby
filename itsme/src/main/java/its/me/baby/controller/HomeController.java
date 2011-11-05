package its.me.baby.controller;

import its.me.baby.dto.User;
import its.me.baby.dto.UserGetter;
import its.me.baby.mapper.UserMapper;

import javax.servlet.http.HttpServletRequest;
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
	private UserMapper userMapper;

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
		modelAndView.addObject("userGetter", new UserGetter());
		modelAndView.setViewName("login");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "login", method= RequestMethod.POST)
	public ModelAndView login(@Valid UserGetter userGetter, BindingResult result, HttpServletRequest request) {
	
		if (result.hasErrors()) {
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("userGetter", userGetter);
			modelAndView.setViewName("login");
			return modelAndView;
		}
		User user = userMapper.getUserByEmailAndCryptoPassword(userGetter.getEmail(), userGetter.getCryptoPassword());
		if (user == null) {
			ModelAndView modelAndView = new ModelAndView();
			result.rejectValue("email", "error.login.failed");
			modelAndView.addObject("userGetter", userGetter);
			modelAndView.setViewName("login");
			return modelAndView;
		}

		request.getSession(true).setAttribute(User.class.getName(), user);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("forward:edit");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "create", method = RequestMethod.GET)
	public ModelAndView create(HttpServletRequest request) {

		request.getSession(true);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("user", new User());
		modelAndView.setViewName("create");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "save", method = RequestMethod.POST)
	public ModelAndView save(@Valid User user, BindingResult result, HttpServletRequest request) {

		if (result.hasErrors()) {
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("user", user);
			modelAndView.setViewName("create");
			return modelAndView;
		}
		if (userMapper.countUserByEmail(user.getEmail(), null) != 0) {
			result.rejectValue("email", "error.email.exists");
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("user", user);
			modelAndView.setViewName("create");
			return modelAndView;
		}

		user.setId(userMapper.newId());
		userMapper.saveUser(user);

		user = userMapper.getUserById(user.getId());

		request.getSession(false).setAttribute(User.class.getName(), user);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("resultCreated", true);
		modelAndView.setViewName("forward:edit");
		return modelAndView;
	}

}
