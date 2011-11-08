package its.me.baby.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.servlet.view.RedirectView;

public class AuthInterceptor extends HandlerInterceptorAdapter {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		if (handler.getClass().getName().startsWith("org.springframework")) {
			return true;
		} else if (handler instanceof HomeController) {
			return true;
		} else {
			if (request.getSession(false) == null) {
				logger.info("Access without session: " + request.getRequestURI());
				new RedirectView("/login", true).render(null, request, response);
				return false;
			}
		}
		return true;
	}

}