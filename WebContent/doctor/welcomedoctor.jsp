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
			
			.details {
				width: 85%;
				border-collapse: collapse;
				border: 15px;
				border-style: solid;
				box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19);
				border-color: #666;
				font-family: verdana;
				text-align: left;
				opacity: 0.75;
				table-layout: fixed;
				cursor: default;
			}
			
			.details th {
				padding: 12px;
				background: #aaa;
			    color: #ffffff;
			    font-size: 1.5em;
			}
			
			.details td {
				font-size: 0.9em;
				background: #ddd;
				padding: 12px;
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
				<h1>Welcome</h1>
				<h2> <%= session.getAttribute("name") %> </h2>
			</div>
			
			<div class="navbar">
				<a href="index.jsp">Home</a>
				<a href="about.jsp">About</a>
				
				<a href="logout.jsp" class="right">Log out</a>
				<a id="selected" href="doctor?action=welcome" class="right"> <%= session.getAttribute("name") %> </a>
				<a href="doctor?action=appointments" class="right">Appointment menu</a>
					<a href="doctor?action=appointmentdeclaration" class="right">Appointment declaration</a>
				
			</div>
		</div>
		
		<div class="offset"> </div>
		
		<br>
		<table class="details">
			<tr>
				<th>Username:</th>
				</tr>
				<tr>
				<td><c:out value="${Doctor.username}"/></td>
			</tr>
			<tr>
				<th>FirstName:</th>
				</tr>
				<tr>
				<td><c:out value="${Doctor.name}"/></td>
			</tr>
			<tr>
				<th>SurName:</th>
				</tr>
				<tr>
				<td><c:out value="${Doctor.surname}"/></td>
			</tr>
			<tr>
				<th>AMKA:</th>
			</tr>
			<tr>
				<td><c:out value="${Doctor.AMKA}"/></td>
			</tr>
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