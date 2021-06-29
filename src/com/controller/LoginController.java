package com.controller;

import java.io.IOException;


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.UserDao;
import com.model.User;
import com.util.Encryption;


// SHORT was here...

@WebServlet("/login")
public class LoginController extends HttpServlet {
	
	/**
	 * Autogenerated identifier used for <b>serialization</b> and <b>deserialization</b>.
	 */
	private static final long serialVersionUID = 4249322171481546695L;
	private UserDao dao;

	public LoginController() {
		super();
		dao = new UserDao();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String forward = "";
		String action = request.getParameter("action");
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");

		if(action.equalsIgnoreCase("login")) {

			User user;
			
			//get user from dao
			user = dao.login(request.getParameter("username")); //if user is not in database, null obj is returned

			if(user == null) {
				forward = "/loginfailed.jsp";
			}
			else {
				//check with hash function
				String temp = Encryption.getHashMD5(request.getParameter("psw"), user.getSalt());
				//if psw is correct
				if(temp.equals(user.getPassword())){
					//create synchronized session
					HttpSession session = request.getSession();
					synchronized(session) {
	
						session.setAttribute("username", user.getUsername());
						session.setAttribute("name", user.getName());
						session.setAttribute("role", user.getRole());
						
						//forward user to the right welcome page
						switch(user.getRole()) {
							case "patient":
							forward = "/patient/welcomepatient.jsp";
							break;
						}
					}
				} else {
					forward = "/loginfailed.jsp";
				}
			}
			
			RequestDispatcher view = request.getRequestDispatcher(forward);
			view.forward(request, response);
		}
	}
}
