package its.me.baby.controller;

import its.me.baby.dto.StreamEntry;
import its.me.baby.dto.User;
import its.me.baby.dto.UserGetter;
import its.me.baby.mapper.UserMapper;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.social.connect.Connection;
import org.springframework.social.connect.ConnectionRepository;
import org.springframework.social.connect.UsersConnectionRepository;
import org.springframework.social.facebook.api.Facebook;
import org.springframework.social.facebook.api.Post;
import org.springframework.social.twitter.api.Tweet;
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
public class UserController {

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
	@RequestMapping(value = "update", method = RequestMethod.POST)
	public ModelAndView update(@Valid User user, BindingResult result, HttpServletRequest request) {

		if (result.hasErrors()) {
			ModelAndView modelAndView = new ModelAndView();
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

		userMapper.updateUser(user);

		user = userMapper.getUserById(user.getId());

		request.getSession(false).setAttribute(User.class.getName(), user);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("resultUpdated", true);
		modelAndView.setViewName("forward:edit");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "disconnect", method = RequestMethod.POST)
	public ModelAndView disconnect(@RequestParam String provider, HttpServletRequest request) {

		User user = (User)request.getSession(false).getAttribute(User.class.getName());

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

		User user = (User)request.getSession(false).getAttribute(User.class.getName());

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
	@RequestMapping(value = "show", method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView show(HttpServletRequest request) {
	//public ModelAndView show(@PathVariable Integer id, HttpServletRequest request) {

		User user = (User)request.getSession(false).getAttribute(User.class.getName());

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("user", user);
		modelAndView.setViewName("user/show");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "stream", method={RequestMethod.GET})
	public ModelAndView stream(HttpServletRequest request) {

		User user = (User)request.getSession(false).getAttribute(User.class.getName());

		ConnectionRepository connectionRepository = usersConnectionRepository.createConnectionRepository(user.getId().toString());

		List<Post> feedList = null;
		List<StreamEntry> entryList = new ArrayList<StreamEntry>();
		if (connectionRepository.findPrimaryConnection(Facebook.class) != null) {
			Facebook facebook = connectionRepository.getPrimaryConnection(Facebook.class).getApi();
			feedList = facebook.feedOperations().getFeed();
			for (Iterator<Post> itr = feedList.iterator(); itr.hasNext(); ) {
				Post post = itr.next();
				entryList.add(new StreamEntry(post));
			}
		}
		List<Tweet> tweets = null;
		if (connectionRepository.findPrimaryConnection(Twitter.class) != null) {
			Twitter twitter = connectionRepository.getPrimaryConnection(Twitter.class).getApi();
			tweets = twitter.timelineOperations().getUserTimeline();
			for (Iterator<Tweet> itr = tweets.iterator(); itr.hasNext(); ) {
				Tweet tweet = itr.next();
				entryList.add(new StreamEntry(tweet));
			}
		}
		Collections.sort(entryList);
		Collections.reverse(entryList);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("feedList", feedList);
		modelAndView.addObject("tweets", tweets);
		modelAndView.addObject("entryList", entryList);
		modelAndView.setViewName("user/stream");
		return modelAndView;
	}
}
