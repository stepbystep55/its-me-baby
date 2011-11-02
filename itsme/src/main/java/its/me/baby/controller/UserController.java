package its.me.baby.controller;

import its.me.baby.dto.User;
import its.me.baby.dto.UserGetter;
import its.me.baby.mapper.UserMapper;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.social.connect.ConnectionRepository;
import org.springframework.social.connect.UsersConnectionRepository;
import org.springframework.social.facebook.api.Facebook;
import org.springframework.social.facebook.api.Post;
import org.springframework.social.twitter.api.Tweet;
import org.springframework.social.twitter.api.Twitter;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("user")
public class UserController {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
/*
	private final Facebook facebook;

	@Inject
	public UserController(Facebook facebook) {
		this.facebook = facebook;
	}
	*/
	
	@Autowired
	private UsersConnectionRepository usersConnectionRepository;
/*
	@Inject
	public UserController(UsersConnectionRepository usersConnectionRepository) {
		this.usersConnectionRepository = usersConnectionRepository;
	}
*/

	@Autowired
	private UserMapper userMapper;

/*
	@ModelAttribute
	public User setUpForm(){
		return new User();
	}
*/
	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView top() {

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("userGetter", new UserGetter());
		modelAndView.setViewName("user/top");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "create", method = RequestMethod.POST)
	public ModelAndView create(HttpServletRequest request) {

		request.getSession(true);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("user", new User());
		modelAndView.setViewName("user/create");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "save", method = RequestMethod.POST)
	public ModelAndView save(@Valid User user, BindingResult result, HttpServletRequest request) {

		if (result.hasErrors()) {
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("user", user);
			modelAndView.setViewName("user/create");
			return modelAndView;
		}
		if (userMapper.countUserByEmail(user.getEmail()) != 0) {
			result.rejectValue("email", "error.email.exists");
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("user", user);
			modelAndView.setViewName("user/create");
			return modelAndView;
		}

		user.setId(userMapper.newId());
		userMapper.saveUser(user);

		user = userMapper.getUserById(user.getId());

		request.getSession(false).setAttribute("its.me.baby.User", user);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("user", user);
		modelAndView.addObject("resultCreated", true);
		modelAndView.setViewName("user/edit");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "update", method = RequestMethod.POST)
	public ModelAndView update(@Valid User user, BindingResult result, HttpServletRequest request) {

		if (result.hasErrors()) {
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("user", user);
			modelAndView.setViewName("user/edit");
			return modelAndView;
		}
		if (userMapper.countUserByEmail(user.getEmail()) != 0) {
			result.rejectValue("email", "email.exists");
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("user", user);
			modelAndView.setViewName("user/edit");
			return modelAndView;
		}

		userMapper.updateUser(user);

		user = userMapper.getUserById(user.getId());

		request.getSession(false).setAttribute("its.me.baby.User", user);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("user", user);
		modelAndView.addObject("resultUpdated", true);
		modelAndView.setViewName("user/view");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "login", method={RequestMethod.POST})
	public ModelAndView login(@Valid UserGetter userGetter, BindingResult result, HttpServletRequest request) {

		if (result.hasErrors()) {
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("userGetter", userGetter);
			modelAndView.setViewName("user/top");
			return modelAndView;
		}

		User user = userMapper.getUserByEmailAndCryptoPassword(userGetter.getEmail(), userGetter.getCryptoPassword());

		request.getSession(false).setAttribute("its.me.baby.User", user);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("user", user);
		modelAndView.setViewName("user/view");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "view/{id}", method={RequestMethod.GET})
	public ModelAndView view(@PathVariable Integer id) {

		User user = userMapper.getUserById(id);
		List<Post> feedList = null;
		try {
			ConnectionRepository connectionRepository = usersConnectionRepository.createConnectionRepository(user.getId().toString());
			Facebook facebook = connectionRepository.getPrimaryConnection(Facebook.class).getApi();
			feedList = facebook.feedOperations().getFeed();
		} catch (Exception e) {
			e.printStackTrace();
		}
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("user", user);
		//modelAndView.addObject("feedList", feedList);
		modelAndView.setViewName("user/view");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "show", method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView show(HttpServletRequest request) {

		User user = (User)request.getSession(false).getAttribute("its.me.baby.User");
		List<Post> feedList = null;
		List<Tweet> tweets = null;
		try {
			ConnectionRepository connectionRepository = usersConnectionRepository.createConnectionRepository(user.getId().toString());
			if (connectionRepository.findPrimaryConnection(Facebook.class) != null) {
				Facebook facebook = connectionRepository.getPrimaryConnection(Facebook.class).getApi();
				feedList = facebook.feedOperations().getFeed();
			}

			if (connectionRepository.findPrimaryConnection(Twitter.class) != null) {
				Twitter twitter = connectionRepository.getPrimaryConnection(Twitter.class).getApi();
				tweets = twitter.timelineOperations().getUserTimeline();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("user", user);
		modelAndView.addObject("feedList", feedList);
		modelAndView.addObject("tweets", tweets);
		modelAndView.setViewName("user/view");
		return modelAndView;
	}
}
