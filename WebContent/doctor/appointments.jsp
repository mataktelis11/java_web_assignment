<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Appointment Menu</title>
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
			<h1>Appointment menu</h1>
			<h2> of <%= session.getAttribute("name") %> </h2>
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
		
		<div class="title">
			<h2>Scheduled appointments</h2>
		</div>
		
		<table>
	        <thead>
				<tr>
					<th>Patient AMKA</th>
					<th>Appointment Date</th>
					<th>End time</th>
					<th></th>
				</tr>
	        </thead>
	        <tbody>
	            <c:forEach items="${requestScope.Appointments1}" var="a">
					<tr>

						<td><c:out value="${a.patient.AMKA}" /></td>
						<td><c:out value="${a.datetime}" /></td>
						<td><c:out value="${a.endtime}" /></td>
						<td>
							<button class="chooseAppointment" onclick='openModal("${a.datetime}", "${a.patient.AMKA}")'>Cancel appointment</button>
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
		
		<div id="myModal" class="modal">
			<!-- Modal content -->
			<div class="modal-content">
				<div class="modal-header">
					<span class="close">&times;</span>
					<h2>Cancel this appointment?</h2>
				</div>
				<br>
				<div class="modal-body"><p style="font-size:15px; font-family:verdana;"></p><p style="font-size:15px; font-family:verdana;"></p><p style="font-size:15px; font-family:verdana;"></p><p style="font-size:15px; font-family:verdana;"></p></div>
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
				window.location.href = "doctor?action=cancel&pamka="+patientAMKA+"&date="+dateTime;
			}
		
			//modal
			
			// Get the modal
			var modal = document.getElementById("myModal");
			
			// Get the <span> element that closes the modal
			var span = document.getElementsByClassName("close")[0];
			
			//POST data variables
			var patientAMKA;
			var dateTime;
			
			// When the user clicks the button, open the modal 
			function openModal(datetime, patAMKA) {
				modal.style.display = "block";
				
				patientAMKA = patAMKA;
				dateTime = datetime;
				
				var date = datetime.split(' ')[0];
				var time = datetime.split(' ')[1];
				
				
				document.getElementsByClassName("modal-body")[0].childNodes[0].innerHTML = "Cancel the reservation with Patient <b> " + patientAMKA + 
				" </b> on the <b> " + date + " </b> at <b> " + time + " </b>?";
				
				document.getElementsByClassName("modal-body")[0].childNodes[1].innerHTML = "<br><b> Patient AMKA: </b> " + patientAMKA;
				document.getElementsByClassName("modal-body")[0].childNodes[2].innerHTML = "<br><b> Appointment Date: </b> " + date;
				document.getElementsByClassName("modal-body")[0].childNodes[3].innerHTML = "<br><b> Appointment Time: </b> " + time;
					
				
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