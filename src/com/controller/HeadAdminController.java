package com.controller;


import java.io.IOException;


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.HeadAdminDao;
import com.model.Admin;
import com.model.Doctor;
import com.model.Hospital;
import com.util.Encryption;
import com.util.Generator;

/**
 * 
 * Class that extends <b>HttpServlet</b>.
 * Simulates the function is the HeadAdmins<br>
 * 
 * @authors telis, vasilis, atnwnis
 * 
 */
@WebServlet("/headadmin")
public class HeadAdminController extends HttpServlet {
	
	/**
	 * Autogenerated identifier used for <b>serialization</b> and <b>deserialization</b>.
	 */
	private static final long serialVersionUID = 11173178321454820L;
	HeadAdminDao dao;
	private Generator gen;
	
	public HeadAdminController() {
		super();
		dao = new HeadAdminDao();
		gen = new Generator();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String forward="";
		String action = request.getParameter("action");
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession(false);
		
		//check if session exists
		if(session == null) {
			forward = "/falseRequest.jsp";
		}
		//check if session Attribute exists
		else if(session.getAttribute("role") == null) {
			forward = "/falseRequest.jsp";
		}
		//check if the user is a doctor
		else if(!(session.getAttribute("role").equals("headadmin"))) {
			forward = "/falseRequest.jsp";
		}
		else {
			
			
			if(action.equalsIgnoreCase("welcome")) {
				forward = "/headadmin/welcomeheadadmin.jsp";
				request.setAttribute("HAdmin", dao.getDetails((String)session.getAttribute("username")));
				
			}
			
			
			
			else if(action.equalsIgnoreCase("addadmin")) {
				forward = "/headadmin/addadmin.jsp";
				request.setAttribute("message", "nomessage");
				request.setAttribute("Admins", dao.getAllAdmins());
				
			}
		}
		
		RequestDispatcher view = request.getRequestDispatcher(forward);
		view.forward(request, response);
	}
	
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String forward="";
		String action = request.getParameter("action");
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession(false);
		
		
		if(action.equalsIgnoreCase("insertadmin")) {
			
			forward = "/headadmin/addadmin.jsp";
			
			
			Admin admin = new Admin();
			
			String name = request.getParameter("name");
			String surName = request.getParameter("surname");
			String username = request.getParameter("username");
			String password = request.getParameter("psw");

			
			//check data
			if(true) {
			
				admin.setName(username);
				admin.setSurname(surName);
				admin.setUsername(username);
				
				admin.setSalt(gen.generate(16));
				admin.setPassword(Encryption.getHashMD5(password, admin.getSalt()));
				
				admin.setHeadAdmin((String)session.getAttribute("username"));
				

				
				//call dao
				int check = dao.addAdmin(admin);
				
				if(check == 1) {
					request.setAttribute("message", "Success");
					request.setAttribute("Admins", dao.getAllAdmins());
				}
					
				else {
					request.setAttribute("message", "Fail");
					request.setAttribute("Admins", dao.getAllAdmins());
				}
			}
		}
		
		RequestDispatcher view = request.getRequestDispatcher(forward);
		view.forward(request, response);
		
	}
	
}
