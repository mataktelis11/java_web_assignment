package com.controller;

import java.io.IOException;


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.PatientDao;
import com.model.Patient;

/**
 * 
 * Class that extends <b>HttpServlet</b>.
 * It's only function is the <i>login</i> of all user types.<br>
 * If the credentials are right, the user is forwarded to the corresponding welcome page and a <b>session</b> is created.
 * 
 * @authors telis, vasilis, atnwnis
 * 
 */
@WebServlet("/patient")
public class PatientController extends HttpServlet {
	
	/**
	 * Autogenerated identifier used for <b>serialization</b> and <b>deserialization</b>.
	 */
	private static final long serialVersionUID = -91978933072924051L;
	private PatientDao dao;
	
	public PatientController() {
		super();
		dao = new PatientDao();
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
		else if(!(session.getAttribute("role").equals("patient"))) {
			forward = "/falseRequest.jsp";
		}
		else {
			if(action.equalsIgnoreCase("details")) {
				forward="/patient/patientdetails.jsp";
				//get username from session
				String username = (String)session.getAttribute("username");
				//get Patient-obj from dao
				Patient patient = dao.getPatientDetails(username);
				//pass it to jsp
				request.setAttribute("Patient", patient);
			}
			else if(action.equalsIgnoreCase("appointments")) {
				forward = "/patient/appointments.jsp";
				//get username from session
				String username = (String)session.getAttribute("username");
				//get appointment list from dao and pass it to jsp
				request.setAttribute("Appointments", dao.getAppointments(username));
			}
			else if(action.equalsIgnoreCase("welcome")) {
				forward = "/patient/welcomepatient.jsp";
			}
		}
		
		RequestDispatcher view = request.getRequestDispatcher(forward);
		view.forward(request, response);
	}
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String forward = "";
		String action = request.getParameter("action");
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		
		if(action.equalsIgnoreCase("register")) {
			
			Patient p = new Patient();
			p.setName("AAAAAA");
			p.setSurname("BBBBAA");
			p.setSalt("Bq_&HR`LRkIHdT4_");
			p.setPassword("2C52C69FBD9B7F298BA0A6B663D3C2F1");
			p.setUsername("telis2");
			p.setAMKA("1386605437");
			
			System.out.println(dao.addPatient(p));
			
			
			
			forward = "/falseRequest.jsp";
		}
		

		
		
		
		RequestDispatcher view = request.getRequestDispatcher(forward);
		view.forward(request, response);
	}

	
}
