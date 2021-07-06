<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Appointments</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="style.css">
		<link rel="stylesheet" href="board.css">
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
			
			.title {
				opacity: 0.7;
				padding: 0.2px;
				border: 1px;
				border-style: outset;
				border-color: #666;
				background-color: #555;
			    color: white;
			    font-size: 1.2em;
			}
			
		</style>
		
	</head>
	<body>
		
		<% 
			
			response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
			response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
			response.setHeader("Expires", "0"); // Proxies.
		
			if(session.getAttribute("username")==null)
			{
				response.sendRedirect("login.html");
			}
		
		%>
		
		<div class="unselectable">
			<div class="header">
				<h1>Appointment menu</h1>
				<h2> of <%= session.getAttribute("name") %> </h2>
			</div>
			
			<div class="navbar">
				<a href="index.jsp">Home</a>
				<a href="about.jsp">About</a>
				
				<a href="logout.jsp" class="right">Log out</a>
				<a href="patient?action=welcome" class="right"> <%= session.getAttribute("name") %> </a>
				<a id="selected" href="patient?action=appointments" class="right">Appointment menu</a>
				<a href="patient?action=availables" class="right">Available Appointments</a>
				
			</div>
		</div>
		
		<div class="offset"> </div>
		
		<div class="title">
			<h2>Scheduled Appointments</h2>
		</div>
		
    	<table>
	        <thead>
				<tr>
					<th>Doctor Full name</th>
					<th>Doctor Speciality</th>
					<th>Date Time</th>
					<th>End Time</th>
					<th>Hospital</th>
					<th></th>
				</tr>
	        </thead>
	        <tbody>
	            <c:forEach items="${requestScope.Appointments1}" var="a">
					<tr>

						<td><c:out value="${a.doctor.name}" /> <c:out value="${a.doctor.surname}" /></td>
						<td><c:out value="${a.doctor.speciality}" /></td>
						<td><c:out value="${a.datetime}" /></td>
						<td><c:out value="${a.endtime}" /></td>
						<td><c:out value="${a.hospital.name}" /></td>
						<td>
							<c:set var = 'date' value = '<%= new java.util.Date()%>' />
							<p style="display:none;"><fmt:formatDate var='now' value="${date}" type="date" pattern="yyyy-MM-dd"/></p>
							
							<c:set var = "thisdateparts" value = "${fn:split(now, '-')}" />
							<c:set var = "appdateparts" value = "${fn:split(a.datetime, '-')}" />
							
							<fmt:parseNumber var="thisday" value="${thisdateparts[2]}" type = "number" integerOnly="true"/>
							<fmt:parseNumber var="appday" value="${appdateparts[2]}" type = "number" integerOnly="true"/>
							
							<c:set var = 'thismonth' value = '${thisdateparts[1]}' />
							<c:set var = 'appmonth' value = '${appdateparts[1]}' />
							<c:set var = 'thisyear' value = '${thisdateparts[0]}' />
							<c:set var = 'appyear' value = '${appdateparts[0]}' />
							
							<c:if test="${(thisyear == appyear && thismonth == appmonth && appday - thisday >= 3) || (thisyear == appyear && thismonth < appmonth) || (thisyear < appyear)}">
								<button class="chooseAppointment" onclick='openModal("${a.doctor.name}", "${a.doctor.surname}", "${a.doctor.speciality}", "${a.datetime}", "${a.hospital.name}", "${a.doctor.AMKA}", "${a.patient.AMKA}")'>Cancel appointment</button>
							</c:if>
						</td>

					</tr>
	            </c:forEach>
	        </tbody>
		</table>
		
		<div class="title">
			<h2>Appointment History</h2>
		</div>
		
    	<table>
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
	            <c:forEach items="${requestScope.Appointments2}" var="a">
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
		
		<div id="myModal" class="modal">
			<!-- Modal content -->
			<div class="modal-content">
				<div class="modal-header">
					<span class="close">&times;</span>
					<h2>Cancel the appointment with this doctor?</h2>
				</div>
				<br>
				<div class="modal-body"><p style="font-size:15px; font-family:verdana;"></p><p style="font-size:15px; font-family:verdana;"></p><p style="font-size:15px; font-family:verdana;"></p><p style="font-size:15px; font-family:verdana;"></p><p style='font-size:10px; font-family:verdana;'></p></div>
				<br>
				<div class="modal-footer">
					<br>
					<button class="confirm" onclick="cancelAppointment()">Confirm cancellation</button>
					<br>
					<br>
				</div>
			</div>
		</div>
		
		<script>
			
			//delete appointment
			
			function cancelAppointment() {
				window.location.href = "patient?action=delete&damka="+doctorAMKA+"&pamka="+patientAMKA+"&date="+dateTime;
			}
		
			//modal
			
			// Get the modal
			var modal = document.getElementById("myModal");
			
			// Get the <span> element that closes the modal
			var span = document.getElementsByClassName("close")[0];
			
			//POST data variables
			var doctorAMKA;
			var patientAMKA;
			var dateTime;
			
			// When the user clicks the button, open the modal 
			function openModal(docName, docSurname, docSpeciality, datetime, hospital, docAMKA, patAMKA) {
				modal.style.display = "block";
				
				doctorAMKA = docAMKA;
				patientAMKA = patAMKA;
				dateTime = datetime;
				
				var date = datetime.split(' ')[0];
				var time = datetime.split(' ')[1];
				
				
				document.getElementsByClassName("modal-body")[0].childNodes[0].innerHTML = "Cancel the reservation with <b> " + docSpeciality + " </b> Doctor <b> " + docSurname + " " + docName + 
				" </b> on the <b> " + date + " </b> at <b> " + time + " </b> in <b> " + hospital + " </b>?";
				
				document.getElementsByClassName("modal-body")[0].childNodes[1].innerHTML = "<br><b> Doctor Full Name: </b> " + docSurname + " " + docName;
				document.getElementsByClassName("modal-body")[0].childNodes[2].innerHTML = "<br><b> Appointment Date: </b> " + date;
				document.getElementsByClassName("modal-body")[0].childNodes[3].innerHTML = "<br><b> Appointment Time: </b> " + time;
				document.getElementsByClassName("modal-body")[0].childNodes[4].innerHTML =  "You can cancel your appointment up to three days prior."
					
				
			}
			
			// When the user clicks on <span> (x), close the modal
			span.onclick = function() {
				modal.style.display = "none";
			}
			
			// When the user clicks anywhere outside of the modal, close it
			window.onclick = function(event) {
				if (event.target == modal) {
					modal.style.display = "none";
				}
			}
		
		
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