<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Appointments</title>
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
			<h1>Appointment menu of</h1>
			<p> <%= session.getAttribute("name") %> </p>
		</div>
		
		<div class="navbar">
			<a href="index.jsp">Home</a>
			<a href="about.jsp">About</a>
			
			<a href="logout.jsp" class="right">Log out</a>
			<a href="patient?action=welcome" class="right"> <%= session.getAttribute("name") %> </a>
			<a href="patient?action=details" class="right">Account Details</a>
			<a id="selected" href="patient?action=appointments" class="right">Appointment menu</a>
			
		</div>
		
		<div class="offset"> </div>
		
		<br>
    	<table border=1>
	        <thead>
				<tr>
					<th>Doctor Full name</th>
					<th>Doctor Speciality</th>
					<th>Date Time</th>
					<th>End Time</th>
					<th>Hospital</th>
				</tr>
	        </thead>
	        <tbody>
	            <c:forEach items="${requestScope.Appointments}" var="a">
					<tr>

						<td><c:out value="${a.doctor.name}" /> <c:out value="${a.doctor.surname}" /></td>
						<td><c:out value="${a.doctor.speciality}" /></td>
						<td><c:out value="${a.datetime}" /></td>
						<td><c:out value="${a.endtime}" /></td>
						<td><c:out value="${a.hospital.name}" /></td>

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