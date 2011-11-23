package its.me.baby.controller;

import its.me.baby.dto.AuthUser;
import its.me.baby.mapper.UserMasterMapper;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
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
		modelAndView.addObject("authUser", new AuthUser());
		modelAndView.setViewName("login");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "login", method= RequestMethod.POST)
	public ModelAndView login(@Valid AuthUser userGetter, BindingResult result, HttpServletRequest request) {
	
		if (result.hasErrors()) {
			ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("userGetter", new AuthUser());
			modelAndView.setViewName("login");
			return modelAndView;
		}
		AuthUser authUser = userMasterMapper.getAuthUserByEmailAndCryptoPassword(userGetter.getEmail(), userGetter.getCryptoPassword());
		if (authUser == null) {
			ModelAndView modelAndView = new ModelAndView();
			result.rejectValue("email", "error.login.failed");
			modelAndView.addObject("userGetter", userGetter);
			modelAndView.setViewName("login");
			return modelAndView;
		}

		request.getSession(true).setAttribute(AuthUser.class.getName(), authUser);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("forward:edit");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "logout", method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView logout(HttpServletRequest request) {

		HttpSession session = request.getSession(false);
		if (session != null) session.invalidate();

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("top");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "create", method = RequestMethod.GET)
	public ModelAndView create(HttpServletRequest request) {

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("authUser", new AuthUser());
		modelAndView.setViewName("create");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "create", method = RequestMethod.POST)
	public ModelAndView create(@Valid AuthUser authUser, BindingResult result, HttpServletRequest request) {
System.out.println("authuser="+authUser.getEmail());
		if (result.hasErrors()) {
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("authUser", authUser);
			modelAndView.setViewName("create");
			return modelAndView;
		}
		if (userMasterMapper.countUserByEmail(authUser.getEmail(), null) != 0) {
			result.rejectValue("email", "error.email.exists");
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("authUser", authUser);
			modelAndView.setViewName("create");
			return modelAndView;
		}

		authUser.setId(userMasterMapper.newId());
		userMasterMapper.createUser(authUser);

		authUser = userMasterMapper.getAuthUserByEmailAndCryptoPassword(authUser.getEmail(), authUser.getCryptoPassword());
		request.getSession(true).setAttribute(AuthUser.class.getName(), authUser);

		request.setAttribute("created", "true");

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("forward:edit");
		return modelAndView;
	}

}
