package com.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.YearMonth;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.GregorianCalendar;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.DoctorDao2;
import com.dao.PatientDao;
import com.model.Patient;


@WebServlet("/doctor")
public class DoctorController extends HttpServlet {
	
	/**
	 * Autogenerated identifier used for <b>serialization</b> and <b>deserialization</b>.
	 */
	private static final long serialVersionUID = -91978933072924051L;
	//private DoctorDao dao;
	private DoctorDao2 dao;
	public DoctorController() {
		super();
		dao = new DoctorDao2();
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
		else if(!(session.getAttribute("role").equals("doctor"))) {
			forward = "/falseRequest.jsp";
		}
		else {
			if(action.equalsIgnoreCase("appointments")) {
				forward = "/doctor/appointments.jsp";
				request.setAttribute("Appointments", dao.getScheduledAppointments(dao.getAmka((String)session.getAttribute("username"))));
			}
			if(action.equalsIgnoreCase("appointmentdeclaration")) {
				forward = "/doctor/appointmentdeclaration.jsp";
			}
			else if(action.equalsIgnoreCase("welcome")) {
				forward = "/doctor/welcomedoctor.jsp";
				request.setAttribute("Doctor", dao.getDetails((String)session.getAttribute("username")));
			}
			else if(action.equalsIgnoreCase("callendar")) {
				
				filldates(request.getParameter("data"),(String)session.getAttribute("username"));
				forward = "/doctor/appointmentdeclaration.jsp";
			}
		}
		
		RequestDispatcher view = request.getRequestDispatcher(forward);
		view.forward(request, response);
	}
	
	
	
	
	private void filldates(String data,String username) {
		String[] split = data.split(",");
		String[] s1=split[0].split("-");
		
		Date x=  new GregorianCalendar(2020, 1, 20).getTime();
		ArrayList<String[]> spans=new ArrayList();
		//print day and spans
		for (int i=1;i<split.length;i++) {
			spans.add(split[i].split("/"));
			
		}
		//print spans
		for (int i=0;i<spans.size();i++) {
			
			
			int c=1;
			int month=Integer.parseInt(s1[0]);
			try {
			LocalDate date2=LocalDate.of(Integer.parseInt(s1[1]),month, 1);
			 for(int z=0;z<date2.lengthOfMonth();z++){
		            if(spans.get(i)[0].equalsIgnoreCase(date2.getDayOfWeek().toString())){

		                break;
		            }else{
		                date2=date2.plusDays(1);
		            }
		        }
			 c=date2.getDayOfMonth();
			 
			
			}catch(Exception e) {
				e.printStackTrace();
			}
			YearMonth yearMonthObject = YearMonth.of(Integer.parseInt(s1[1]), month);
			int daysInMonth = yearMonthObject.lengthOfMonth();
			for (int k=c;k<=daysInMonth;k+=7) {
			x=  new GregorianCalendar(Integer.parseInt(s1[1]), month-1, k).getTime();
			
			for(int j=1;j<spans.get(i).length;j++) {
			String[] s=spans.get(i)[j].split("-");
			
			int from =Integer.parseInt(s[0]);
			int until=Integer.parseInt(s[1]);
			for (int a=from;a<until;a++) {
				x.setHours(a);
				x.setSeconds(0);
				for (int b=0;b<=30;b+=30) {
					x.setMinutes(b);
					java.sql.Date da = new java.sql.Date(x.getTime());
					String s2=da.toString()+" "+x.toString().substring(11, 20);
					Date y= x;
					if(b==30) {
						
						y.setHours(a+1);
						y.setMinutes(0);
						
					}else {
						y.setMinutes(30);
						}
					String s3=da.toString()+" "+y.toString().substring(11, 20);
					
					dao.addAvailableAppointment(username, s2, s3);
					}
				}
			}
		}
		}
		

		
		
	}
 
		
	
	
}
