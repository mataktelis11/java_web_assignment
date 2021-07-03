<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Welcome</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="style.css">
		<style>
			
			body {
				background: #eee;
			}
			
			.header {
				font-size: 42px !important;
			}
			
			/* Makes the text of the buttons unselectable */
			.unselectable {
			    -webkit-touch-callout: none;
			    -webkit-user-select: none;
			    -khtml-user-select: none;
			    -moz-user-select: none;
			    -ms-user-select: none;
			    user-select: none;
			}
			
			/* Button used to open the contact form - fixed at the bottom of the page */
			.submitButton {
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
			
			/* Error Popup -- https://www.w3schools.com/howto/howto_js_popup.asp */
			
			/* Popup container */
			.popup {
				position: relative;
				display: inline-block;
				cursor: pointer;
				-webkit-user-select: none;
				-moz-user-select: none;
				-ms-user-select: none;
				user-select: none;
			}
			
			/* The popup */
			.popup .popuptext {
				visibility: hidden;
				width: 280px;
				background-color: #555;
				color: #fff;
				text-align: center;
				border-radius: 6px;
				padding: 8px 0;
				position: fixed;
				z-index: 1;
				bottom: 76px;
				right: 28px;
				margin-left: -80px;
			}
			
			/* Popup arrow */
			.popup .popuptext::after {
				content: "";
				position: absolute;
				top: 100%;
				left: 50%;
				margin-left: -5px;
				border-width: 5px;
				border-style: solid;
				border-color: #555 transparent transparent transparent;
			}
			
			/* hide and show the popup */
			.popup .show {
				visibility: visible;
				-webkit-animation: fadeIn 1s;
				animation: fadeIn 1s;
			}
			
			/* fade in the popup animation */
			@-webkit-keyframes fadeIn {
				from {opacity: 0;} 
				to {opacity: 1;}
			}
			
			@keyframes fadeIn {
				from {opacity: 0;}
				to {opacity:1 ;}
			}
			
			/*                                                                   */
			
			/* DateTime selection board */
			
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
			
			/*                          */
			
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
			<h1></h1>
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
					<td onclick="myCreateFunction('monTimes')"> Monday <br> <b>click to add</b> </td>
					<td onclick="myCreateFunction('tusTimes')"> Tuesday <br> <b>click to add</b> </td>
					<td onclick="myCreateFunction('wedTimes')"> Wednesday <br> <b>click to add</b> </td>
					<td onclick="myCreateFunction('thuTimes')"> Thursday <br> <b>click to add</b> </td>
					<td onclick="myCreateFunction('friTimes')"> Friday <br> <b>click to add</b> </td>
					<td onclick="myCreateFunction('satTimes')"> Saturday <br> <b>click to add</b> </td>
					<td onclick="myCreateFunction('sunTimes')"> Sunday <br> <b>click to add</b> </td>
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
				
				<div class="popup">
					<button class="submitButton" onclick="dataContructor()" >Submit Data</button>
					<span class="popuptext" id="error" onclick="errorPopup()"><b style="color:red">ERROR</b> <br> <i>hint: check the time spans</i> </span>
				</div>
				
		<script>
			
			//window on-load
			
			var mm;
			var yyyy;
			window.onload = function() {
				
				const months = ["January","February","March","April","May","June","July","August","September","October","November","December"];
				var today = new Date();
				mm = today.getMonth() + 1;
				yyyy = today.getFullYear();
				while(mm > 11) {
					mm -= 12;
					yyyy += 1;
				}
				
				document.getElementsByClassName("header")[0].innerHTML = '<br>' + months[mm] + '<br>' + yyyy;
				
			}
			
			//data validation
			
			function validate(from, to) {
				if(parseInt(from) >= parseInt(to)) return false;
				else return true;
			}
			
			function errorPopup() {
				  var popup = document.getElementById("error");
				  popup.classList.toggle("show");
			}
		
			//data constructor
			
			function dataContructor() {
				var data = (mm + 1) + "," + yyyy + ",";

				//Monday====================================================//
				var rows = document.getElementById("monTimes").rows;
				data += 'Monday/';
				for(var i = 0; i < rows.length; i++) {
					var row = rows[i];
					var cell = row.cells[0];
					var from = cell.getElementsByClassName('from')[0].value;
					var to = cell.getElementsByClassName('to')[0].value;
					if(!validate(from, to)) {
						errorPopup();
						return;
					}
					data += from + '-' + to + '/';
				}
				data += ',';
				//==========================================================//
				
				//Tuesday===================================================//
				rows = document.getElementById("tusTimes").rows;
				data += 'Tuesday/';
				for(var i = 0; i < rows.length; i++) {
					var row = rows[i];
					var cell = row.cells[0];
					var from = cell.getElementsByClassName('from')[0].value;
					var to = cell.getElementsByClassName('to')[0].value;
					if(!validate(from, to)) {
						errorPopup();
						return;
					}
					data += from + '-' + to + '/';
				}
				data += ',';
				//==========================================================//
				
				//Wednesday=================================================//
				rows = document.getElementById("wedTimes").rows;
				data += 'Wednesday/';
				for(var i = 0; i < rows.length; i++) {
					var row = rows[i];
					var cell = row.cells[0];
					var from = cell.getElementsByClassName('from')[0].value;
					var to = cell.getElementsByClassName('to')[0].value;
					if(!validate(from, to)) {
						errorPopup();
						return;
					}
					data += from + '-' + to + '/';
				}
				data += ',';
				//==========================================================//
				
				//Thursday==================================================//
				rows = document.getElementById("thuTimes").rows;
				data += 'Thursday/';
				for(var i = 0; i < rows.length; i++) {
					var row = rows[i];
					var cell = row.cells[0];
					var from = cell.getElementsByClassName('from')[0].value;
					var to = cell.getElementsByClassName('to')[0].value;
					if(!validate(from, to)) {
						errorPopup();
						return;
					}
					data += from + '-' + to + '/';
				}
				data += ',';
				//==========================================================//
				
				//Friday====================================================//
				rows = document.getElementById("friTimes").rows;
				data += 'Friday/';
				for(var i = 0; i < rows.length; i++) {
					var row = rows[i];
					var cell = row.cells[0];
					var from = cell.getElementsByClassName('from')[0].value;
					var to = cell.getElementsByClassName('to')[0].value;
					if(!validate(from, to)) {
						errorPopup();
						return;
					}
					data += from + '-' + to + '/';
				}
				data += ',';
				//==========================================================//
				
				//Saturday==================================================//
				rows = document.getElementById("satTimes").rows;
				data += 'Saturday/';
				for(var i = 0; i < rows.length; i++) {
					var row = rows[i];
					var cell = row.cells[0];
					var from = cell.getElementsByClassName('from')[0].value;
					var to = cell.getElementsByClassName('to')[0].value;
					if(!validate(from, to)) {
						errorPopup();
						return;
					}
					data += from + '-' + to + '/';
				}
				data += ',';
				//==========================================================//
				
				//Sunday====================================================//
				rows = document.getElementById("sunTimes").rows;
				data += 'Sunday/';
				for(var i = 0; i < rows.length; i++) {
					var row = rows[i];
					var cell = row.cells[0];
					var from = cell.getElementsByClassName('from')[0].value;
					var to = cell.getElementsByClassName('to')[0].value;
					if(!validate(from, to)) {
						errorPopup();
						return;
					}
					data += from + '-' + to + '/';
				}
				//==========================================================//
				
				window.location.href = "doctor?action=callendar&data=" + data;
				
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
						'<option value="14">14</option>' +
						'<option value="15">15</option>' +
						'<option value="16">16</option>' +
						'<option value="17">17</option>' +
						'<option value="18">18</option>' +
						'<option value="19">19</option>' +
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
						'<option value="19">19</option>' +
						'<option value="20">20</option>' +
						'<option value="21">21</option>' +
					'</select>' +
					'&nbsp;&nbsp;' +
					"<button style='color:red;opacity:0.8;cursor:pointer;' id='"+counter+"' onclick='myDeleteFunction(this, `"+id+"`)'>X</button><br>" +
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