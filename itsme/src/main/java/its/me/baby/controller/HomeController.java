package its.me.baby.controller;

import its.me.baby.dto.Temp;
import its.me.baby.mapper.TempMapper;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	private TempMapper tempMapper;

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! the client locale is "+ locale.toString());
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}

	@ModelAttribute
	public Temp setUpForm(){
		return new Temp();
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(method = RequestMethod.GET)
	public ModelAndView create() {

		List<Temp> tempList = tempMapper.list();

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("tempList", tempList);
		modelAndView.setViewName("create");
		return modelAndView;
	}

	@Transactional(rollbackForClassName="java.lang.Exception")
	@RequestMapping(method = RequestMethod.POST)
	public ModelAndView save(Temp temp, BindingResult result, HttpServletRequest request) {

		tempMapper.save(temp);
		List<Temp> tempList = tempMapper.list();

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("tempList", tempList);
		modelAndView.setViewName("create");
		return modelAndView;
	}
}
