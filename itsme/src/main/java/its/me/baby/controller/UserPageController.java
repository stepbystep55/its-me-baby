package its.me.baby.controller;

import its.me.baby.dto.StreamEntry;
import its.me.baby.dto.UserProfile;
import its.me.baby.mapper.UserProfileMapper;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/")
public class UserPageController {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private UsersConnectionRepository usersConnectionRepository;

	@Autowired
	private UserProfileMapper userProfileMapper;

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "show/{id}", method={RequestMethod.GET})
	public ModelAndView show(@PathVariable Integer id) {

		UserProfile userProfile = userProfileMapper.getUserProfileById(id);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("userProfile", userProfile);
		modelAndView.setViewName("user/show");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(value = "stream/{id}", method={RequestMethod.GET})
	public ModelAndView stream(@PathVariable Integer id) {

		ConnectionRepository connectionRepository = usersConnectionRepository.createConnectionRepository(id.toString());

		List<Post> feedList = null;
		List<StreamEntry> entryList = new ArrayList<StreamEntry>();
		if (connectionRepository.findPrimaryConnection(Facebook.class) != null) {
			Facebook facebook = connectionRepository.getPrimaryConnection(Facebook.class).getApi();
			feedList = facebook.feedOperations().getFeed();
			for (Post post : feedList) {
				dumpPost(post);
				if (post.getMessage() != null) {
					entryList.add(new StreamEntry(post));
				}
			}
		}
		List<Tweet> tweets = null;
		if (connectionRepository.findPrimaryConnection(Twitter.class) != null) {
			Twitter twitter = connectionRepository.getPrimaryConnection(Twitter.class).getApi();
			tweets = twitter.timelineOperations().getUserTimeline();
			for (Tweet tweet : tweets) {
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
	
	private void dumpPost(Post post) {
		if (post == null) {
			logger.debug("post is null");
			return;
		}
		String stype = "post";
		 Post.PostType ptype = post.getType();
		 if (ptype == Post.PostType.CHECKIN) { stype = "checkin"; }
		 else if (ptype == Post.PostType.LINK) { stype = "link"; }
		 else if (ptype == Post.PostType.MUSIC) { stype = "music"; }
		 else if (ptype == Post.PostType.NOTE) { stype = "note"; }
		 else if (ptype == Post.PostType.PHOTO) { stype = "photo"; }
		 else if (ptype == Post.PostType.POST) { stype = "post"; }
		 else if (ptype == Post.PostType.STATUS) { stype = "status"; }
		 else if (ptype == Post.PostType.SWF) { stype = "swf"; }
		 else if (ptype == Post.PostType.VIDEO) { stype = "video"; }
		String val =
				"post="
				+" id="+post.getId()
				+", type="+stype
				+", caption="+post.getCaption()
				+", comments="+post.getComments()
				+", message="+post.getMessage()
				+", createdTime="+post.getCreatedTime()
				+", description="+post.getDescription()
				+", icon="+post.getIcon()
				+", link="+post.getLink()
				+", name="+post.getName()
				+", pic="+post.getPicture()
				;
		if (post.getApplication() != null) {
			stype += ", application(id, name)=("+post.getApplication().getId()+","+post.getApplication().getName()+")";
		}
		if (post.getFrom() != null) {
			stype += ", form(id, name)=("+post.getFrom().getId()+","+post.getFrom().getName()+")";
		}
		logger.debug(val);
	}
}
