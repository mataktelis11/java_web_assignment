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
			
			.sort a {
				font-size: 15px;
				display: block;
				color: white;
				text-align: center;
				padding: 1px;
				text-decoration: none;
			}
			
			.sort a:hover {
				background-color: #bbbbbb;
				color: black;
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
			<h1>Available Appointments</h1>
			<h2>make a reservation</h2>
		</div>
		
		<div class="navbar">
			<a href="index.jsp">Home</a>
			<a href="about.jsp">About</a>
			
			<a href="logout.jsp" class="right">Log out</a>
			<a href="patient?action=welcome" class="right"> <%= session.getAttribute("name") %> </a>
			<a href="patient?action=appointments" class="right">Appointment menu</a>
			<a id="selected" href="patient?action=availables" class="right">Available Appointments</a>
			
		</div>
		
		<div class="offset"> </div>
		
    	<table>
	        <thead>
				<tr>
					<th>Full name</th>
					<th>Speciality</th>
					<th>Date Time</th>
					<th>Hospital</th>
					<th class="sort"> 
						<a <c:if test="${(requestScope.Data != null) && (requestScope.Appointments[0].doctor.speciality == 'Pathologist')}"> id="selected" </c:if> href='patient?action=availables&data=Pathologist' class="right">Pathologist</a>
						<a <c:if test="${(requestScope.Data != null) && (requestScope.Appointments[0].doctor.speciality == 'Ophthalmologist')}"> id="selected" </c:if> href='patient?action=availables&data=Ophthalmologist' class="right">Ophthalmologist</a>
						<a <c:if test="${(requestScope.Data != null) && (requestScope.Appointments[0].doctor.speciality == 'Orthopedic')}"> id="selected" </c:if> href='patient?action=availables&data=Orthopedic' class="right">Orthopedic</a>
					</th>
				</tr>
	        </thead>
	        <tbody>
	            <c:forEach items="${requestScope.Appointments}" var="a">
					<tr>

						<td><c:out value="${a.doctor.name}" /> <c:out value="${a.doctor.surname}" /></td>
						<td><c:out value="${a.doctor.speciality}" /></td>
						<td><c:out value="${a.datetime}" /></td>
						<td><c:out value="${a.hospital.name}" /></td>
						<td> <button class="chooseAppointment" onclick='openModal("${a.doctor.name}", "${a.doctor.surname}", "${a.doctor.speciality}", "${a.datetime}", "${a.hospital.name}", "${a.doctor.AMKA}", "${requestScope.PAMKA}")'>Choose appointment</button> </td>

					</tr>
	            </c:forEach>
	        </tbody>
		</table>
		
		<div id="myModal" class="modal">
			<!-- Modal content -->
			<div class="modal-content">
				<div class="modal-header">
					<span class="close">&times;</span>
					<h2>Make a reservation with this doctor?</h2>
				</div>
				<br>
				<div class="modal-body"><p style="font-size:15px; font-family:verdana;"></p><p style="font-size:15px; font-family:verdana;"></p><p style="font-size:15px; font-family:verdana;"></p><p style="font-size:15px; font-family:verdana;"></p><p style='font-size:10px; font-family:verdana;'></p></div>
				<br>
				<div class="modal-footer">
					<br>
					<button class="confirm" onclick="addAppointment()">Confirm Reservation</button>
					<br>
					<br>
				</div>
			</div>
		</div>
		
		
		<script>
		
			//add appointment
			
			function addAppointment() {
				window.location.href = "patient?action=add&damka="+doctorAMKA+"&pamka="+patientAMKA+"&date="+dateTime;
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
				
				
				document.getElementsByClassName("modal-body")[0].childNodes[0].innerHTML = "Confirm the reservation with <b> " + docSpeciality + " </b> Doctor <b> " + docSurname + " " + docName + 
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
		
			//onload
			
			window.onload = function() {
				
				onScroll();
				
				var th = document.getElementsByTagName("th");
				
				for(var i = 0; i < th.length; i++) {
					th[i].style.position = "sticky";
					th[i].style.top = document.getElementsByClassName("navbar")[0].clientHeight + "px";
				}
			}
			
			//navbar 
			
			window.onscroll = function() {
				onScroll();
			}
			
			function onScroll() {
				if(
					window.pageYOffset >= document.getElementsByClassName("header")[0].clientHeight) {
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