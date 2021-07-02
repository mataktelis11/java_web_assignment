<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Welcome</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="style.css">
		<style>
		
			.show {
				display: block;
			}
			
			.header {
				font-size: 42px !important;
			}
			
			ul {
				overflow: hidden;
			}
			
			body {
			background: #eee;
			}
			
			.weekdays {
				cursor: pointer;
				margin: 0;
				padding: 10px 0;
				background-color: #ddd;
			}
			
			.weekdays li {
				float: left;
				display: inline-block;
				width: 13.6%;
				color: #666;
				text-align: center;
			}
			
			.days {
				cursor: default;
				padding: 10px 0;
				margin: 0;
			}
			
			.days li {
				cursor: default;
				float: right;
				display: inline-block;
				list-style-type: none;
				width: 13.6%;
				margin-bottom: 10px;
				font-size:16px;
				color: #777;
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
		
		<ul class="weekdays">
			<li onclick="myCreateFunction('monTimes')">Mo<br> click to add</li>
			<li onclick="myCreateFunction('tusTimes')">Tu<br> click to add</li>
			<li onclick="myCreateFunction('wedTimes')">We<br> click to add</li>
			<li onclick="myCreateFunction('thuTimes')">Th<br> click to add</li>
			<li onclick="myCreateFunction('friTimes')">Fr<br> click to add</li>
			<li onclick="myCreateFunction('satTimes')">Sa<br> click to add</li>
			<li onclick="myCreateFunction('sunTimes')">Su<br> click to add</li>
		</ul>
		
		<ul class="days">
		<li>
			<table id="sunTimes">
			</table>
			<br>
		</li>
		<li>
			<table id="satTimes">
			</table>
			<br>
		</li>
		<li>
			<table id="friTimes">
			</table>
			<br>
		</li>
		<li>
			<table id="thuTimes">
			</table>
			<br>
		</li>
		<li>
			<table id="wedTimes">
			</table>
			<br>
		</li>
		<li>
			<table id="tusTimes">
			</table>
			<br>
		</li>
		<li>
			<table id="monTimes">
			</table>
			<br>
		</li>
		</ul>
			
		<script>
			var counter = 0;
			function myCreateFunction(id) {
				var table = document.getElementById(id);
				var rows = table.getElementsByTagName('tr');
				var lastrow = rows.length;
				var row = table.insertRow(lastrow);
				var cell1 = row.insertCell(0);
				var cell2 = row.insertCell(1);
				cell1.innerHTML = 
				'<td>' +
					'<label for="from">From:&nbsp;</label>' +
					'<select id="from" required>' +
						'<option value="8">6</option>' +
						'<option value="8">7</option>' +
						'<option value="8">8</option>' +
						'<option value="9">9</option>' +
						'<option value="10">10</option>' +
						'<option value="11">11</option>' +
						'<option value="12">12</option>' +
						'<option value="13">13</option>' +
					'</select>' +
					'<br>' +
					'<label for="to">To:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>' +
					'<select id="to" required>' +
						'<option value="8">8</option>' +
						'<option value="9">9</option>' +
						'<option value="10">10</option>' +
						'<option value="11">11</option>' +
						'<option value="12">12</option>' +
						'<option value="13">13</option>' +
						'<option value="14">14</option>' +
						'<option value="15">15</option>' +
						'<option value="15">16</option>' +
						'<option value="15">17</option>' +
						'<option value="15">18</option>' +
					'</select><br><br>' +
				'</td>';
				cell2.innerHTML = "<button style='color:red' id='"+counter+"' onclick='myDeleteFunction(this, `"+id+"`)'>X</button><br><br>";
				row.id = counter;
				counter++;
			}
			
			function myDeleteFunction(ele, id) {
				alert(id);
			    var table = document.getElementById(id);
			   	var rowIndex = document.getElementById(ele.id).rowIndex;
			    table.deleteRow(rowIndex);
			}
		
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
				
				document.getElementsByClassName("header")[0].innerHTML = '<br>' + months[mm] + '<br>' + yyyy;
				
			}
		
		
		
			/* //returned value
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
		 */
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