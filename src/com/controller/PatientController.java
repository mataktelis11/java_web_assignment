package com.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.Period;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.PatientDao;
import com.model.Appointment;
import com.model.Patient;
import com.util.Generator;
import com.util.Encryption;

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
	private Generator gen;
	
	public PatientController() {
		super();
		dao = new PatientDao();
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
		else if(!(session.getAttribute("role").equals("patient"))) {
			forward = "/falseRequest.jsp";
		}
		else {
			
			if(action.equalsIgnoreCase("appointments")) {
				forward = "/patient/appointments.jsp";
				//get username from session
				String username = (String)session.getAttribute("username");
				//get appointment list from dao and pass it to jsp
				
				List<Appointment> appointments = dao.getAppointments(username);
				
				List<Appointment> appointments1 = new ArrayList<Appointment>();
				List<Appointment> appointments2 = new ArrayList<Appointment>();
				
				
				//https://tecadmin.net/get-current-timestamp-in-java/
				
					Date date= new Date();
					
					long time = date.getTime();

					
					Timestamp ts = new Timestamp(time);
				
				for(Appointment a : appointments) {
					
					

					
					if(Timestamp.valueOf(a.getEndtime()).after(ts))
						appointments1.add(a);
					else
						appointments2.add(a);
				}
				
				request.setAttribute("Appointments1", appointments1);
				request.setAttribute("Appointments2", appointments2);
			}
			else if(action.equalsIgnoreCase("availables")) {
				String username = (String)session.getAttribute("username");
				Date date1= new Date();
				long time = date1.getTime();
				Timestamp ts = new Timestamp(time);
				
				if(request.getParameter("data") == null) {
					forward = "/patient/availappointments.jsp";
					//get appointment list from dao and pass it to jsp
					List<Appointment> appointments = dao.getAvailableAppointments();
					List<Appointment> appointments1 = new ArrayList<Appointment>();
					for(Appointment a : appointments) {
						if(Timestamp.valueOf(a.getDatetime()).after(ts)) {
							appointments1.add(a);
						};
					}
					
					request.setAttribute("Appointments", appointments1);
					request.setAttribute("PAMKA", dao.getAmka(username));
				}
				else if (request.getParameter("data").equals("Pathologist")) {
					forward = "/patient/availappointments.jsp";
					//get appointment list from dao and pass it to jsp
					List<Appointment> appointments = dao.getAvailableAppointments(request.getParameter("data"));
					List<Appointment> appointments1 = new ArrayList<Appointment>();
					for(Appointment a : appointments) {
						if(Timestamp.valueOf(a.getDatetime()).after(ts)) {
							appointments1.add(a);
						};
					}
					
					request.setAttribute("Appointments", appointments1);
					request.setAttribute("Data", request.getParameter("data"));
					request.setAttribute("PAMKA", dao.getAmka(username));
				}
				else if (request.getParameter("data").equals("Ophthalmologist")) {
					forward = "/patient/availappointments.jsp";
					//get appointment list from dao and pass it to jsp
					List<Appointment> appointments = dao.getAvailableAppointments(request.getParameter("data"));
					List<Appointment> appointments1 = new ArrayList<Appointment>();
					for(Appointment a : appointments) {
						if(Timestamp.valueOf(a.getDatetime()).after(ts)) {
							appointments1.add(a);
						};
					}
					
					request.setAttribute("Appointments", appointments1);
					request.setAttribute("Data", request.getParameter("data"));
					request.setAttribute("PAMKA", dao.getAmka(username));
				}
				else if (request.getParameter("data").equals("Orthopedic")) {
					forward = "/patient/availappointments.jsp";
					//get appointment list from dao and pass it to jsp
					List<Appointment> appointments = dao.getAvailableAppointments(request.getParameter("data"));
					List<Appointment> appointments1 = new ArrayList<Appointment>();
					for(Appointment a : appointments) {
						if(Timestamp.valueOf(a.getDatetime()).after(ts)) {
							appointments1.add(a);
						};
					}
					
					request.setAttribute("Appointments", appointments1);
					request.setAttribute("Data", request.getParameter("data"));
					request.setAttribute("PAMKA", dao.getAmka(username));
				}
			}
			else if(action.equalsIgnoreCase("welcome")) {
				forward = "/patient/welcomepatient.jsp";

				String username = (String)session.getAttribute("username");
				//get Patient-obj from dao
				Patient patient = dao.getPatientDetails(username);
				//pass it to jsp
				request.setAttribute("Patient", patient);
			}
			else if(action.equalsIgnoreCase("delete")) {
				String damka = request.getParameter("damka");
				String pamka = request.getParameter("pamka");
				String date = request.getParameter("date");
				
				
				//check date
				
				//https://www.codegrepper.com/code-examples/java/number+of+days+between+two+timestamps+java+sprin
				
				Timestamp ts2 = Timestamp.valueOf(request.getParameter("date"));
				
				LocalDate d1 = LocalDate.now();
				LocalDate d2 = ts2.toLocalDateTime().toLocalDate();
				
				Period period = Period.between(d1, d2);
				
				int diffd = period.getDays();
				int diffy = period.getYears();
				int diffm = period.getMonths();
				
				
				
				if((diffy>0 || diffm>0) || diffd>=3) {
					dao.cancelAppointment(pamka, damka, date);
				}
				
				
				
				forward = "/patient/appointments.jsp";
				//get username from session
				String username = (String)session.getAttribute("username");
				//get appointment list from dao and pass it to jsp
				
				List<Appointment> appointments = dao.getAppointments(username);
				
				List<Appointment> appointments1 = new ArrayList<Appointment>();
				List<Appointment> appointments2 = new ArrayList<Appointment>();
				
				
				//https://tecadmin.net/get-current-timestamp-in-java/
				
					Date date1= new Date();
					long time = date1.getTime();
					Timestamp ts = new Timestamp(time);
				
				for(Appointment a : appointments) {
					
					if(Timestamp.valueOf(a.getEndtime()).after(ts))
						appointments1.add(a);
					else
						appointments2.add(a);
				}
				
				request.setAttribute("Appointments1", appointments1);
				request.setAttribute("Appointments2", appointments2);
			}
			else if(action.equalsIgnoreCase("add")) {
				String damka = request.getParameter("damka");
				String pamka = request.getParameter("pamka");
				String date = request.getParameter("date");
				
				dao.addAppointment(pamka, damka, date);
				
				forward = "/patient/appointments.jsp";
				//get username from session
				String username = (String)session.getAttribute("username");
				//get appointment list from dao and pass it to jsp
				
				List<Appointment> appointments = dao.getAppointments(username);
				
				List<Appointment> appointments1 = new ArrayList<Appointment>();
				List<Appointment> appointments2 = new ArrayList<Appointment>();
				
				
				//https://tecadmin.net/get-current-timestamp-in-java/
				
				Date date1= new Date();
				long time = date1.getTime();
				Timestamp ts = new Timestamp(time);
				
				for(Appointment a : appointments) {
					
					if(Timestamp.valueOf(a.getEndtime()).after(ts))
						appointments1.add(a);
					else
						appointments2.add(a);
				}
				
				request.setAttribute("Appointments1", appointments1);
				request.setAttribute("Appointments2", appointments2);
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
			
			//get data from the request
			String name = request.getParameter("name");
			String surName = request.getParameter("surname");
			String amka = request.getParameter("amka");
			String username = request.getParameter("username");
			String password = request.getParameter("psw");
			String passwordRepeat = request.getParameter("psw-repeat");
			
			//check data
			if(password.equals(passwordRepeat)) {
				//pass data to object
				p.setName(name);
				p.setSurname(surName);
				p.setSalt(gen.generate(16));
				p.setPassword(Encryption.getHashMD5(password, p.getSalt()));
				p.setUsername(username);
				p.setAMKA(amka);
				
				//call dao
				
				int check = dao.addPatient(p);
				
				if(check == 1) {
					forward = "/regsuccess.jsp";
				}
					
				else {
					forward = "/regfail.jsp";
					String message = "username and/or amka already in the database OR invalid.";
					request.setAttribute("message", message);
				}
					
			}
			else {
				forward = "/regfail.jsp";
				String message = "invalid password given.";
				request.setAttribute("message", message);
			}
			
			

		}

		RequestDispatcher view = request.getRequestDispatcher(forward);
		view.forward(request, response);
	}

	
}
