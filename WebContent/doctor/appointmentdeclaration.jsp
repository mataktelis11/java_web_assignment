<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Welcome</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="style.css">
		<link rel="stylesheet" href="doctor/calendar.css">
		<link rel="stylesheet" href="doctor/timePicker.css">
		<style>
		
			.show {
				display: block;
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
		
		
		<div class="header">
			<h1>Welcome</h1>
			<p> <%= session.getAttribute("name") %> </p>
		</div>
		
		<div class="navbar">
			<a href="index.jsp">Home</a>
			<a href="about.jsp">About</a>
			
			<a href="logout.jsp" class="right">Log out</a>
			<a href="doctor?action=welcome" class="right"> <%= session.getAttribute("name") %> </a>
			<a href="doctor?action=appointments" class="right">Appointment menu</a>
			<a id="selected" href="doctor?action=appointmentdeclaration" class="right">Appointment declaration</a>
			
		</div>
		
		<div class="offset"> </div>
		
		<div class="month">
			<h2 id="month" style="font-size:25px">
				<br>August<br>2021
			</h2>
		</div>
		
		<ul class="weekdays">
			<li>Mo</li>
			<li>Tu</li>
			<li>We</li>
			<li>Th</li>
			<li>Fr</li>
			<li>Sa</li>
			<li>Su</li>
		</ul>
		
		<ul class="days">  
			<li id="1" class="inactive" onclick="myFun(this)">1</li>
			<li id="2" class="inactive" onclick="myFun(this)">2</li>
			<li id="3" class="inactive" onclick="myFun(this)">3</li>
			<li id="4" class="inactive" onclick="myFun(this)">4</li>
			<li id="5" class="inactive" onclick="myFun(this)">5</li>
			<li id="6" class="inactive" onclick="myFun(this)">6</li>
			<li id="7" class="inactive" onclick="myFun(this)">7</li>
			<li id="8" class="inactive" onclick="myFun(this)">8</li>
			<li id="9" class="inactive" onclick="myFun(this)">9</li>
			<li id="10" class="inactive" onclick="myFun(this)">10</li>
			<li id="11" class="inactive" onclick="myFun(this)">11</li>
			<li id="12" class="inactive" onclick="myFun(this)">12</li>
			<li id="13" class="inactive" onclick="myFun(this)">13</li>
			<li id="14" class="inactive" onclick="myFun(this)">14</li>
			<li id="15" class="inactive" onclick="myFun(this)">15</li>
			<li id="16" class="inactive" onclick="myFun(this)">16</li>
			<li id="17" class="inactive" onclick="myFun(this)">17</li>
			<li id="18" class="inactive" onclick="myFun(this)">18</li>
			<li id="19" class="inactive" onclick="myFun(this)">19</li>
			<li id="20" class="inactive" onclick="myFun(this)">20</li>
			<li id="21" class="inactive" onclick="myFun(this)">21</li>
			<li id="22" class="inactive" onclick="myFun(this)">22</li>
			<li id="23" class="inactive" onclick="myFun(this)">23</li>
			<li id="24" class="inactive" onclick="myFun(this)">24</li>
			<li id="25" class="inactive" onclick="myFun(this)">25</li>
			<li id="26" class="inactive" onclick="myFun(this)">26</li>
			<li id="27" class="inactive" onclick="myFun(this)">27</li>
			<li id="28" class="inactive" onclick="myFun(this)">28</li>
			<li id="29" class="inactive" onclick="myFun(this)">29</li>
			<li id="30" class="inactive" onclick="myFun(this)">30</li>
			<li id="31" class="inactive" onclick="myFun(this)">31</li>
		</ul>
		
		<div class="form-popup" id="timePicker">
			<form class="form-container">
				<h1>Pick the time span</h1>
				
				<label for="from">From:</label>
				<select id="from" required>
					<option value="8">6</option>
					<option value="8">7</option>
					<option value="8">8</option>
					<option value="9">9</option>
					<option value="10">10</option>
					<option value="11">11</option>
					<option value="12">12</option>
					<option value="13">13</option>
				</select>
				
				<label for="to">To:</label>
				<select id="to" required>
					<option value="8">8</option>
					<option value="9">9</option>
					<option value="10">10</option>
					<option value="11">11</option>
					<option value="12">12</option>
					<option value="13">13</option>
					<option value="14">14</option>
					<option value="15">15</option>
					<option value="15">16</option>
					<option value="15">17</option>
					<option value="15">18</option>
				</select>
				
				<button type="button" class="btn" onclick="confirmDay()">Confirm</button>
				<button type="button" class="btn cancel" onclick="closeForm()">Close</button>
			</form>
		</div>
			
		<script>
		
			//returned value
			var returned_days = "";
		
			//date picker
			
			window.onload = function() {
				
				const months = ["January","February","March","April","May","June","July","August","September","October","November","December"];
				var today = new Date();
				var dd = String(today.getDate()).padStart(2, '0');
				var mm = today.getMonth() + 2;
				var yyyy = today.getFullYear();
				while(mm > 11) {
					mm -= 12;
					yyyy += 1;
				}
				
				if(mm == 1) {
					document.getElementById("29").className = "active";
					document.getElementById("30").className = "active";
					document.getElementById("31").className = "active";
				}
				else if(mm < 7 && mm % 2 == 1) {
					document.getElementById("31").className = "active";
				}
				else if(mm >= 7 && mm % 2 == 0){
					document.getElementById("31").className = "active";
				}
				
				document.getElementById("month").innerHTML = '<br>' + months[mm] + '<br>' + yyyy;
				
			}
			
			var chosen_days = "";
			var ele_id;
			function myFun(ele) {
				chosen_days = "";
				ele_id = ele.id;
				var clas = ele.className;
				
				if(clas == "inactive") {
					chosen_days += ele_id + " ";
					openForm();
				}
				
				
			}
			
			//time picker
			
			function openForm() {
				document.getElementById("timePicker").style.display = "block";
			}
			
			function closeForm() {
				document.getElementById("timePicker").style.display = "none";
			}
			
			function confirmDay() {
				chosen_days += document.getElementById("from").value + "-" + document.getElementById("to").value + "/";
				returned_days += chosen_days;
				alert(returned_days);
				document.getElementById(ele_id).className = "active";
				closeForm();
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