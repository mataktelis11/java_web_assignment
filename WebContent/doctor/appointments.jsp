<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Welcome</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="style.css">
		<style>
		
			/* Makes the text of the buttons unselectable */
			.unselectable {
			    -webkit-touch-callout: none;
			    -webkit-user-select: none;
			    -khtml-user-select: none;
			    -moz-user-select: none;
			    -ms-user-select: none;
			    user-select: none;
			}
			
			.show {
				display: block;
			}
			
		</style>
	</head>
	<body class="unselectable">
	
		<% 
			
			response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
			response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
			response.setHeader("Expires", "0"); // Proxies.
			
			if(session.getAttribute("username")==null)
			{
				response.sendRedirect("login.html");
			}
		
		%>
		
		
		<div class="header">
			<h1>Welcome</h1>
			<p> <%= session.getAttribute("name") %> </p>
		</div>
		
		<div class="navbar">
			<a href="index.jsp">Home</a>
			<a href="about.jsp">About</a>
			
			<a href="logout.jsp" class="right">Log out</a>
			<a href="doctor?action=welcome" class="right"> <%= session.getAttribute("name") %> </a>
			<a id="selected" href="doctor?action=appointments" class="right">Appointment menu</a>
			<a href="doctor?action=appointmentdeclaration" class="right">Appointment declaration</a>
			
		</div>
		
		<div class="offset"> </div>
		
		<p>This is the appointment page of the doctor.</p>
		
		
		<br>
		<p>Scheduled appointments</p>
		
		<table border=1>
	        <thead>
				<tr>
					<th>Patient AMKA</th>
					<th>Appointment Date</th>
					<th>End time</th>
					<th>Action</th>
				</tr>
	        </thead>
	        <tbody>
	            <c:forEach items="${requestScope.Appointments1}" var="a">
					<tr>

						<td><c:out value="${a.patient.AMKA}" /></td>
						<td><c:out value="${a.datetime}" /></td>
						<td><c:out value="${a.endtime}" /></td>
						<td><a href="doctor?action=cancel&pamka=<c:out value="${a.patient.AMKA}"/>&date=<c:out value="${a.datetime}"/>">Cancel</a></td>
					</tr>
	            </c:forEach>
	        </tbody>
		</table>
		
		
		
		<p>Old appointments</p>
		
		<table border=1>
	        <thead>
				<tr>
					<th>Patient AMKA</th>
					<th>Appointment Date</th>
					<th>End time</th>
				</tr>
	        </thead>
	        <tbody>
	            <c:forEach items="${requestScope.Appointments2}" var="a">
					<tr>

						<td><c:out value="${a.patient.AMKA}" /></td>
						<td><c:out value="${a.datetime}" /></td>
						<td><c:out value="${a.endtime}" /></td>
					</tr>
	            </c:forEach>
	        </tbody>
		</table>
		
		
		
		<script>
			//navbar 
			
			window.onscroll = function() {
				if(window.pageYOffset >= document.getElementsByClassName("header")[0].clientHeight) {
					document.getElementsByClassName("offset")[0].style.height = (document.getElementsByClassName("navbar")[0].clientHeight + "px");
					document.getElementsByClassName("navbar")[0].style.top = "0";
					document.getElementsByClassName("navbar")[0].style.position = "fixed";
				}
				else {
					document.getElementsByClassName("navbar")[0].style.position = "relative";
					document.getElementsByClassName("offset")[0].style.height = "0px";
				}
			}
		</script>
	
	</body>
</html>