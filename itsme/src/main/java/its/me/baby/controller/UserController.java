package its.me.baby.controller;

import its.me.baby.dto.User;
import its.me.baby.dto.UserGetter;
import its.me.baby.mapper.UserMapper;

import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class UserController {
	
	@Autowired
	private UserMapper userMapper;

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
/*
	@ModelAttribute
	public User setUpForm(){
		return new User();
	}
*/
	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(method = RequestMethod.GET)
	public ModelAndView top() {

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("userGetter", new UserGetter());
		modelAndView.setViewName("user/top");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(method = RequestMethod.POST)
	public ModelAndView create() {

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("user", new User());
		modelAndView.setViewName("user/create");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(method = RequestMethod.POST)
	public ModelAndView save(@Valid User user, BindingResult result) {

		if (result.hasErrors()) {
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("user", user);
			modelAndView.setViewName("user/create");
			return modelAndView;
		}
		if (userMapper.countUserByEmail(user.getEmail()) != 0) {
			result.rejectValue("email", "error.email.exists", new String[] {}, "");
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("user", user);
			modelAndView.setViewName("user/create");
			return modelAndView;
		}

		user.setId(userMapper.newId());
		userMapper.saveUser(user);

		user = userMapper.getUserById(user.getId());

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("user", user);
		modelAndView.addObject("resultCreated", true);
		modelAndView.setViewName("user/view");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(method = RequestMethod.POST)
	public ModelAndView update(@Valid User user, BindingResult result) {

		if (result.hasErrors()) {
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("user", user);
			modelAndView.setViewName("user/edit");
			return modelAndView;
		}
		if (userMapper.countUserByEmail(user.getEmail()) != 0) {
			result.rejectValue("email", "email.exists", new String[] {}, "");
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("user", user);
			modelAndView.setViewName("user/edit");
			return modelAndView;
		}

		userMapper.updateUser(user);

		user = userMapper.getUserById(user.getId());

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("user", user);
		modelAndView.addObject("resultUpdated", true);
		modelAndView.setViewName("user/view");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView login(@Valid UserGetter userGetter, BindingResult result) {

		if (result.hasErrors()) {
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("userGetter", userGetter);
			modelAndView.setViewName("user/top");
			return modelAndView;
		}

		User user = userMapper.getUserByEmailAndCryptoPassword(userGetter.getEmail(), userGetter.getCryptoPassword());

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("user", user);
		modelAndView.setViewName("user/view");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "/user/view/{id}", method={RequestMethod.GET})
	public ModelAndView view(@PathVariable Integer id) {

		User user = userMapper.getUserById(id);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("user", user);
		modelAndView.setViewName("user/view");
		return modelAndView;
	}
}
