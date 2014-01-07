package com.aic.appengine;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import twitter.SentAnalysis;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;


public class SentimentServlet extends HttpServlet {



	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {

		ServletContext context=getServletContext();

		String searchText = req.getParameter("searchText");
		String start = req.getParameter("start");
		String end = req.getParameter("end");

		System.out.println(searchText + " " + start + " " + end);

		System.out.println(context.getResource("/WEB-INF/classifier.txt").getPath());
		SentAnalysis analysis = new SentAnalysis(searchText, start, end, 1, 1, context.getResource("/WEB-INF/classifier.txt").getPath());
		analysis.run();
		System.out.println("result: " + analysis.getResult());

		resp.setContentType("text/plain");
		resp.getWriter().println(analysis.getResult());

	}
}