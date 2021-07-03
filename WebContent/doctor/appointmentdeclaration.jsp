<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Welcome</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="style.css">
		<style>
		
			/* Button used to open the contact form - fixed at the bottom of the page */
			.open-button {
				background-color: #555;
				color: white;
				padding: 16px 20px;
				border: none;
				cursor: pointer;
				opacity: 0.8;
				position: fixed;
				bottom: 23px;
				right: 28px;
				width: 280px;
			}
		
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
			
			.weekdays td {
				display: table-cell;
				color: #666;
				text-align: center;
				width: 13.6%;
			}
			
			.days {
				cursor: default;
			}
			
			.days td {
				display: table-cell;
				vertical-align: top;
				cursor: default;
				font-size:16px;
				color: #777;
			}
			
			.days td .tdbgd {
				background-color: #ddd;
				width: 100%;
				border: 5px solid #ddd;
			}
			
			.board {
				width: 100%;
				table-layout: fixed;
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
		
		<table class="board">
		
				<tr class="weekdays">
					<td onclick="myCreateFunction('monTimes')">Mo<br> click to add</td>
					<td onclick="myCreateFunction('tusTimes')">Tu<br> click to add</td>
					<td onclick="myCreateFunction('wedTimes')">We<br> click to add</td>
					<td onclick="myCreateFunction('thuTimes')">Th<br> click to add</td>
					<td onclick="myCreateFunction('friTimes')">Fr<br> click to add</td>
					<td onclick="myCreateFunction('satTimes')">Sa<br> click to add</td>
					<td onclick="myCreateFunction('sunTimes')">Su<br> click to add</td>
				</tr>
				
				<tr class="days">
				<td>
					<table id="monTimes">
					</table>
					<br>
				</td>
				<td>
					<table id="tusTimes">
					</table>
					<br>
				</td>
				<td>
					<table id="wedTimes">
					</table>
					<br>
				</td>
				<td>
					<table id="thuTimes">
					</table>
					<br>
				</td>
				<td>
					<table id="friTimes">
					</table>
					<br>
				</td>
				<td>
					<table id="satTimes">
					</table>
					<br>
				</td>
				<td>
					<table id="sunTimes">
					</table>
					<br>
				</td>
				</tr>
				</table>
				
				<button class="open-button" onclick="dataContructor()" >Submit Data</button>
			
		<script>
			
			//window on-load
			
			var mm;
			var yyyy;
			window.onload = function() {
				
				const months = ["January","February","March","April","May","June","July","August","September","October","November","December"];
				var today = new Date();
				var dd = String(today.getDate()).padStart(2, '0');
				mm = today.getMonth() + 1;
				yyyy = today.getFullYear();
				while(mm > 11) {
					mm -= 12;
					yyyy += 1;
				}
				
				document.getElementsByClassName("header")[0].innerHTML = '<br>' + months[mm] + '<br>' + yyyy;
				
			}
		
			//data constructor
			
			var data;
			function dataContructor() {
				data = (mm + 1) + "," + yyyy + ",";

				//Monday====================================================//
				var rows = document.getElementById("monTimes").rows;
				data += 'Monday/';
				for(var i = 0; i < rows.length; i++) {
					var row = rows[i];
					var cell = row.cells[0];
					var from = cell.getElementsByClassName('from')[0].value;
					var to = cell.getElementsByClassName('to')[0].value;
					data += from + '-' + to + '/';
				}
				data += ',';
				//==========================================================//
				
				//Tuesday===================================================//
				var rows = document.getElementById("tusTimes").rows;
				data += 'Tuesday/';
				for(var i = 0; i < rows.length; i++) {
					var row = rows[i];
					var cell = row.cells[0];
					var from = cell.getElementsByClassName('from')[0].value;
					var to = cell.getElementsByClassName('to')[0].value;
					data += from + '-' + to + '/';
				}
				data += ',';
				//==========================================================//
				
				//Wednesday=================================================//
				var rows = document.getElementById("wedTimes").rows;
				data += 'Wednesday/';
				for(var i = 0; i < rows.length; i++) {
					var row = rows[i];
					var cell = row.cells[0];
					var from = cell.getElementsByClassName('from')[0].value;
					var to = cell.getElementsByClassName('to')[0].value;
					data += from + '-' + to + '/';
				}
				data += ',';
				//==========================================================//
				
				//Thursday==================================================//
				var rows = document.getElementById("thuTimes").rows;
				data += 'Thursday/';
				for(var i = 0; i < rows.length; i++) {
					var row = rows[i];
					var cell = row.cells[0];
					var from = cell.getElementsByClassName('from')[0].value;
					var to = cell.getElementsByClassName('to')[0].value;
					data += from + '-' + to + '/';
				}
				data += ',';
				//==========================================================//
				
				//Friday====================================================//
				var rows = document.getElementById("friTimes").rows;
				data += 'Friday/';
				for(var i = 0; i < rows.length; i++) {
					var row = rows[i];
					var cell = row.cells[0];
					var from = cell.getElementsByClassName('from')[0].value;
					var to = cell.getElementsByClassName('to')[0].value;
					data += from + '-' + to + '/';
				}
				data += ',';
				//==========================================================//
				
				//Saturday==================================================//
				var rows = document.getElementById("satTimes").rows;
				data += 'Saturday/';
				for(var i = 0; i < rows.length; i++) {
					var row = rows[i];
					var cell = row.cells[0];
					var from = cell.getElementsByClassName('from')[0].value;
					var to = cell.getElementsByClassName('to')[0].value;
					data += from + '-' + to + '/';
				}
				data += ',';
				//==========================================================//
				
				//Sunday====================================================//
				var rows = document.getElementById("sunTimes").rows;
				data += 'Sunday/';
				for(var i = 0; i < rows.length; i++) {
					var row = rows[i];
					var cell = row.cells[0];
					var from = cell.getElementsByClassName('from')[0].value;
					var to = cell.getElementsByClassName('to')[0].value;
					data += from + '-' + to + '/';
				}
				data += ',';
				//==========================================================//
				
				
				window.location.href = "doctor?action=callendar?data=" + data;
				
			}
		
			//datetime picker
		
			var counter = 0;
			function myCreateFunction(id) {
				var table = document.getElementById(id);
				var rows = table.getElementsByTagName('tr');
				var lastrow = rows.length;
				var row = table.insertRow(lastrow);
				var cell1 = row.insertCell(0);
				cell1.innerHTML = 
				'<div class="tdbgd">' +
					'<label>From:&nbsp;</label>' +
					'<select class="from" required>' +
						'<option value="6">6</option>' +
						'<option value="7">7</option>' +
						'<option value="8">8</option>' +
						'<option value="9">9</option>' +
						'<option value="10">10</option>' +
						'<option value="11">11</option>' +
						'<option value="12">12</option>' +
						'<option value="13">13</option>' +
					'</select>' +
					'&nbsp;&nbsp;' +
					'<label>To:&nbsp;</label>' +
					'<select class="to" required>' +
						'<option value="8">8</option>' +
						'<option value="9">9</option>' +
						'<option value="10">10</option>' +
						'<option value="11">11</option>' +
						'<option value="12">12</option>' +
						'<option value="13">13</option>' +
						'<option value="14">14</option>' +
						'<option value="15">15</option>' +
						'<option value="16">16</option>' +
						'<option value="17">17</option>' +
						'<option value="18">18</option>' +
					'</select>' +
					'&nbsp;&nbsp;' +
					"<button style='color:red' id='"+counter+"' onclick='myDeleteFunction(this, `"+id+"`)'>X</button><br>" +
					'</div>';
				row.id = counter;
				counter++;
			}
			
			function myDeleteFunction(ele, id) {
			    var table = document.getElementById(id);
			   	var rowIndex = document.getElementById(ele.id).rowIndex;
			    table.deleteRow(rowIndex);
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