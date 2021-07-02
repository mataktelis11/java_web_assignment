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
			<h1>Adding a doctor</h1>
			<p> <%= session.getAttribute("name") %> </p>
		</div>
		
		<div class="navbar">
			<a href="index.jsp">Home</a>
			<a href="about.jsp">About</a>
			
			<a href="logout.jsp" class="right">Log out</a>
			<a href="admin?action=welcome" class="right"> <%= session.getAttribute("name") %> </a>
			<a href="admin?action=details" class="right">Account Details</a>
			<a href="admin?action=appointments" class="right">Appointment menu</a>
			<a href="admin?action=addpatient" class="right">Add a Patient</a>
			<a id="selected" href="admin?action=adddoctor" class="right">Add a Doctor</a>
			
		</div>
		
		<div class="offset"> </div>
		<p>The admin can add a doctor here.</p>
		<form method="post" action="admin">
			<input type="hidden" name="action" value="insertdoctor" />
			<table>
				<tr>
					<td>AMKA:</td>
					<td><input type="text" name="amka" /></td>
					<br />
				</tr>
				<tr>
					<td>Name:</td>
					<td><input type="text" name="name" /></td>
					<br />
				</tr>
				<tr>
					<td>Surname:</td>
					<td><input type="text" name="surname" /></td>
					<br />
				</tr>
				<tr>
					<td>Username:</td>
					<td><input type="text" name="username" /></td>
					<br />
				</tr>
				<tr>
					<td>Password:</td>
					<td><input type="text" name="psw" /></td>
					<br />
				</tr>
				<tr>
					<td>Hospital:</td>
					<td><input type="text" name="hospital" /></td>
					<br />
				</tr>
				<tr>
					<td>Specialty:</td>
					<td><input type="text" name="sp" /></td>
					<br />
				</tr>
				
				<tr>
					<td></td>
					<td><input type="submit" value="Add doctor" /></td>
					<br />
				</tr>
	
			</table>
		</form>
			
			
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